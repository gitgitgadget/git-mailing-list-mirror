From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Git User's Survey 2010
Date: Sat, 3 Jul 2010 21:46:02 +0200
Message-ID: <201007032146.05412.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 21:46:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV8fU-0006sA-VL
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 21:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474Ab0GCTqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 15:46:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64216 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242Ab0GCTqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 15:46:22 -0400
Received: by fxm14 with SMTP id 14so2978125fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=7c0fELcO5tmMRgTz2hpOq0A1iO4+AUzDN2mfqjjfi4g=;
        b=wpIIltdXlffLS7ZatK4IUM4FH1egXPGRkN6FC7Sp88hZ2Wc7WORhOExYzkOwd4TY97
         N1PGLAvcmqfl8Niehp87yoqkgOjAZ4GwiYEkZaPexWhMvBLXIoIpdO8CXYtrlIwsrIzR
         JO9kixx2tGRYADpDFhN5kWNYPz6U5vMl5WlUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=LXepPbDUuuNM7DGWBCucb/ywAzedpSWv+MxriWgCv5zaUzwMpsbDOyegDM9Ih2sten
         xirkseGbSB+clEKP0Bx0YqjNjyGMiSELKe71Ei8gQ8gZcmzT9WDu9fSyIFFu55AI3t9L
         rwItrfpIG6bertswwhHpOinFoPnvSXc304WuQ=
Received: by 10.86.80.6 with SMTP id d6mr523402fgb.76.1278186380234;
        Sat, 03 Jul 2010 12:46:20 -0700 (PDT)
Received: from [192.168.1.15] (abwj153.neoplus.adsl.tpnet.pl [83.8.233.153])
        by mx.google.com with ESMTPS id 8sm4714869fau.4.2010.07.03.12.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Jul 2010 12:46:19 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150198>

I guess it is time for annual (so far) Git User's Survey.  Should
there be one?  When should it start, and how long should it last?
Earlier surveys:
 * 2009 was open from 15 July   to 15 September 2009 (for 2 months)
 * 2008 was open from 31 August to 14 October 2008 (for 1.5 months)
 * 2007 was open from 20 August to 10 September 2007 (for 20 days)
        (officially: results are up until 28 September 2007)
 * 2006 was open from 23 July   to 6-12 September 2006 
   (for a bit less than 2 months)

With more that 3000 responses in 2008 and 2009 survey, analysing
free-form data was hard.  That is why in this proposal there is only
single one free-form response (about missing features).

What questions (and with what proposed answers) shound there be in
this year survey?  Below there is the content of the proposed survey:


= Git User's Survey 2010 (proposal) =

== About you ==

NOTES: 
^^^^^^
This section gives us a bit of demographical information about survey
responders.  Is it useful?  Should we leave it in survey, or remove it?

Should we for example include 'gender' as one of questions?  Perl Survey
2010 did.


=== 01. What country do you live in? ===
        (Country of residence)
(free-form single line)

NOTES:
^^^^^^
Perhaps a better solution would be a menu (drop-down list) of countries,
using list of current countries.  It would be more work to create it, 
but
might reduce ambiguities and unparsable responses.

What I'd like to have is to pre-fill / select default answer based on 
GeoIP.
Even better would be to be able to show current position on Google Map, 
like
contributors and users map on Ohloh... but that I think is simply not
possible with Survs.com, the site to be used for this survey (and I 
guess
neither with any other survey site).  One can dream.

Pel Survey 2010 also included (from what I remember, and from provided 
data
and analysis of survey) also country of origin / country of birth, to
measure mobility.  I wonder if it would make sense to have the same for 
Git
User's Survey 2010...  Note that it would be harder to come up with the 
list
of countries for such question, because the country might no longer 
exists.
Therefore the list (if present) should be based on all countries that 
exist
or existed since 100 years ago (or so).


=== 02. How old are you (in years)? ===
(free-form single line)

NOTES:
^^^^^^
Instead of unconstrained free-form response it might be better to have
single choice (or menu) of age ranges.  What do you think?  Of course 
with
ranges there is question what ranges to use (how to quantize age); goo
solution would be to chose ranges corresponding somewhat to the levels 
of
education.


== Getting started with Git ==

=== 03. Have you found Git easy to learn? ===
(single choice)

* Very easy
* Easy
* Reasonably easy
* Hard
* Very hard

=== 04. Have you found Git easy to use? ===
(single choice)

* Very easy
* Easy
* Reasonably easy
* Hard
* Very hard

