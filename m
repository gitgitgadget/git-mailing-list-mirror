Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56761FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 18:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbcHTS4j (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 14:56:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33963 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbcHTS4h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 14:56:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so7589533wma.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=7mBoqCAf9TgmZp+F6QuN1eSw0fmBzoJ6HPzzY3EpDSE=;
        b=Yqf/4ZQXYfO1cz7kPNln7PCRcbO8m+YGPMY1rcimqp07PT9WduV7m1hWEx87BKf/w3
         Ndg1EWw5I6TXAhjmEhMrFXFkozORVPa56zMBtM0RWPDKIoTs95dQt+SJvRK4ut8JPS8t
         92g+7rOqB81s4Amf4T9vEtZRbZyEellp7Nad0aCpMUNJSsSdgl2JDps0V4eK0jfajuec
         0gfQxhgTiKBdZNfYYy+i6Lm8iGDVIwH5921sF+JIid/IuGDHgA2TjGd8Mz7pTIEM0k+2
         VtT1PrW/VnBYUQmbhpgmkQ4lblhAwz4aLW3V8fm4rY7KyIk9T1khp8LX1khyHxQtQXkE
         uiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=7mBoqCAf9TgmZp+F6QuN1eSw0fmBzoJ6HPzzY3EpDSE=;
        b=TeQ50Rkw+OQJxNsLhMu4iOuR/0nAXG/fNbgD2ofqJctztGxtM9rYuX0nyHEXneC9a7
         uaO8PGf8C8JR3eA4t15FeIKAE+H9gwexwWPSv3Zo1MQ5l3bTiXRXXyjZssyuHT9U9dqT
         1Qf5DBNZYRv8Ke0hSpuVPRT+lGw+d98If8GhuF1c4qvdf+A6pbSZoMoWQF8N424QSari
         vJkRLfVJi92wrN7YJhKgtAcAiEnvuN6YeNUNE1qDvd4JwMz+nf/mzFzuPFMFFjdvW3CV
         59OtJWr+doL8ml3clWg6vLpgNODyqRKGGcuhkcqcF7mc8BW73LQDCaVesaA3owqlJddV
         t8Fg==
X-Gm-Message-State: AEkoousktwrkb8KEhmmUUSZy/uRJyFRn6Jd2+1UxZutBqZW5HCyIBjdaZUt/JKJrdtBV4w==
X-Received: by 10.194.186.166 with SMTP id fl6mr11125493wjc.44.1471719394853;
        Sat, 20 Aug 2016 11:56:34 -0700 (PDT)
Received: from [192.168.1.26] (epm44.neoplus.adsl.tpnet.pl. [83.20.54.44])
        by smtp.googlemail.com with ESMTPSA id bj8sm13419442wjc.49.2016.08.20.11.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Aug 2016 11:56:33 -0700 (PDT)
X-Mozilla-News-Host: news://news.gmane.org:119
To:     git@vger.kernel.org
Cc:     Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: [RFC] Proposed questions for "Git User's Survey 2016"
Message-ID: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
Date:   Sat, 20 Aug 2016 20:56:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

As I wrote previously here, I am thinking about returning to doing the
Git User's Survey this year.

  Message-ID: <577E6F32.7020007@gmail.com>

  https://marc.info/?l=git&m=146790381602547&w=2
  https://public-inbox.org/git/577E6F32.7020007%40gmail.com/

The previous email, which did not receive many responses, was a query about
the direction we want to have for Git User's Survey 2016.  Now I would like
to ask about something more specific: what questions (and answers) you would
like to see in the survey.

Below is my initial proposal; my comments are prefixed with "JN> ".
----------------------------------------------------------------------------

#### About you

JN> This section gives us a bit of demographical information about survey
JN> responders.  Is it useful?


01. What country do you live in? (Country of residence)
    (free-form single line)

JN> Survs.com do not offer list of countries as a pre-defined drop-down
JN> list (select, with search), and it looks like it is not as easy as
JN> I thought (though I could push responsibility to Locale::Country ;-):
JN>
JN>   https://en.wikipedia.org/wiki/List_of_sovereign_states
JN>
JN> This question originally read "What country are you from?"
JN> which might be thought as country of birth... which may not
JN> exist any longer.


02. How old are you (in years)?
    (single number)

JN> Perhaps a selection of age ranges would be better (if less precise).
JN> We could follow the example of StackOverflow Survey here:

   ( ) <20
   ( )  20-24
   ( )  25-29
   ( )  30-34
   ( )  35-39
   ( )  40-49
   ( )  50-59
   ( ) >60


03. Your gender
    (single choice)

   ( )  Man
   ( )  Woman
   ( )  Other
   ( )  Prefer to not disclose

JN> This would be new question, to check if we good good diversity
JN> among survey responders (and not skewed in particular direction).
JN> Though I am not sure if it is a good idea...


04. How would you describe your occupation / role as Git user?
    (multiple choice with other, limit to 3 selections (?))

   [ ] Developer
   [ ] Programmer
   [ ] Engineer
   [ ] Analyst
   [ ] Manager / Leader
   [ ] Maintainer / Reviewer / Sub-maintainer
   [ ] DevOps
   [ ] Administrator
   [ ] Designer
   [ ] Artist / Writer
   [ ] Tester / QA
   [ ] Expert
   [ ] Student
   [ ] Researcher
   [ ] Teacher
   [ ] Other, please specify

JN> This is a new question, based somewhat on "Developer Occupations"
JN> and "Programmers, Engineers, and Developers" questions in 
JN> StackOverflow Survey.  It is here to find out if different
JN> occupation leads to different ways of using Git, and if there
JN> is some occupation that is not well served by Git.
JN>
JN> The list of "occupations" is preliminary, and I would like to
JN> ask for your thought about possible answers.
  

05. Have you ever contributed to Git project (code, documentation, etc.)?

   ( )  Yes
   ( )  No
   ( )  Maybe

JN> This is here to correlate other responses with Git developers.
JN> In 20012 it was called "Does Git include code or documentation by you?
JN> (Are you a Git developer?)".  I think this way of stating it is better;
JN> if it is here to stay - the number of active and past developers is
JN> not very large.  On the other hand it can be used to detect if we
JN> have a bias due to the way survey is announced.


JN> NOTE: earlier surveys have had two additional questions that were
JN> since removed (to make survey shorter, among others).  Those were:
JN>
JN>  - What is your preferred [non-programming] language?
JN>  - Which programming languages / technologies you are proficient with?
JN>
JN> Well, the latter was only about programming languages, originally.


#### Getting started with Git

JN> This is probably not the best name for this section of questions.

06. Have you found Git easy to learn?
    (single choice)

  * Very easy
  * Easy
  * Reasonably easy
  * Hard
  * Very hard

07. Have you found Git easy to use?
    (single choice)

  * Very easy
  * Easy
  * Reasonably easy
  * Hard
  * Very hard

JN> Those two questions, considered alone, doesn't tell us much.  If one
JN> uses git, then usually one does not think it is too hard to use
JN> (unless forced to use git by external circumstances, like project
JN> he/she works on using git).  On the other hand those two questions
JN> together give us some mesaure of Git's learning curve, telling us
JN> if people consider git easy to use but hard to learn, or vice versa ;-)
JN>
JN> This question was present from the beginning of Git User's Survey,
JN> so it can be used to compare with historical surveys, and see
JN> Git evolution in motion (hopefully in good direction, that is getting
JN> easier to learn and use).


