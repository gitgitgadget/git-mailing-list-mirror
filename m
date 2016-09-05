Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9323020705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932466AbcIEV17 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:27:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33234 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbcIEV1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:27:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id w207so15392620wmw.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=hDXFXjj2m1lISz+6e9H/TSbGnfBDhJS8K1ChmjeKJ2E=;
        b=lNAfIUl0Fxs1VBObaMayG6eWMtyWk4mQ4Wj2Ejv8VpEggUdQ3fz5KlTvmxmdW3CKbZ
         cusS/mDZqIT+7rP5zCcXjdwzlhTLUM3P9JVxycIfg5AdPNFvgCUZXEsMlQC1pOLkSIY3
         lVjIEUdiDIA6CsqXBtGIx6Xmv1RdSxPDW4wSrJ1x6mFH/lCCxSDMjRhbWmXYyy7R35IP
         smlP2BHD/1LkVyWEmCa66Vwt5rjwHSAz49uT5PUCHwXhEb2AiAYfYAcxKiNNxL2A+3hS
         Ycpyska9zaMVpFHHDoieclGCP7Z438DyWLDEo/Y17YEkJ2mRgC8REH/ezfm9zG5U/2Q/
         Kgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hDXFXjj2m1lISz+6e9H/TSbGnfBDhJS8K1ChmjeKJ2E=;
        b=jSnudTUk/Qv2tjKDmixBld7likivKj1s132lGEFY5pFVfyCYrA6FrMEE/IJjLqh5PP
         zSgSMlg8S3PqzumX0xJC1Wzct6U70LZTka80VOTIQQmGSJEJQ3h3prtoY1NoJcsvJZZN
         HmQnBq95IRORN1kNU/GyX8ReLKtfFdyEFIPuiQlAMVsa1ne+LEKtIY+/FbXoaHE0x1iF
         8GBmi2UY5dvk1Hc33D+UgkjFwsPjTICwmqXgeLupc1H1mT7kaZz0BelEwub7dPE0ZnZ9
         l2kbViyRTpSbhPWe3ZlJZtHzeADpthx3EOideS1IOto79WCb7y6cDY2gaSXgPeVG15MP
         C4Dw==
X-Gm-Message-State: AE9vXwN9C8qiBOHgaPKmFG0taul7wkNPoUdLFnna88MYceRCcX/TsZBQ4vSMAlKN+7rFaA==
X-Received: by 10.194.200.36 with SMTP id jp4mr37010903wjc.26.1473110873700;
        Mon, 05 Sep 2016 14:27:53 -0700 (PDT)
Received: from [192.168.1.26] (epw136.neoplus.adsl.tpnet.pl. [83.20.64.136])
        by smtp.googlemail.com with ESMTPSA id v189sm22763770wmv.12.2016.09.05.14.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Sep 2016 14:27:52 -0700 (PDT)
Subject: [RFCv3] Proposed questions for "Git User's Survey 2016", take three
To:     git@vger.kernel.org
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <ae804c55-d145-fc90-e1a9-6ebd6c60453a@gmail.com>
Cc:     Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>, Eric Wong <e@80x24.org>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        "W. David Jarvis" <william.d.jarvis@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ccb678e4-d91a-1ef0-90e3-0a507ea0ee25@gmail.com>
Date:   Mon, 5 Sep 2016 23:27:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <ae804c55-d145-fc90-e1a9-6ebd6c60453a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

As I wrote previously, I am thinking about returning to doing the
Git User's Survey this year.

  Message-ID: <577E6F32.7020007@gmail.com>

  https://marc.info/?l=git&m=146790381602547&w=2
  https://public-inbox.org/git/577E6F32.7020007%40gmail.com/

In this email I'd like to propose the revised list of questions (and
answers) for Git User's Survey 2016, following comments to the previous
revisions, starting with

  Message-ID: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>

  https://public-inbox.org/git/91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com/


