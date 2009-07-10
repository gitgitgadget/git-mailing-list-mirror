From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Git User's Survey 2009 - last trial run, announcing survey
Date: Fri, 10 Jul 2009 18:09:34 +0200
Message-ID: <200907101809.35486.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 18:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPIfZ-0002Lh-6Y
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 18:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbZGJQJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 12:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbZGJQJo
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 12:09:44 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:55421 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbZGJQJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 12:09:42 -0400
Received: by bwz25 with SMTP id 25so982352bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=UHT3fDe224eK/Cm9xGmYaAmTQgV40wTDwHLPjX+fgu8=;
        b=PHZ9DtloMhIEbg9oeZYBLqk0PaVR4096mu+k0b5WnawavU02GfpO+DVtN8NP4tmIro
         8xOl7GAFxqEZHh3J6sfmmTfpz6MME7eaLDdDpEcImewGA0txDsyITMom1xRtyQRnbLXR
         kkw/uavaBchtH7910JHwgHVjs2N8enxx8iz1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=mjebPLIIMiwqrt6/4MuH75dUY2IDBx9JbGaPKZFUWo9v8ha8lxjjIlTRUVACCLEVet
         ag/mROjYjlejvmopskGDMhJFiodR7FmhJlhJ8ZkQ2V+xPuj9s8FALFmgCXkDU0d78LKX
         JBjQzVrpt1dVEVeRXYtmUwkbFpNL9HpbtSwFg=
Received: by 10.103.214.13 with SMTP id r13mr1167818muq.37.1247242178653;
        Fri, 10 Jul 2009 09:09:38 -0700 (PDT)
Received: from ?192.168.1.13? (abwp104.neoplus.adsl.tpnet.pl [83.8.239.104])
        by mx.google.com with ESMTPS id 23sm6743704mun.16.2009.07.10.09.09.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 09:09:37 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123060>

This is proposed third (and hopefully last) version of questions for
upcoming "Git User's Survey 2009", which is planned to run from around
15 July 2009 to 15 September 2009 (duration of two months).

One of main changes compared to previous version is slight=20
reorganization of answers and substantial rewrite of help text
for question
  8. How do/did you obtain Git
and adding "preinstalled / sysadmin job" and "other - please specify"
to the list of possible answers.

Other major addition was creating description of major changes for
 23. How do you compare the current version with the version
     from one year ago?
question.  Please review this explanation, and tell me if there are
some major changes missing; conversely if you consider some of changes
listed not worth mentioning, please tell me what to delete.


Thanks to Junio C Hamano, Felipe Contreras, David Aguilar, Andreas
Ericsson, Martin Renold, Erik Faye-Lund and others who participated
in previous GitSurvey2009 thread[1] for their feedback and comments.
 [1]: http://thread.gmane.org/gmane.comp.version-control.git/122675

This time I didn't Cc-ed all contributors from earlier round; please
tell me if it is preferred, or would you rather if I put all=20
contributors on CC list.


A few questions about announcing "Git User's Survey 2009":

1. We would like to announce this survey on=20
    * Git Homepage (contact: Scott Chacon)
    * git hosting sites using gitweb:
      - repo.or.cz (contact: Petr 'Pasky' Baudis)
      - git.kernel.org (contact: John 'Warthog9' Hawley ???)
    * other git hosting sites:
      - GitHub, via blog (contact: Chris Wanstrath, PJ Hyett)
      - Gitorious (contact: Johan S=C3=B8rensen)
      - Assembla, Unfuddle, Codebase (contact: support)
        last year IIRC only Unfuddle posted the announcement
    * other software-related sites:
      - Ohloh blog/announcement (contact: info, Robin Luckey)
    * blogs:
      - Elijah's blog (contact: Elijah Newren)
      - gitblog (contact: Felipe Conreras)

   What other sites to contact (and who to contact about it) to put
   announcement info about "Git User's Survey 2009"?  LWN.net?
   Freedesktop.org?  OLPC?  Linux-Magazine?  FSF Magazine?
   VersionControlBlog (seems to be down)?  Masukomi weblog?
   Ryan Tomayko linkings?  Submit to Slashdot?

   From git developers blogs that I know of have: Junio C Hamano,
   Shawn Pearce (inactive since year ago), Sam Vilain (currently
   broken) and Linus Torvalds.