NOTES:
^^^^^^ 
Those two questions, considered alone, doesn't tell us much.  If one use
git, then usually one does not think it is too hard to use (unless 
forced to
use git by external circumstances, like project he/she works on using 
git).
On the other hand those two questions together give us some mesaure of 
git
learning curve, telling us if people consider git easy to use but hard 
to
learn, or vice versa ;-)

I think it might be also good to have to calculate correlations, e.g. if
people who find git hard to use make use of its advanced features.

The question is: should they stay, or should they go?


=== 05. Which Git version(s) are you using? ===
(multiple choice, with other)

 + pre 1.3
 + 1.3.x
 + 1.4.x
 + 1.5.x
 + 1.6.x
 + 1.7.x

 + minor (maintenance) release 1.x.y.z
 + 'master' branch of official git repository
 + 'next' branch of official git repository
 + 'pu' branch of official git repository
 + version from msysGit / Git for Windows fork repository
 + git-bigfiles fork
 + JGit implementation (e.g. via Eclipse plugin, EGit)

 + other, please specify

NOTES:
^^^^^^
A few of possible answers are new in this version of survey, namely 
'pu',
msysGit, git-bigfiles, JGit, and of course 1.7.x.

This question is here to stay.


=== 06. Rate your own proficiency with Git: ===
(single choice)

 * 1. novice
 * 2. casual, needs advice
 * 3. everyday use
 * 4. can offer advice
 * 5. know it very well

NOTES:
^^^^^^
This question tell us penetration of announcements of Git User's Survey 
2010;
did we get to all, or only to git gurus?  It is also useful for 
correlating
with other responses, for example to know which features are used by
novices, and which by gurus.


== How you use Git ==

=== 07. I use Git for (check all that apply): ===
(multiple choice, with other)

Note that above choices are neither orthogonal nor exclusive.  One
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
Those two are about using git at work vs using git on your own free 
time.
There are of course shades of gray, like using git for work project
unofficially (e.g.using git-svn as "fat" client for company's Subversion
repository), or employer allowing to work on non-work OSS project during
working hours.  But I'm not sure if they are worth adding.

 + proprietary projects
 + OSS development (also public domain, and published & unlicensed)
 + private (unpublished)

Notes:
^^^^^^
Those three are about licensing: proprietary / free (open) / unlicensed.
By 'OSS development' I mean here also free licenses for documentation 
and
documents, like GFDL or Creative Commons licenses.

 + code (programming)
 + personal data
 + documents (data)
 + static website
 + web app
 + large (> 1MB) binary files
 + often changing binary files

Notes:
^^^^^^
This is about what kind of data do you store in git.  I am a bit unsure
whether it is worth separating 'web app'; it is 'code'.

New in this edition of survey is 'large binary data' and 'often changing
binary files'... but should 'large' cutoff be 1MB, or 10MB, or 50MB, or
100MB?

I'm not sure about having 'personal data'...

 + sharing data or sync
 + managing configuration files
 + backup
 + backend for wiki, blog, or other web app
 + frontend to other SCM (e.g. git-svn)

Notes:
^^^^^^
This is about (ab)using git for other things than straighforward source
control management.  List of possible answers specified here should 
cover
most commonly encountered usages: shdoul we add anything else here?

 + other (please specify)


=== 08. How do/did you obtain Git (install and/or upgrade)? ===
(multiple choice, with other)

Note that this question is multiple choices question because one can
install Git in different ways on different machines or on different
operating systems.

 + binary package
 + source package or script
 + source tarball
 + pull from (main) repository
 + preinstalled / sysadmin job

 + other - please specify

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


=== 09. On which operating system(s) do you use Git? ===
(multiple choice, with other)

 + Linux (includes MeeGo and Moblin)
 + MacOS X (Darwin)
 + MS Windows/msysGit (MINGW)
 + MS Windows/Cygwin
 + FreeBSD, OpenBSD, NetBSD, etc.
 + other Unix

 + iPhone OS
 + Android
 + WebOS

 + Other, please specify

NOTES:
^^^^^^
The iPhone OS, Androind and WebOS answers are new this year.
OpenSolaris died, so I removed it.  I wonder if it is worth it to
differentiate between MS Windows/msysGit and MS Windows/Cygwin, or if
we should just have one, single 'MS Windows' choice.


=== 10. What do you use to edit contents under version control with Git? 
===
        What kind of editor, IDE or RAD you use working with Git?
(multiple choice, with other)

 + simple text editor
 + programmers editor
 + IDE or RAD
 + WYSIWYG tool

 + other kind

Description:
~~~~~~~~~~~~
* "simple text editor" option includes editors such as pico, nano,
  joe, Notepad,