08. Which Git version(s) are you using?
   (multiple choice, with other)

 + pre 2.0
 + 2.0.x to 2.5.x
 + 2.6.x
 + 2.7.x
 + 2.8.x
 + 2.9.x or newer

 + 2.10.x-rcN version (release candidate)
 + minor (maintenance) release 1.x.y.z
 + 'master' branch of official git repository
 + 'next' branch of official git repository
 + version from msysGit / Git for Windows fork repository
 + alternate Git implementation (JGit and similar)

 + other, please specify

JN> I don't know if it is a good range.  One thing that might be good
JN> to know is people using outdated Git, perhaps because it is version
JN> bundled with GUI tool (e.g. using last msysGit instead of Git for
JN> Windows, that is 1.9.x at latest).
JN>
JN> If we want connection with last survey, from 2012, we would
JN> need to go back down to 1.7.x or earlier version...


09. On which operating system(s) do you use Git?
    (multiple choice, with other)

 + GNU/Linux
 + MS Windows
 + macOS
 + *BSD (FreeBSD, OpenBSD, NetBSD, etc.)
 + Android
 + iOS
 + other Unix
 + other, please specify

JN> This question was a part of previous surveys, but it was asked
JN> a bit later.  This year I skipped asking about Cygwin vs native
JN> Git for Windows.  Note that I am not sure if Android and iOS,
JN> added just now, should be present here.


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