2. How such request to announce "Git User's Survey 2009" should look
   like?  How should example proposed announcement looks like?

3. Last year we posted announcement about survey on various mailing
   lists for projects using git as SCM of choice.  This seems a bit
   spammy, so this year it was decided to skip this... also with number
   of projects using git so large it would be hard to decide which=20
   projects to include, and which to skip.

   I will be posing announcement on git mailing list (of course),
   on msysGit list, and on "Git for Human Beings" Google Group
   (if it exists).  Should we as special case post also to GitHub
   and Gitorious mailing list?  What about LKML (Linux kernel mailing
   list)?

4. What other ways to announce this survey to wider audience (but
   best if limited to developers, even better to developers using git)
   are there? =20
   - Twitter or identi.ca or Plurk?  Needs someone with following.
   - Digg or (better) Reddit or DZone?  Needs some point of reference;
     perhaps GitSurvey2009 page on Git Wiki... but is it a good idea
     to use this avenue?


The *test* version of this year survey can be now found at
the following URL (as in previous year, we use Survs.com)

  http://www.survs.com/survey?id=3D2PIMZGU0&channel=3DTFN2Y52K7Y

ATTENTION: All data in test survey would be deleted when survey
would start for real!

Below there is rendered form of survey
=2E....................................................................=
=2E
Git User's Survey 2009

This survey is anonymous, but all information that the users provide
(raw data) will be publicly available on the Git Wiki, at
http://git.or.cz/gitwiki/GitSurvey2009, to allow for independent
analysis.

Note that you may skip questions as you like.

You can also return to this survey after submission, and correct it,
or fill more questions later. This feature makes this survey to
require to have COOKIES ENABLED, at least for this site, to be able to
submit.

About you
~~~~~~~~~
1. What country do you live in?
2. How old are you (in years)?

Getting started with Git
~~~~~~~~~~~~~~~~~~~~~~~~
3. Have you found Git easy to learn?
    * Very easy
    * Easy
    * Reasonably easy (average)
    * Hard
    * Very hard

4. Have you found Git easy to use?
    * Very easy
    * Easy
    * Reasonably easy (average)
    * Hard
    * Very hard

5. Which Git version(s) are you using?
    * pre 1.3
    * 1.3.x
    * 1.4.x
    * 1.5.x
    * 1.6.x
    * minor (maintenance) release 1.x.y.z
    * 'master' branch of official git repository
    * 'next' branch of official git repository
    * other, please specify

You can find git version by using "git --version" or "git version".

"Minor release" is additional specification, so if you for example use
git version 1.6.3.3, please check both "1.6.x" and "minor release".

6. Rate your own proficiency with Git:
    * 1. novice
    * 2. casual, needs advice
    * 3. everyday use
    * 4. can offer advice
    * 5. know it very well

You can think of it as 1-5 numerical grade of your proficiency in Git.

How you use Git
~~~~~~~~~~~~~~~
7. I use Git for (check all that apply):
    * work projects
    * unpaid projects
    * proprietary projects
    * OSS development
    * private (unpublished) code
    * code (programming)
    * personal data
    * documents
    * static website
    * web app
    * sharing data or sync
    * backup
    * backend for wiki, blog, or other web app
    * managing configuration files
    * frontend to other SCM (e.g. git-svn)
    * other (please specify)

Note that above choices are neither orthogonal nor exclusive.
You might want to check multiple answers even for a single repository.

8. How do/did you obtain Git (install and/or upgrade)?
    * binary package
    * source package or script
    * source tarball
    * pull from (main) repository
    * preinstalled / sysadmin job
    * other - please specify (if none of the above apply)

