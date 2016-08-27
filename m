Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D711F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 22:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbcH0WBL (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 18:01:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32845 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbcH0WBH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 18:01:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so4405312wme.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=SO7wkM8XFB/93FsGzKBUkcJT7zEnxE+jkVu6gCduCmE=;
        b=wQMKFsAXiSv5t6HvQLVj22FlKKb5I1dD/4qwsIcllU8jmBOqslx4GEgzeZEZA/of3W
         gUlochihDKt2wwGLeJ0v+0dDvXVf0mLlr5HW/UbByysKVGzHQ8QvQboUFr3qyh4s1LOL
         EwdPxaE1HRYGFouLgR3/8ide10T8d8wg8oW1418sUWxzP5lBJTDElctHLNZETOpcvujj
         uDWe6F2ly6435odf+DpFmTkboohw266wFAIv0BqSHnpEj/Iulnt2yyCQL2QjXoqTeaPZ
         t4o3f7Gp3Qv5eLkK/5M2H6Q9cx/Ed2nTczfA4iFow1TujmInVsvyxFINuq3BS7AvfNFk
         +SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=SO7wkM8XFB/93FsGzKBUkcJT7zEnxE+jkVu6gCduCmE=;
        b=cImYUcU79iizOooOuMJ2ltBYz3icaupVDVJrJSLNXjNKso/FwQXNCIoXI+v85aoesJ
         EOrEFrv1a83CLiXesQM9YfgtV3+D+H9cDkqT2L1uw0gaxNefiaPAbsoPZBI7uVfTgoEe
         Y2sn6+Up/+U54ViCHP9KB/PpdHkhuxEyfPKwUKf7zqziw8GZpO0xE0aQUUsAt6smg8Q2
         VVmsuhsP34fAnbN+fnsLcdt+JlBbV4JYfgCmNjaT8Z/+GMSjgaX2JRJqk+77hQj1fhHX
         CSKo9s6Kx5JafJhhJsOjO+Ss/tKKNb9of1VhafVck2R36/XfA5OQpQy535g4DrlmrjW+
         L7UQ==
X-Gm-Message-State: AE9vXwNsSpyT06V2d/q6obAozsaWBMHb50SMao3nEyx1U5yh36i13auJ+THVE5qXdi3e2Q==
X-Received: by 10.194.238.170 with SMTP id vl10mr10738336wjc.18.1472335265115;
        Sat, 27 Aug 2016 15:01:05 -0700 (PDT)
Received: from [192.168.1.26] (enk96.neoplus.adsl.tpnet.pl. [83.20.0.96])
        by smtp.googlemail.com with ESMTPSA id vh6sm26440977wjb.0.2016.08.27.15.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2016 15:01:04 -0700 (PDT)
Subject: [RFCv2] Proposed questions for "Git User's Survey 2016", take two
To:     git@vger.kernel.org
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
Cc:     Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>, Eric Wong <e@80x24.org>,
        Andrew Ardill <andrew.ardill@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ae804c55-d145-fc90-e1a9-6ebd6c60453a@gmail.com>
Date:   Sun, 28 Aug 2016 00:00:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
Content-Type: text/plain; charset=utf-8
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

In this email I'd like to propose the revised list of questions (and
answers) for Git User's Survey 2016, following comments to the previous
revision

  Message-ID: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>

  https://public-inbox.org/git/91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com/

Below is my second proposal; old comments are prefixed with "jn> ", new ones
are prefixed with "JN> ".
----------------------------------------------------------------------------

#### About you

jn> This section gives us a bit of demographic information about survey
jn> responders.  Is it useful?  Should we keep it?


01. What country do you live in? (Country of residence, in English)
    (free-form single line)

jn> Survs.com do not offer list of countries as a pre-defined drop-down
jn> list (select, with search), and it looks like it is not as easy as
jn> I thought (though I could push responsibility to Locale::Country ;-):
jn>
jn>   https://en.wikipedia.org/wiki/List_of_sovereign_states
jn>
jn> This question originally read "What country are you from?"
jn> which might be thought as country of birth... which country
jn> may not exist any longer, like East Germany.