JN> This question tell us penetration of announcements of the survey;
JN> did we get to all users, or only to git gurus?  It is also useful
JN> for correlating with other responses, for example to get to know
JN> which Git features are used by novices, and which by gurus.
JN>
JN> Note that the answers are rather here to stay because of
JN> "backwards compatibility", that is to be able to easy compare
JN> with earlier surveys.


JN> I have moved questions around, so we now have 5 questions per
JN> section.  I wonder if it is something worth having (from the
JN> point of view of answering survey).


#### How do you use Git

11. I use Git for (check all that apply):
    (multiple choice, with other)


Note that those choices are neither orthogonal nor exclusive.  One
might want to check multiple answers even for a single repository.

JN> Answers to this question probe different direction.
JN> We might want to split this question... but on the other hand
JN> I think we'd rather reduce the number of questions in the survey.

 + work and work-related projects
 + unpaid projects
 
 + closed-source projects
 + OSS development, public domain, and published & unlicensed
 + private (unpublished), in house projects

JN> It was "proprietary projects" instead of "closed-source projects"
JN> in previous version(s) of Git User's Survey

 + code (programming) and its documentation
 + data, documents, static assets (without code)

 + sharing data or synchronization
 + managing configuration files
 + backup
 + frontend / fat-client to other SCM (e.g. git-svn, git-p4)

JN> I'm not sure if the last answer should not be moved to
JN> question about other version control systems

 + other, please specify


11. How do/did you obtain Git (install and/or upgrade)?
    (multiple choice, with other)

JN> Perhaps this question should be moved to previous section.
JN> If yes, should we keep it to 5 questions per section, that
JN> is move or remove other question then?

Note that this question is multiple choices question because one can
install Git in different ways on different machines or on different
operating systems.

 + binary package
 + source package or script (automatic compiling)
 + source tarball/archive (extract, make, make install)
 + pull from repository, and compiled
 + bundled with GUI or other kind of tool
 + preinstalled / sysadmin job

 + other - please specify (if none of the above apply)

JN> The "bundled" answer is new.  I guess that most people would
JN> not check if GUI brought it own Git (sometimes very outdated;
JN> SourceTree for Windows bundled git 1.9.7 (sic!)) and is using
JN> it instead of system- or user-installed Git.
JN>
JN> Note for example that Eclipse brings JGit, implementation
JN> of Git in Java, and would be covered by "bundled" answer...


JN> NOTE: I think we can skip
JN>
JN>   What Git interfaces, implementations and frontends do you use?
JN>
JN> question.  What do you think?


12. What kind of Git tools do you use?
    (multiple choice, with other)

 + editor/IDE VC integration (e.g. EGit (for Eclipse), TextMate bundle, magit (for GNU Emacs))
 + filemanager / shell extension (e.g. git-cheetah, TortoiseGit, Git Extension)
 + filesystem interface (e.g. gitfs, figfs)
 + graphical history viewer/browser (e.g. gitk; might be a part of GUI tool)
 + graphical commit tool (e.g. git-gui; might be a part of GUI tool)
 + graphical diff and/or merge tool (e.g. Kompare, Meld; might be a part of GUI tool)
 + graphical blame or pickaxe tool (e.g. 'git gui blame'; might be a part of editor plugin)
 + tool to manage git repositories (e.g. Gitolite)
 + git-instaweb, or self-hosted web interface (e.g. gitweb, cgit)
 + self-hosted project hosting solution (e.g. GitLab, GitHub FI, GitPrep, Phabricator)
 + self-hosted code review or audit system (e.g. Gerrit, Differential)
 + patch or patch series management interface (e.g. StGit, Guilt, git-series)
 + command line tab-completion, or equivalent (e.g. git-completion.sh)
 + shell prompt, or widget, desklet, etc. (e.g. git-prompt / __git_ps1(), git-radar)
 + git aware pager, or syntax highlighter (e.g. tig, diff-highlight)

 + credentials helper, or askpass wrapper
 + remote helper to store repository (e.g. FTP, Amazon S3, Dropbox)
 + remote helper to interact with foreign repositories (e.g. git-hg)

 + my own scripts (for daily use)
 + my own scripts (for special tasks)

 + other, please specify

