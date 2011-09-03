From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFCv2] Questions for "Git User's Survey 2011"
Date: Sat, 3 Sep 2011 03:43:54 +0200
Message-ID: <201109030343.55575.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Phil Hord <hordp@cisco.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 03:44:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzfHK-0001OE-Uw
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 03:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab1ICBoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 21:44:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64893 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1ICBoF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 21:44:05 -0400
Received: by fxh19 with SMTP id 19so2143174fxh.19
        for <git@vger.kernel.org>; Fri, 02 Sep 2011 18:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zsTojvp26r6NaW9Jn7bNspV25Lo3xe8+/i6sb9YEqEE=;
        b=EtrlenvHc3OYbmRSePd09FB+7YJ5bOV8Y75I4gGcg2Wnl5HftFyaW7+JD11VchJKT+
         AhxrpGrZerpWwuaz5WjHPn6It6Hv58GOe2Dk4dsPNhHWryoqL/7r0numu6Vgq74yFbok
         Zt8oBKmj3430jiBp3/uPXbqZdbc9WBJpYKoyw=
Received: by 10.223.22.16 with SMTP id l16mr2766676fab.62.1315014243945;
        Fri, 02 Sep 2011 18:44:03 -0700 (PDT)
Received: from [192.168.1.13] (abwo246.neoplus.adsl.tpnet.pl [83.8.238.246])
        by mx.google.com with ESMTPS id q23sm443794fae.1.2011.09.02.18.43.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Sep 2011 18:44:00 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180643>

This is last call for feedback (comments) on contents of this year
Git User's Survey.

Thanks to generocity of Survs.com, we have been gifted with premium
annual plan (last year Git User's Survey had more than 8000
responses!).  This plan will last till 26 October 2011, so I am
planning on having the survey for 4 weeks, in September:

  5 September 2011 -- 2 October 2011

You can see test version of survey at

  https://www.survs.com/survey/VEBXFGJ9B0

Note that all answers in this test channel will be deleted!


Below there is the content of the proposed survey.  

New questions include:
* List git tools that you use (optional)
* What do you use submodules for?
* Do you use paid git hosting, and if so, why?
* If you self-host git repositories, what tools do you use?
* What other version control systems do you use beside Git?
* What gave you most trouble learning, understanding and using Git?
* Did you give help about Git?  What medium did you use?
* What gave you most trouble explaining and teaching Git?


= Git User's Survey 2011 (proposal) =

== About you ==

=== 01. What country do you live in? ===
        (Country of residence)
(free-form single line)

NOTES:
^^^^^^
This question originally read "What country are you from?"

=== 02. How old are you (in years)? ===
        (Single number)
(free-form single line)

=== 03. Does Git include code or documentation by you? ===
    (Are you a Git developer?)
(single choice)

* Yes
* No

NOTES:
^^^^^^
This is here to correlate other responses with Git developers.


== Getting started with Git ==

=== 04. Have you found Git easy to learn? ===
(single choice)

* Very easy
* Easy
* Reasonably easy
* Hard
* Very hard

=== 05. Have you found Git easy to use? ===
(single choice)

* Very easy
* Easy
* Reasonably easy
* Hard
* Very hard

NOTES:
^^^^^^ 
Those two questions, considered alone, doesn't tell us much.  If one use
git, then usually one does not think it is too hard to use (unless forced to
use git by external circumstances, like project he/she works on using git).
On the other hand those two questions together give us some mesaure of git
learning curve, telling us if people consider git easy to use but hard to
learn, or vice versa ;-)


=== 06. Which Git version(s) are you using? ===
(multiple choice, with other)

 + pre 1.3
 + 1.3.x
 + 1.4.x
 + 1.5.x
 + 1.6.x
 + 1.7.x

 + 1.7.x-rcN version (release candidate)
 + minor (maintenance) release 1.x.y.z
 + 'master' branch of official git repository
 + 'next' branch of official git repository
 + 'pu' branch of official git repository
 + version from msysGit / Git for Windows fork repository
 + JGit implementation (e.g. via Eclipse plugin, EGit)

 + other, please specify