02. How old are you (in years)?
    (single number, or single choice)

jn> Perhaps a selection of age ranges would be better (if less precise).
jn> We could follow the example of StackOverflow Survey here, see below.
JN> Though oldest / youngest info could be interesting...

  * <20
  *  20-24
  *  25-29
  *  30-34
  *  35-39
  *  40-49
  *  50-59
  * >60


03. Your gender
    (single choice)

  *  Man
  *  Woman
  *  Other
  *  Prefer to not disclose

jn> This would be new question, to check if we good good diversity
jn> among survey responders (and not skewed in particular direction).
jn> Though I am not sure if it is a good idea...


04. How would you describe your occupation / role as Git user?
    (multiple choice with other, limit to 3 selections (?))

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

jn> This is a new question, based somewhat on "Developer Occupations"
jn> and "Programmers, Engineers, and Developers" questions in 
jn> StackOverflow Survey.  It is here to find out if different
jn> occupation leads to different ways of using Git, and if there
jn> is some occupation that is not well served by Git.
jn>
jn> The list of "occupations" is preliminary, and I would like to
jn> ask for your thought about possible answers.
  

05. Have you ever contributed to Git project (code, documentation, i18n, etc.)?
    (single choice)

  * Yes
  * No
  * Maybe
  # Tried to             <--- new answer

jn> This is here to correlate other responses with Git developers.
jn> In 2012 it was called "Does Git include code or documentation by you?
jn> (Are you a Git developer?)".  I think this way of stating it is better;
jn> if it is here to stay - the number of active and past developers is
jn> not very large.  On the other hand it can be used to detect if we
jn> have a bias due to the way survey is announced.

JN> This would also serve as a reminder that Git is an open-source
JN> project (and free software), and anyone can contribute to it.
JN> Should there be a similar question about doing review?


06. What's stopping you from contributing to Git?
    What was hardest / most difficult when contribution to Git?
    (free-text essay question)

JN> This was the question proposed by Duy Nguyen in "Working with
JN> public-inbox.org" thread (well, the first part of it):
JN>   https://public-inbox.org/git/CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com/


jn> NOTE: earlier surveys have had two additional questions that were
jn> since removed (to make survey shorter, among others).  Those were:
jn>
jn>  - What is your preferred [non-programming] language?
jn>  - Which programming languages / technologies you are proficient with?
jn>
jn> Well, the latter was only about programming languages, originally.
JN> And it would be possibly added, of in later section ("Other tools").


#### Getting started with Git

jn> This is probably not the best name for this section of questions.
JN> Can anyone think of a better one?


07. Have you found Git easy to learn?
    (single choice)

  * Very easy
  * Easy
  * Reasonably easy
  * Hard
  * Very hard

08. Have you found Git easy to use?
    (single choice)

  * Very easy
  * Easy
  * Reasonably easy
  * Hard
  * Very hard

jn> Those two questions, considered alone, doesn't tell us much.  If one
jn> uses git, then usually one does not think it is too hard to use
jn> (unless forced to use git by external circumstances, like project
jn> he/she works on using git).  On the other hand those two questions
jn> together give us some measure of Git's learning curve, telling us
jn> if people consider git easy to use but hard to learn, or vice versa ;-)
jn>
jn> This question was present from the beginning of Git User's Survey,
jn> so it can be used to compare with historical surveys, and see
jn> Git evolution in motion (hopefully in good direction, that is getting
jn> easier to learn and use).


09. Which Git version(s) are you using?
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

jn> I don't know if it is a good range.  One thing that might be good
jn> to know is people using outdated Git, perhaps because it is version
jn> bundled with GUI tool (e.g. using last msysGit instead of Git for
jn> Windows, that is 1.9.x at latest).
jn>
jn> If we want connection with last survey, from 2012, we would
jn> need to go back down to 1.7.x or earlier version...