Below is my third, and probably final proposal.  You can see the survey
in work at (there might be some slight differences from what's below)

  https://survs.com/survey/kn2bpu4p9d

NOTE: This is a *test channel*, all responses will be deleted.


The survey is currently planned to be open (after a bit of delay)
from  10 September 2016  to  20 October 2016.

I'd like to ask also about announcing the survey as widely as possible.
Please reply if you think of some channel, or of you could announce
it yourself.  Thanks in advance.


If you want to do this survey "in house", you can ask for a separate
channel (a separate survey URL).  After the survey ends, I'll send 
anonymous responses from that channel in Excel and CSV formats.

There also will be anonymous, JavaScript- and cookie-less channel;
at the cost that you cannot go back and change or add to your response.
----------------------------------------------------------------------------
There are 50 questions in this survey.


#### About you

01. What country do you live in? (Country of residence, in English)
    (free-form single line)

02. How old are you (in years)?
    (single number)

03. What is your gender?
    (single choice)

  *  Man
  *  Woman
  *  Other
  *  Prefer to not disclose

04. How would you describe your occupation / role as Git user?
    (multiple choice with other, limit to 3 selections)

  + Developer
  + Programmer
  + Engineer
  + Analyst
  + Manager / Leader
  + Maintainer / Reviewer / Sub-maintainer
  + DevOps
  + Administrator
  + Designer
  + Artist / Writer
  + Tester / QA
  + Expert
  + Student
  + Researcher
  + Teacher
  + Other, please specify

05. Have you ever contributed to Git project (code, documentation, i18n, etc.)?
    (single choice)

  * Yes
  * No
  * Maybe, don't remember
  * Plan to, soon

06. Have you ever reviewed contribution to Git project?
    (single choice)

  * Yes
  * No
  * Maybe, don't remember
  * Plan to, soon
  * Only spelling corrections, or correctness of translation

07. What's stopping you from contributing to Git?
    What was hardest / most difficult when contribution to Git?
    (free-text essay question)


#### Getting started with Git

08. Have you found Git easy to learn?
    (single choice)

  * Very easy
  * Easy
  * Reasonably easy (average)
  * Hard
  * Very hard

09. Have you found Git easy to use?
    (single choice)

  * Very easy
  * Easy
  * Reasonably easy (average)
  * Hard
  * Very hard

10. Rate your own proficiency with Git
    (single choice, rating)

  1. novice
  2. casual, needs advice
  3. everyday use
  4. can offer advice
  5. know it very well

Description:
~~~~~~~~~~~~
You can think of it as 1-5 numerical grade of your proficiency in Git.



11. Which Git version(s) are you using?
   (multiple choice, with other)

 + I don't remember and cannot check the version
 + pre 2.0
 + 2.0.x to 2.4.x
 + 2.5.x
 + 2.6.x
 + 2.7.x
 + 2.8.x
 + 2.9.x
 + 2.10.x or newer
 + 2.10.x-rcN version (release candidate)
 + minor (maintenance) release 1.x.y.z
 + 'master' branch of official git repository
 + 'next' branch of official git repository
 + version from msysGit / Git for Windows fork repository
 + alternate Git implementation (JGit and similar)

 + other, please specify


#### Getting and updating Git

12. On which operating system(s) do you use Git?
    (multiple choice, with other)

 + GNU/Linux
 + MS Windows
 + macOS
 + *BSD (FreeBSD, OpenBSD, NetBSD, etc.)
 + Android
 + iOS
 + other Unix

 + other operating system, please specify

13. How do/did you obtain Git (install and/or upgrade)?
    (multiple choices, with other)

  + binary package
  + source package or script (automatic compiling)
  + source tarball/archive (extract, make, make install)
  + pull from repository, and compiled
  + bundled with GUI or other tool
  + preinstalled / sysadmin job / I don't know

  + other, please specify (if none of the above apply)

14. How often do you upgrade Git?
    (multiple choice)

  + use 'master' or 'next' version, and/or pre-release
  + as soon as new version is released
  + when there is new binary package / distribution package
  + when updating distribution / system
  + around every month, or more often
  + around every 6 months or more often
  + update from time to time, cannot say how often
  + I use what is installed on system


#### How do you use Git

15. What kind of projects etc. do you use Git for?
    (multiple choice, with other)

  + work and work-related projects
  + unpaid projects

  + closed-source projects
  + open-source development, public domain, and published & unlicensed
  + private (unpublished), in house projects

  + other (please specify)

16. I use Git for (check all that apply):
    (multiple choice, with other)

  + code (programming) and its documentation
  + data, documents, static assets (without code)

  + sharing data or synchronization
  + managing configuration files
  + backup
  + frontend / fat-client to other SCM (e.g. git-svn, git-p4)

  + other (please specify)

17. What kind of Git tools do you use?
    (multiple choice, with other)

  + editor/IDE VC integration (e.g. EGit (for Eclipse), TextMate bundle, magit (for GNU Emacs))
  + build tool integration (e.g. git plugin for Maven, gitbuilder, Parabuild)
  + continuous integration (CI) (e.g. cidaemon)
  + commit notification tools (e.g. irker, git-notify)
  + filemanager / shell extension (e.g. git-cheetah, TortoiseGit, Git Extension)
  + filesystem interface (e.g. gitfs, figfs)
  + graphical history viewer/browser (e.g. gitk; might be a part of GUI tool)
  + graphical commit tool (e.g. git-gui; might be a part of GUI tool)
  + graphical diff and/or merge tool (e.g. Kompare, Meld; might be a part of GUI tool)
  + graphical blame or pickaxe tool (e.g. 'git gui blame'; might be a part of editor plugin)
  + tool to manage git repositories (e.g. Gitolite)
  + git-instaweb, or self-hosted web interface (e.g. gitweb, cgit)
  + self-hosted project hosting solution / software forge (e.g. GitLab, GitHub Enterprise, Phabricator)
  + self-hosted code review or audit system (e.g. Gerrit, Differential)
  + patch or patch series management interface (e.g. StGit, Guilt, git-series)
  + tracking some files out-of-band, large files handling (e.g. git-LFS, git-annex, git-media)
  + storing metadata (e.g. metastore, gitperms, git-cache-meta)
  + managing composite repositories (e.g. git-stree, gitslave, repo)
  + command line tab-completion, or equivalent (e.g. git-completion.sh)
  + shell prompt, or widget, desklet, etc. (e.g. git-prompt / __git_ps1(), git-radar)
  + git aware pager, or syntax highlighter (e.g. tig, diff-highlight)
  + credentials helper, or askpass wrapper (e.g. wincred, winstore, cache)
  + remote helper to store repository (e.g. FTP, Amazon S3, Dropbox)
  + remote helper to interact with foreign repositories (e.g. git-hg)

  + my own scripts (for daily use)
  + my own scripts (for special tasks)

  + other kind, please specify

18. List git tools that you are using, one per line, or as comma separated list
    (textarea)

19. How often do you use Git command line (and other command line tools)?
    (single-choice, rating-like)

  * never
  * rarely (less often than other tools)
  * average, or about average
  * cannot say how often
  * often (more often than other tools)
  * only (always)


#### Git hosting sites and software forges

18. Which git hosting site(s) do you use for your project(s)?
    Please check only hosting sites where you publish/push to (with git)
    (multiple choice, with other)

  + GitHub
  + Bitbucket
  + GitLab

  + SourceForge
  + Savannah or Gna!
  + CodePlex

  + Assembla
  + Beanstalk
  + CloudForge (formetly Codesion)
  + Codebase
  + Deveo
  + Unfuddle

  + git hosting site for related projects (e.g. OLPC, freedesktop.org)
  + company internal / self-hosted

  + other site, please specify

21. If you, your project or your company self-hosts Git repositories,
    what Git repository management tools do they use?
    (multiple choice, assuming mostly single selected, with other)

  + git-shell
  + Gitolite
  + Gitosis (DEPRECATED)

  + Gerrit

  + Kallithea
  + Rhodecode
  + Phabricator

  + Bitbucket Server (Atlassian)
  + GitHub Enterprise
  + GitLab Community Edition (OSS)
  + GitLab Enterprise Edition
  + Deveo On-Premises

  + GitPrep
  + Girocco (repo.or.cz)

  + don't use self-hosted / on-premises
  + other, please specify

22. Do you use paid git hosting, and if so, why?
    (multiple choice, with other)

  * N/A (don't use paid git hosting)
  * private or team-limited repositories
  * increased limits (repository size, number of repositories)
  * paid support / help
  * extra features compared to free plan / free hosting
  * other, please specify


#### Interacting with other repositories, git workflows

23. How do you fetch/get changes from upstream repositories
    and/or other developers?
    (multiple choice, with other)

  + git protocol        (e.g. git://git.example.com/repo.git)
  + ssh                 (e.g. ssh+git://git.example.com/repo.git,
                              git.example.com:/srv/scm/repo.git)
  + http(s)             (e.g. http://git.example.com/repo.git)
  + rsync (DEPRECATED)  (e.g. rsync://git.example.com/repo.git)
  + filesystem          (e.g. /path/to/repo.git, file:///path/to/repo.git)
  + applying patches    (e.g. git-am from emails, or other source)
  + via git-bundle
  + foreign SCM (fat-client or remote helper, e.g. git-svn, git-p4, gitifyhg)

  + Other, please specify

24. How do you publish/propagate your changes?
    (multiple choice, with other)

  + push via SSH
  + push via HTTP / HTTPS
  + push via git protocol (not available y default, NOT RECOMMENDED)
  + push (unknown transport)
  + pull request (+ any form of announcement / notification)
  + format-patch + email
  + format-patch + other (e.g. reviewboard, issue tracker or forum)
  + git bundle

  + git-svn (to Subversion repository)
  + git-p4 (to Perforce repository)
  + foreign SCM interface, or remote helper (other than mentioned above)

  + other - please specify

25. What git workflow(s) is used by projects in which development you participate?
    (multiple choice, with other)

  + single developer, only private repository (no interaction)

  + centralized workflow (push to common repository)
  + branched centralized (push to different branches in common repository)
  + peer-to-peer workflow (all repositories roughly equal)
  + integration-manager workflow (maintainer pulls/applies patches to "blessed" repository))
  + dictator and lieutenants workflow (hierarchical workflow)
  + using collaborative code review tool, e.g. Gerrit

  + other workflow, please explain
 
References:
~~~~~~~~~~~
 [1] https://git-scm.com/book/en/Distributed-Git-Distributed-Workflows
 [2] https://git-scm.com/about/distributed
 [3] https://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html
 [4] https://gerrit-documentation.storage.googleapis.com/Documentation/2.12.3/intro-quick.html


26. What types of branches can be found in your repositories?
    (repositories you use or are contributing to)
    (multiple choice, with other)

  + there is only a single branch
  + development/graduation branches (master/stable, next/devel/unstable etc.)
  + per-release maintenance branches (or release branches)
  + proposed-updates integration testing and WIP publish branch

  + bugfix / hotfix branches (topic branches for bug fixes)
  + release branches (for preparing a new release)
  + other short-lived topic / feature branches

  + orphan branches (with disconnected history, e.g. gh-pages, todo)

  + other types and uses, please describe


27. How do you integrate changes from others?
    (multiple choice, with other)

  + merge  (includes 'git pull')
  + rebase (includes 'git pull --rebase')
  + reapply (e.g. git-am from patches)
  + git-imerge (third-party tool)

  + git mergetool, or graphical merge tool directly
  + graphical rebase tool
  + custom merge driver (e.g. to merge GNU ChangeLogs)

  + other, please specify


28. How do you sign your Git repositories?
    (multiple choice, with other)

  + digital certificate of origin ("Signed-off-by:")

  + signed tags
  + signed commits
  + signed merges (merging signed tags)
  + signed pushes

  + other way, please specify


#### How you use Git

29. Which of the following Git features do you use?
    (multiple choice, with other)

  + end-of-line conversion (crlf or eol)
  + custom diff/merge driver
  + textconv
  + other gitattributes (e.g. clean/smudge filter)

  + word diff
  + merge strategy options (e.g. -Xrenormalize)

  + submodules (subprojects)
  + subtrees / subtree merge (e.g. git-subtree, git-stree)

  + partial (sparse) checkout
  + shallow clone (e.g. "git clone --depth=<n>")

  + multiple worktrees (e.g. git-worktree)

  + searching history for commit message and metadata (e.g. "git log --grep")
  + searching changes in history, pickaxe search ("git log -S" and "git log -G")
  + finding bugs in history with bisect (also "git bisect run <script>")

  + tracking code movement with git-blame ("git blame -M", "git gui blame", etc.)
  + history of lines ("git log -L")

  + detaching HEAD (e.g. "git checkout --detach", "git checkout <tag>")
  + orphan branches, with disconnected history (gh-pages, todo, man, etc.)
  + merging independent histories, joining different projects together
    (outside subtree merge)

  + alternates mechanism (sharing object database)
  + stash and autostash (also "git stash --keep-index")
  + commit message templates, and/or commit-related hooks
  + interactive commit / per-hunk comitting / partial commit / splitting commits
  + interactive rebase, fixup commits (small scale history editing)
  + git-filter-branch or equivalent, like BFG Repo Cleaner (large history rewriting)
  + committing with dirty tree (keeping some changes uncommitted)
  + reflog (including @{1}, @{yesterday}, @{-1} / -, 'git log -g')

  + client-side hooks (e.g. pre-commit)
  + server-side hooks (e.g. post-receive)

  + git-aware shell prompt
  + git aliases, shell aliases for git, or own git scripts

  + one-way interaction with other SCMs (from SCM to git)
  + two-way interaction with other SCMs (from SCM to git, from git to SCM)

  + object overlays (git replace or grafts)
  + object annotation (git notes)

  + other, please specify


30. Describe what features would you like to have in Git
    (free form, essay length / textarea)

31. What tool do you use to create new commits?
    (matrix)

 Columns: never / rarely / often / always
 ----------------------------------------
  - command line				
  - graphical commit tool (GUI)				
  - IDE/editor integration				
  - filemanager extension				
  - web interface				
  - other kind of tool				

32. What do you use submodules (or their equivalent, like subtree) for?
    (multiple choice, with other)

  + I don't use submodules or subtrees
  + planning to use submodules
  + for dependency management (including dependencies)
  + to import repositories maintained by others (in subdirectory)
  + for your own (or your organization's) code shared between different projects
  + to separate large and/or many files for performance reasons
  + to separate data which you don't want (or aren't allowed) to disclose
  + to separate code whose copyright we do not own, or with different licensing
  + to manage access to different parts of repository

  + other purpose, please specify


#### Other version control systems

33. What other centralized, local or per-file version control systems (SCM)
    do you use beside Git?
   (multiple choice, with other)

  + I don't use any centralized or local version control system

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
  + Vault
  + Team Foundation Server
  + Visual Studio Team System / ALM
  + Rational Team Concert

  + other centralized SCM, please specify


34. What other distributed version control systems
    do you use or used beside Git?
   (multiple choice, with other)

  + I don't use any version control system beside Git

  + Bazaar (bzr)
  + Mercurial (hg)
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

  + other, please specify


35. How does Git compare to other SCM tools that you have used?
    (single choice, rating)

Git is ____ that other version control systems I have used.

 * better
 * equal (comparable)
 * it depends (in some matters better, in some matters worse)
 * worse
 * cannot compare (have not used anything beside Git)


#### What you think of Git?

36. Overall, how happy are you with Git?
    (single choice, rating)

  # hate it
  * unhappy
  * not so happy
  # neutral
  * happy
  * very happy
  * completely ecstatic

37. In your opinion, which areas in Git needs improvement?
    Please state your preference.
    (matrix)

   Columns: don't care / don't need / a little / some / much
   ---------------------------------------------------------
 + user-interface (UI and UX)
 + core documentation
 # messages, error messages, advices
 + performance
 * portability
 + more features
 + tools (e.g. GUI)
 + localization (translation) of messages
 # translated documentation (manpages)
 * community (mailing list)
 * community (IRC)	

38. What do you like most about Git? (optional)
   (free-text, essay length, textarea)
 
39. What do you hate about Git? (optional)
   (free-text, essay length, textarea)


#### Other tools

40. How do you read and answer email (check all that apply)?
    (multiple choice)

  + GUI client (e.g. Outlook, Thunderbird, Evolution, KMail)
  + console client (e.g. pine, alpine, mutt)
  + webmail or web client (e.g. GMail, Hotmail; HyperKitty)
  + phone app (e.g. K-9 Mail, Airmail, CloudMagic)
  + I don't use email at all

41. Which of the decentralized/federated systems do you use
    or are interested in?
   (multiple choice, with other)

  + IPFS
  + PGP / GPG
  + Tor
  + diaspora*
  + Bitcoin, Litecoin, Etherium, etc.
  + tent.io
  + XMPP / Jabber
  + OMEMO
  + Matrix.org
  + pump.io
  + other, please specify

42. Which of IDEs and programmer's editors do you use [with Git]?
    (multiple choice, with other)

  + Visual Studio
  + Eclipse
  + NetBeans
  + Xcode
  + IntelliJ IDEA / PhpStorm / WebStorm
  + KDevelop or Qt Designer
  + Anjuta
  + Android Studio

  + Sublime Text
  + TextMate
  + Emacs
  + Vim
  + Atom
  + Brackets
  + Geany
  + Notepad++

  + other IDE or editor, please specify


43. Which of the programming languages are you proficient with?
    (multiple choices, with other)

  + C
  + C++
  + C#
  + Java
  + VisualBasic.NET 
  + Objective-C

  + Python
  + Perl
  + PHP
  + JavaScript
  + Ruby
  + shell script

  + CSS, LESS, SASS etc.
  + HTML, HTML5
  + TeX, LaTeX, ConTeXt
  + SQL

  + Go
  + Rust
  + Swift
  + Scala
  + Haskell
  + OCaml

  + other, please specify


#### Documentation. Getting help.

44. How useful have you found the following forms of Git documentation?
    (matrix)

  Columns: never used / not useful / somewhat / useful
 ------------------------------------------------------
 + help distributed with git (manpages, tutorials, guides, etc.)
 + "Pro Git" book
 + Git Wiki
 + Git Reference site
 + hosting site tutorials and help, etc.
 + 'git' section of StackOverflow Documentation
 + other on-line help
 + printed books (or ebooks)

Description:
~~~~~~~~~~~~
* help distributed with Git includes their online version:
  - https://git.github.io/htmldocs/git.html
  - https://git-scm.com/docs/
  - https://www.kernel.org/pub/software/scm/git/docs/
* Git Wiki was to be found at http://git.wiki.kernel.org
* Git Reference site can be found at http://gitref.org
* StackOverflow Documentation refers to http://stackoverflow.com/documentation/git
* "Pro Git" can be found at https://git-scm.com/book and https://progit.org
* hosting sites tutorials include
  - https://help.github.com/
  - https://www.atlassian.com/git/
  - https://www.git-tower.com/learn/git/ebook
* help distributed with git include manpages, manual, tutorials, HOWTO,
  release notes, technical documentation, contrib/examples/


45. How useful have you found the following kinds of Git documentation?
    (matrix)

  Columns: never used / not useful / somewhat / useful
  ----------------------------------------------------
 + in-command (command messages)
 + command manpages
 + concept manpages (e.g. gitcli, gitworkflows)
 + tutorials
 + technical documentation
 + contrib/examples
 + "The Git User's Manual"				

 + "Pro Git"				
 + other printed books (or ebooks)


46. What [channel(s)] do you use to request/get help about Git [(if any)]?
   (multiple choice, with other)

  + git mailing list (git@vger.kernel.org)
  + "Git for Human Beings" Google Group
  + Git for Windows mailing list / Google Group
  + IRC (#git)
  + IRC (other git/SCM related, e.g. #github)
  + IRC (other than above)
  + request in blog post or on wiki
  + asking git expert/git guru/colleague/friend
  + project mailing list, or IRC, or forum
  + Twitter or other microblogging platform
  + instant messaging (IM) like XMPP/Jabber
  + StackOverflow or other StackExchange site
  + search specific site or whole web (e.g. with Google)

  + find and read book or ebook
  + watch an instructional video or course
  + attend a seminar, webinar or lecture about Git (interactively)

  + N/A (didn't request help about Git)

  + other (please specify)


47. Which books about Git have you read and recommend, or plan to read?
    (multiple choice, with other)

 + "Pragmatic Version Control Using Git", by Travis Swicegood (2008)
 + "Pragmatic Guide to Git", by Travis Swicegood (2010)
 + "Version Control by Example", by Eric Sink (2011)
 + "Version Control with Git", by by Jon Loeliger and Matthew McCullough
   (1st ed. 2009, 2nd ed. 2012)
 + "Git: Version Control for Everyone", by Ravishankar Somasundaram
   (2013)
 + "Pro Git", by Scott Chacon and Ben Straub (1st ed. 2009, 2nd ed. 2014)
 + "Git Version Control Cookbook", by Aske Olsson and Rasmus Voss (2014)
 + "Git in Practice", by Mike McQuaid (2014)
 + "Git for Teams", by Emma Hogbin Westby (2015)
 + "Git Essentials", by Ferdinando Santacroce (2015)
 + "Mastering Git", by Jakub Narębski (2016)



#### About this survey. Git news. Open forum.

48. How did you hear about this Git User's Survey? ===
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
 * news or social news site (e.g. LWN.net, Digg, Reddit)
 * blog (or blog planet)
 * other kind of web site
 * Twitter or other microblogging platform

 * other - please specify

49. How do you hear about git related news 
    (such as new releases and community events)?
    (multiple choice, with other)

  + I wasn't aware there was any news
  + I don't read any news, but I'm aware of it
  + through news aggregation sites (such as reddit or hacker news)
  + from a newsletter (such as Git Rev News)
  + through a watched blog (such as GitHub Blog)
  + announcement section in news site (such as LWN.net)
  + RelNotes file(s) in git sources
  * from a mailing list (such as the git developer or the git for windows list)
  * other, please specify

50. What other comments or suggestions do you have,
    that are not covered by the questions above?
    (free-form / essay length / textarea)

-- 
Jakub Narębski