Description:
~~~~~~~~~~~~
You can find git version by using `git --version` or `git version`.

"Minor release" is additional specification, so if you for example use
git version 1.7.4.5, please check both "1.7.x" and "minor release"; if
you use "v1.7.6-rc3" please check both "1.7.x" and "-rcN version"

NOTES:
^^^^^^
The "-rcN version" is new option.


=== 07. Rate your own proficiency with Git: ===
(single choice)

 * 1. novice
 * 2. casual, needs advice
 * 3. everyday use
 * 4. can offer advice
 * 5. know it very well

Description:
~~~~~~~~~~~~
You can think of it as 1-5 numerical grade of your proficiency in Git.

NOTES:
^^^^^^
This question tell us penetration of announcements of Git User's Survey 2011;
did we get to all, or only to git gurus?  It is also useful for correlating
with other responses, for example to know which features are used by
novices, and which by gurus.

Note that the answers are here to stay because of "backwards
compatibility", i.e. to be able to easy compare with earlier surveys.


== How you use Git ==

=== 08. I use Git for (check all that apply): ===
(multiple choice, with other)

NOTES:
^^^^^^
Answers to this question probe different direction.

 + work projects
 + unpaid projects

 + proprietary projects
 + OSS development (also public domain, and published & unlicensed)
 + private (unpublished), in house

 + code (programming) and its documentation
 + data, documents (also e.g. static website)

 + sharing data or sync
 + managing configuration files
 + backup
 + backend for wiki, blog, or other web app
 + bugtracker / issue tracker
 + frontend to other SCM (e.g. git-svn)

 + other (please specify)

Description:
~~~~~~~~~~~~
Note that above choices are neither orthogonal nor exclusive.
You might want to check multiple answers even for a single repository.


=== 09. How do/did you obtain Git (install and/or upgrade)? ===
(multiple choice, with other)

Note that this question is multiple choices question because one can
install Git in different ways on different machines or on different
operating systems.

 + binary package
 + source package or script (automatic compiling)
 + source tarball (extract, make, make install)
 + pull from (main) repository
 + preinstalled / sysadmin job

 + other - please specify (if none of the above apply)

Description:
~~~~~~~~~~~~
Explanation: "binary package" covers pre-compiled binary (e.g.  from
rpm or deb binary packages); "source package" covers things like
deb-src and SRPMS / *.src.rpm; "source script" is meant to cover
installation in source-based distributions, like 'emerge' in Gentoo.

Automatic update (apt, yum, etc.) in most cases means binary package
install; unless one uses source-based distribution like Gentoo, CRUX,
or SourceMage, where automatic update means using source package (or
source script).

The option named "preinstalled / sysadmin job" means that either you
didn't need to install git because it was preinstalled (and you didn't
upgrade); or that you have to ask system administrator to have git
installed or upgraded.

Note that this question is multiple choices question because one can
install Git in different ways on different machines or on different
operating systems.

NOTES:
^^^^^^
What I didn't take into account in above explanation is operating
systems with packaging systems different that the one used by various
Linux distributions.

In short: if to have git installed you compile it, you use source
package or source tarball.  If the installation onvolves anything more
than 'make install' (or manual copying), then it is most probably
source package or script.

This for example means that "msysGit" installer is source package, and
"Git for Windows" is binary package, if I understand it correctly.


=== 10. On which operating system(s) do you use Git? ===
(multiple choice, with other)

 + GNU/Linux (includes MeeGo)
 + MacOS X (Darwin)
 + MS Windows/msysGit (MINGW)
 + MS Windows/Cygwin
 + some MS Windows (unknown or other)
 + FreeBSD, OpenBSD, NetBSD, etc.
 + Solaris / OpenSolaris / Illuminati / IllumOS
 + other Unix

 + Other, please specify

Description:
~~~~~~~~~~~~
On Unix-based operating system you can get the name of operation
system by running `uname` (or `uname -o`).