Explanation: binary package covers pre-compiled binary (e.g. from rpm
or deb binary packages); source package covers things like deb-src and
SRPMS/*.src.rpm; source script is meant to cover installation in
source-based distributions, like 'emerge' in Gentoo.

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

9. On which operating system(s) do you use Git?
    * Linux
    * *BSD (FreeBSD, OpenBSD, NetBSD, etc.)
    * MacOS X (Darwin)
    * MS Windows/Cygwin
    * MS Windows/msysGit (MINGW)
    * OpenSolaris
    * other Unix
    * Other, please specify

On Unix-based operating system you can get the name of operation
system by running 'uname'.

10. What do you use to edit contents under version control with Git?
    What kind of editor, IDE or RAD you use working with Git?

    * simple text editor
    * programmers editor
    * IDE or RAD
    * WYSIWYG tool
    * other kind - please specify

* "simple text editor" option includes editors such as pico, nano,
  joe, Notepad,

* "programmets editor" option includes editors such as Emacs/XEmacs,
  Vim, TextMate, SciTE (syntax highlighting, autoindentation,
  integration with other programmers tools, etc.)

* "IDE (Integrated Development Environment) and RAD (Rapid Application
  Development)" option includes tools such as Eclipse, NetBeans IDE,
  IntelliJ IDE, MS Visual Studio, KDevelop, Anjuta, XCode,
  Code::Blocks but also tools such as Quanta+, BlueFish or Screem (for
  editing HTML, CSS, PHP etc.), and Kile or LEd for LaTeX.

* "WYSIWYG tools" option includes word processors such as MS Office or
  OpenOffice.org, but also tools such as Adobe Acrobat (for PDF) or
  GIMP (for images), or WYSIWYG DTP tools such as QuarkXPress,
  PageMaker or Scribus, or WYSIWYG HTML editors such as FrontPage,
  Dreamweaver or KompoZer.

11. What Git interfaces, implementations, frontends and tools do you us=
e?
    * git (core) commandline
    * JGit (Java implementation)
    * library / language binding (e.g. Grit or Dulwich)
    * Cogito (DEPRECATED)
    * Easy Git
    * Pyrite
    * StGIT
    * Guilt
    * TopGit
    * pg aka Patchy Git (DEPRECATED)
    * gitk
    * git gui
    * QGit
    * GitView
    * Giggle
    * GitNub
    * GitX
    * git-cola
    * tig
    * TortoiseGit
    * Git Extensions
    * git-cheetah
    * git-instaweb
    * git-sh
    * Gitosis (as admin)
    * repo (to manage multiple repositories)
    * editor/IDE VC integration
    * filemanager integration / shell extension (any)
    * graphical history viewer/browser (any)
    * graphical commit tool (any)
    * graphical diff tool
    * graphical merge tool
    * graphical blame or pickaxe tool
    * my own scripts
    * Other (please specify)

Here graphics diff tool means tools such as Kompare, and graphical
merge tool means tools such as Meld and KDiff3. Those answers include
graphical merge and diff tools used by programmers editors and IDEs.

"graphical history browser (any)" covers tools such as gitk, QGit,
Giggle, tig etc., but also built-in git commands such as "git log
--graph" and "git show-branch". If you use one of mentioned tools _as_
history browser, mark both a tool and "graphical history browser
(any)"; if you use some graphical history viewer not listed here,
please both mark this answer and specify it in the "other tool"
answer.

Similarly for other answers marked "(any)".

12. What tool (or kind of tool) would you like to have Git support in?
    (e.g. IDE, RAD, editors, continuous integration, software hosting,
     bugtracker, merge tool...)
    (this includes language bindings and Git (re)implementations)

    free-form, essay

13. Which git hosting site(s) do you use for your project(s)?
    (Please check only hosting sites where you publish/push to)

    * repo.or.cz
    * GitHub
    * Gitorious
    * Savannah
    * SourceForge
    * Assembla
    * Unfuddle
    * kernel.org
    * freedesktop.org
    * Alioth
    * Fedora Hosted
    * git hosting site for set of related projects (e.g. OLPC)
    * generic site without git support
    * self hosted
    * Other (please specify)

14. How do you fetch/get changes from upstream repositories?
    * git protocol (e.g. git://example.com/repo.git)
    * ssh (e.g. ssh://example.com/repo.git or user@example.com:/repo.gi=
t)
    * http (e.g. http://example.com/repo.git)
    * rsync (DEPRECATED) (e.g. rsync://example.com/repo.git)
    * filesystem (e.g. /path/to/repo.git or file:///path/to/repo.git)
    * via git-bundle
    * foreign SCM import / script like git-svn
    * Other, please specify

This question asks about how do you get changes (updates) from
projects you follow into your local repository. It is not about how do
you get latest version of Git.

=46etching (or rather cloning) via bundle could mean that project
publishes ready for download bundles to reduce traffic and load on
server (HTTP download [of bundle] can be resumed, git-clone currently
cannot; one can also distribute bundle using P2P).

15. How do you publish/propagate your changes?
    * push
    * pull request (+ any form of announcement / notification)
    * format-patch + email
    * format-patch + other (e.g. reviewboard, issue tracker or forum)
    * git bundle
    * git-svn (to Subversion repository)
    * git-p4 (to Perforce repository)
    * foreign SCM interface (other than mentioned above)
    * other - please specify

Publishing via bundle could mean sending bundle via email, or posting
it on review board (or forum).

16. How often do you use the following forms of git commands
    or extra git tools?
        (columns: never | rarely | sometimes | often)
      git add -i / -p
      git add -u / -A
      git am
      git am -i
      git apply
      git apply --whitespace=3Dfix
      git archive
      git bisect
      git bisect run <cmd>
      git annotate
      git gui blame
      git blame
      git blame -L <start>,<end> etc.
      git bundle
      git cherry
      git cherry-pick
      git cherry-pick -n / --no-commit
      git citool
      git clean
      git add + git commit
      git commit -a
      git commit <file>...
      git commit -i <file>...
      git commit --amend
      git cvsexportcommit
      git cvsserver
      git daemon
      git daemon (pushing enabled)
      git difftool
      git ... --dirstat
      git fetch [<options>]
      git filter-branch
      git format-patch
      git grep
      git imap-send
      git instaweb
      git log --grep/--author/...
      git log -S<string> (pickaxe search)
      git log --graph
      git merge
      git merge with strategy
      git merge --squash
      git mergetool
      git pull (no remote)
      git pull --rebase [<options>]
      git pull <remote>
      git pull <URL> <ref>
      git push

This question (and its continuation below) is entirely optional.

17. How often do you use the following forms of git commands
    or extra git tools? (continued)
        (columns: never | rarely | sometimes | often)
      git relink
      git rebase
      git rebase -i
      git reflog or git log -g
      git remote
      git remote update
      git request-pull
      git revert
      git send-email
      git show-branch
      git shortlog
      git shortlog -s
      git stash
      git stash --keep-index
      git submodule
      git subtree
      git svn
      git whatchanged
      git gui
      gitk

Explanation: "Rarely" means that you use mentioned form of command
either rarely, or you have used it only a few times.

Questions 16 and 17 (its continuation) are purely optional (as are the
rest of questions in survey). If you don't feel like filling this
questions, please skip them.

Note: git-subtree is managed out of tree, as a separate project (not
in git.git repository, not even in contrib/ area). Originally
git-subtree was submitted for inclusion, and later was considered for
'contrib/', but it was decided that it would be better if it mature
out-of-tree, before resubmitting.

18. Which of the following features have you used?
    * git bundle (off-line transport)
    * eol conversion (crlf)
    * gitattributes
    * mergetool and/or difftool, or custom diff/merge driver
    * submodules (subprojects)
    * subtree merge (optionally git-subtree)
    * separate worktree / core.worktree
    * multiple worktrees (git-new-worktree)
    * alternates mechanism (sharing object database)
    * stash (optionally "git stash --keep-index")
    * shallow clone (e.g. "git clone --depth=3D<n>")
    * detaching HEAD (e.g. "git checkout HEAD^0")
    * interactive rebase (small scale history editing)
    * interactive commit / per-hunk comitting / partial commit
    * commit message templates
    * git-filter-branch or equivalent (large history rewriting)
    * bisect (optionally "git bisect run <script>")
    * committing with dirty tree (keeping some changes uncommitted)
    * non-default hooks (from contrib/hooks/ or other)
    * shell completion of commands
    * git-aware shell prompt
    * git aliases, shell aliases for git, or own git scripts
    * Other, please specify

19. What features would you like implemented in Git?
    What features are you missing?

    free-form, essay

EXAMPLES: partial / subtree checkout, commit annotations aka
git-notes, refs/replace/* mechanism, "smart" HTTP protocol (git via
HTTP), resumable clone/fetch, lazy clone (on demand downloading of
objects), wholesame directory rename detection, syntax highlighting
and/or side-by-side diffs in gitweb, graphical merge tool integrated
with git-gui, etc.


What you think of Git
~~~~~~~~~~~~~~~~~~~~~
20. Overall, how happy are you with Git?
    * unhappy
    * not so happy
    * happy
    * very happy
    * completely ecstatic

21. In your opinion, which areas in Git need improvement?
    Please state your preference.
        (columns: don't need | a little | some | much)
      user-interface
      documentation
      performance
      more features
      tools (e.g. GUI)
      localization (translation)


Changes in Git (since year ago, or since you started using it)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
22. Did you participate in previous Git User's Surveys?
    * in 2006
    * in 2007
    * in 2008

23. How do you compare the current version with the version
    from one year ago?

    * better
    * no changes
    * worse
    * cannot say

The version from approximately one year ago is 1.5.6 from 18-06-2008,
the last version in 1.5.x series (except maintenance releases from
1.5.6.1 to 1.5.6.6). Major controversial change in 1.6.0 was
installing most of the programs outside your $PATH.

Other changes include:
 * stash never expires by default
 * git-branch got -v, --contains and --merged options
 * fast-export / fast-import learned to export and import marks file
 * "git stash save" learned --keep-index option; "git stash" learned
   "branch" subcommand
 * when you mistype a command name, git can suggest what you might
   meant to say
 * git add -N / --intent-to-add
 * built in synonym "git stage" for "git add",
   and --staged for --cached
 * improvements to "git bisect skip" (can take range, more aggresive)
 * "git diff" can use varying mnemonic prefixes, learned "textconv"
   filter
 * "git log" learned --simplify-merges, --source,
   --simplify-by-decoration
 * "git send-email" can automatically run "git format-patch"
 * you can use @{-1} to refer to the last branch you were on
 * "git diff" learned --inter-hunk-context and can be told to run
   --patience diff
 * git-difftool can run graphical diff tool
 * unconfigured git-push issue now a big warning (preparing for the
   future incompatibile change)

(see individual RelNotes for more details)


Documentation. Getting help.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
24. How useful have you found the following forms of Git documentation?
        (columns: never used | not useful | somewhat | useful)
      Git Wiki
      on-line help
      help distributed with git

* Git Wiki can be found at http://git.or.cz/gitwiki
* on-line help includes, among others, Git Homepage
  (http://git-scm.com) and "Git Community Book"
  (http://book.git-scm.com)
* help distributed with git include manpages, manual, tutorials,
  HOWTO, release notes, technical documentation, contrib/examples/

25. Have you tried to get help regarding Git from other people?
    * Yes
    * No

26. If yes, did you get these problems resolved quickly
    and to your liking?

    * Yes
    * No
    * Somewhat

27. What channel(s) did you use to request help?
    * git mailing list (git@vger.kernel.org)
    * "Git for Human Beings" Google Group
    * IRC (#git)
    * IRC (other git/SCM related, e.g. #github)
    * request in blog post or on wiki
    * asking git guru/colleague
    * project mailing list, or IRC, or forum
    * Twitter or other microblogging platform
    * instant messenging (IM) like XMPP/Jabber
    * StackOverflow
    * other (please specify)

28. Which communication channel(s) do you use?
    Do you read the mailing list, or watch IRC channel?

    * git@vger.kernel.org (main)
    * Git for Human Beings (Google Group)
    * msysGit
    * #git IRC channel
    * #github or #gitorious IRC channel
    * #revctrl IRC channel


About this survey. Open forum.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
29. How did you hear about this Git User's Survey?
    * git mailing list
    * git-related mailing list (msysGit, Git for Human Beings, ...)
    * mailing list or forum of some project
    * #git IRC channel topic
    * announcement on IRC channel
    * git homepage
    * git wiki
    * git hosting site
    * software-related web site
    * news web site or social news site
    * blog (or blog planet)
    * other kind of web site
    * Twitter or other microblogging platform
    * other - please specify

30. What other comments or suggestions do you have that are not
    covered by the questions above?

    free-form, essay

If you have cookies enabled, you can always submit partially filled
survey, and return to your answers at later time, completing it later.
=2E....................................................................=
=2E