JN> Does this list cover all kind of tools that one might be using,
JN> or is some category missing from the above list (slightly modified
JN> and extended compared to previous surveys)?


13. List Git tools that you are using (comma separated, or one per line)
13. List git tools that you use (optional)
    (textarea)

JN> Open ended questions are often a pain to analyze, but I don't think
JN> this one would be a problem.  Instead of free-form text field we
JN> could provide a list of most common GUIs and other tools... but I am
JN> not sure what they are, and we are risking skewing results.  On the
JN> other hand free-form might mean people forgetting about tool they use,
JN> or used in the past; it is also a bit more work, to write and not
JN> only to select.


14. How often do you use Git command line (and other command line tools)?
    (single-choice, rating-like)

  1. never
  2. rarely
  3. often
  4. only (always)

JN> This is a new question, replacing somewhat "What Git interfaces,
JN> implementations and frontends do you use?".  I'm not quite sure if
JN> it is a question worth to have.


15. Which git hosting site(s) do you use for your project(s)?
    Please check only hosting sites where you publish/push to (with git)
    (multiple choice, with other)

JN> I think it should be limited to *main* hosting sites; there is
JN> always the "other, please specify" option

  + GitHub
  + Bitbucket
  + GitLab

  + SourceForge
  + Savannah or Gna!
  + CodePlex

  + git hosting site for related projects (e.g. OLPC, freedesktop.org)
  + company internal / self-hosted

  + other, please specify

JN> Gitorious was acquired/changed into GitLab, Google Code is in archive
JN> mode, BerliOS is no longer.  CodePlex is new; many hosting sites that
JN> were present are missing, but could be added: Assembla, Beanstalk,
JN> CloudForge (formerly Codesion), Codebase, Deveo, Unfuddle, perhaps
JN> even Alioth (Debian), Fedora Hosted, Launchpad (Ubuntu)
JN>
JN> "Company internal" and "self-hosted" got concatenated into one answer.

JN> This question could be moved to the next section.


#### Git workflows, or
#### Interacting with other repositories

