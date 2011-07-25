From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Questions for "Git User's Survey 2011"
Date: Mon, 25 Jul 2011 22:33:01 +0200
Message-ID: <201107252233.02088.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 22:33:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlRq5-00078z-90
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 22:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab1GYUdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 16:33:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45797 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab1GYUdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 16:33:13 -0400
Received: by ewy4 with SMTP id 4so2667992ewy.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KIahJyABxQiFwMwfCDFYZ2qZNu4WWCZaY9YC6BfGBMI=;
        b=WWNE/0QIRLMN+cFtKTVQNz1htru0UCNZ1iSCqmkFcclYN5GoTPZHVixkugRHBDI/3i
         n+Dzaf0fVJYMU9/tZWsnJBSp3flvXMTjPTLz5Kswtf2T2b+KZ17UwT9LVBtwPWrDl49V
         a5itE2+YCler3VTCtJ5Rpe/THn2OrKyU0yaxU=
Received: by 10.213.106.20 with SMTP id v20mr1722917ebo.121.1311625990856;
        Mon, 25 Jul 2011 13:33:10 -0700 (PDT)
Received: from [192.168.1.13] (abwi16.neoplus.adsl.tpnet.pl [83.8.232.16])
        by mx.google.com with ESMTPS id 16sm666479eei.47.2011.07.25.13.33.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 13:33:08 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177815>

I am planning doing annual Git User's Survey, and I'd like to ask for
feedback.

Thanks to generocity of Survs.com, we have been gifted with premium
annual plan (last year Git User's Survey had more than 8000
responses!).  This plan will last till 26 October 2011, so I am
planning on having the survey for 1 month, in September:

  1 September -- 30 September 2011

One difference is that I would be sending announcements to git hosting
sites, to a few blogs, to git mailing lists, to git IRC channels, git
homepage and git wiki... but I will not be sending announcements to
individual projects and projects groups, perhaps with exception of
LKML.  Though if you want to, feel free.

I will be also making available separate channels, with separate URLs,
so that if one wants one might track all responses followed from
his/her site (e.g. some company wanting to see how their employees use
Git).  It would be available on request... though there would be only
one shortened "named" URL (tinyurl.com); might use goo.gl for separate
channels.

What questions (and with what proposed answers) should there be in
this year survey?  I am planning on having 30 questions or less total,
this time split into pages.

Below there is the content of the proposed survey:


= Git User's Survey 2011 (proposal) =

== About you ==

NOTES: 
^^^^^^
This section gives us a bit of demographical information about survey
responders.  Is it useful?

=== 01. What country do you live in? ===
        (Country of residence)
(free-form single line)

NOTES:
^^^^^^
Perhaps a better solution would be a menu (drop-down list) of
countries, using list of current countries.  It would be more work to
create it (so it looks like it is out of question, unless Survs.com
implements it as template or something), but might reduce ambiguities
and unparsable responses... though there weren't that many.

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

The question is: should those questions stay, or should they go?


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
This question is here to stay.  Should it be extended somehow?

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

Note that those choices are neither orthogonal nor exclusive.  One
might want to check multiple answers even for a single repository.

NOTES:
^^^^^^
Answers to this question probe different direction.
This list is interspersed with comments about specific
(sub)sections.

 + work projects
 + unpaid projects

Notes:
^^^^^^
Those two are about using git at work vs using git on your own free time.
There are of course shades of gray, like using git for work project
unofficially (e.g.using git-svn as "fat" client for company's Subversion
repository), or employer allowing to work on non-work OSS project during
working hours.  But I'm not sure if they are worth adding.

 + proprietary projects
 + OSS development (also public domain, and published & unlicensed)
 + private (unpublished), in house

Notes:
^^^^^^
Those three are about licensing: proprietary / free (open) / unlicensed.
By 'OSS development' I mean here also free licenses for documentation and
documents, like GFDL or Creative Commons licenses (both copyleft and
permissive).

 + code (programming) and its documentation
 + data, documents (also e.g. static website)

Notes:
^^^^^^
This is about what kind of data do you store in git.  It is much
simplified compared to previous version, reduced to only two
responses: code and data.

 + sharing data or sync
 + managing configuration files
 + backup
 + backend for wiki, blog, or other web app
 + bugtracker / issue tracker
 + frontend to other SCM (e.g. git-svn)

