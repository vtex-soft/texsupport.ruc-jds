%% This is file `jdsart.cls'.
%%
%% LaTeX 2e class file for articles in jds journal published by VTeX.
%%
%% Macros written by VTeX Ltd., Lithuania
%% Please submit bugs or your comments to latex-support@vtex.lt
%%
%% Copyright 2020 by VTEX UAB
%%
%% You are free to use this class file as you see fit, provided
%% that you do not make changes to the file.
%% If you DO make changes, you are required to rename this file.
%%
%% It may be distributed under the terms of the LaTeX Project Public
%% License, as described in lppl.txt in the base LaTeX distribution.
%% Either version 1.3 or (at your option) any later version.
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jdsart}[2025/09/03 v0.25 Journal of Data Science class]

\def\fmt@name{jdsart}

\RequirePackage{etoolbox}

\newif\if@review 
\newif\if@inpress \@inpresstrue
\newif\if@discussion
\newif\if@chinese
\newif\if@linenumber

% only one of review and inpress can be true
\DeclareOption{review}{\@reviewtrue \@inpressfalse \@linenumbertrue}
\DeclareOption{inpress}{\@reviewfalse \@inpresstrue}
\DeclareOption{discussion}{\@discussiontrue}
\DeclareOption{chinese}{\@chinesetrue \@discussiontrue}
\DeclareOption{linenumber}{\@linenumbertrue}
\DeclareOption{nolinenumber}{\@linenumberfalse}

\newif\if@rotating@loaded \@rotating@loadedfalse
\DeclareOption{rotating}{%
  \@rotating@loadedtrue
  \AtEndOfClass{\RequirePackage{rotating}}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions*

\usepackage[T1]{fontenc}
\usepackage{textcomp}
\if@review
    \LoadClass[12pt,twoside]{article}
    \RequirePackage{setspace}
    \doublespacing
    \RequirePackage[left=1in,right=1in,top=1in,bottom=1in]{geometry}
\else
    \LoadClass[11pt,twoside]{article}
    \RequirePackage[left=1.1in,right=1.1in,top=1.1in,bottom=1.1in]{geometry}
\fi

\if@discussion
    \gdef\disfirstpage{0}
    \RequirePackage{subfiles}
    \if@chinese
    \else
      \RequirePackage{bibunits}
      \defaultbibliographystyle{jds}
    \fi
\fi

\if@chinese
    %% By default, scheme = chinese, which changes line space and font size.
    %% see the manual of ctex package for details
    \RequirePackage[UTF8,heading=true,scheme=plain]{ctex}
    \ctexset{
      autoindent = true,
      part/afterindent = true,
      % chapter/afterindent = true,
      section/afterindent = true,
      subsection/afterindent = true,
      subsubsection/afterindent = true,
      paragraph/afterindent = true,
      subparagraph/afterindent = true,
      contentsname = {??},
      listfigurename = {??},
      indexname = {??},
      abstractname = {??},
      figurename = {?},
      tablename = {?},
      appendixname = {??},
      bibname = {????},
      proofname = {??}
      % algorithmname = {??}
    }
    \RequirePackage{xeCJK}
    \RequirePackage{setspace}
    \gdef\@pageprefix{S}
\else
    \gdef\@pageprefix{}
\fi


\def\@@lastpage{\@lastpage}

\InputIfFileExists{jdsart.cfg}{}{
  \RequirePackage{lastpage}
  \def\@@lastpage{\pageref*{LastPage}}
  }

\def\@journal{Journal of Data Science}
\def\@journalabbrev{Journal of Data Science}
\def\@journal@url{https://www.jds.org}
\def\@JOURNAL{JOURNAL OF DATA SCIENCE}
\def\@jid{jds}
\def\@JID{JDS}

\@ifundefined{doi@base}{\def\doi@base{https://doi.org/}}{}
\def\print@doi{\href{\doi@base\@doi}{\doi@base\@doi}}
\def\@ppages{\@firstpage--\@@lastpage}
\def\print@volume@line{\textsc{\@journal}\space\@volume\space (\@issue), \@ppages\\ \@pubmonth\ \@pubyear}

\def\@volume{0}
\def\@pubyear{0000}
\def\@pubmonth{}
\def\@@ppages{\empty}
\def\@firstpage{1}
\def\@lastpage{0}
\def\@doi{\empty}

\def\volume#1{\gdef\@volume{#1}}
\def\issue#1{\gdef\@issue{#1}}
\def\pubyear#1{\gdef\@pubyear{#1}}
\def\pubmonth#1{\gdef\@pubmonth{#1}}
\def\firstpage#1{\gdef\@firstpage{#1}\setcounter{page}{#1}}
\def\lastpage#1{\gdef\@lastpage{#1}}
\def\doi#1{\gdef\@doi{#1}}

\def\logo@vtex{jds-logo-vtex}
\def\includevtexlogo{\null}
\def\@vtex@url{https://www.vtex.lt/en/}

% COPYRIGHT
% Define font psyr for copyright:
\DeclareFixedFont{\copyrf}{U}{psy}{m}{n}{8}
\DeclareFixedFont{\copyrfa}{U}{psy}{m}{n}{9}
\def\copyright@sign{{\copyrf\char'323}}

\newif\if@open@access \global\@open@accesstrue
\def\cclicense@link{https://creativecommons.org/licenses/by/4.0/}
\def\@openaccess{Open access article under the \href{\cclicense@link}{CC BY} license.}
\def\copyright@statement{\textcopyright\ \@pubyear\ The Author(s). Published by the School of Statistics and 
  the Center for Applied Statistics, Renmin University of China. \@openaccess}
\def\copyright@line{\@copyright@fmt{\copyright@statement}}

\newbox\copyright@box
\def\@copyright@fmt#1{%
  \setbox\copyright@box=\vbox to0pt{\vss \footnotesize #1\hfill}%
  \wd\copyright@box=\z@
  \ht\copyright@box=\z@
  \dp\copyright@box=\z@
  \footnotesize
  \raise %11pt
  \baselineskip
  \box\copyright@box}

\def\nocopyrightline{\gdef\copyright@line{\@copyright@fmt{}}}
\def\credit@line{\@credit@fmt{\@credit}}
\def\@credit@fmt#1{{\parindent0pt#1}}
\def\@credit{%
  \vbox to 0pt{%
    \vskip-1.85pc
    \hskip-\textwidth
    \noindent
    \raise4mm\hbox to \textwidth{%
      \footnotesize
      \href{\@journal@url}{www.jds.org}%
      \hfill
      \href{\@vtex@url}{\includevtexlogo}%
      }%
    }%
  }

\let\@received\@empty
\let\@revised\@empty
\let\@accepted\@empty
\let\@publishedonline\@empty
\def\received#1{\gdef\@received{{Received on~\hbox{#1}}}}
\def\revised#1{\gdef\@revised{{Revised on~\hbox{#1}}}}
\def\accepted#1{\gdef\@accepted{{Accepted on~\hbox{#1}}}}
\def\publishedonline#1{\gdef\@publishedonline{{Published~online:~\hbox{#1}}}}
\def\print@history{%
  \def\sep{\def\sep{, \allowbreak}}%
  \ifx\@received\@empty\else\sep\@received\fi%
  \ifx\@revised\@empty\else\sep\@revised\fi%
  \ifx\@accepted\@empty\else\sep\@accepted\fi%
  \ifx\@publishedonline\@empty\else\sep\@publishedonline\fi%
  }

\RequirePackage{amsmath}
\RequirePackage{amssymb}

\ifdefined\noaccents@
    \noaccents@
\fi

\let\kernel@bordmatrix@left(
\let\kernel@bordmatrix@right)
\def\kernel@bordermatrix#1{%
    \begingroup 
        \@nameuse{boredematrix@begin@hook}%
        \m@th \@tempdima 8.75\p@
        \setbox\z@\vbox{%
            \def\cr{\crcr\noalign{\kern2\p@\global\let\cr\endline}}%
            \ialign{$##$\hfil\kern2\p@\kern\@tempdima&\thinspace\hfil$##$\hfil
                &&\quad\hfil$##$\hfil\crcr
                \omit\strut\hfil\crcr\noalign{\kern-\baselineskip}%
                #1\crcr\omit\strut\cr
                }%
            }%
        \setbox\tw@\vbox{\unvcopy\z@\global\setbox\@ne\lastbox}%
        \setbox\tw@\hbox{\unhbox\@ne\unskip\global\setbox\@ne\lastbox}%
        \setbox\tw@\hbox{$\kern\wd\@ne\kern-\@tempdima
            \left\kernel@bordmatrix@left\kern-\wd\@ne
            \global\setbox\@ne\vbox{\box\@ne\kern2\p@}%
            \vcenter{\kern-\ht\@ne\unvbox\z@\kern-\baselineskip}
            \,\right\kernel@bordmatrix@right$%
            }%
        \null\;\vbox{\kern\ht\@ne\box\tw@}%
        \@nameuse{boredematrix@end@hook}%
    \endgroup
    }
\def\set@bordermatrix@braces#1#2{%
    \let\kernel@bordmatrix@left#1\relax
    \let\kernel@bordmatrix@right#2\relax
    \kernel@bordermatrix
    }
\def\bordermatrix#1#{%
    \ifx\relax#1\relax
        \expandafter\kernel@bordermatrix
    \else
        \expandafter\set@bordermatrix@braces
    \fi#1%
    }

\AtBeginDocument{%
  \def\tfrac#1#2{{\textstyle\frac{#1}{#2}}}%
  \def\dfrac#1#2{{\displaystyle\frac{#1}{#2}}}%
  }%
\def\dvt{\colon\ }
\def\dvtx{\nobreak\,\colon\relax}
%
\let\ge\geqslant
\let\geq\geqslant
\let\le\leqslant
\let\leq\leqslant

\RequirePackage{amsthm}

\RequirePackage{graphicx}
\RequirePackage{array}

%% frontmatter
\newlength\printhistorymargin
\setlength\printhistorymargin{0pc}
\newenvironment{printhistory}
  {%
    \list{}{%
      \rightmargin\printhistorymargin
      \leftmargin\printhistorymargin
      }%
    \item\relax\centering
  }{%
    \par
    \endlist
  }

\newif\iflongmktitle \longmktitlefalse
\def\@@@Label#1{%
  \@bsphack
  \protected@write\@auxout{}{\string\Newlabel{#1}{\@currentlabel}}%
  \@esphack
  }
\def\Newlabel#1#2{%
  \expandafter\gdef\csname X@#1\endcsname{#2}%
  }
\def\@@@Ref#1{%
  \@ifundefined{X@#1}
    {0}
    {\csname X@#1\endcsname}%
  }
\RequirePackage{pifont}

\def\abstract@preskip{28pt}
\newcommand\abstract@fmt[1]{\textbf{#1}}
\newcommand\abstract@name{Abstract}
\newcommand\abstract@name@skip{\vskip7pt}
\newbox\absbox
\renewenvironment{abstract}
  {%
    \global\setbox\absbox=\vbox\bgroup
    \hsize=\textwidth
    \def\baselinestretch{1}%
    \centerline{\abstract@fmt{\abstract@name}}%
    \noindent\unskip
    \abstract@name@skip
    \noindent\ignorespaces
  }{%
    \par
    \egroup
  }

\newcount\keyboxcnt
\newenvironment{keywords}[1][]%
  {%
    \expandafter\newsavebox\csname keybox#1\endcsname
    \@ifundefined{keybox@list}
      {%
        \csxdef{keybox@list}{keybox#1}%
      }{%
        \csxappto{keybox@list}{,keybox#1}%
      }%
    \def\@tempa{#1}%
    \def\PACS@name{PACS}%
    \def\JEL@name{JEL}%
    \def\MSC@MMX@name{MSC2010}%
    \ifx\@tempa\@empty
      \def\keywords@prefix{\textbf{Keywords}\enskip\space}%
    \else
      \ifx\@tempa\PACS@name
        \def\keywords@prefix{\it PACS:\space}%
      \else
        \ifx\@tempa\JEL@name
          \def\keywords@prefix{\textbf{JEL~classification}\enskip\space}%
        \else
          \ifx\@tempa\MSC@MMX@name
            \def\keywords@prefix{\textbf{2010~MSC}\enskip\space}%
            \def\MSC@active@keywords{1}%
          \else
            \def\keywords@prefix{\textbf{#1~MSC}\enskip\space}%
            \def\msc@tempa{2010}%
            \ifx\@tempa\msc@tempa
              \def\MSC@active@keywords{1}%
            \fi
          \fi
        \fi
      \fi
    \fi
    \@firstkwdtrue
    \global\advance\keyboxcnt\@ne
    \global\expandafter\setbox\csname keybox#1\endcsname=\vbox\bgroup
      \hsize=\textwidth
      \normalfont\normalsize
      \def\baselinestretch{1}%
      \parskip\z@
      % 10pt between abstract/keyword boxes and baselineskip + 2pt between keyword baselines
      \ifdefined\first@keyword@env
        \prevdepth\z@
        \medskip
      \fi
      \noindent{\keywords@prefix}%
      \raggedright % Keywords are not justified.
      \ignorespaces
  }{%
      \kwd@lastsep\par
    \egroup
    \gdef\first@keyword@env{1}%
  }

\ifdefined\directlua
  \def\fix@italic@cor{%
    %% remove italic correction at the end of inline math before keyword sep ';'
    \directlua{
    local prevnode = tex.nest[tex.nest.ptr].tail 
    if prevnode and prevnode.id == node.id("math") then
      local pprevnode = prevnode.prev 
      if pprevnode and pprevnode.id == node.id("kern") then
        node.remove(tex.nest[tex.nest.ptr].head, pprevnode)
      end
    end
  }}
\else
  \let\fix@italic@cor\empty
\fi
  
\newif\if@firstkwd
\def\kwd@sep{\unskip\fix@italic@cor; }
\def\kwd@lastsep{\unskip}
\def\kwd@font{\itshape}
\def\msc@hrefprefix{https://www.ams.org/msc/msc2010.html?s=}
\newcommand\kwd[2][]{%
  \bgroup
    \kwd@font
    \def\@tempa{#1}%
    \if@firstkwd
      \global\@firstkwdfalse
      \let\kwd@sep\@empty
    \fi
    \ifx\@tempa\@empty
      \kwd@sep
    \else
      \@tempa
    \fi
    \ifdefined\MSC@active@keywords
      \href{\msc@hrefprefix #2}{#2}%
    \else
      #2%
    \fi
  \egroup
  \ignorespaces
  }

\newdimen\Columnwidth
\Columnwidth=\columnwidth

\def\printWarning{%
  \mbox{}\par\vfill\par
  \bgroup
    \fboxsep=12pt
    \fboxrule=1pt
    \hspace*{.18\textwidth}%
    \fcolorbox{gray50}{gray10}{\box\warnbox}%
  \egroup
  \par\vfill\thispagestyle{empty}%
  \setcounter{page}{0}%
  \clearpage
  }

\long\def\finalMaketitle{%
  % \enlargethispage{-4.5pc}%
  \if@discussion
    %% for discussion, only show first page header style once
    \if\disfirstpage0
      \thispagestyle{copyright}
      \gdef\disfirstpage{1}
      \xdef\@discussionfirstpage{\thepage}
    \else
      \if@chinese
        \gdef\disfirstpage{2}
        \thispagestyle{chfirstpage}
      \else
         \thispagestyle{doipage}
      \fi
    \fi
  \else
    \newpage
    \thispagestyle{copyright}
  \fi  
  \MaketitleBox
  }

\def\output@frontmatter@authors{%
  \def\do##1{%
    \expandafter\author@fmt\expandafter{\the\c@author}{\csuse{##1t@loc@notes}}{##1}%
    }%
  \front@author@defs 
  \expandafter\docsvlist\expandafter{\author@list}%
  \par
  }

\def\validate@frontmatter@authors{%
  \def\do##1{%
    \setbox\@tempboxa=\hbox{%
      \let\bio\@gobble
      \let\degs\@gobble
      \let\prefix\@gobble
      \let\inits\@gobble
      \let\fnms\@gobble
      \let\snm\@gobble
      \let\suffix\@gobble
      \let\roles\@gobble
      \def\thanks##1##{\@gobble}%
      \def\thanksref##1##{\@gobble}%
      \let\thankstext\@gobble
      \def\ead####1####{\global\stepcounter{countead}}%
      \csname ##1\endcsname}%
    }%
  \expandafter\docsvlist\expandafter{\author@list}%
  }

\def\output@publishedonline{%
  \ifx\@empty\@publishedonline
  \else
    \publishedonline@prefix\hbox{\@publishedonline}\publishedonline@postfix
    \@historytrue
  \fi
  }

\AtBeginDocument{\csname \@articletype @articletype@control\endcsname}

\def\printaug{%
  \begin{flushright}
    \def\do##1{\csuse{##1}\\}%
    \expandafter\docsvlist\expandafter{\author@list}%
  \end{flushright}
  }

\ifdefined\HCode
  \let\printaug\relax
\else
  \def\editorial@articletype@control{%
    \let\output@frontmatter@authors\validate@frontmatter@authors
    \let\output@publishedonline\relax
    }
  \def\other@articletype@control{%
    \let\output@publishedonline\relax
    \gdef\author@list{}%
    \nocopyrightline
    }
\fi

\def\address@list{}
\def\title@preskip{0pt}
\def\title@afterskip{15pt}
\def\subtitle@afterskip{18pt}
\let\author@sep\relax
\long\def\MaketitleBox{%
  \def\baselinestretch{1}%
   \begin{center}%
    \def\baselinestretch{1}%
    %\null
    \vskip\title@preskip
    \Large\textbf{\title@fmt{\@title}{\csuse{title@t@loc@notes}}}%
    \par
    \vskip\title@afterskip
    \ifdefined\@subtitle
      \large\textbf{\subtitle@fmt{\@subtitle}{\csuse{subtitle@t@loc@notes}}}%
      \par
      \vskip\subtitle@afterskip
    \fi
    \output@frontmatter@authors
    \par
    \def\do##1{%
      \address@fmt{\csuse{##1@counter}}{\csuse{##1t@loc@notes}}{\csuse{##1}}%
      }%
    \expandafter\docsvlist\expandafter{\address@list}%
  \end{center}%
  \ifdefined\@dedicated
    \unskip\vskip9.5pt
    \dedicated@fmt{\@dedicated}%
    \par\vskip15pt
  \fi
  \ifvoid\absbox
  \else
    \unskip
    \vskip\abstract@preskip
    \unvbox\absbox
    \par
    \vskip10pt
  \fi
  \ifdefined\keybox@list
    \newdimen\saveboxdepth
    \count@=\z@
    \def\do##1{%
      \saveboxdepth=\expandafter\dp\csname##1\endcsname
      \expandafter\unvbox\expandafter\csname ##1\endcsname
      \advance\count@\@ne
      % depth is 0 for all keyword boxes except the last one
      \ifnum\count@=\keyboxcnt
        \prevdepth=\the\saveboxdepth
      \else
        \addvspace{-\the\saveboxdepth}%
      \fi
      }%
    \expandafter\docsvlist\expandafter{\keybox@list}%
    \par
    \vskip10pt
  \fi
  }

\def\FNtext#1{\par\bgroup\footnotesize#1\egroup}
\newdimen\space@left
\def\alarm#1{%
  \typeout{******************************}%
  \typeout{#1}%
  \typeout{******************************}%
  }
\long\def\getSpaceLeft{%
  \global\setbox0=\vbox{\hsize=\textwidth\MaketitleBox}%
  \global\setbox1=\vbox{\hsize=\textwidth
  \let\footnotetext\FNtext
  \printFirstPageNotes}%
  \xdef\noteheight{\the\ht1}%
  \xdef\titleheight{\the\ht0}%
  \@tempdima=\vsize
  \advance\@tempdima-\noteheight
  \advance\@tempdima-1\baselineskip
  }
\skip\footins=24pt
\newbox\@@@@boxa
\newbox\@@@@boxb
\def\maketitle{%
  \iflongmktitle\getSpaceLeft
    \global\setbox\@@@@boxa=\vsplit0 to \@tempdima
    \box\@@@@boxa\par\resetTitleCounters
    \thispagestyle{copyright}%
    \printFirstPageNotes
    \box0%
  \else
    \finalMaketitle
  \fi
  }%

\def\runtitle#1{\gdef\@runtitle{\hbox{#1}}}
\def\@runtitle{}
\def\runauthor#1{\gdef\@runauthor{#1}} 
\def\@runauthor{\output@head@authors}
\def\output@head@authors{}

\def\runauthor@etal{~et al.}

\def\head@author@defs{%
  \front@author@defs
  \let\write@aux@au\@gobbletwo
  \def\ead##1##{\@gobble}%
  \def\@inits##1{}%  
  \def\@snm##1{}%  
  \def\@fnm##1{}%  
  \let\~\empty
  \def\inits##1{\def\@inits{, ##1}}%
  \def\snm##1{\def\@snm{##1}}%
  \def\fnms##1{\def\@fnms{##1}\ignorespaces}%
  }

\def\head@author@fmt#1{%
  \head@author@defs 
  \get@author@num #1\relax
  \set@author@sep
  \@author@sep
  \@nameuse{#1}%
  \@snm \@inits
  }
\def\head@authors@font{\itshape\selectfont}
  
\newbox\headbox
\def\@output@head@authors{%
  \bgroup
    \head@authors@font
    \ifnum\c@author>2\relax
      \head@author@fmt{author1}\runauthor@etal
    \else
      \def\do##1{\head@author@fmt{##1}}%
      \expandafter\docsvlist\expandafter{\author@list}%
    \fi
  \egroup
  }

%% define header and footer
\RequirePackage{fancyhdr}
\setlength{\headheight}{24pt}
\pagestyle{fancy}
\fancyhead{} % clear all header fields
\fancyhead[CO]{%
  \csname check@head@line\endcsname%
  \textit \@runtitle%
}
\fancyhead[CE]{\@runauthor}
\fancyhead[LE,RO]{\@pageprefix\thepage}
\fancyfoot{} % clear all footer fields
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\def\check@head@line{%
  \def\pseudo@head@line{\@pageprefix 000\space{\textit\@runtitle}\space\@pageprefix 000}%
  \bgroup
    \settowidth\@tempdima{\pseudo@head@line}%
    \ifdim\@tempdima>\textwidth\relax
      \ClassError{jdsart}{Running title is too long!}{}%
      \global\let\check@head@line\relax
    \fi
  \egroup
}

\fancypagestyle{copyright}{%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyhf{}%
  \fancyhead[L]{\normalfont\footnotesize\print@volume@line}
  \fancyhead[R]{\footnotesize DOI: \@doi\\ \@pretitle}
  \fancyfoot[LE,RO]{}% number of the first page
  \fancyfoot[RE,LO]{\footnotesize \history@fmt}
}
  
\if@discussion
  \fancypagestyle{doipage}{%
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhf{}%
    \fancyhead[L]{\footnotesize {\scshape \@journal}
      \@volume\ (\@issue),
      \IfRefUndefinedExpandable{\@doi}{
        \@pageprefix\thepage--\pageref*{LastPage}\\
      }{
        \@pageprefix\thepage--\pageref*{\@doi}\\
      }
      \@smonth\ \@syear
    }
    \fancyhead[R]{\footnotesize DOI:\ \@doi\\ \@pretitle}
    \fancyfoot[LE,RO]{\@pageprefix\thepage}% number of the page
  }
\fi

\if@chinese
  \fancypagestyle{chfirstpage}{%
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhf{}%
    \fancyhead[L]{\footnotesize {\scshape \@journal}
      \@volume\ (\@issue),
      \@pageprefix\@discussionfirstpage--\@pageprefix\pageref*{LastPage}\\
      \@syear 年 \@smonth 月
    }
    \fancyhead[R]{\footnotesize DOI:\ \@doi\\ \@pretitle}
    \fancyfoot[LE,RO]{\@pageprefix\thepage}% number of the first page
    \fancyfoot[RE,LO]{\footnotesize \history@fmt}
  }
\fi

\if@linenumber
  \long\gdef\numberlines@size{\scriptsize\ttfamily}
  \long\gdef\numberlines@skip{24\p@}
  %
  \def\numberlines@hook{%
    \appto\@evenhead\put@numberlines@box
    \appto\@oddhead\put@numberlines@box
    }
  %
  \gappto\ps@copyright\numberlines@hook
  \numberlines@hook
  %
  \newbox\numberlines@box
  \newskip\numberlines@box@skip
  %
  \def\set@numberlines@box{%
    \setlength\numberlines@box@skip\headsep
    \addtolength\numberlines@box@skip{5\p@}%
    %
    \setbox\numberlines@box\vtop to\textheight{%
      \parindent=\z@
      \vskip\z@
      \@tempcnta=0%
      \@tempdima=\z@
      \loop
        \advance\@tempcnta by 1%
        \advance\@tempdima by \baselineskip
        \hbox to\textwidth{%
          \llap{\numberlines@size\the\@tempcnta\kern\numberlines@skip}%
          \hfill
          \rlap{\numberlines@size\kern\numberlines@skip\the\@tempcnta}%
          }%
      \ifdim\@tempdima<\textheight\repeat
      \vss
      }%
    %
    \ht\numberlines@box=\z@
    \dp\numberlines@box=\z@
    }
  %
  \def\put@numberlines@box{\lower\numberlines@box@skip\hbox to\z@{\hss\copy\numberlines@box}}
  %
  \AtBeginDocument{\set@numberlines@box}
  %
\fi

%% caption
% \RequirePackage{caption}
% \captionsetup{margin=0pt,font=small,labelfont=bf,labelsep=period}
% \captionsetup[table]{position=top}
% \renewcommand\figurename{Fig.}

\def\floatfmt{\centering}
\appto\@floatboxreset\floatfmt

\newtoks\fm@temp@toks
\newenvironment{frontmatter}
  {%
    \global\@firstauthortrue
    \let\saved@thefootnote\thefootnote
  }{%
    \do@pdfmeta@authors
    \maketitle
    \csname check@articletype@pretitle@status\endcsname
  }

\def\init@standard@footnote{%
  \ifdefined\init@standard@footnote@done
  \else
    \gdef\init@standard@footnote@done{1}%
    \global\let\thefootnote\saved@thefootnote
    \setcounter{footnote}{0}%
  \fi
  }

%% lists
\setlength{\parskip}{0ex plus0.1ex minus0.1ex}
\setlength{\parindent}{2em}

\RequirePackage{enumitem}
\setlist{nosep, leftmargin=1.5em, labelwidth=0.25em}
\raggedbottom

\IfFileExists{vtexnatbib.sty}
  {\RequirePackage[authoryear,round]{vtexnatbib}}
  {\RequirePackage[authoryear,round]{natbib}}
  
\let\code\texttt
\let\proglang\textsf
\newcommand{\pkg}[1]{{\fontshape{it}\selectfont #1}}
  
\setlength{\bibsep}{0em}

\def\MR@url{https://www.ams.org/mathscinet-getitem?mr=}
\def\MR#1{\href{\MR@url#1}{MR#1}}

\RequirePackage{xcolor}
\definecolor{linkblue}{rgb}{0 0.4235 0.6392}
\RequirePackage{hyperref}
\hypersetup{%
  colorlinks=true,
  pdfborder={0 0 1},
  linkcolor=linkblue,
  citecolor=linkblue,
  urlcolor=linkblue,
  breaklinks,
  hypertexnames=false
  }



%% >>> startlocaldefs, endlocaldefs >>>
\let\check@localdefs@status\relax
\def\startlocaldefs{%
  \gdef\check@localdefs@status{\dbl@error{Missing command \string\endlocaldefs!}}%
  \gdef\startlocaldefs{\dbl@error{Command \string\startlocaldefs already exists!}}%
  \makeatletter}
\def\endlocaldefs{%
  \makeatother
  \ifx\check@localdefs@status\relax
    \gdef\check@localdefs@status{\dbl@error{Missing command \string\startlocaldefs!}}%
  \else
    \global\let\check@localdefs@status\relax
  \fi
  \gdef\endlocaldefs{\dbl@error{Command \string\endlocaldefs already exists!}}%
  }
\AtBeginDocument{\check@localdefs@status}%
%% <<< startlocaldefs, endlocaldefs <<<

%% >>> \bid >>>
\define@key{bid}{mr}{\def\bid@mr{\MR{#1}}}
\define@key{bid}{doi}{\def\bid@doi{\doiurl{#1}}}
\define@key{bid}{pubmed}{}
\define@key{bid}{pii}{}

\def\bid#1{%
  \bgroup
  \let\bid@output\@empty
  \setkeys{bid}{#1}\ignorespaces%
  % Output sequence:
  % <MR>. <DOI>
  \ifdefvoid\bid@mr{}{\appto\bid@output{\bid@mr}}%
  \ifdefvoid\bid@doi{}{%
    \ifdefempty\bid@output{}{\appto\bid@output{. }}% separator if output not empty
    \appto\bid@output{\bid@doi}%
    }%
  \bid@output
  \egroup
  }

\def\set@proof@mr{%
  \define@key{bid}{mr}{%
    \@nameuse{startchkuriskip}%
    \safe@href{https://www.ams.org/mathscinet-getitem?mr=##1}{MR##1}%
    \@nameuse{endchkuriskip}%
    \ignorespaces
    }%
  \define@key{bid}{doi}{%
    \ifnum\doc@stage<200\relax
      \@nameuse{startchkuriskip}%
      \safe@href{\doi@base ##1}{\doi@base ##1}%
      \@nameuse{endchkuriskip}%
      \space
    \fi
    }%
  }
\def\set@crc@mr{%
  \define@key{bid}{mr}{%
    \if@sici
      \global\@biblinktrue
    \fi
    \ignorespaces
    }%
  }
%% <<< \bid <<<

\frenchspacing

%% >>> Metadata >>>
\def\@publisher{School of Statistics, Renmin University of China}  
\def\@publisheraddress{No. 59 Zhongguancun Street, Haidian
  District Beijing 100872, P.R. China}
\def\@issn{1680-743X}
\def\@eissn{1683-8602}
\def\@articletype{}
\def\articletype#1{\gdef\@articletype{#1}}
\@onlypreamble\articletype
\def\aid#1{\gdef\@aid{#1}}
%% <<< Metadata <<<

%% >>> Frontmatter >>>
\def\@pretitle{}
\def\pretitle#1{\gdef\@pretitle{#1}}
\newenvironment{aug}
  {}
  {%
    \global\let\thefootnote\saved@thefootnote
    \setcounter{footnote}{\the\c@authornote}% footnote counter is continuous with authornote
  }

\ifdefined\HCode
\else
  \def\lmr@font@fix{%
    \DeclareFontShape{T1}{lmr}{b}{sc}{<->ssub*cmr/bx/sc}{}
    \DeclareFontShape{T1}{lmr}{bx}{sc}{<->ssub*cmr/bx/sc}{}
    }
  \@nameuse{\rmdefault @font@fix}
\fi
  
%% >>> author setup >>>
\def\author@font{\fontsize{\@xipt}{17pt}\scshape}
\def\author@preskip{2\p@}
\newif\if@firstauthor
\newif\if@newelem
\let\cmd@for@aut@elem\@gobblethree
\let\mdforvkt\@gobblethree
\let\orcid\@gobble

\newcounter{author}
  
\protected\def\fmt@snm#1{\textsc{#1}}
\protected\def\fmt@fnms#1{\textsc{#1}}
   
\let\write@aux@au\@gobbletwo
\protected\def\@write@aux@au#1#2{%
  \protect\protected@write\@auxout{}{\string\global\string\@namedef{metadata@\author@num @#1}{#2}}%
  }

\def\front@author@eval@emails{%
  \let\bio\@gobble
  \let\fnms\@gobble
  \let\snm\@gobble
  \let\inits\@gobble
  \let\prefix\@gobble
  \let\degs\@gobble
  \let\suffix\@gobble
  \let\roles\@gobble
  \let\~\empty
  }
  
\def\front@author@defs{%
  \let\bio\@gobble
  \let\write@aux@au\@write@aux@au
  \protected\def\degs##1{##1}%
  \protected\def\prefix##1{%
    \write@aux@au{prefix}{##1}%
    \fmt@prefix{##1}%
    }%
  \protected\def\fnms##1{\fmt@fnms{##1}}%
  \protected\def\inits##1{%
    \def\@inits{##1}%
    \write@aux@au{inits}{##1}%
    }%
  \protected\def\snm##1{%
    \def\@snm{##1}%
    \write@aux@au{snm}{##1}%
    \fmt@snm{##1}%
    }%
  \protected\def\suffix##1{##1}%
  \protected\def\roles##1{##1}%
  }
  
\def\author{%
  \@ifnextchar[%
    {\author@optarg}
    {\author@optarg[]}%
  }
  
\def\author@optarg[#1]#2{%
  %% headings will use authors 
  \global\let\output@head@authors\@output@head@authors
  \stepcounter{author}%
  \beg@elem
  \@for\@tempa:=#1\do{\expandafter\add@addressref\expandafter{\@tempa}}%
  \let\oldunderscore\_%
  \let\_\textunderscore
  \init@fm@element{author}{#2}%
  \let\_\oldunderscore
  \csxdef{author\the\c@author}{\expandonce{\@author}}%
  \protected\csxdef{author\the\c@author t@loc@notes}{\the\t@loc@notes}%
  \@ifundefined{author@list}
    {%
      \xdef\author@list{author\the\c@author}%
    }{%
      \xappto\author@list{,author\the\c@author}%
    }%
  \bgroup
    \front@author@eval@emails  
    \setbox\z@=\hbox{#2}%  
  \egroup
  \csname author@end@hook\endcsname
  }%

\newtoks\pdfmeta@authors
\def\addto@pdfmeta@authors#1{%
  \begingroup
    \xdef\@act{\global\noexpand\pdfmeta@authors{\the\pdfmeta@authors#1}}%
    \@act
  \endgroup
  }
  
\def\do@pdfmeta@authors{%
  \@tempcnta\z@
  \@whilenum\@tempcnta<\c@author\do{%
    \advance\@tempcnta\@ne
    \ifnum\@tempcnta>\@ne
      \addto@pdfmeta@authors{, }%
    \fi
    \addto@pdfmeta@authors{%
      \@ifundefined{metadata@\the\@tempcnta @inits}{}{%
        \@nameuse{metadata@\the\@tempcnta @inits}%
        \space 
        }%
      \@nameuse{metadata@\the\@tempcnta @snm}%
      }%
    }%
  \hypersetup{%
    pdfinfo={%
      Title={\@title},
      Subject={},
      Author={\the\pdfmeta@authors},
      Creator={VTeX},
      Producer={VTeX},
      }%
    }%
  }

\def\author@num{0}  
\def\get@author@num author#1\relax{\def\author@num{#1}}  
\def\author@sep{, }
\def\author@twosep{ and }
\def\author@lastsep{, and }

\def\set@author@sep{%
  \ifnum \author@num>1\relax
    \ifnum \author@num=\the\c@author\relax
      \ifnum\author@num=2\relax
        \let\@author@sep\author@twosep
      \else
        \let\@author@sep\author@lastsep
      \fi    
    \else
      \let\@author@sep\author@sep
    \fi
  \else
    \let\@author@sep\empty
  \fi
  }
  
\newtoks\temptoks
\def\author@fmt#1#2#3{%
  \ifdefined\author@fmt@init@done
  \else
    \author@fmt@init
  \fi
  \bgroup
    \author@font
    \get@author@num #3\relax
    \set@author@sep
    \@author@sep
    \@nameuse{#3}%
    \edef\@tempb{#2}%
    \ifx\@tempb\@empty
    \else
      \fm@textsuperscript{#2}%
    \fi
  \egroup
  }
\def\fm@textsuperscript#1{%
  %$^{\mathrm{\scriptsize #1}}$%
  \unskip\textsuperscript{{\normalfont #1}}%
  }

\def\author@fmt@init{%
  \gdef\author@fmt@init@done{1}%
  \vskip\author@preskip
  \leavevmode
  }

\def\author@note@fmt{%
  \def\thefootnote{\sxarabic{footnote}}}

\def\sxarabic#1{%
  \expandafter
  \ifcase\value{#1}%
  \or *%
  \or **%
  \or ***%
  \or ****%
  \or *****%
  \fi
  }

\def\add@addressref#1{%
  \global\advance\note@cnt\@ne
  \ifnum\note@cnt>\@ne
    \add@xtok\t@loc@notes{\note@sep}%
  \fi
  \add@tok\t@loc@notes{\ref{aff.#1}}%
  }
\def\note@sep{,}
%% <<< author setup <<<

%% >>> affil setup >>>
\newcounter{address}
\def\address@font{\mdseries\slshape\small}
\def\address@preskip{5\p@}
\def\address{%
  \@ifstar
    {\address@star}
    {\@ifnextchar[{\address@optarg}{\address@noptarg}}%
  }

\def\address@optarg[#1]#2{%
  \refstepcounter{address}%
  \beg@elem
  \init@fm@element{address}{#2}%
  \csxdef{address\the\c@address @counter}{\the\c@address}%
  \temptoks=\expandafter{\@address}%
  \csxdef{address\the\c@address}{\the\temptoks}%
  \protected\csxdef{address\the\c@address t@loc@notes}{\the\t@loc@notes}%
  \@ifundefined{address@list}
    {%
      \xdef\address@list{address\the\c@address}%
    }{%
      \xappto\address@list{,address\the\c@address}%
    }%
  \label{aff.#1}%
  \csname address@end@hook\endcsname
  \ignorespaces
  }

\def\address@noptarg#1{%
  \refstepcounter{address}%
  \beg@elem
  \init@fm@element{address}{#1}%
  \csxdef{address\the\c@address @counter}{\z@}%
  \temptoks=\expandafter{\@address}%
  \csxdef{address\the\c@address}{\the\temptoks}%
  \protected\csxdef{address\the\c@address t@loc@notes}{\the\t@loc@notes}%
  \@ifundefined{address@list}
    {%
      \xdef\address@list{address\the\c@address}%
    }{%
      \xappto\address@list{,address\the\c@address}%
    }%
  \csname address@end@hook\endcsname
  \ignorespaces
  }

\def\address@star#1{%
  \beg@elem
  \init@fm@element{address}{#1}%
  \address@fmt{\m@ne}{\the\t@loc@notes}{\@address}%
  \ignorespaces
  }

\def\theaddress{\the\c@address}

\def\address@fmt#1#2#3{%
  \ifdefined\address@fmt@init@done
  \else
    \address@fmt@init
  \fi
  \bgroup
    \def\baselinestretch{1}%
    \address@font
    \ifnum#1=\z@
      #3\,\fm@textsuperscript{#2}\space
    \else
      \ifnum#1=\m@ne
        \phantom{\fm@textsuperscript{#1}\,}#3\,\fm@textsuperscript{#2}%
      \else
        \fm@textsuperscript{#1}#3\fm@textsuperscript{#2}%
      \fi
    \fi
    \par
  \egroup
  }
\def\address@fmt@init{%
  \gdef\address@fmt@init@done{1}%
  \vskip\address@preskip
  \leavevmode
  }
%% <<< affil setup <<<

%% >>> \beg@elem, \proc@elem (based on iosart2x.cls) >>>
\def\beg@elem{%
  \global\t@loc@notes={}%
  \global\note@cnt\z@
  }
\def\@xnamedef#1{%
  \expandafter\xdef\csname #1\endcsname
  }
\def\no@harm{%
  \let\\=\relax  \let\rm\relax
  \let\ss=\relax \let\ae=\relax \let\oe=\relax
  \let\AE=\relax \let\OE=\relax
  \let\o=\relax  \let\O=\relax
  \let\i=\relax  \let\j=\relax
  \let\aa=\relax \let\AA=\relax
  \let\l=\relax  \let\L=\relax
  \let\d=\relax  \let\b=\relax \let\c=\relax
  \let\bar=\relax
  \def\qq@group@start{}\def\qq@group@end{}\let\qq@cmd\@firstofone\def\qq@style{}%
  \def\protect{\noexpand\protect\noexpand}%
  }

\def\thanks#1#{\@gobble}
\def\thanksref#1#{\@gobble}

\def\proc@elem#1#2{%
  \begingroup
    \no@harm
    \def\thanks##1##{\@gobble}%
    \def\thanksref##1##{\@gobble}%
    \csgdef{@#1}{#2}%
  \endgroup
  \prev@elem=\cur@elem
  \cur@elem=\csname e@#1\endcsname
  \elem@nothanks#2\thanks\relax
  \elem@nothanksref#2\thanksref\relax
  }
%% <<< \beg@elem, \proc@elem (based on iosart2x.cls) <<<

%% >>> thanks macro block >>>
\newtoks\t@glob@notes
\newtoks\t@loc@notes
\newcount\note@cnt
\newcount\c@ThanksID
\newcount\prev@elem \prev@elem=0
\newcount\cur@elem  \cur@elem=0
\chardef\e@pretitle=1
\chardef\e@title=1
\chardef\e@subtitle=1
\chardef\e@author=2
\chardef\e@address=3

\newif\if@thankshyperlink \global\@thankshyperlinkfalse

\def\add@tok#1#2{%
  \global#1\expandafter{\the#1#2}%
  }
\def\add@xtok#1#2{%
  \begingroup
    \no@harm
    \xdef\@act{%
      \global\noexpand#1{\the#1#2}%
      }%
    \@act
  \endgroup
  }
  
\def\@fnsymbol#1{%
  \ifcase #1%
  \or \TextOrMath \textdagger \dagger 
  \or \TextOrMath \textdaggerdbl \ddagger 
  \or \TextOrMath \textsection \mathsection 
  \or \TextOrMath \textparagraph \mathparagraph 
  \or \TextOrMath \textbardbl \|%
  \or \TextOrMath {\textasteriskcentered \textasteriskcentered }{**}%
  \or \TextOrMath {\textdagger \textdagger }{\dagger \dagger }%
  \or \TextOrMath {\textdaggerdbl \textdaggerdbl }{\ddagger \ddagger }%
  \else \@ctrerr \fi} 

\newcounter{correspnote}
\def\corresp@note@counter{correspnote}

\newcounter{titlenote}
\def\title@note@counter{titlenote}
\def\subtitle@note@counter{titlenote}
\def\relatedarticle@note@counter{titlenote}
\def\correctionnote@note@counter{titlenote}
\def\correctedarticle@note@counter{titlenote}
\def\commentaryarticle@note@counter{titlenote}

\newcounter{authornote}
\def\author@note@counter{authornote}
\def\theauthornote{\fnsymbol{authornote}}
\def\thecorrespnote{%
  \ifcase\c@correspnote\relax
  \or
    $\ast$%
  \or
    $\ast\ast$%
  \or
    $\ast\ast\ast$%
  \fi
  }%
\def\thetitlenote{%
  \ifcase\c@titlenote\relax
  \or
    \protect\ding{73}%
  \or
    \protect\ding{73}\protect\ding{73}%
  \or
    \protect\ding{73}\protect\ding{73}\protect\ding{73}%
  \fi
  }%
\let\thesubtitlenote\thetitlenote

\let\thanks@id\@empty
\let\thanks@mark\@empty
\let\thanks@type\@empty
\define@key{thanks}{id}{\def\thanks@id{#1}}
\define@key{thanks}{mark}{\def\thanks@mark{#1}}
\define@key{thanks}{type}{\def\thanks@type{#1}}
\def\reset@thanks{%
  \let\thanks@id\@empty
  \let\thanks@mark\@empty
  \let\thanks@type\@empty
  }
\def\thanks@optarg@fmt#1#2{%
  \freefootnotetext[#1]{#2}%
  }
\def\thanks@optarg[#1]#2{%
  \let\thanks@type\@empty
  \setkeys{thanks}{#1}%
  \ifx\thanks@type\@empty
    \let\thanks@type\fm@object
  \fi
  \edef\current@counter{\csname\thanks@type @note@counter\endcsname}%
  \refstepcounter{\current@counter}%
  \setcounter{footnote}{\the\csname c@\current@counter\endcsname}%
  \def\thefootnote{\csname the\current@counter\endcsname}%
  \edef\thanks@optarg@id{\thanks@type.thanks\the\c@footnote.\jobname}%
  \@@@Label{\thanks@optarg@id}%
  \if@thankshyperlink %% TODO: make active links
    \ifx\thanks@id\@empty%
      \Hy@GlobalStepCount\Hy@linkcounter
      \xdef\thanks@currentHref{\thanks@type.thanks\the\c@footnote.\jobname.\the\Hy@linkcounter}%
      \edef\my@hy@tmp{\noexpand\hypertarget{\thanks@currentHref}{}}%
      %\edef\my@hy@tmp{\noexpand\hypertarget{\@currentHref}{}}% in case \refstepcounter{footnote} is used
    \else
      \edef\my@hy@tmp{\noexpand\hypertarget{\thanks@id thanks}{}}%
    \fi
    %\expandafter\add@tok\expandafter\t@glob@notes\expandafter{\expandafter{\my@hy@tmp #2}}%
    \ifx\thanks@mark\@empty
      \def\thanks@mark{\thefootnote}%
    \fi
    \freefootnotetext[\thanks@mark]{{\my@hy@tmp #2}}%
  \else
    \ifx\thanks@mark\@empty
      \def\thanks@mark{\thefootnote}%
    \fi
    \thanks@optarg@fmt{\thanks@mark}{#2}%
  \fi
  \csname end@thanks@optarg@hook\endcsname
  \ignorespaces
  }%
\def\freefootnotetext[#1]{%
  \begingroup
    \unrestored@protected@xdef\@thefnmark{#1}%
  \endgroup
  \@footnotetext
  }
%% TODO: do we need \tailthanksref?
\def\tailthanksref[#1]#2{%
  \noexpand\pthanksref{#1}%
  }
\def\pthanksref#1{%
  \global\advance\note@cnt\@ne
  \ifnum\note@cnt>\@ne
    \global\t@loc@notes\expandafter{\the\t@loc@notes\note@sep}%
  \fi
  \global\t@loc@notes\expandafter{\the\t@loc@notes#1}%
  }
  
\def\elem@nothanksref#1\thanksref{%
  \futurelet\@peektok\elem@thanksref
  }
\def\elem@thanksref{%
  \ifx\@peektok\relax
  \else
    \expandafter\elem@morethanksref
  \fi
  }
\def\elem@morethanksref#1{%
  \csxdef{#1@thankstext@type}{\fm@object}%
  \csletcs{thankstext@type}{#1@thankstext@type}%
  \add@thanks{id=#1}%
  \elem@nothanksref
  }
  
\def\elem@nothanks#1\thanks{%
  \futurelet\@peektok\elem@thanks
  }
\def\elem@thanks{%
  \ifx\@peektok\relax
  \else
    \ifx\@peektok[%
      \expandafter\expandafter\expandafter\elem@morethankse
    \else
      \expandafter\expandafter\expandafter\elem@morethanks
    \fi
  \fi
  }
\def\elem@morethankse[#1]#2{%
  \thanks@optarg[#1]{#2}%
  \add@thanks{#1}%
  \elem@nothanks
  }
\def\elem@morethanks#1{%
  \thanks@optarg[]{#1}%
  \add@thanks{}%
  \elem@nothanks
  }
  
\define@key{thankstext}{type}{\gdef\thankstext@type{#1}}
\define@key{thankstext}{id}{\gdef\thankstext@id{#1}}
\def\reset@thankstext{%
  \let\thankstext@id\@empty
  \let\thankstext@mark\@empty
  \let\thankstext@type\@empty
  }
\def\thankstext@fmt#1#2{%
  \freefootnotetext[#1]{#2}%
  }
\def\thankstext[#1]#2{%
    \reset@thankstext
    \setkeys{thankstext}{#1}%
    \ifx\thankstext@type\@empty
      \csletcs{thankstext@type}{\thankstext@id @thankstext@type}%
    \fi
    \edef\current@counter{\csname\thankstext@type @note@counter\endcsname}%
    \refstepcounter{\current@counter}%
    \setcounter{footnote}{\the\csname c@\current@counter\endcsname}%
    \def\thefootnote{\csname the\current@counter\endcsname}%
    \@@@Label{\thankstext@id}%
    \thankstext@fmt{\thefootnote}{\csname \thankstext@type @prehook\endcsname #2\csname \thankstext@type @posthook\endcsname}%
  }

  
\define@key{addthanks}{id}{\def\addthanks@id{#1}}
\define@key{addthanks}{mark}{\def\addthanks@mark{#1}}
\define@key{addthanks}{type}{\def\addthanks@type{#1}}
\def\reset@addthanks{%
  \let\addthanks@id\@empty
  \let\addthanks@mark\@empty
  \let\addthanks@type\@empty
  }
\def\add@thanks#1{%
  \reset@addthanks
  \setkeys{addthanks}{#1}%
  \global\advance\note@cnt\@ne
  \ifnum\note@cnt>\@ne
    \add@xtok\t@loc@notes{\note@sep}%
  \fi
  \if@thankshyperlink %% TODO: make active links
    \ifx\addthanks@id\@empty
      \add@xtok\t@loc@notes{\protect\Hy@breaklinkstrue
        \protect\hyper@linkstart{link}{\thanks@currentHref}\thefootnote\protect\hyper@linkend}%
        %\protect\hyper@linkstart{link}{\@currentHref}\thefootnote\protect\hyper@linkend}%
    \else
      \add@xtok\t@loc@notes{\protect\Hy@breaklinkstrue
        \protect\hyper@linkstart{link}{\addthanks@id thanks}\addthanks@id\protect\hyper@linkend}%
    \fi%
  \else
    \ifx\addthanks@id\@empty
      \def\addthanks@mark{\thefootnote}%
    \else
      \ifx\addthanks@mark\@empty
        \def\addthanks@mark{\@@@Ref{\addthanks@id}}%
      \fi
    \fi
    \add@xtok\t@loc@notes{\addthanks@mark}%
  \fi
  \csname end@add@thanks@hook\endcsname
  }
\newcount\c@sv@footnote
\def\output@glob@notes{%
  \bgroup
    \the\t@glob@notes
  \egroup
  }
%% <<< thanks macro block <<<

%% >>> init FM element setup >>>
\newcommand\init@fm@element[3][]{%
  \def\fm@object{#2}%
  \ifcsname init@fm@#2@done\endcsname
  \else
    \setkeys{#2}{#1}%
  \fi
  \csgdef{init@fm@#2@done}{1}%
  \proc@elem{#2}{#3}%
  }
%% <<< init FM element setup <<<

%% >>> title/subtitle setup >>>

\def\title#1{%
  \beg@elem
  \gdef\@runtitle{\hbox{#1}}%
  \init@fm@element{title}{#1}%
  \protected\csxdef{title@t@loc@notes}{\the\t@loc@notes}%
  \csname title@end@hook\endcsname
  }
\def\subtitle#1{%
  \beg@elem
  \init@fm@element{subtitle}{#1}%
  \protected\csxdef{subtitle@t@loc@notes}{\the\t@loc@notes}%
  \csname subtitle@end@hook\endcsname
  }
\def\title@fmt#1#2{%
  \bgroup
    #1\hbox{\title@textsuperscript{#2}}%
  \egroup
  }
\let\subtitle@fmt\title@fmt
\def\title@textsuperscript#1{\textsuperscript{#1}}
%% <<< title/subtitle setup <<<

%% >>> email >>>
\def\ead@mark{}
\def\ead@href#1#2{\href{#1}{\ead@mark}}
\def\email@prefix{Email:\space}
\def\email@postfix{.}
\def\email@font{ }

\newtoks\email@author@toks
\def\email@author@fmt{\ignorespaces}

%% blocked use of printead.sty in author environment
\newcounter{countead}
\def\ead@hook#1#2{%
    \stepcounter{countead}%
    \ifx.#2.
        \gdef\ead@mark{???}%
    \else
        \gdef\ead@mark{#2}%
    \fi
    }
    
\def\ead@hrefprefix@email{mailto:}
        
\DeclareRobustCommand\ead[2][]{{%
%% few necessary printead.sty definitions
  \define@key{ead}{label}{\def\ead@id{#1}}%
  \define@key{ead}{email}[true]{\def\ead@type{email}}%
  \def\@setead##1##2##3{%
    \bgroup
      \csname @setead@hook\endcsname
      \expandafter\xdef\csname ead@##1@##2\endcsname{##3}%
    \egroup
    }%
  %
  \csname before@ead@hook\endcsname
  \setkeys{ead}{label={},email,#1}%
  \@setead{\ead@id}{options}{#1}%
  \@setead{\ead@id}{type}{\ead@type}%
  \@setead{\ead@id}{value}{#2}%
  \csedef{\ead@id @email@author}{}%
  \def\email@type{email}%
  \ifx\ead@type\email@type
    \ead@hook{#1}{#2}%
    \add@xtok\email@author@toks{%
      \csuse{emailauthor@sep}%
      \ead@href{\ead@hrefprefix@email #2}{#2}%
      }%
    \gdef\emailauthor@sep{\unskip\space or\space}%
  \fi
  \csname after@ead@hook\endcsname
  }\ignorespaces}

\def\output@frontmatter@emails{%
  \bgroup
    \edef\emaillist{\the\email@author@toks}%
    \ifx\emaillist\empty
    \else
      \bgroup
        \email@font
        \email@prefix \the\email@author@toks \email@postfix
      \egroup
    \fi
  \egroup
  }

\protected\def\corresp@posthook{\output@frontmatter@emails} 
%% <<< email <<<

%% >>> history >>>
%% history month - full name
\def\setvaluelist#1#2{%
  \@tempcnta=0\relax
  \@for\@curr@val:=#2\do{%
    \advance\@tempcnta by1\relax
    \expandafter\protected@xdef\csname #1@item@\the\@tempcnta\endcsname{\@curr@val}%
    }%
    \expandafter\protected@xdef\csname #1@item@0\endcsname{\the\@tempcnta}%
  }
\xdef\getitemvalue#1#2{\noexpand\csname #1@item@#2\endcsname}
\def\sday#1{\gdef\@sday{#1}#1}
\def\syear#1{\gdef\@syear{#1}#1}
\def\smonth#1{%
  \gdef\@smonth{#1}%  
  \@ifundefined{month@item@#1}%
    {\@latex@error{There is no month with number '#1'!}\@ehc}%
    {\getitemvalue{month}{#1}}%
  }%
\setvaluelist{month}{January,February,March,April,May,June,July,August,September,October,November,December}
\expandafter\def\csname month@item@0\endcsname{????}

\newif\if@history \@historyfalse
\def\define@history@date#1{%
  \expandafter\def\csname #1\endcsname##1{%
    \def\@tempa{##1}%
    \ifx\@tempa\@empty
    \else
      \csgdef{@#1}{##1}%
    \fi
    }%
  }
\define@history@date{received}
\define@history@date{revised}
\define@history@date{accepted}
\define@history@date{publishedonline}


\def\received@prefix{Received~}
\def\revised@prefix{Revised~}
\def\accepted@prefix{Accepted~}
\def\publishedonline@prefix{Published~online:~}
\if@chinese
  \def\received@prefix{投稿于~}
  \def\accepted@prefix{接收于~}
\fi

\def\received@postfix{}
\def\revised@postfix{}
\def\accepted@postfix{}
\def\publishedonline@postfix{}
\def\history@prefix{}
\def\history@postfix{}

\def\history@sep{%
  \if@history
    ; \allowbreak
  \fi
  }
\def\history@fmt{%
  \history@prefix
  \ifx\@empty\@received
  \else
    \received@prefix\hbox{\@received}\received@postfix
    \@historytrue
  \fi
  \ifx\@empty\@revised
  \else
    \history@sep
    \revised@prefix\hbox{\@revised}\revised@postfix
    \@historytrue
  \fi
  \ifx\@empty\@accepted
  \else
    \history@sep
    \accepted@prefix\hbox{\@accepted}\accepted@postfix
    \@historytrue
  \fi
  \output@publishedonline
  \history@postfix
  }

\def\history@skip{14pt}  
\def\output@frontmatter@history{%
    \vskip\history@skip
    \bgroup
      \small
      \history@fmt
    \egroup
    \par
  }  
%% <<< history <<<

\let\cny\@firstofone
\let\dept\@firstofone
\let\institution\@firstofone
\let\addr\@firstofone
\let\city\@firstofone

\def\dedicated#1{%
  \gdef\@dedicated{#1}%
  }
\def\dedicated@fmt#1{%
  \normalsize\itshape
  #1%
  }
%% <<< Frontmatter <<<

%% fix footnote Postscript /Dest position
\let\orig@H@@footnotetext\H@@footnotetext
\long\def\H@@footnotetext#1{{%
  \def\@pdfview{XYZ}%
  \def\@pdfviewparams{ pdf@hoff pdf@voff \strip@pt\baselineskip\space 72.27 div 72 mul add null}%
  \orig@H@@footnotetext{#1}%
  }}

%% definitions execution after \begin{document} (for tex4ht)
\ifdefined\HCode
  {
  \catcode`#=12\relax
  \catcode`&=6\relax
  \gdef\startlocaldefs{%
    \catcode`#=12\relax
    \makeatletter
    \@startlocaldefs
    }
  \gdef\@startlocaldefs@toks{}%
  \long\gdef\@startlocaldefs&1\endlocaldefs{%
    \long\xdef\@startlocaldefs@toks{\detokenize{&1}}%
    \makeatother
    \catcode`#=6\relax
    }
  }
  \appto\document{\makeatletter\expandafter\scantokens\expandafter{\@startlocaldefs@toks}\makeatother}%
\fi

%% Acknowledgement
\define@key{acknowledgement}{title}{\def\acknowledgement@title{#1}}
\def\acknowledgement@title{Acknowledgement}
\newenvironment{acknowledgement}[1][]%
  {%
    \setkeys{acknowledgement}{#1}%
    \section*{\acknowledgement@title}%
  }{%
    \par
  }

%% >>> Funding >>>
\def\funding@font{\normalfont \Large \bfseries}

\def\@afterbox{%
  \everypar{%
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
      \if@afterindent \else
        {\setbox\z@\lastbox}%
        \everypar{}%
      \fi
    \else
      \clubpenalty \@clubpenalty
      {\setbox\z@\lastbox}%
      \everypar{}%
    \fi
    }%
  }
  
\newenvironment{Env@EndOfContrib}[1]
  {%
    \if@noskipsec\leavevmode\fi
    \par
    \@afterindenttrue
    \if@nobreak
      \everypar{}%
    \else
      \addpenalty\@secpenalty\addvspace\baselineskip
    \fi
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
        {\setbox\z@\lastbox}%
        \clubpenalty\@M
        {%
          %\sffamily
          \funding@font
          #1\\\\%
        }%
        %\unskip\hskip0.5em\relax
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi
      }%
    \ignorespaces
  }{%
    \par
    \vskip\baselineskip
    \aftergroup\@afterbox
  }

\define@key{gsponsor}{id}{\def\gsponsor@id{#1}}
\define@key{gsponsor}{sponsor-id}{\def\gsponsor@sponsorid{#1}}
\define@key{gnumber}{refid}{\def\gnumber@refid{#1}}

\def\gsponsor@fmt#1{#1}
\def\gnumber@fmt#1{#1}

\newcommand\gsponsor[2][]{%
  \bgroup
    \setkeys{gsponsor}{#1}%
    \gsponsor@fmt{#2}%
  \egroup
  }
\newcommand\gnumber[2][]{%
  \bgroup
    \setkeys{gnumber}{#1}%
    \gnumber@fmt{#2}%
  \egroup
  }

\def\fundingname{Funding}
\def\funding{\Env@EndOfContrib\fundingname}
\let\endfunding\endEnv@EndOfContrib
%% <<< Funding <<<

%% >>> esm environment for xml >>>
\def\esm@titlesep{}
\def\esm{%
  \@ifnextchar[%
    \@esm
    {\@esm[]}%
  }
\def\@esm[#1]{%
  \bgroup
  \par
  \def\esmtitle##1{%
    \section*{##1}%
    \esm@titlesep}%
  \def\esmdescription{\@firstofone}%
  \def\esmfiletype{\@gobble}%
  \def\esmfilename{\@gobble}%
  }
\def\endesm{\egroup}
%% <<< esm environment for xml <<<

\newenvironment{backmatter}{\goodbreak\ignorespaces}{}

\newenvironment{biography}{%
  \par\smallskip
  \def\author##1{\noindent\textbf{##1}}%
  \def\photofilename##1{%
    \includegraphics[scale=1]{##1}\\
    }%
  }%
 {}%

\newdimen\tablewidth
\tablewidth=\textwidth
\belowcaptionskip=4pt

%%%%%%%%%%%%%%% CONTTABLE
\newtoks\table@head

\long\def\thead#1\endthead{\global\table@head{#1}#1}
\def\contthead{\the\table@head}

\let\contpart\relax

\newenvironment{conttable}{%
  \let\footnoterule\relax
  \tablewidth=\hsize
  \@float{table}}
  {\end@float}

\newenvironment{conttable*}{%
  \let\footnoterule\relax
  \tablewidth=\textwidth
  \@dblfloat{table}}
  {\end@dblfloat}

\newenvironment{sidewaysconttable}{%
  \@rotfloat{table}}
  {\end@rotfloat}

%%%%%%%%%%%%%%% CONTCAPTION 

\def\contcaptionbraces#1#2{\gdef\contcaptionbraces@left{#1}\gdef\contcaptionbraces@right{#2}}
\contcaptionbraces()

\def\contcaption#1{\caption{\contcaptionbraces@left\textit{#1}\contcaptionbraces@right}}

\def\continued#1{\rightline{(\textit{#1})}}

\@namedef{contfigure*}{\@nameuse{figure*}}
\@namedef{endcontfigure*}{\@nameuse{endfigure*}}
\let\contfigure\figure
\let\endcontfigure\endfigure

\let\tsub\textsubscript
\let\tsup\textsuperscript

\RequirePackage{marginnote}
% \reversemarginpar
\setlength{\marginparwidth}{2.4cm}

\endinput
%%
%% End of file `jds.cls'.
