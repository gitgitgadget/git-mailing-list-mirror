From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC v2] Git User's Survey 2008
Date: Wed, 20 Aug 2008 03:08:25 +0200
Message-ID: <200808200308.26308.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 03:09:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVcCi-0004LY-6u
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 03:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbYHTBIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 21:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbYHTBIf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 21:08:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:14720 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbYHTBId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 21:08:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so115617nfc.21
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 18:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yCWar2H+Phh/kenvQyepvLogapv3K2Qp3x+1IoU4Yv0=;
        b=Xzl1a7yCZXYtvR05t0qu+tz1WwsnkP6/2KnFnq64RDGGrczXlpmXSWeGdvtp5UzWzB
         fnKqDLGdnrcvJfqy/Ws9WCCEc8aecLq7O32sOMXYIMovVYm4m+ASlGBBmFUA+LOJI+cA
         ImcM/RppQDHJ/6nIkpxmW4nDMsMvG3wiF06jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jBWbL3kaHgbtpP1Mx+2DDTbkmVb+a/QnelwQqiJzoTqBQSDGbiU410mjyk2MEqJ3Am
         jx2olfiMOAv7LLUGOkbtvV11CPmSk0rbRPNQCpUebH297sGnQWGJi31tagSPwFVphwvP
         2OgWXy+rriKRVKgQK66djg+pPR+Q51cpsdcxU=
Received: by 10.210.66.1 with SMTP id o1mr2005853eba.25.1219194510369;
        Tue, 19 Aug 2008 18:08:30 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.231.175])
        by mx.google.com with ESMTPS id b30sm1333450ika.3.2008.08.19.18.08.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 18:08:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200807230325.04184.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92948>

This is second revision (version) of proposed questions 
for Git User's Survey 2008.