10. On which operating system(s) do you use Git?
    (multiple choice, with other)

 + GNU/Linux
 + MS Windows
 + macOS
 + *BSD (FreeBSD, OpenBSD, NetBSD, etc.)
 + Android
 + iOS
 + other Unix
 + other, please specify

jn> This question was a part of previous surveys, but it was asked
jn> a bit later.  This year I skipped asking about Cygwin vs native
jn> Git for Windows.  Note that I am not sure if Android and iOS,
jn> added just now, should be present here.


11. Rate your own proficiency with Git
    (single choice, rating)

 1. novice
 2. casual, needs advice
 3. everyday use
 4. can offer advice
 5. know it very well

Description:
~~~~~~~~~~~~
You can think of it as 1-5 numerical grade of your proficiency in Git.

jn> This question tell us penetration of announcements of the survey;
jn> did we get to all users, or only to git gurus?  It is also useful
jn> for correlating with other responses, for example to get to know
jn> which Git features are used by novices, and which by gurus.
jn>
jn> Note that the answers are rather here to stay because of
jn> "backwards compatibility", that is to be able to easy compare
jn> with earlier surveys.


#### How do you use Git

12. I use Git for (check all that apply):
    (multiple choice, with other)


Note that those choices are neither orthogonal nor exclusive.  One
might want to check multiple answers even for a single repository.

jn> Answers to this question probe different direction.
jn> We might want to split this question... but on the other hand
jn> I think we'd rather reduce the number of questions in the survey.

 + work and work-related projects
 + unpaid projects
 
JN> This is one possible point of split, work vs unpaid.  Are there
JN> other possibilities in this dimension?

 + closed-source projects
 + OSS development, public domain, and published & unlicensed
 + private (unpublished), in house projects

jn> It was "proprietary projects" instead of "closed-source projects"
jn> in previous version(s) of Git User's Survey (and it does not
JN> belong in this dimension).  This is another possible point of
JN> splitting into a separate question.

 + code (programming) and its documentation
 + data, documents, static assets (without code)

JN> That is another dimension, another possible split into a separate
JN> question: what types of content is stored in git repositories.
JN> Are there any other types of data?

 + sharing data or synchronization
 + managing configuration files
 + backup
 + frontend / fat-client to other SCM (e.g. git-svn, git-p4)

jn> I'm not sure if the last answer should not be moved to
jn> question about other version control systems

 + other, please specify


13. How do/did you obtain Git (install and/or upgrade)?
    (multiple choice, with other)

jn> Perhaps this question should be moved to previous section.
JN> Or to a separate section, "Getting Git", or something like
JN> that.

Note that this question is multiple choices question because one can
install Git in different ways on different machines or on different
operating systems.

 + binary package
 + source package or script (automatic compiling)
 + source tarball/archive (extract, make, make install)
 + pull from repository, and compiled
 # bundled with GUI or other kind of tool
 + preinstalled / sysadmin job

 + other - please specify (if none of the above apply)

jn> The "bundled" answer is new.  I guess that most people would
jn> not check if GUI brought it own Git (sometimes very outdated;
jn> SourceTree for Windows bundled git 1.9.7 (sic!)) and is using
jn> it instead of system- or user-installed Git.
jn>
jn> Note for example that Eclipse brings JGit, implementation
jn> of Git in Java, and would be covered by "bundled" answer...
JN>
JN> The question about Git version and operating system could be
JN> brought together with this question.


14. How often you upgrade Git?
    (multiple choice or single choice?)

 # use 'master' or 'next' version, and/or pre-release
 * as soon as new version is released
 * when there is new binary package / distribution package
 * when updating distribution / system
 * around every month, or more often
 * around every 6 months or more often
 # update from time to time, cannot say how often
 * I use what is installed on system

JN> This question was added (well, considered to be added) at the
JN> request / suggestion by Andrew Ardill
JN>   Message-ID: <CAH5451n0=kmr9SeOKSH5iiJr5Lnr2TapfZrTUR6Pm90xUEKFxQ@mail.gmail.com>


jn> NOTE: I think we can skip
jn>
jn>   What Git interfaces, implementations and frontends do you use?
jn>
jn> question.  What do you think?