Notes:
^^^^^^
This is about (ab)using git for other things than straighforward source
control management.  List of possible answers specified here should cover
most commonly encountered usages: should we add anything else here?

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
 + some MS Windows (unknown)
 + FreeBSD, OpenBSD, NetBSD, etc.
 + Android
 + Solaris / OpenSolaris / Illuminati
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
 + Cogito (DEPRECATED)
 + Easy Git
 + Pyrite
 + I don't know, I only use (graphical) tools

 + pg aka Patchy Git (DEPRECATED)
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
 + filemanager / shell extension (e.g. git-cheetah, TortoiseGit)
 + filesystem interface (e.g. gitfs, figfs)
 + graphical history viewer/browser (e.g. gitk)
 + graphical commit tool (e.g. git-gui)
 + graphical diff and/or merge tool (e.g. Kompare, Meld)
 + graphical blame or pickaxe tool (e.g. 'git gui blame')
 + tool to manage git repositories (e.g. Gitosis, Gitolite)
 + git-instaweb, or self-hosted web interface (e.g. gitweb, cgit)
 + self-hosted code review system (e.g. Gerrit)
 + patch management interface (e.g. StGit, Guilt)

 + my own scripts (for daily use)
 + my own scripts (for special tasks)

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

NOTES:
^^^^^^
As the number of tools increases (see InterfacesFrontendsAndTools page
on git wiki), having them listed all there gets a bit unwieldy.  On
the other hand it was a good way to find new tools that were not yet
included on IFaT page.  What do you think: should it be about tools,
or only about kind of tools used with git?  

The survey from 2011 did include "What Git GUIs (graphical user
interfaces) do you use?" question.

What do you think about this list?  IS there something that should not
be here?  Or perhaps there is something that should be added to this
list?


=== 13. Which git hosting site(s) do you use for your project(s)? ===
        Please check only hosting sites where you publish/push to (with git)