16. How do you fetch/get changes from upstream repositories
    and/or other developers?
    (multiple choice, with other)

 + git protocol        (e.g. git://git.example.com/repo.git)
 + ssh                 (e.g. ssh+git://git.example.com/repo.git,
                             git.example.com:/srv/scm/repo.git)
 + http                (e.g. http://git.example.com/repo.git)
 + rsync (DEPRECATED)  (e.g. rsync://git.example.com/repo.git)
 + filesystem          (e.g. /path/to/repo.git, file:///path/to/repo.git)
 + applying patches    (e.g. git-am from emails)
 + via git-bundle
 + foreign SCM (fat-client or remote helper, e.g. git-svn, git-p4, gitifyhg)

 + Other, please specify

JN> Nobody should be using rsync, as it got broken and nobody noticed,
JN> and then removed from Git.  Note that "applying patches" is new,
JN> because question got extended to cover getting changes from other
JN> developers (in maintainer role), not only from upstream repo.
JN> This question is about getting changes into local work repository.


17. How do you publish/propagate your changes?
    (multiple choice, with other)

 + push via SSH
 + push via HTTP / HTTPS
 + push via git protocol (NOT RECOMMENDED)
 + push (unknown)
 + pull request (+ any form of announcement / notification)
 + format-patch + email
 + format-patch + other (e.g. reviewboard, issue tracker or forum)
 + git bundle

 + git-svn (to Subversion repository)
 + git-p4 (to Perforce repository)
 + foreign SCM interface (other than mentioned above)

 + other - please specify


XX. How do you integrate changes from others?
    (multiple choice, with other)

 + merge  (includes 'git pull')
 + rebase (includes 'git pull --rebase')
 + reapply (e.g. git-am from patches)
 + git-imerge (third-party tool)

 + git mergetool or other graphical merge tool
 + graphical rebase tool

JN> This is proposed new question about workflows.


XX. What types of branches can be found in your repositories?
    (repositories you use or are contributing to)
    (multiple choice, with other)

 + there is only a single branch
 + development/graduation branches (master/stable, next/devel/unstable etc.)
 + per-release maintenance branches
 + proposed-updates integration testing and WIP publish branch

 + bugfix / hotfix branches (topic branches for bug fixes)
 + release branches (for preparing a new release)
 + other short-lived topic / feature branches

 ? orphan branches (with disconnected history, e.g. gh-pages, todo)

 + other types and uses, please describe


JN> This is new question.  It doesn't ask about use of git-flow, but
JN> is close.


#### How you use Git

18. Which of the following Git features do you use?
    (multiple choice, with other)

 + end-of-line conversion (crlf or eol)
 + custom diff/merge driver
 + textconv
 + other gitattributes (e.g. clean/smudge filter)

 + word diff
 + merge strategy options (e.g. -Xrenormalize)

 + submodules (subprojects)
 + subtree merge (e.g. git-subtree, git-stree)

 + partial (sparse) checkout
 + shallow clone (e.g. "git clone --depth=<n>")

 + multiple worktrees (e.g. git-worktree)

 + alternates mechanism (sharing object database)
 + stash and autostash (also "git stash --keep-index")
 + detaching HEAD (e.g. "git checkout --detach", "git checkout <tag>")
 + orphan branches, with disconnected history (gh-pages, todo, man, etc.)
 + commit message templates, and/or commit-related hooks
 + interactive commit / per-hunk comitting / partial commit / splitting commits
 + interactive rebase, fixup commits (small scale history editing)
 + git-filter-branch or equivalent, like BFG Repo Cleaner (large history rewriting)
 + finding errors in history with bisect (also "git bisect run <script>")
 + tracking code movement with git-blame ("git blame -M" etc.)
 + committing with dirty tree (keeping some changes uncommitted)
 + reflog (including @{1}, @{yesterday}, @{-1} / -, 'git log -g')

 + git-aware shell prompt
 + git aliases, shell aliases for git, or own git scripts

 + one-way interaction with other SCMs (from SCM to git)
 + two-way interaction with other SCMs (from SCM to git, from git to SCM)

 + object overlays (git replace or grafts)
 + object annotation (git notes)

 + Other, please specify

JN> The problem is come up not with exhaustive list of features: there are
JN> too many of them to list.  The problem is coming up with list of
JN> important and used enough often features (and those interesting to
JN> know about).
JN>
JN> So: what features should be included in this list?  What features
JN> should be removed from above list of answers?
JN>
JN> Should this question be split into parts?  Should we ask how often
JN> those features are used (matrix-form question)?


19. Describe what features would you like to have in Git
    (free form, essay length / textarea)

JN> The Git User's Survey 2012 (last survey) have had also
JN> "17. Which of the following features would you like to see
JN> implemented in git?", with a list of answers.  But as Git development
JN> is not directed by surveys, I'm not sure if it is worth it.
JN>
JN> Such free-form question would be a pain to analyze well, but it
JN> could also be a source of a good inspiration.


#### Other version control systems

20. What other version control systems (SCM) do you use beside Git?
   (multiple choice, with other)

Explanation: "using" version control system here means using
it to actively contribute (propose changes or accept proposals),
and not only e.g. using it to download software.

JN> Perhaps we should split it into two questions, one about
JN> centralized version control systems, one about distributed
JN> ones.
JN>
JN> Clarification (narrowing of scope) is new.

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

JN> Is there any *prominent* and important version control system
JN> missing from this list?  Are there systems that are so rare that
JN> they should be removed from the list?


21. How does Git compare to other SCM tools you have used?
    (single choice, rating)

Git is ____ that other version control systems I have used.

 * better
 * equal (comparable)
 * it depends (in some matters better, in some matters worse)
 * worse
 * cannot compare (have not used anything beside Git)


#### What you think of Git?

22. Overall, how happy are you with Git?
    (single choice, rating)

 * unhappy
 * not so happy
 # neutral
 * happy
 * very happy
 * completely ecstatic

JN> I'm not sure if this question is at all useful.
JN>
JN> There is also problem, that the current wording is considered biased
JN> by some, but on the other hand changing wording of answers would make
JN> it impossible to compare it to answers from previous surveys...
JN> Though I have added 'neutral' as an answer.  Perhaps I should add
JN> most negative answer to make rating balanced?
JN>
JN>  # hate Git with a passion of thousands suns


23. In your opinion, which areas in Git needs improvement?
    Please state your preference.
    (matrix)

   Columns: don't need / a little / some / much
 + user-interface (UI and UX)
 + core documentation
 # messages, error messages, advices
 + performance
 + more features
 + tools (e.g. GUI)
 + localization (translation) of messages
 # translated documentation (manpages)

JN> Are there any general areas that are missing from this list?
JN> What are they?
JN>
JN> Note that "translated documentation" and "messages..." are new.


24. How do you compare the current Git version with the version from one year ago?
    (single choice)

 * better
 * no changes
 * worse

 * cannot say
 * Git used for less than 1 year

JN> This question is mainly excuse for providing list of main changes
JN> from the year ago, to show off how Git continues improving.
JN> List of new features and other changes taken from RelNotes.

Description:
~~~~~~~~~~~~
The version from approximately one year ago is x.y.z from DD-MM-YYYY
(x.y.v is from DD-MM-YYYY).

Changes since x.y.z include:

[TO BE DONE]


#### Documentation. Getting help. ==

25. How useful have you found the following forms of Git documentation?
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
  ? https://www.git-tower.com/learn/git/ebook
* help distributed with git include manpages, manual, tutorials, HOWTO,
  release notes, technical documentation, contrib/examples/

JN> Should we split those answers further, e.g. separating on-line
JN> tutorials and guides, from on-line tips etc.?
JN>
JN> This is also educational, showing where one can find documentation;
JN> note that StackOverflow Documentation in yet in Beta.


25. What [channel(s)] do you use to request/get help about Git [(if any)]?
   (multiple choice, with other)

 + git mailing list (git@vger.kernel.org)
 + "Git for Human Beings" Google Group
 + msysGit mailing list / Google Group
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

JN> Are there any main channels of requesting help that I have missed in
JN> the above list of answers?  What are they, and why do you think they
JN> are important enought to warrant inclusion in above list?
JN>
JN> Should we ask the opposite: how one provides help (if one does)?


26. Which books about Git have you read and recommend, or plan to read?
    (multiple choice, with other)

JN> New question.  List of answers based partially on the "Books" section
JN> in https://git-scm.com/documentation/external-links , ordered by date
JN> of latest edition to within a year.
JN>
JN> Should "plan to read" be included in question, or not?

 + "Pragmatic Version Control Using Git", by Travis Swicegood (2008)
 + "Pragmatic Guide to Git", by Travis Swicegood (2010)
 ? "Version Control by Example", by Eric Sink (2011)
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

JN> What *good* books should be added here?  I'd rather add only those books
JN> which have a paper version, and not be ebook-only (or be on a website
JN> only).


#### About this survey. Open forum.

27. How did you hear about this Git User's Survey? ===
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

JN> This list would of course be updated to reflect the list of (planned)
JN> announcement channels.  I also plan to use separate "channels"
JN> (separate shorter URLs) for different announcements.
JN>
JN> I'm not sure how useful would it be.


28. Other comments and suggestions
    What other comments or suggestions do you have,
    that are not covered by the questions above?
    (essay length / textarea)

JN> This would be hard to analyze...

-- 
Jakub Narębski