15. What kind of Git tools do you use?
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

 # large files handling (e.g. git-LFS, git-annex)
 # handling subprojects or multiple repositories (e.g. git-stree, repo, git-slave)

 + credentials helper, or askpass wrapper (e.g. wincred, winstore, cache)
 + remote helper to store repository (e.g. FTP, Amazon S3, Dropbox)
 + remote helper to interact with foreign repositories (e.g. git-hg)

 + my own scripts (for daily use)
 + my own scripts (for special tasks)

 + other, please specify

jn> Does this list cover all kind of tools that one might be using,
jn> or is some category missing from the above list (slightly modified
jn> and extended compared to previous surveys)?

JN> Answers about large file support and subproject / dependency handling
JN> are new in this revision of the proposal.


16. List Git tools that you are using (comma separated, or one per line)
16. List git tools that you use (optional)
    (textarea)

jn> Open ended questions are often a pain to analyze, but I don't think
jn> this one would be a problem.  Instead of free-form text field we
jn> could provide a list of most common GUIs and other tools... but I am
jn> not sure what they are, and we are risking skewing results.  On the
jn> other hand free-form might mean people forgetting about tool they use,
jn> or used in the past; it is also a bit more work, to write and not
jn> only to select.


17. How often do you use Git command line (and other command line tools)?
    (single-choice, rating-like)

  1. never
  2. rarely
  3. often
  4. only (always)

jn> This is a new question, replacing somewhat "What Git interfaces,
jn> implementations and frontends do you use?".  I'm not quite sure if
jn> it is a question worth to have.  Though it would be good to verify
JN> the assumption that people have access to command-line tools.
JN> And perhaps correlate use of CLI with use of advanced features.


18. Which git hosting site(s) do you use for your project(s)?
    Please check only hosting sites where you publish/push to (with git)
    (multiple choice, with other)

jn> I think it should be limited to *main* hosting sites; there is
jn> always the "other, please specify" option

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

JN> The above section is new... and would allow us to ask for announcement
JN> about Git User's Survey 2016 on those sites.

  + git hosting site for related projects (e.g. OLPC, freedesktop.org)
  + company internal / self-hosted

  + other, please specify

jn> Gitorious was acquired/changed into GitLab, Google Code is in archive
jn> mode, BerliOS is no longer.  CodePlex is new; many hosting sites that
jn> were present are missing, but could be added: Assembla, Beanstalk,
jn> CloudForge (formerly Codesion), Codebase, Deveo, Unfuddle, perhaps
jn> even Alioth (Debian), Fedora Hosted, Launchpad (Ubuntu)
jn>
jn> "Company internal" and "self-hosted" got concatenated into one answer.
jn>
jn> This question could be moved to the next section.


19. If you, your project or your company self-hosts Git repositories,
    what Git repository management tools do they use?
    (multiple choice, assuming mostly single selected, with other)

JN> This was a suggestion by David Bainbridge: "This is not directly
JN> about Git of course but seeing the extent to which these are used,
JN> and the proportion of users using them might be useful."

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

JN> This was somewhat present in previous version of survey, namely
JN> there is question about *types* of tools (with git repository
JN> management, git hosting tools and code review tools included),
JN> and there is free-form question asking to enumerate tools one uses.
JN>
JN> Though I guess people would forget to write about them, if not
JN> asked explicitly.


#### Git workflows, or
#### Interacting with other repositories