First, it was decided that it would be web based survey; I would use
survs.com (new, in beta), unless free version expires or acquires
unbearable restrictions (like no more than 10 questions, no more than
100 replies some survey sites have for non-paid accounts), because it
has some nice features, and allows export of results to CSV format for
further analysis... but I have not checked if the site that was used
for earlier, 2006 and 2007 surveys (http://www.survey.net.nz) doesn't
have those features now (it didn't have when 2007 survey was run).

Note that new features like "matrix" questions and ability to have
'other' selection for single choice and multiple choice questions
affect a bit form of this survey.


Second, what questions should be put in the survey, and in the case of
single choice and multiple choice questions what possible answers
should be?  I'd rather avoid free-form questions, even if they are
more interesting, as they are PITA to analyze and summarize,
especially to create some kind of histogram from free-form replies
data (some of 2007 free-form responses are not fully summarized even
now).  Below there are proposals for questions for this year survey.
Please comment on them.

By the way, should the survey be divided in pages, or simply use
headers to divide survey into sections?


Third, where to send survey to / where to publish information about the 
survey?  Last year the announcement was send to git mailing list, to
LKML (Linux kernel mailing list), and mailing list for git projects 
found on GitProjects page on GIT wiki.  Now that the number of projects 
using Git as version control system has grown, I don't think it would 
be good idea to "spam" all those mailing list; and if we don't send 
notice to all other projects I'm not sure if we should include LKML.

Last year survey announcement was put on Git Homepage (thanks Pasky), 
and on front page of Git Wiki; info about survey was also put on two 
git hosting sites: kernel.org and repo.or.cz.  It would be nice if it 
was possible to put announcement about Git User's Survey 2008 at front 
pages of other Git hosting sites, like GitHub (one of most popular, I 
think), Gitorious, Freedesktop.org.  If you know some other popular Git 
hosting sites, and even better if you know who to contact about putting 
survey announcement, please write.  Is there some channel that I have 
forgot about?  Should info/announcement about Git User's Survey 2008 be 
sent also to one of on-line magazines like LinuxToday or LWN, or asked 
to put on some blog?  I'll add it as journal entry for #git on Ohloh, 
and try to make it so it would appear in "News" section for Ohloh 
project page for Git: http://www.ohloh.net/projects/git.

Survs.com has nice feature of "channels", which allow to count
responses sent via different means separately; I am using it to
publish URL for 'test' channel - answers from this channel won't be
counted AT ALL!!!


Fourth, how long should the survey last?  When sending announcement we 
should say where notice about Git User's Survey 2008 should be taken 
down.  Last year the survey was meant to take three weeks, but was up 
longer.  I'm thinking about having it last a month, or a month and a
half, starting from September 1.


Below there is second version of announcement email (I should probably
come up also with boilerplate announcement for web pages), and second
version of this year round of questions.  Comments are prefixed by
'+', and would not necessary be included in the survey text.

Questions which were reworked are included in square brackets '[...]',
while old version of answers or comments are prefixed with '!'.

BTW should this survey be divided into pages or not (if it will be
on Survs.com, as it is now)?

----
Hi all,

We would like to ask you a few questions about your use of the Git
version control system. This survey is mainly to understand who is
using Git, how and why.

The results will be published to the Git wiki and discussed on the git
mailing list.

We'll close the survey in <duration> starting from today, <date>.

Please devote a few minutes of your time to fill this simple
questionnaire, it will help a lot the git community to understand your
needs, what you like of git, and of course what you don't like  of it.

The survey can be found here:
  http://www.survs.com/survey?id=M3PIVU72&channel=9XYYGHJ77G

(this is temporary channel URL; responses to this URL would
be, I guess, discarded).
----
About you

   xx. What country are you in?
       (free form; it would be nice to have pre-filled pull-down
        menu, i.e. select form.  Survs.com doesn't support it, yet)
   xx. How old are you (in years)?
       (free form, integer)
   xx. Which programming languages you are proficient with?
       (zero or more: multiple choice)
     - C, shell, Perl, Python, Tcl/Tk, C++, C#, Java, PHP,
       Ruby, Emacs Lisp, Common Lisp or Scheme, Visual Basic,
       Delphi, Assembly, other (please specify), I am not programmer
     ! C, shell, Perl, Python, Tcl/Tk
     + First version included only programming languages used
       by git, and some from contrib area


Getting started with GIT

   xx. How did you hear about Git?
       (single choice?, in 2007 it was free-form)
     - Linux kernel news (LKML, LWN, KernelTrap, KernelTraffic,...),
       news site or magazine, blog entry, some project uses it,
       presentation or seminar (real life, not on-line), SCM research,
       IRC, mailing list, told by friend, word of mouth (off-line),
       other Internet, must be used at job, other off-line, other(*)
     + the problem is with having not very long list (not too many
       choices), but spanning all possibilities.
     + is this question interesting/important to have in survey?
   xx. Did you find GIT easy to learn?
     - very easy/easy/reasonably/hard/very hard
   xx. What helped you most in learning to use it?
       (free form question)
   xx. What did you find hardest in learning Git?
       What did you find hardest in using Git?
       (free form question)
   xx. Which Git version(s) are you using?
       (zero or more, multiple choice:
        one can use different versions on different machines)
     - pre 1.3, 1.3, 1.4, 1.5, 1.6, master, next
     + might be important when checking "what did you find hardest" etc.
     + perhaps we should ask in addition to this question, or in place
       of this question (replacing it) what git version one uses; it
       should be multiple choice, and allow 'master', 'next', 'pu',
       'dirty (with own modifications)' versions in addition.
   xx. How long do you use Git?
     - never/less than month/1-3 months/3-6 months/6-12 months/
       1-2 year/more than 2 years/from the beginning
     ! never/few days/few weeks/month/few months/year/few years/
       from beginning/I wrote it(*)
     + (*) just kidding ;-)
   xx. Does git.git repository include code produced by you?
     - yes/no


Other SCMs (shortened compared with 2007 survey)

   xx. What other SCM did or do you use?
     ! (zero or more: multiple choice)
       (matrix with the following columns: never/used it/still use)
     - SCCS, RCS, CVS, Subversion, Arch or clone (ArX, tla, ...),
       Bazaar-NG, Darcs, Mercurial, Monotone, SVK, AccuRev, Perforce,
       BitKeeper, ClearCase, MS Visual Source Safe, MS Visual Studio
       Team System, PVCS, custom, other (please specify)
   xx. Why did you choose/use Git? (if you use Git)
       What do you like about using Git?
       (free form, not to be tabulated)
   xx. Why did you choose/use other SCMs? (if you use other SCMs)
       What do you like about using other SCMs?
       Note: please write name of SCMs you are talking about.
       (free form, not to be tabulated).
   xx. Do you miss features in git that you know from other SCMs?
       If yes, what features are these (and from which SCM)?
       (free form, not to be tabulated).
     + suggested by Stephan Beyer


How you use Git

  [xx. Do you use Git for work, unpaid projects, or both?
       (single choice)
     - work/unpaid projects/both]
   xx. I use Git for (check all that apply):
     - work projects, unpaid projects, proprietary code development,
       OSS development, private (unpublished) development, personal data,
       documents, website or web app, sharing data, backup, 
       wiki/blog backend, frontend to other SCM (git-svn, git-p4),
       other (if interesting)
     + Answers above are not orthogonal, neither exclusive.
       More than one answer can apply even for single repository.
   xx. How do you obtain Git?
     - binary package/source package or source script(*)/
       source tarball/pull from main repository
       (*) this includes source based distributions like Gentoo
     + added new option: source package or source script
     + should this be multiple choice?
   xx. What operating system do you use Git on?
       (one or more: multiple choice, as one can use more than one OS)
     - Linux, FreeBSD, OpenBSD, NetBSD, MacOS X (Darwin),
       UnixWare, SCO SV, SunOS, Solaris, AIX, IRIX, HP-UX, Other Unix,
       MS Window/Cygwin, MS Windows/msysGit (MINGW), MS Windows/unknown,
       Other (please specify).
     ! Linux, *BSD (FreeBSD, OpenBSD, etc.), MS Windows/Cygwin,
       MS Windows/msysGit, MacOS X, other UNIX, other
     + I have added here all the operating systems explicitly
       specified in "guessing configuration" part of Makefile
     + You can use 'uname' to get the name of operating system on Unices.
   xx. What hardware platforms do you use GIT on?
       (one or more: multiple choice, as one can use more than one machine)
     - 32bit, 64bit, handheld/portable, other (please specify)
     + It is much simplified compared to previous version, and it is
       not a free-form question.  Still not sure if even in such
       simplified form this question is to stay, or should it be removed.
   xx. What editor, IDE or RAD you use working with GIT?
       (zero/one or more: multiple choice with 'other')
     - Eclipse, NetBeans, IntelliJ IDEA, Visual Studio, KDevelop, Anjuta,
       XCode, PIDA, Eric, Dreamweaver, Emacs, Vim, TextMate, Notepad++,
       other (please specify)
     + What choices should be in the list of editors and IDE;
       or should perhaps this question be free-form?
   xx. Which porcelains / interfaces / implementations do you use?
       (zero or more: multiple choice)
     - core-git, Cogito (deprecated), StGIT, Guilt, pg (deprecated),
       TopGit, Pyrite, Easy Git, IsiSetup, jgit, my own scripts,
       other (please specify)
   xx. Which git GUI (commit tool or history viewer, or both) do you use
       (zero or more: multiple choice)
     - CLI, gitk, git-gui, qgit, gitview, giggle, tig, instaweb,
       (h)gct, qct, KGit, git-cola / ugit, GitNub, Pyrite, git.el,
       other (please specify)
   xx. Which (main) git web interface do you use for your projects?
       (zero or more: multiple choice)
     - gitweb, cgit, wit (Ruby), git-php, viewgit (PHP), Gitorious,
       other (please specify)
   xx. Which git hosting site do you use for your projects?
       (zero or more: multiple choice)
     - repo.or.cz, GitHub, Gitorious, kernel.org, freedesktop.org,
       Savannah, Assembla, Unfuddle, Alioth, Fedora Hosted, other
     + of course "if other, which"
     + should some other web hosting sites be included as well?
   xx. How do you publish/propagate your changes?
       (zero or more: multiple choice)
     - push, pull request, format-patch + email, bundle,
       git-svn, foreign SCM (not via git-svn),
       other (see also below)
   xx. If the way you publish your changes is not mentioned above, how
       do you publish your changes?  Please explain.
       (free form, either input field or textarea)
   xx. How often do you use the following forms of git commands or extra
       git tools?
       (matrix form: never/rare/often)
        . git add -i / -p
	. git add -u
        . git am
        . git am -i
	. git apply
        . git archive
        . git bisect
	. git bisect run <cmd>
	. git bisect replay <logfile>
	. git annotate
        . git gui blame
	. git blame
	. git blame -L <start>,<end>
	. git blame -S <revs-file>
        . git bundle
	. git cherry
        . git cherry-pick
        . git cherry-pick -n
        . git citool
        . git clean
        . git commit
        . git commit -a
        . git commit <file>...
	. git commit -i <file>...
	. git commit --amend
	. git count-objects
	. git cvsexportcommit
	. git cvsserver
	. git ... --dirstat
        . git fetch <options>
	. git filter-branch
	. git format-patch
	. git fsck
        . git grep
	. git imap-send
	. git instaweb
        . git log --grep/--author/...
	. git log -S<string>
	. git log --graph
        . git merge
        . git merge with strategy
        . git merge --squash
	. git mergetool
        . git pull
	. git pull <remote>
	. git pull <URL> <ref>
        . git push
	. git relink
        . git rebase
        . git rebase -i
	. git rebase --onto
	. git remote add <name> <URL>
	. git remote show <name>
	. git remote prune <name>
	. git remote update
	. git request-pull
        . git reset --soft
	. git reset [--mixed]
	. git reset --hard
	. git revert
	. git send-email
	. git show-branch
	. git shortlog
	. git shortlog -s
	. git stash
	. git submodule
	. git svn
	. git tag
	. git tag -a/-s
	. git tag -v
	. git whatchanged
        . git gui
	. gitk
	. gitprompt
     + (*)rarely is to mean: a few times, or sometimes (from time to time)
     + the list does not include commands which you _have_ to use,
       like "git add <file>", "git init"/"git clone" etc. 
     + in what order should be those commands; currently they are in
       alphabetical order?
   xx. Which of the following features do you use?
       (zero or more: multiple choice)
     - git-gui or other commit tool, gitk or other history viewer, patch
       management interface (e.g. StGIT), bundle, eol conversion (crlf),
       gitattributes, submodules, separate worktree, reflog, stash,
       shallow clone, detaching HEAD, mergetool, interactive rebase,
       add --interactive or other partial commit helper, commit
       templates, bisect, working with dirty tree, integration with
       IDE/editor, other (not mentioned here)
     + should probably be sorted in some resemblance of order
     + are there any new features which should be listed here?
   xx. Which features do you find unique and useful ones, compared
       to other systems (other SCMs)?
       (zero or more: multiple choice)
     - [same set as in above question, or almost the same set]
   xx. If you use some important Git features not mentioned above,
       what are those?
       (free form, textarea)
       


What you think of Git

   xx. Overall, how happy are you with Git?
       (single choice)
     - unhappy/not so happy/happy/very happy/completely ecstatic
   xx. How does Git compare to other SCM tools you have used?
       (single choice)
     - worse/equal (or comparable)/better
   xx. What would you most like to see improved about Git?
       (features, bugs, plug-ins, documentation, ...)
   xx. What tools would you like to see Git support in?
       (free form)


Changes in Git (since year ago, or since you started using it)

   xx. Did you participate in previous Git User's Surveys?
       (zero or more, multiple choice)
     - 2006, 2007
   xx. How do you compare current version with version from year ago?
     - current version is: better/worse/no changes/cannot say


Documentation

   xx. Do you use the Git wiki?
    -  yes/no
   xx. Do you find Git wiki useful?
    -  yes/no/somewhat
   xx. Do you contribute to Git wiki?
    -  yes/no/only corrections or spam removal
   xx. Do you find Git's on-line help (homepage, documentation) useful?
    -  yes/no/somewhat
   xx. Do you find help distributed with Git useful
       (manpages, manual, tutorial, HOWTO, release notes)?
    -  yes/no/somewhat
   xx. What could be improved on the Git homepage?
       (free form)
   xx. What could be improved in Git documentation?
       (free form)


Translating Git

   xx. What is your preferred non-programming language?
  (or) What is the language you want computer communicate with you?
   xx. What do you need/want to have translated?
       (zero or more, multiple choice)
     - commands messages, manpages, manual & tutorial etc.,
       technical documentation, HOWTOs, git homepage, git wiki,
       git-gui/gitk, subcommands and long option names


Getting help, staying in touch

   xx. Have you tried to get Git help from other people?
    -  yes/no
   xx. What channel did you use to request help?
       (zero or more: multiple choice)
    -  git mailing list, git users group, IRC, blog post, 
       asking git guru/colleague, other
    +  This is one question which doesn't need, I think, explanation
       of "other" choice
   xx. If yes, did you get these problems resolved quickly
       and to your liking?
    -  yes/no
   xx. Would commercial (paid) support from a support vendor
       be of interest to you/your organization?
    -  yes/no/not applicable
   xx. Do you think it is easy to find out how to do a specific task
       with git?
    -  yes/no/not always
   xx. Do you read the mailing list?
       (multiple choice: zero or more; "none" is just in case)
    -  none/git@vger.kernel.org/Git For Human Beings/msysGit
   xx. If yes, do you find it useful?
    -  yes/no/somewhat (optional)
  [xx. Do you find traffic levels on Git mailing list OK.
    -  yes/no? (optional)]
   xx. Do you find the mailing list traffic level to be:
    -  too low/OK/just right/tolerable/intolerable/
       a bit high/absurdly high/I don't read it
   xx. Do you use the IRC channel (#git on irc.freenode.net)?
    -  yes/no
   xx. If yes, do you find IRC channel useful?
    -  yes/no/somewhat (optional)
   xx. Did you have problems getting GIT help on mailing list or
       on IRC channel? What were it? What could be improved?
       (free form)


Open forum

   xx. What other comments or suggestions do you have that are not
       covered by the questions above?
       (free form)
   xx. Should such a survey be repeated next year?
    -  yes/no/no opinion

-- 
Jakub Narebski
Poland