* "programmets editor" option includes editors such as Emacs/XEmacs,
  Vim, TextMate, SciTE (syntax highlighting, autoindentation,
  integration with other programmers tools, etc.)

* "IDE (Integrated Development Environment) and RAD (Rapid Application
  Development)" option includes tools such as Eclipse, NetBeans IDE,
  IntelliJ IDE, MS Visual Studio, KDevelop, Anjuta, Xcode,
  Code::Blocks but also tools such as Quanta+, BlueFish or Screem (for
  editing HTML, CSS, PHP etc.), and Kile or LEd for LaTeX.

* "WYSIWYG tools" option includes word processors such as MS Office or
  OpenOffice.org, but also tools such as Adobe Acrobat (for PDF) or
  GIMP (for images), or WYSIWYG DTP tools such as QuarkXPress,
  PageMaker or Scribus, or WYSIWYG HTML editors such as FrontPage,
  Dreamweaver or KompoZer.

NOTES:
^^^^^^
Is this question useful, or should it be removed from survey?


=== 11. What Git interfaces and frontends do you use? ===
(multiple choice, with other)

 + Cogito (DEPRECATED)
 + Easy Git
 + Pyrite
 + I don't know, I only use (graphical) tools

 + pg aka Patchy Git (DEPRECATED)
 + StGIT
 + Guilt
 + TopGit

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

 + editor/IDE VC integration (e.g. EGit, TextMate bundle, magit)
 + filemanager / shell extension (e.g. git-cheetah, TortoiseGit)
 + graphical history viewer/browser (e.g. gitk)
 + graphical commit tool (e.g. git-gui)
 + graphical diff and/or merge tool (e.g. Kompare, Meld)
 + graphical blame or pickaxe tool
 + git-instaweb, or self-hosted web interface
 + tool to manage git repositories (e.g. Gitosis, Gitolite)

 + my own scripts (for daily use)
 + my own scripts (for special tasks)

NOTES:
^^^^^^
As the number of tools increases (see InterfacesFrontendsAndTools page
on git wiki), having them listed all there gets a bit unwieldy.  On
the other hand it was a good way to find new tools that were not yet
included on IFaT page.  What do you think: should it be about tools,
or only about kind of tools used with git?

What do you think about this list?  IS there something that should not
be here?  Or perhaps there is something that should be added to this
list?