NOTES:
^^^^^^
How to detect if it is msysGit or Cygwin from within?  Perhaps we
should have just "MS Windows"...


=== 11. What Git interfaces, implementations and frontends do you use? ===
(multiple choice, with other)

 + JGit (Java implementation), e.g. via Eclipse plugin
 + NGit or Git# (C# implementation)
 + Dulwich (pure-Python implementation)
 + Git::PurePerl (Perl implementation)
 + git.js (JavaScript)
 + libgit2 bindings

 + git (core) commandline
 ? Cogito (DEPRECATED)
 + Easy Git
 + Pyrite
 + I don't know, I only use (graphical) tools

 ? pg aka Patchy Git (DEPRECATED)
 + StGIT
 + Guilt
 + TopGit

 + Zit

 + other (please specify)

NOTES:
^^^^^^
This version is going back to split from 2008 survey, rather than
having everything put together like in 2009 one.  There are, of
course, problems with both choices.  

The problem with split part is that people can have troubls with
distinguising between interfaces, implementations, frontends and tools
(although "I don't know ..."  answer should, I think, help here).  The
problem with having it everything together is that the list of
possible answers gets long and a bit unwieldy.

BTW are there any implementations and frontends that should be added
to the list above?


=== 12. What kind of Git tools do you use? ===
(multiple choice, with other)

If a tool is both history viewer, and commit tool, please choose the
option that corresponds to how do you use this tool.

 + editor/IDE VC integration (e.g. EGit (for Eclipse), TextMate bundle, magit (for GNU Emacs))
 + build tool integration (e.g. git plugin for Maven, gitbuilder, Parabuild)
 + filemanager / shell extension (e.g. git-cheetah, TortoiseGit)
 + filesystem interface (e.g. gitfs, figfs)
 + graphical history viewer/browser (e.g. gitk)
 + graphical commit tool (e.g. git-gui)
 + graphical diff and/or merge tool (e.g. Kompare, Meld)
 + graphical blame or pickaxe tool (e.g. 'git gui blame')
 + tool to manage git repositories (e.g. Gitosis, Gitolite)
 + git-instaweb, or self-hosted web interface (e.g. gitweb, cgit)
 + self-hosted code review system (e.g. Gerrit)
 + self-hosted git software forge (e.g. Gitorious, GitHub:FI, InDefero)
 + patch management interface (e.g. StGit, Guilt)
 + tracking some files out-of-band (e.g. git-annex, git-media)
 + storing metadata (e.g. metastore, gitperms, git-cache-meta)
 + managing composite repositories (e.g. git-subtree, gitslave, repo)

 + my own scripts (for daily use)
 + my own scripts (for special tasks)

 + other kind (please specify)

Description:
~~~~~~~~~~~~
Here graphics diff tool means tools such as Kompare, and graphical
merge tool means tools such as Meld and KDiff3. Those answers include
graphical merge and diff tools used by programmers editors and IDEs.

"graphical history browser (any)" covers tools such as gitk, QGit,
Giggle, tig etc., but also built-in git commands such as "git log
--graph" and "git show-branch". If you use one of mentioned tools
*as* history browser, mark both a tool and "graphical history
browser (any)"; if you use some graphical history viewer not listed
here, please both mark this answer and specify it in the "other tool"
answer.

Similarly for other answers marked "(any)".


=== 13. List git tools that you use (optional) ===
(free form, essay)