20. How do you fetch/get changes from upstream repositories
    and/or other developers?
    (multiple choice, with other)

 + git protocol        (e.g. git://git.example.com/repo.git)
 + ssh                 (e.g. ssh+git://git.example.com/repo.git,
                             git.example.com:/srv/scm/repo.git)
 + http(s              (e.g. http://git.example.com/repo.git)
 + rsync (DEPRECATED)  (e.g. rsync://git.example.com/repo.git)
 + filesystem          (e.g. /path/to/repo.git, file:///path/to/repo.git)
 + applying patches    (e.g. git-am from emails, or other source)
 + via git-bundle
 + foreign SCM (fat-client or remote helper, e.g. git-svn, git-p4, gitifyhg)

 + Other, please specify

jn> Nobody should be using rsync, as it got broken and nobody noticed,
jn> and then removed from Git.  Note that "applying patches" is new,
jn> because question got extended to cover getting changes from other
jn> developers (in maintainer role), not only from upstream repo.
jn> This question is about getting changes into local work repository.


21. How do you publish/propagate your changes?
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


22. How do you integrate changes from others?
    (multiple choice, with other)

 + merge  (includes 'git pull')
 + rebase (includes 'git pull --rebase')
 + reapply (e.g. git-am from patches)
 + git-imerge (third-party tool)

 + git mergetool, or graphical merge tool directly
 + graphical rebase tool

 + other, please specify

jn> This is proposed new question about workflows.


23. What types of branches can be found in your repositories?
    (repositories you use or are contributing to)
    (multiple choice, with other)

 + there is only a single branch
 + development/graduation branches (master/stable, next/devel/unstable etc.)
 + per-release maintenance branches (or release branches)
 + proposed-updates integration testing and WIP publish branch

 + bugfix / hotfix branches (topic branches for bug fixes)
 + release branches (for preparing a new release)
 + other short-lived topic / feature branches

 ? orphan branches (with disconnected history, e.g. gh-pages, todo)

 + other types and uses, please describe


jn> This is new question.  It doesn't ask about use of git-flow, but
jn> is close.  I think all types of branches are covered, isn't it?


24. Which of the following signing features do you use?
    How do you sign your Git repositories?
    (multiple choice)

JN> This is a new question; it somewhat overlaps with the following
JN> question about Git features, but I think it would be nice to have
JN> it separate.

  + digital certificate of origin ("Signed-off-by:")
  + signed tags
  + signed commits
  + signed merges (merging signed tags)
  + signed pushes

JN> Should there be "other, please specify"?  Are there any other ways
JN> of signing repositories?  Would this question be useful?
JN>
JN> Could be dropped.


#### How you use Git

25. Which of the following Git features do you use?
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

 # searching history for commit message and metadata (e.g. "git log --grep")
 # searching changes in history, pickaxe search ("git log -S" and "git log -G")
 # finding errors in history with bisect (also "git bisect run <script>")

 + tracking code movement with git-blame ("git blame -M" etc.)
 # history of lines ("git log -L")

 + detaching HEAD (e.g. "git checkout --detach", "git checkout <tag>")
 + orphan branches, with disconnected history (gh-pages, todo, man, etc.)

 + alternates mechanism (sharing object database)
 + stash and autostash (also "git stash --keep-index")
 + commit message templates, and/or commit-related hooks
 + interactive commit / per-hunk comitting / partial commit / splitting commits
 + interactive rebase, fixup commits (small scale history editing)
 + git-filter-branch or equivalent, like BFG Repo Cleaner (large history rewriting)
 + committing with dirty tree (keeping some changes uncommitted)
 + reflog (including @{1}, @{yesterday}, @{-1} / -, 'git log -g')

 # client-side hooks (e.g. pre-commit)
 # server-side hooks (e.g. post-receive)

 + git-aware shell prompt
 + git aliases, shell aliases for git, or own git scripts

 + one-way interaction with other SCMs (from SCM to git)
 + two-way interaction with other SCMs (from SCM to git, from git to SCM)

 + object overlays (git replace or grafts)
 + object annotation (git notes)

 + Other, please specify

jn> The problem is come up not with exhaustive list of features: there are
jn> too many of them to list.  The problem is coming up with list of
jn> important and used enough often features (and those interesting to
jn> know about).
jn>
jn> So: what features should be included in this list?  What features
jn> should be removed from above list of answers?
jn>
jn> Should this question be split into parts?  Should we ask how often
jn> those features are used (matrix-form question)?

JN> New features are marked (here and in other places) with '#' as bullet
JN> point in place of '+' (or '*' in other places).  This looks like
JN> longest list of answers for a question...


26. Describe what features would you like to have in Git
    (free form, essay length / textarea)

jn> The Git User's Survey 2012 (last survey) have had also
jn> "17. Which of the following features would you like to see
jn> implemented in git?", with a list of answers.  But as Git development
jn> is not directed by surveys, I'm not sure if it is worth it.
jn>
jn> Such free-form question would be a pain to analyze well, but it
jn> could also be a source of a good inspiration.


#### Other version control systems

27. What other version control systems (SCM) do you use beside Git?
   (multiple choice, with other)

Explanation: "using" version control system here means using
it to actively contribute (propose changes or accept proposals),
and not only e.g. using it to download software.

jn> Perhaps we should split it into two questions, one about
jn> centralized version control systems, one about distributed
jn> ones; longer list of answers vs more questions.
jn>
jn> Clarification (narrowing of scope) is new.

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

jn> Is there any *prominent* and important version control system
jn> missing from this list?  Are there systems that are so rare that
jn> they should be removed from the list?

JN> If not for "other, please specify" it could be made into matrix
JN> form, and ask how often one uses other version control systems,
JN> for example
JN>   never used / used in past / rarely / often


28. How does Git compare to other SCM tools that you have used?
    (single choice, rating)

Git is ____ that other version control systems I have used.

 * better
 * equal (comparable)
 * it depends (in some matters better, in some matters worse)
 * worse
 * cannot compare (have not used anything beside Git)

JN> The answers "it depends" and "cannot compare" are new in this
JN> year's survey (well, "cannot compare" could have been answered
JN> as not putting any answer in previous surveys).


#### Other tools

JN> This section was added (well, considered to be added) thanks
JN> to request / suggestion in a comment by Eric Wong in
JN>   Message-ID: <20160820212937.GA20555@starla>
JN> Well, the suggestion was about federated systems only.

> Perhaps there can be a question about use and interest of other
> decentralized/federated systems which could be potential
> collaboration tools or transports for git.
> e.g. ipfs, gpg, tor, diaspora, *coin, tent, xmpp, matrix, ...
> 
> And another about how they use email: webmail, GUI client,
> console client, phone app, none at all.


29. How do you read and answer email (check all that apply)?
    (multiple choice, possibly with other)

 + GUI client (e.g. Outlook, Thunderbird, Evolution, KMail)
 + console client (e.g. pine, alpine, mutt)
 + webmail or web client (e.g. GMail, Hotmail; HyperKitty)
 + phone app (e.g. K-9 Mail, Airmail, CloudMagic)
 + I don't use email at all


30. Which of the decentralized/federated systems do you use
    or are interested in?

JN> Have I missed some interesting and Git-relevant federated system?

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


There are a few other questions that we might want to ask if
such section is to be added to the Git User's Survey 2016:


31. Which of IDEs and programmer's editors do you use [with Git]?
    (multiple choice, with other)

JN> Have I missed some popular IDE or programmers editor?

 + Visual Studio
 + Eclipse
 + NetBeans
 + Xcode
 + IntelliJ IDEA / PhpStorm / WebStorm
 + KDevelop
 + Anjuta

 + Sublime Text
 + TextMate
 + Emacs
 + Vim
 + Atom
 + Brackets
 + Geany

 + other IDE or editor, please specify


32. Which of the programming languages are you proficient with?
    (multiple choices, with other)

JN> Based on TIOBE index from August 2016, Language Trends on GitHub
JN> 2015, GitHut (languages in GitHub), Stack Overflow Developer
JN> Survey 2016, and my own preferences; in no particular order

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
 + shell scripe

 + CSS, LESS, SASS etc.
 + HTML, HTML5
 + TeX, LaTeX, ConTeXt
 + SQL

 + Go
 + Rust
 + Swift
 + Scala
 + Haskell

 + other, pleasespecify


#### What you think of Git?

33. Overall, how happy are you with Git?
    (single choice, rating)

 * unhappy
 * not so happy
 # neutral
 * happy
 * very happy
 * completely ecstatic

jn> I'm not sure if this question is at all useful.
jn>
jn> There is also problem, that the current wording is considered biased
jn> by some, but on the other hand changing wording of answers would make
jn> it impossible to compare it to answers from previous surveys...
jn> Though I have added 'neutral' as an answer.  Perhaps I should add
jn> most negative answer to make rating balanced?  For example ;-)
jn>
jn>   # hate Git with a passion of thousands suns


34. In your opinion, which areas in Git needs improvement?
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

jn> Are there any general areas that are missing from this list?
jn> What are they?  (Matrix form cannot have "other, please specify").
jn>
jn> Note that "translated documentation" and "messages..." are new.


35. How do you compare the current Git version with the version from one year ago?
    (single choice)

 * better
 * no changes
 * worse

 * cannot say
 * Git used for less than 1 year

jn> This question is mainly excuse for providing list of main changes
jn> from the year ago, to show off how Git continues improving.
jn> List of new features and other changes taken from RelNotes.

JN> I am considering dropping this question.  It is of questionable
JN> utility; it was more useful (as an announcement of new features)
JN> when there were annual surveys.

Description:
~~~~~~~~~~~~
The version from approximately one year ago is x.y.z from DD-MM-YYYY
(x.y.v is from DD-MM-YYYY).

Changes since x.y.z include:

[TO BE DONE]


#### Documentation. Getting help. ==

36. How useful have you found the following forms of Git documentation?
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

jn> Should we split those answers further, e.g. separating on-line
jn> tutorials and guides, from on-line tips etc.?
jn>
jn> This is also educational, showing where one can find documentation;
jn> note that StackOverflow Documentation in yet in Beta.


37. What [channel(s)] do you use to request/get help about Git [(if any)]?
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

jn> Are there any main channels of requesting help that I have missed in
jn> the above list of answers?  What are they, and why do you think they
jn> are important enought to warrant inclusion in above list?
jn>
jn> Should we ask the opposite: how one provides help (if one does)?


38. Which books about Git have you read and recommend, or plan to read?
    (multiple choice, with other)

jn> New question.  List of answers based partially on the "Books" section
jn> in https://git-scm.com/documentation/external-links , ordered by date
jn> of latest edition to within a year.
jn>
jn> Should "plan to read" be included in question, or not?

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

jn> What *good* books should be added here?  I'd rather add only those books
jn> which have a paper version, and not be ebook-only (or be on a website
jn> only); that excludes many online tutorials and guides.

JN> Should "Version Control by Example" be included (it has a chapter on Git)?


#### About this survey. Open forum.

39. How did you hear about this Git User's Survey? ===
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

jn> This list would of course be updated to reflect the list of (planned)
jn> announcement channels.  I also plan to use separate "channels"
jn> (separate shorter URLs) for different announcements.
jn>
jn> I'm not sure how useful would it be.

JN> I am considering dropping this question in favor of the next one.


40. How do you hear about git related news 
    (such as new releases and community events)?
    (multiple choice or single choice?, with other)

JN> This question was proposed by Andrew Ardill, with the proposal in
JN> Message-ID: <CAH5451nMeuZttRgM8LK3JcPhfOYHieyawV2pJzp0jdh2KAf60Q@mail.gmail.com>

  * I wasn't aware there was any news
  * I don't read any news, but I'm aware of it
  * through news aggregation sites (such as reddit or hacker news)
  * from a newsletter (such as Git Rev News)
  + through a watched blog (such as GitHub Blog)
  + announcement section in news site (such as LWN.net)
  + RelNotes file(s) in git sources
  * from a mailing list (such as the git developer or the git for windows list)
  * other, please specify

JN> Are there any other common channels that you (the people) watch for
JN> git news or software news?  Freshmeat / Freecode is defunct, and no
JN> replacement got popular enough...


41. Other comments and suggestions
    What other comments or suggestions do you have,
    that are not covered by the questions above?
    (essay length / textarea)

jn> This would be hard to analyze... but possibly useful.

-- 
Jakub Narębski