=== 13. Which git hosting site(s) do you use for your project(s)? ===
        Please check only hosting sites where you publish/push to (with 
git)
(multiple choice, with other)

 + [http://repo.or.cz repo.or.cz]
 + [http://github.com GitHub]
 + [http://gitorious.org Gitorious]
 + [http://www.indefero.net InDefero]

Notes:
^^^^^^
Those are generic git hosting sites, each of them showcasing their own
tool, all except GitHub open source (it is Girocco for repo.or.cz; for
the rest the tool is named the same as the git hosting site).

 + [http://savannah.gnu.org Savannah]
 + [http://sourceforge.net SourceForge]

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
 - [http://unfuddle.com Unfuddle]

Notes:
^^^^^^
Those are commercial and/or less known git hosting sites.  I am not
sure which ones of those marked with '-' to include, and whether to
include other sites from GitHosting page on git wiki.  What do you
think?

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

 +  git hosting site for related projects
 +  generic site without git support
 +  self hosted

Notes:
^^^^^^
Are ther other kinds / typse of sites one can host project using git
on?  What are they?

 +  Other (please specify)

NOTES:
^^^^^^
I think this question is here to stay.


=== 14. How do you fetch/get changes from upstream repositories? ===
(multiple choice, with other)

 + git protocol        (e.g. git://git.example.com/repo.git)
 + ssh                 (e.g. ssh+git://git.example.com/repo.git,
                             git.example.com:/srv/scm/repo.git)
 + http                (e.g. http://git.example.com/repo.git)
 + rsync (DEPRECATED)  (e.g. rsync://git.example.com/repo.git)
 + filesystem          (e.g. /path/to/repo.git, 
file:///path/to/repo.git)
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

 + push
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


=== 16. Which of the following features do you use? ===
(multiple choice, with other)

 + "smart" HTTP protocol
 + git bundle (off-line transport)
 + eol conversion (crlf)
 + gitattributes
 + custom diff/merge driver
 + submodules (subprojects)
 + subtree merge (optionally git-subtree)
 + partial (sparse) checkout, or assume-unchanged bit
 + separate worktree / core.worktree
 + multiple worktrees (git-new-worktree)
 + alternates mechanism (sharing object database)
 + stash (optionally "git stash --keep-index")
 + shallow clone (e.g. "git clone --depth=<n>")
 + detaching HEAD (e.g. "git checkout HEAD^0")
 + interactive rebase (small scale history editing)
 + interactive commit / per-hunk comitting / partial commit
 + commit message templates
 + git-filter-branch or equivalent (large history rewriting)
 + bisect (optionally "git bisect run <script>")
 + committing with dirty tree (keeping some changes uncommitted)
 + non-default hooks (from contrib/hooks/ or other)
 + shell completion of commands
 + git-aware shell prompt
 + git aliases, shell aliases for git, or own git scripts
 + one-way interaction with other SCMs (from SCM to git)
 + two-way interaction with other SCMs (from SCM to git, from git to 
SCM)
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


=== 17. Which of the following features would you like to see 
implemented in git? ===
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
 + localization of command-line messages
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
This is new question, a multiple choice companion to a essay free-form
question below.  Included are a few example features (some from
partial analysis of "19. What features would you like implemented in
Git?" question in 2009 survey.

What features should be mentioned besides those above?  What criteria
should we have for including features in this list?

=== 18. Describe what features would you like to have in Git, if it is
        not on the list above? ===
(free form, essay length)


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
 + none of the above

NOTES:
^^^^^^ 
This might be quite useful comparing with previous surveys.  The
answer 'none of the above' is new in this survey (as is 'in 2009',
of course).


=== 22. How do you compare the current version with the version from one 
year ago? ===
(single choice)

 * better
 * no changes
 * worse

 * cannot say

NOTES:
^^^^^^
This question was mainly excuse for providing list of main changes
from the year ago.  I think that this question should be removed, as
it doesn't bring any important information.


== Documentation. Getting help. ==

=== 23. How useful have you found the following forms of Git 
documentation? ===
(matrix)

  Columns: never used / not useful / somewhat / useful
 + Git Wiki
 + on-line help
 + help distributed with git


Description:
~~~~~~~~~~~~
* Git Wiki was to be found at http://git.wiki.kernel.org
* on-line help includes, among others, Git Homepage 
(http://git-scm.com),
  "Git Community Book" (http://book.git-scm.com), "Pro Git" book
  (http://progit.org) and Git Reference site (http://gitref.org)
* help distributed with git include manpages, manual, tutorials, HOWTO,
  release notes, technical documentation, contrib/examples/

NOTES:
^^^^^^
Should we split those answers further, e.g. separating on-line
tutorials and guides, from on-line tips etc.?


=== 24. Have you tried to get help regarding Git from other people? ===
(single choice)

 * Yes
 * No

=== 25. If yes, did you get these problems resolved quickly and to your 
liking? ===
(single choice)

 * Yes
 * No
 * Somewhat

NOTES:
^^^^^^
Those two questions are not very useful.  I think that they should be
removed from 2010 survey.


=== 26. What channel(s) do you use to request help about git? ===
(multiple choice, with other)

 + git mailing list (git@vger.kernel.org)
 + "Git for Human Beings" Google Group
 + msysGit mailing list / Google Group
 + IRC (#git)
 + IRC (other git/SCM related, e.g. #github)
 + request in blog post or on wiki
 + asking git guru/colleague
 + project mailing list, or IRC, or forum
 + Twitter or other microblogging platform
 + instant messaging (IM) like XMPP/Jabber
 + StackOverflow or other StackExchange site

 + other (please specify)

NOTES:
^^^^^^
Are there any main channels of requesting help that I have missed in
the above list of answers?  What are they, and why do you think they
are important enought to warrant inclusion in above list?


=== 27. Which communication channel(s) do you use? ===
        Do you read the mailing list, or watch IRC channel?
(multiple choice)

 + git@vger.kernel.org (main)
 + Git for Human Beings (Google Group)
 + msysGit
 + #git IRC channel
 + #git-devel IRC channel
 + #github or #gitorious IRC channel
 + #revctrl IRC channel

NOTES:
^^^^^^
Are there any communication channels that I have missed?  For example
is there a separate channel that JGit/EGit developers use?


== About this survey. Open forum. ==

=== 28. How did you hear about this Git User's Survey? ===
(single choice, with other)

 * git mailing list
 * git-related mailing list (e.g. msysGit)
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

Sidenote: I am thinking about contacting different git hosting sites
_before_ staring survey, asking them (them = administrators) about
what questions would they like to see.  Do you think thet it is good
idea?

Should I try to post announcement on mailing list for projects that
use git?  There are entirely too many such projects nowadays, and such
announcement can be considered spamming by some...

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