Description:
~~~~~~~~~~~~
Please include only frontends, interfaces and tools that have support
for Git (so e.g. EGit applies, but Eclipse doesn't).

Please either use comma separated list of tools, or put each tool in a
separate line.  That would make analysis of answers simpler.  Thanks
in advance.

NOTES:
^^^^^^
Replaced list of tools from 2009 with free-form question.

=== 14. What do you use submodules for? ===
(multiple choice, with other)

 + I don't use submodules at all

 + I use submodules
 + I use repo
 + I use git-subtree
 + I use gitslave

 + to import repositories maintained by others
 + for your own (or your organization's) code shared between different projects
 + to separate large and/or many files for performance reasons
 + to separate data which you don't want (or aren't allowed) to disclose

 + Other, please specify

NOTES:
^^^^^^
New.  Requested by Jens Lehmann.


=== 15. Which of the following Git features do you use? ===
(multiple choice, with other)

 + git bundle (off-line transport)

 + eol conversion (crlf or eol)
 + gitattributes (any)
 + custom diff/merge driver
 + word diff
 + merge strategy options (e.g. -Xrenormalize)
 + textconv

 + submodules (subprojects)
 + subtree merge (optionally git-subtree)

 + partial (sparse) checkout, 
 + assume-unchanged bit

 + separate worktree / core.worktree
 + multiple worktrees (e.g. git-new-worktree)
 + gitdir mechanism (.git file pointing to repository)
 + remote helpers (e.g. <transport>::<address> URLs)

 + alternates mechanism (sharing object database)
 + stash (optionally "git stash --keep-index")
 + shallow clone (e.g. "git clone --depth=<n>")
 + detaching HEAD (e.g. "git checkout --detach")
 + commit message templates

 + interactive commit / per-hunk comitting / partial commit
 + interactive rebase (small scale history editing)
 + git-filter-branch or equivalent (large history rewriting)

 + bisect (optionally "git bisect run <script>")
 + tracking code movement with git-blame ("git blame -M" etc.)
 + advanced history examination (pickaxe search, ancestor only, etc.)
 + committing with dirty tree (keeping some changes uncommitted)

 + non-default hooks (from contrib/hooks/ or other)
 + shell completion of commands
 + git-aware shell prompt
 + git aliases, shell aliases for git, or own git scripts

 + one-way interaction with other SCMs (from SCM to git)
 + two-way interaction with other SCMs (from SCM to git, from git to SCM)

 + git-cvsserver
 + git notes
 + replace meachanism (git replace)
 + grafts (not only as a way to do filter-branch)

 + Other, please specify

NOTES:
^^^^^^
The problem is come up not with exhaustive list of features: there are
too many of them to list.  The problem is coming up with list of
important and used enough often features.

So: what features should be included in this list?  What features
should be removed from above list of answers?


=== 16. Which of the following features would you like to see implemented in git? ===
(multiple choice)

 + localization of command-line messages (i18n)
 + better support for big files (large media)
 + resumable clone/fetch (and other remote operations)
 + GitTorrent Protocol, or git-mirror
 + lazy clone / on-demand fetching of object
 + support for tracking empty directories
 + improved submodule support (and user-interface)
 + environmental variables in config
 + better undo/abort/continue, and for more commands
 + '-n' like option for each command, which describes what would happen
 + side-by-side diffs and/or color-words diff in gitweb
 + admin and/or write features in gitweb
 + graphical history view in gitweb
 + GUI for rebase in git-gui
 + GUI for creating repository in git-gui
 + filename encoding (in repository vs in filesystem)
 + git push --create
 + wholesame directory rename detection
 + graphical merge tool integrated with git-gui
 + union checkouts (some files from one branch, some from other)
 + advisory locking / "this file is being edited"
 + "commands issued" (or "command equivalents") in git-gui / gitk
 + warn before/when rewriting published history
 + built-in gitjour/bananajour support
 + syntax highlighting in git-gui

 + other (describe below)

NOTES:
^^^^^^
What features should be mentioned besides those above?  What criteria
should we have for including features in this list?

=== 17. Describe what features would you like to have in Git, if it is
        not on the list above? ===
(free form, essay length)


== Interacting with other repositories ==

=== 18. Which git hosting site(s) do you use for your project(s)? ===
        Please check only hosting sites where you publish/push to (with git)
(multiple choice, with other)

 + [http://repo.or.cz repo.or.cz]
 + [http://github.com GitHub]
 + [http://gitorious.org Gitorious]
 + [http://code.google.com/hosting Google Code]
 + [http://www.indefero.net InDefero]

 + [http://savannah.gnu.org Savannah]
 + [http://sourceforge.net SourceForge]
 + [http://developer.berlios.de BerliOS]

 + [http://www.assembla.com Assembla]
 + [http://codebasehq.com Codebase]
 + [http://unfuddle.com Unfuddle]
 - [http://codesion.com Codesion]
 - [http://gitfarm.appspot.com GitFarm]
 - [http://www.projectlocker.com ProjectLocker]
 - [http://thechaw.com The Chaw]

 + [http://git.kernel.org kernel.org]
 + [http://www.freedesktop.org/wiki/ freedesktop.org]

 + [http://alioth.debian.org Alioth] (Debian)
 + [http://hosted.fedoraproject.org Fedora Hosted]

 +  company internal
 +  git hosting site for related projects (e.g. OLPC)
 +  generic site without git support
 +  self hosted

 +  Other (please specify)

Description:
~~~~~~~~~~~~
You can find those and other git hosting sites listed on GitHosting
page on Git Wiki.

NOTES:
^^^^^^
I think this question is here to stay.

Google Code is new; they support Git only recently.  The "company
internal" answer was added in survey from 2010.

=== 19. Do you use paid git hosting, and if so, why? ===
(multiple choice, with other)

 + N/A (don't use paid git hosting)
 
 + private repositories
 + increased limits
 + paid support / help
 + extra features

 + other (please specify)

NOTES:
^^^^^^
New.

=== 20. If you self-host git repositories, what tools do you use? ===
(multiple choice, with other)

 + gitosis
 + gitolite
 + Gitblit
 + SCM Manager

 + gitweb
 + cgit
 + Gitalist
 + ViewGit

 + GitHub:FI
 + Gitorious
 + InDefero
 + Girocco

 + repo
 + Gerrit

 + other management / collaboration git tool

NOTES:
^^^^^^
New.

=== 21. How do you fetch/get changes from upstream repositories? ===
(multiple choice, with other)

 + git protocol        (e.g. git://git.example.com/repo.git)
 + ssh                 (e.g. ssh+git://git.example.com/repo.git,
                             git.example.com:/srv/scm/repo.git)
 + http                (e.g. http://git.example.com/repo.git)
 + rsync (DEPRECATED)  (e.g. rsync://git.example.com/repo.git)
 + filesystem          (e.g. /path/to/repo.git, file:///path/to/repo.git)
 + via git-bundle
 + foreign SCM (e.g. git-svn)

 + Other, please specify

Description:
~~~~~~~~~~~~
This question asks about how do you get changes (updates) from
projects you follow into your local repository. It is not about how do
you get latest version of Git.

Fetching (or rather cloning) via bundle could mean that project
publishes ready for download bundles to reduce traffic and load on
server (HTTP download [of bundle] can be resumed, git-clone currently
cannot; one can also distribute bundle using P2P).

NOTES:
^^^^^^
What is new are examples of URLs / URIs for each protocol.

Did I miss anything?  Is this question interesting, and should it
stay, or should it be removed?


=== 22. How do you publish/propagate your changes? ===
(multiple choice, with other)

 + push via SSH
 + push via HTTP / HTTPS
 + push via git protocol
 + push (unknown)
 + pull request (+ any form of announcement / notification)
 + format-patch + email
 + format-patch + other (e.g. reviewboard, issue tracker or forum)
 + git bundle

 + git-svn (to Subversion repository)
 + git-p4 (to Perforce repository)
 + foreign SCM interface (other than mentioned above)

 + other - please specify

Description:
~~~~~~~~~~~~
Publishing via bundle could mean sending bundle via email, or posting
it on review board (or forum).

Instead of git-format-patch there can be utilized other way of
generating patch (e.g. git-show, git-diff, 'patch' view from gitweb,
etc.)

NOTES:
^^^^^^
Splitting push into transports is new in this survey.


== Other version control systems ==

=== 23. What other version control systems do you use beside Git? ===
(multiple choice, with other)

 + PVCS
 + SCCS
 + RCS

 + CVS
 + Subversion

 + Perforce
 + ClearCase
 + AccuRev SCM
 + StarTeam
 + Visual SourceSafe
 + Team Foundation Server
 + Visual Studio Team System / ALM
 + Rational Team Concert

 + Bazaar
 + Mercurial
 + Monotone
 + Darcs
 + SVK
 + Fossil
 + Veracity

 + BitKeeper
 + Code Co-op
 + TeamWare
 + Plastic SCM

 + by hand / own scripts / custom
 + other, please specify

NOTES:
^^^^^^
What SCM should be removed, which should be added?


== What you think of Git ==

=== 24. Overall, how happy are you with Git? ===
(single choice)

 * unhappy
 * not so happy
 * happy
 * very happy
 * completely ecstatic

NOTES:
^^^^^^
There is a problem, that the current wording is considered biased
by some, but on the other hand changing wording of answers would make
it impossible to compare it to answers from previous surveys...


=== 25. In your opinion, which areas in Git need improvement? ===
        Please state your preference.
(matrix)

   Columns: don't know / don't need / a little / some / much
 + user-interface
 + documentation
 + performance
 + portability
 + more features
 + tools (e.g. GUI)
 + localization (translation)

NOTES:
^^^^^^
Are there any general areas that are missing from this list?
What are they?


== Changes in Git (since year ago, or since you started using it) ==

=== 26. Did you participate in previous Git User's Surveys? ===
(multiple choice)

 + in 2006
 + in 2007
 + in 2008
 + in 2009
 + in 2010
 + I don't remember, but I have participated in the past
 + none of the above (this is my first Git User's Survey)

NOTES:
^^^^^^ 
This might be quite useful comparing with previous surveys.


=== 27. How do you compare the current Git version with the version from one year ago? ===
(single choice)

 * better
 * no changes
 * worse

 * cannot say

Description:
~~~~~~~~~~~~
The version from approximately one year ago is 1.7.2 from 21-07-2011
(1.7.3 is from 18-09-2010).

Changes since 1.7.2 include:
* passing extra options to merge strategy via "-X" in more places
* -Xrename-threshold and -Xignore-space-at-eol
  for recursive merge strategy
* "exec" instruction support in interactive rebase
* system-wide attributes file /etc/gitattributes and
  `core.attributesfile`
* completion of commands for bash 4 and zsh
* [<tree>]:./<path> to use path relative to current directory
* ":/<path>" to use path relative to root of working tree hierarchy
* ":/" magic pathspec to work on entire working tree
* "git log -G"
* globbing pathspecs in "git log"
* git log --cherry and --cherry-mark
* "git notes merge" and --notes option to "git log" and friends
* extending "git shell" with custom set of commands
* beginnings of i18n/l10n and translations
* "git checkout --detach"
* "git cherry-pick" and "git revert" improvements
* "git merge" and "git rebase" now DWIMs to upstream
* "git merge -" to merge the previous branch
* `merge.ff` configuration variable
* selecting common timezone in gitweb with JavaScript
* updated (faster and more robust) content tags (labels) in gitweb
* GIT_PREFIX in "[alias] <name> = !process"
* git diff --dirstat=0 and --dirstat=lines
* and more...

NOTES:
^^^^^^
This question is mainly excuse for providing list of main changes
from the year ago.


== Documentation. Getting help. ==

=== 28. How useful have you found the following forms of Git documentation? ===
(matrix)

  Columns: never used / not useful / somewhat / useful
 + Git Wiki
 + Git Reference site
 + other on-line help
 + help distributed with git
 + printed books (or ebooks)

Description:
~~~~~~~~~~~~
* Git Wiki was to be found at http://git.wiki.kernel.org
* Git Reference site can be found at http://gitref.org
* on-line help includes, among others, Git Homepage (http://git-scm.com),
  "Git Community Book" (http://book.git-scm.com), "Pro Git" book
  (http://progit.org) and Git-related help pages on git hosting sites
* help distributed with git include manpages, manual, tutorials, HOWTO,
  release notes, technical documentation, contrib/examples/


=== 29. What channel(s) do you use to request help about Git (if any)? ===
(multiple choice, with other)

 + N/A (didn't request help about Git)

 + git mailing list (git@vger.kernel.org)
 + "Git for Human Beings" Google Group
 + msysGit mailing list / Google Group
 + IRC (#git)
 + IRC (other git/SCM related, e.g. #github)
 + IRC (other than above)
 + request in blog post or on wiki
 + asking git guru/colleague/friend
 + project mailing list, or IRC, or forum
 + Twitter or other microblogging platform
 + instant messaging (IM) like XMPP/Jabber
 + StackOverflow or other StackExchange site

 + other (please specify)


=== 30. What gave you most trouble learning, understanding and using Git? ===
(free form, essay)

NOTES:
^^^^^^
New / resurrected.


=== 31. Which communication channel(s) do you use? ===
        Do you read the mailing list, or watch IRC channel?
(multiple choice, with other)

 + git@vger.kernel.org (main)
 + Git for Human Beings (Google Group)
 + msysGit
 + #git IRC channel
 + #git-devel IRC channel
 + #github or #gitorious IRC channel
 + #revctrl IRC channel

 + other (please specify)


=== 32. Did you give help about Git?  What medium did you use? ===
(multiple choice, with other)

 + N/A (didn't give help about Git)

 + talk / private explanation
 + IRC channel
 + talk / presentation / seminar
 + workshop or other form of schooling / training
 + blog post / webpage
 + article in magazine
 + book or ebook
 + git mailing list
 + other mailing list
 + email
 + Usenet (newsgroup)
 + instant messaging (IM) like XMPP/Jabber
 + forum
 + StackOverflow or similar
 + remote aid / control tool, like FogCreek Copilot

 + other, please specify

=== 33. What gave you most trouble explaining and teaching Git? ===
(free-form, essay)


== About this survey. Open forum. ==

=== 34. How did you hear about this Git User's Survey? ===
(single choice, with other)

 * git mailing list
 * git-related mailing list (e.g. msysGit, Git for Human Beings)
 * mailing list or forum of some project
 * #git IRC channel topic
 * announcement on IRC channel
 * git homepage
 * git wiki
 * git hosting site (or blog related to such site)
 * software-related web site
 * news or social news site (e.g. Digg, Reddit)
 * blog (or blog planet)
 * other kind of web site
 * Twitter or other microblogging platform

 * other - please specify

NOTES:
^^^^^^
This list would of course be updated to reflect the list of (planned)
announcement channels.

There of course will be announcement on Git Mailing List, and perhaps
also on msysGit list / Google Group, and on Git For Human Beings
Google Group (if it exists).  I'll announce it on #git, and ask op to
put short announcement in channel description, and I can announce it
on other IRC channels.  I would add announcement to main page of Git
Wiki, and as Git Homepage administrator to put announcement about Git
User's Survey.

I usually tried to contact administrators of git hosting sites,
including git.kernel.org, repo.or.cz, GitHub, Gitorious, Assembla,
Codebase and Unfuddle, asking them to put announcement about 
Git User's Survey either somewhere on the site, or in their blog 
(if there is any).  What git hosting sites it is worth to ask?


I would like to have announcement of Git User's Survey 2010 at
LWN.net, but this would need to be send at least two weeks in advance,
if I remember correctly.  Is it worth it?  What other news site should
I (or you) send announcement to?

If you can Digg / Reddit announcment on some site, please do.  I can
announce Git User's Survey 2-1- at Twitter, Identi.ca and Plurk, but I
don't have wide area of followers.  So please RT.

Should we contact some bloggers (besides asking Junio to put
announcement on his blog) to post an anouncement?  Which bloggers
would respond positively (perhaps Linus...)?

-- 
Jakub Narebski
Poland