(multiple choice, with other)

 + [http://repo.or.cz repo.or.cz]
 + [http://github.com GitHub]
 + [http://gitorious.org Gitorious]
 + [http://code.google.com/hosting Google Code]
 + [http://www.indefero.net InDefero]

Notes:
^^^^^^
Those are generic git hosting sites (well, InDefero is now paysite),
each of them showcasing their own tool, all except GitHub open source
(it is Girocco for repo.or.cz; for the rest the tool is named the same
as the git hosting site).

Google Code is new; they support Git only recently.

 + [http://savannah.gnu.org Savannah]
 + [http://sourceforge.net SourceForge]
 + [http://developer.berlios.de BerliOS]

Notes:
^^^^^^
Generic software hosting sites, with git support.  Did I miss
something, should I include yet another site?

 + [http://www.assembla.com Assembla]
 + [http://codebasehq.com Codebase]
 + [http://unfuddle.com Unfuddle]
 - [http://codesion.com Codesion]
 - [http://gitfarm.appspot.com GitFarm]
 - [http://www.projectlocker.com ProjectLocker]
 - [http://thechaw.com The Chaw]

Notes:
^^^^^^
Those are commercial and/or less known git hosting sites, or software
hosting sites with git support.  I am not sure which ones of those
marked with '-' to include, and whether to include other sites from
GitHosting page on git wiki.  What do you think?

 + [http://git.kernel.org kernel.org]
 + [http://www.freedesktop.org/wiki/ freedesktop.org]

Notes:
^^^^^^
Those are 'git hosting site for related projects', but are special in
some sense.  Should I leave them there, or remove from this list?

 + [http://alioth.debian.org Alioth] (Debian)
 + [http://hosted.fedoraproject.org Fedora Hosted]

Notes:
^^^^^^
Those are distribution-specific.  Are there any sites that I missed?
Launchpad from Ubuntu does not count, as it is Bazaar hosting site,
not Git hosting site.

 +  company internal
 +  git hosting site for related projects (e.g. OLPC)
 +  generic site without git support
 +  self hosted

Notes:
^^^^^^
Are ther other kinds / typse of sites one can host project using git
on?  What are they?

 +  Other (please specify)

Description:
~~~~~~~~~~~~
You can find those and other git hosting sites listed on GitHosting
page on Git Wiki.

NOTES:
^^^^^^
I think this question is here to stay.

The "company internal" answer was added in survey from 2010.


=== 14. How do you fetch/get changes from upstream repositories? ===
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


=== 15. How do you publish/propagate your changes? ===
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
Should it stay, or should it be removed?  I guess it can be
interesting for git hosting sites...  Should we have separate answrs
for different kinds of push (ssh, "dumb" HTTP(S) with WebDAV, "smart"
HTTP - if it is possible, git:// protocol with push enabled)?

Splitting push into transports is new in this survey.


=== 16. Which of the following Git features do you use? ===
(multiple choice, with other)

 + localization of command-line messages (i18n)
 + git bundle (off-line transport)

 + eol conversion (crlf or eol)
 + gitattributes (any)
 + custom diff/merge driver
 + word diff
 + merge strategy options (e.g. -Xrenormalize)
 + textconv

 + submodules (subprojects)
 + subtree merge (optionally git-subtree)

 + partial (sparse) checkout, or assume-unchanged bit

 + separate worktree / core.worktree
 + multiple worktrees (e.g. git-new-worktree)
 + gitdir mechanism (.git file pointing to repository)

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
 + committing with dirty tree (keeping some changes uncommitted)

 + non-default hooks (from contrib/hooks/ or other)
 + shell completion of commands
 + git-aware shell prompt
 + git aliases, shell aliases for git, or own git scripts

 + one-way interaction with other SCMs (from SCM to git)
 + two-way interaction with other SCMs (from SCM to git, from git to SCM)

 + git-cvsserver
 + git notes


 + Other, please specify

NOTES:
^^^^^^
The problem is come up not with exhaustive list of features: there are
too many of them to list.  The problem is coming up with list of
important and used enough often features.

So: what features should be included in this list?  What features
should be removed from above list of answers?


=== 17. Which of the following features would you like to see implemented in git? ===
(multiple choice)

 + better support for big files (large media)
 + resumable clone/fetch (and other remote operations)
 + GitTorrent Protocol, or git-mirror
 + lazy clone / on-demand fetching of object
 + support for tracking empty directories
 + environmental variables in config, 
   and expanding ~ and ~user in paths in config
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

=== 18. Describe what features would you like to have in Git, if it is
        not on the list above? ===
(free form, essay length)


== Other version control systems ==

=== 19. What other version control systems do you use beside Git? ===
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
+ Veracity

+ by hand / own scripts / custom
+ other, please specify

NOTES:
^^^^^^
What SCM should be removed, which should be added?


== What you think of Git ==

=== 19. Overall, how happy are you with Git? ===
(single choice)

 * unhappy
 * not so happy
 * happy
 * very happy
 * completely ecstatic

NOTES:
^^^^^^
I'm not sure if this question is at all useful.

There is also problem, that the current wording is considered biased
by some, but on the other hand changing wording of answers would make
it impossible to compare it to answers from previous surveys...


=== 20. In your opinion, which areas in Git need improvement? ===
        Please state your preference.
(matrix)

   Columns: don't need / a little / some / much
 + user-interface
 + documentation
 + performance
 + more features
 + tools (e.g. GUI)
 + localization (translation)

NOTES:
^^^^^^
Are there any general areas that are missing from this list?
What are they?


== Changes in Git (since year ago, or since you started using it) ==

=== 21. Did you participate in previous Git User's Surveys? ===
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


=== 22. How do you compare the current Git version with the version from one year ago? ===
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

=== 23. How useful have you found the following forms of Git documentation? ===
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

NOTES:
^^^^^^
Should we split those answers further, e.g. separating on-line
tutorials and guides, from on-line tips etc.?


=== 24. What channel(s) do you use to request help about Git (if any)? ===
(multiple choice, with other)

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

 + N/A (didn't request help about Git)

 + other (please specify)

NOTES:
^^^^^^
Are there any main channels of requesting help that I have missed in
the above list of answers?  What are they, and why do you think they
are important enought to warrant inclusion in above list?


=== 25. Which communication channel(s) do you use? ===
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

NOTES:
^^^^^^
Are there any communication channels that I have missed?  For example
is there a separate channel that JGit/EGit developers use?


== About this survey. Open forum. ==

=== 26. How did you hear about this Git User's Survey? ===
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
