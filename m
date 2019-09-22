Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C651F463
	for <e@80x24.org>; Sun, 22 Sep 2019 11:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfIVL6v (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 07:58:51 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40504 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfIVL6u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 07:58:50 -0400
Received: by mail-lj1-f181.google.com with SMTP id 7so11036412ljw.7
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 04:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PVsAWUh7CBsO9I/zvY7O/PfDjjhlz7TAFwemzV8Bib4=;
        b=WFWNfpWFdsTA3lYOlSZzoT1OHQVOnLK0gy/kCNQSfb7QzbJFG0HY3g6X2MTa1Hn+kU
         JXqOjltHYXQiN7qzMvC3cA3tyLDYFUzZ2CWXxv3loKyVWfiQu+LjaEAUu/0S1ZgaUwQX
         FJWn7/UoIbYNPLtTQ2XGIxYSAJ6y58Bvc2RhwOOdO8jaytXp37LZYLQT0DXExh9Nyu7y
         DaHrQma1f15mTPYrYBGZ02uZdE5Hld0s3oq6vOVM1QODiLwY+u5U5RQhyMfbWy3kPEHP
         CH0G6kJraaBMcq7rVMQzvK87pgriTOVyX6cK+Bz0wmbk9ggO2FLQfKjNa+vTVqRVKn7V
         mJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVsAWUh7CBsO9I/zvY7O/PfDjjhlz7TAFwemzV8Bib4=;
        b=UqCNqygzyEj7UyokNT0/XvWVbJcIhXX5rTRBad6L7hPfsc3d1P/XNXMC6PPmLlXEGx
         1UIEvEWx42SUoSYnsjcTWKHwZ/IcHF0KFCcA3vSGDaDdT65a9gTLoNsMkpwiwp/pwffC
         z0TFja019/6LzeoRzTsgmcdtoARRktc4b9we1xIirpZW6VBgQ1w2LUiXus6NqyHX0ZyC
         kwZjS+SsXr/QBJL4OisKuv5/1c8W6pfthjqyczEfsRMMzfrha30LrBTqnqy7AdHU9Giy
         D5EqJI53Uuifyac19PsmMR/6jiINcyFhA+eJBSh2EsEPn+bE6X5+O3QduBR0vx0ZX2qQ
         yWlg==
X-Gm-Message-State: APjAAAXF2m+CI+845oQCbyxBHI9UlVZafkz8Hd5Gu28anUJBtdd5Nvns
        TlPgj7e0Cduk+noSllbEOjriYdIf
X-Google-Smtp-Source: APXvYqzHL2CoxJFszEzx/YpnFznA0MBhD+i/QBxOtJtmqk7uMzgemBsTmbySiQ4Fyz6lAkbyuUASyA==
X-Received: by 2002:a2e:9853:: with SMTP id e19mr1176848ljj.57.1569153524314;
        Sun, 22 Sep 2019 04:58:44 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id q24sm1622413ljj.6.2019.09.22.04.58.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 04:58:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] user-manual.txt: change header notation
Date:   Sun, 22 Sep 2019 13:57:57 +0200
Message-Id: <f4bf1fdd7a7532cc6f3522139b132b81cbcc30a9.1569152396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569152396.git.martin.agren@gmail.com>
References: <cover.1569152396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When AsciiDoc processes user-manual.txt, it generates a book containing
chapters containing sections. So for example, we have chapter 6,
"Advanced branch management", which contains four relatively short
sections, 6.1-6.4. Asciidoctor generates a book containing *parts*
containing *chapters* instead. So part 6, "Advanced branch management"
contains four short chapters, 1-4. This looks a bit odd.

To make AsciiDoc (8.6.10) and Asciidoctor (1.5.5) handle these the same,
change from indicating chapters like so:

  [[foobar]]
  Foobar
  ======

to doing it like so:

  [[foobar]]
  == Foobar

Same thing for sections (line of dashes to ===), subsections (line of
tildes to ====) and subsubsections (line of carets to =====). Mark the
appendices with "[appendix]", which both AsciiDoc and Asciidoctor
understand. This means we need to drop the "Appendix X: " from their
titles, or those "Appendix X: " would be included literally in the name
of the appendix.

This commit is a no-op for AsciiDoc: The generated user-manual.xml is
identical before and after this patch. Asciidoctor now creates the same
chapter-section-subsection structure as AsciiDoc.

Changing the book title at the start of the document to similarly use
"=" instead of a line of equal signs makes no difference with any of the
engines, but let's do that change anyway for consistency.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/user-manual.txt | 356 ++++++++++++----------------------
 1 file changed, 120 insertions(+), 236 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 2dc2ffdaab..919c214b71 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1,5 +1,4 @@
-Git User Manual
-===============
+= Git User Manual
 
 Git is a fast distributed revision control system.
 
@@ -41,12 +40,10 @@ complete.
 
 
 [[repositories-and-branches]]
-Repositories and Branches
-=========================
+== Repositories and Branches
 
 [[how-to-get-a-git-repository]]
-How to get a Git repository
----------------------------
+=== How to get a Git repository
 
 It will be useful to have a Git repository to experiment with as you
 read this manual.
@@ -73,8 +70,7 @@ top-level directory named `.git`, which contains all the information
 about the history of the project.
 
 [[how-to-check-out]]
-How to check out a different version of a project
--------------------------------------------------
+=== How to check out a different version of a project
 
 Git is best thought of as a tool for storing the history of a collection
 of files.  It stores the history as a compressed collection of
@@ -151,8 +147,7 @@ with no way to find the history it used to point to; so use this command
 carefully.
 
 [[understanding-commits]]
-Understanding History: Commits
-------------------------------
+=== Understanding History: Commits
 
 Every change in the history of a project is represented by a commit.
 The linkgit:git-show[1] command shows the most recent commit on the
@@ -202,8 +197,7 @@ history, including file data and directory contents, is stored in an object
 with a name that is a hash of its contents.
 
 [[understanding-reachability]]
-Understanding history: commits, parents, and reachability
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Understanding history: commits, parents, and reachability
 
 Every commit (except the very first commit in a project) also has a
 parent commit which shows what happened before this commit.
@@ -227,8 +221,7 @@ that Y is a descendant of X, or that there is a chain of parents
 leading from commit Y to commit X.
 
 [[history-diagrams]]
-Understanding history: History diagrams
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Understanding history: History diagrams
 
 We will sometimes represent Git history using diagrams like the one
 below.  Commits are shown as "o", and the links between them with
@@ -247,8 +240,7 @@ If we need to talk about a particular commit, the character "o" may
 be replaced with another letter or number.
 
 [[what-is-a-branch]]
-Understanding history: What is a branch?
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Understanding history: What is a branch?
 
 When we need to be precise, we will use the word "branch" to mean a line
 of development, and "branch head" (or just "head") to mean a reference
@@ -261,8 +253,7 @@ However, when no confusion will result, we often just use the term
 "branch" both for branches and for branch heads.
 
 [[manipulating-branches]]
-Manipulating branches
----------------------
+=== Manipulating branches
 
 Creating, deleting, and modifying branches is quick and easy; here's
 a summary of the commands:
@@ -299,8 +290,7 @@ ref: refs/heads/master
 ------------------------------------------------
 
 [[detached-head]]
-Examining an old version without creating a new branch
-------------------------------------------------------
+=== Examining an old version without creating a new branch
 
 The `git switch` command normally expects a branch head, but will also
 accept an arbitrary commit when invoked with --detach; for example,
@@ -340,8 +330,7 @@ make up a name for the new branch.   You can still create a new branch
 (or tag) for this version later if you decide to.
 
 [[examining-remote-branches]]
-Examining branches from a remote repository
--------------------------------------------
+=== Examining branches from a remote repository
 
 The "master" branch that was created at the time you cloned is a copy
 of the HEAD in the repository that you cloned from.  That repository
@@ -383,8 +372,7 @@ Note that the name "origin" is just the name that Git uses by default
 to refer to the repository that you cloned from.
 
 [[how-git-stores-references]]
-Naming branches, tags, and other references
--------------------------------------------
+=== Naming branches, tags, and other references
 
 Branches, remote-tracking branches, and tags are all references to
 commits.  All references are named with a slash-separated path name
@@ -413,8 +401,7 @@ references with the same shorthand name, see the "SPECIFYING
 REVISIONS" section of linkgit:gitrevisions[7].
 
 [[Updating-a-repository-With-git-fetch]]
-Updating a repository with git fetch
-------------------------------------
+=== Updating a repository with git fetch
 
 After you clone a repository and commit a few changes of your own, you
 may wish to check the original repository for updates.
@@ -425,8 +412,7 @@ repository.  It will not touch any of your own branches--not even the
 "master" branch that was created for you on clone.
 
 [[fetching-branches]]
-Fetching branches from other repositories
------------------------------------------
+=== Fetching branches from other repositories
 
 You can also track branches from repositories other than the one you
 cloned from, using linkgit:git-remote[1]:
@@ -474,8 +460,7 @@ text editor.  (See the "CONFIGURATION FILE" section of
 linkgit:git-config[1] for details.)
 
 [[exploring-git-history]]
-Exploring Git history
-=====================
+== Exploring Git history
 
 Git is best thought of as a tool for storing the history of a
 collection of files.  It does this by storing compressed snapshots of
@@ -489,8 +474,7 @@ We start with one specialized tool that is useful for finding the
 commit that introduced a bug into a project.
 
 [[using-bisect]]
-How to use bisect to find a regression
---------------------------------------
+=== How to use bisect to find a regression
 
 Suppose version 2.6.18 of your project worked, but the version at
 "master" crashes.  Sometimes the best way to find the cause of such a
@@ -572,8 +556,7 @@ linkgit:git-bisect[1] for more information about this and other `git
 bisect` features.
 
 [[naming-commits]]
-Naming commits
---------------
+=== Naming commits
 
 We have seen several ways of naming commits already:
 
@@ -637,8 +620,7 @@ e05db0fd4f31dde7005f075a84f96b360d05984b
 -------------------------------------------------
 
 [[creating-tags]]
-Creating tags
--------------
+=== Creating tags
 
 We can also create a tag to refer to a particular commit; after
 running
@@ -655,8 +637,7 @@ should create a tag object instead; see the linkgit:git-tag[1] man page
 for details.
 
 [[browsing-revisions]]
-Browsing revisions
-------------------
+=== Browsing revisions
 
 The linkgit:git-log[1] command can show lists of commits.  On its
 own, it shows all commits reachable from the parent commit; but you
@@ -697,8 +678,7 @@ multiple independent lines of development, the particular order that
 commits are listed in may be somewhat arbitrary.
 
 [[generating-diffs]]
-Generating diffs
-----------------
+=== Generating diffs
 
 You can generate diffs between any two versions using
 linkgit:git-diff[1]:
@@ -726,8 +706,7 @@ will generate a file with a patch for each commit reachable from test
 but not from master.
 
 [[viewing-old-file-versions]]
-Viewing old file versions
--------------------------
+=== Viewing old file versions
 
 You can always view an old version of a file by just checking out the
 correct revision first.  But sometimes it is more convenient to be
@@ -742,12 +721,10 @@ Before the colon may be anything that names a commit, and after it
 may be any path to a file tracked by Git.
 
 [[history-examples]]
-Examples
---------
+=== Examples
 
 [[counting-commits-on-a-branch]]
-Counting the number of commits on a branch
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Counting the number of commits on a branch
 
 Suppose you want to know how many commits you've made on `mybranch`
 since it diverged from `origin`:
@@ -765,8 +742,7 @@ $ git rev-list origin..mybranch | wc -l
 -------------------------------------------------
 
 [[checking-for-equal-branches]]
-Check whether two branches point at the same history
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Check whether two branches point at the same history
 
 Suppose you want to check whether two branches point at the same point
 in history.
@@ -798,8 +774,7 @@ $ git log origin...master
 will return no commits when the two branches are equal.
 
 [[finding-tagged-descendants]]
-Find first tagged version including a given fix
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Find first tagged version including a given fix
 
 Suppose you know that the commit e05db0fd fixed a certain problem.
 You'd like to find the earliest tagged release that contains that
@@ -883,8 +858,7 @@ shows that e05db0fd is reachable from itself, from v1.5.0-rc1,
 and from v1.5.0-rc2, and not from v1.5.0-rc0.
 
 [[showing-commits-unique-to-a-branch]]
-Showing commits unique to a given branch
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Showing commits unique to a given branch
 
 Suppose you would like to see all the commits reachable from the branch
 head named `master` but not from any other head in your repository.
@@ -931,8 +905,7 @@ $ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
 syntax such as `--not`.)
 
 [[making-a-release]]
-Creating a changelog and tarball for a software release
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Creating a changelog and tarball for a software release
 
 The linkgit:git-archive[1] command can create a tar or zip archive from
 any version of a project; for example:
@@ -983,8 +956,7 @@ and then he just cut-and-pastes the output commands after verifying that
 they look OK.
 
 [[Finding-commits-With-given-Content]]
-Finding commits referencing a file with given content
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Finding commits referencing a file with given content
 
 Somebody hands you a copy of a file, and asks which commits modified a
 file such that it contained the given content either before or after the
@@ -1000,12 +972,10 @@ student.  The linkgit:git-log[1], linkgit:git-diff-tree[1], and
 linkgit:git-hash-object[1] man pages may prove helpful.
 
 [[Developing-With-git]]
-Developing with Git
-===================
+== Developing with Git
 
 [[telling-git-your-name]]
-Telling Git your name
----------------------
+=== Telling Git your name
 
 Before creating any commits, you should introduce yourself to Git.
 The easiest way to do so is to use linkgit:git-config[1]:
@@ -1030,8 +1000,7 @@ also edit it with your favorite editor.
 
 
 [[creating-a-new-repository]]
-Creating a new repository
--------------------------
+=== Creating a new repository
 
 Creating a new repository from scratch is very easy:
 
@@ -1052,8 +1021,7 @@ $ git commit
 -------------------------------------------------
 
 [[how-to-make-a-commit]]
-How to make a commit
---------------------
+=== How to make a commit
 
 Creating a new commit takes three steps:
 
@@ -1148,8 +1116,7 @@ for inclusion in the index (by right-clicking on the diff hunk and
 choosing "Stage Hunk For Commit").
 
 [[creating-good-commit-messages]]
-Creating good commit messages
------------------------------
+=== Creating good commit messages
 
 Though not required, it's a good idea to begin the commit message
 with a single short (less than 50 character) line summarizing the
@@ -1162,8 +1129,7 @@ rest of the commit in the body.
 
 
 [[ignoring-files]]
-Ignoring files
---------------
+=== Ignoring files
 
 A project will often generate files that you do 'not' want to track with Git.
 This typically includes files generated by a build process or temporary
@@ -1205,8 +1171,7 @@ Some Git commands can also take exclude patterns directly on the
 command line.  See linkgit:gitignore[5] for the details.
 
 [[how-to-merge]]
-How to merge
-------------
+=== How to merge
 
 You can rejoin two diverging branches of development using
 linkgit:git-merge[1]:
@@ -1254,8 +1219,7 @@ has two parents, one pointing to the top of the current branch, and
 one to the top of the other branch.
 
 [[resolving-a-merge]]
-Resolving a merge
------------------
+=== Resolving a merge
 
 When a merge isn't resolved automatically, Git leaves the index and
 the working tree in a special state that gives you all the
@@ -1297,8 +1261,7 @@ The above is all you need to know to resolve a simple merge.  But Git
 also provides more information to help resolve conflicts:
 
 [[conflict-resolution]]
-Getting conflict-resolution help during a merge
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Getting conflict-resolution help during a merge
 
 All of the changes that Git was able to merge automatically are
 already added to the index file, so linkgit:git-diff[1] shows only
@@ -1401,8 +1364,7 @@ the different stages of that file will be "collapsed", after which
 `git diff` will (by default) no longer show diffs for that file.
 
 [[undoing-a-merge]]
-Undoing a merge
----------------
+=== Undoing a merge
 
 If you get stuck and decide to just give up and throw the whole mess
 away, you can always return to the pre-merge state with
@@ -1423,8 +1385,7 @@ itself have been merged into another branch, as doing so may confuse
 further merges.
 
 [[fast-forwards]]
-Fast-forward merges
--------------------
+=== Fast-forward merges
 
 There is one special case not mentioned above, which is treated
 differently.  Normally, a merge results in a merge commit, with two
@@ -1438,8 +1399,7 @@ to point at the head of the merged-in branch, without any new commits being
 created.
 
 [[fixing-mistakes]]
-Fixing mistakes
----------------
+=== Fixing mistakes
 
 If you've messed up the working tree, but haven't yet committed your
 mistake, you can return the entire working tree to the last committed
@@ -1463,8 +1423,7 @@ fundamentally different ways to fix the problem:
 	a branch that has had its history changed.
 
 [[reverting-a-commit]]
-Fixing a mistake with a new commit
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Fixing a mistake with a new commit
 
 Creating a new commit that reverts an earlier change is very easy;
 just pass the linkgit:git-revert[1] command a reference to the bad
@@ -1490,8 +1449,7 @@ conflicts manually, just as in the case of <<resolving-a-merge,
 resolving a merge>>.
 
 [[fixing-a-mistake-by-rewriting-history]]
-Fixing a mistake by rewriting history
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Fixing a mistake by rewriting history
 
 If the problematic commit is the most recent commit, and you have not
 yet made that commit public, then you may just
@@ -1518,8 +1476,7 @@ this is an advanced topic to be left for
 <<cleaning-up-history,another chapter>>.
 
 [[checkout-of-path]]
-Checking out an old version of a file
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Checking out an old version of a file
 
 In the process of undoing a previous bad change, you may find it
 useful to check out an older version of a particular file using
@@ -1543,8 +1500,7 @@ $ git show HEAD^:path/to/file
 which will display the given version of the file.
 
 [[interrupted-work]]
-Temporarily setting aside work in progress
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Temporarily setting aside work in progress
 
 While you are in the middle of working on something complicated, you
 find an unrelated but obvious and trivial bug.  You would like to fix it
@@ -1575,8 +1531,7 @@ $ git stash pop
 
 
 [[ensuring-good-performance]]
-Ensuring good performance
--------------------------
+=== Ensuring good performance
 
 On large repositories, Git depends on compression to keep the history
 information from taking up too much space on disk or in memory.  Some
@@ -1587,12 +1542,10 @@ to avoid automatic compression kicking in when it is not convenient.
 
 
 [[ensuring-reliability]]
-Ensuring reliability
---------------------
+=== Ensuring reliability
 
 [[checking-for-corruption]]
-Checking the repository for corruption
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Checking the repository for corruption
 
 The linkgit:git-fsck[1] command runs a number of self-consistency checks
 on the repository, and reports on any problems.  This may take some
@@ -1618,12 +1571,10 @@ You can run `git fsck --no-dangling` to suppress these messages, and still
 view real errors.
 
 [[recovering-lost-changes]]
-Recovering lost changes
-~~~~~~~~~~~~~~~~~~~~~~~
+==== Recovering lost changes
 
 [[reflogs]]
-Reflogs
-^^^^^^^
+===== Reflogs
 
 Say you modify a branch with <<fixing-mistakes,`git reset --hard`>>,
 and then realize that the branch was the only reference you had to
@@ -1670,8 +1621,7 @@ same project, the reflog history is not shared: it tells you only about
 how the branches in your local repository have changed over time.
 
 [[dangling-object-recovery]]
-Examining dangling objects
-^^^^^^^^^^^^^^^^^^^^^^^^^^
+===== Examining dangling objects
 
 In some situations the reflog may not be able to save you.  For example,
 suppose you delete a branch, then realize you need the history it
@@ -1715,12 +1665,10 @@ dangling objects can arise in other situations.
 
 
 [[sharing-development]]
-Sharing development with others
-===============================
+== Sharing development with others
 
 [[getting-updates-With-git-pull]]
-Getting updates with git pull
------------------------------
+=== Getting updates with git pull
 
 After you clone a repository and commit a few changes of your own, you
 may wish to check the original repository for updates and merge them
@@ -1783,8 +1731,7 @@ $ git merge branch
 are roughly equivalent.
 
 [[submitting-patches]]
-Submitting patches to a project
--------------------------------
+=== Submitting patches to a project
 
 If you just have a few changes, the simplest way to submit them may
 just be to send them as patches in email:
@@ -1812,8 +1759,7 @@ Consult the mailing list for your project first to determine
 their requirements for submitting patches.
 
 [[importing-patches]]
-Importing patches to a project
-------------------------------
+=== Importing patches to a project
 
 Git also provides a tool called linkgit:git-am[1] (am stands for
 "apply mailbox"), for importing such an emailed series of patches.
@@ -1845,8 +1791,7 @@ the original mailbox, with authorship and commit log message each
 taken from the message containing each patch.
 
 [[public-repositories]]
-Public Git repositories
------------------------
+=== Public Git repositories
 
 Another way to submit changes to a project is to tell the maintainer
 of that project to pull the changes from your repository using
@@ -1899,8 +1844,7 @@ like this:
 We explain how to do this in the following sections.
 
 [[setting-up-a-public-repository]]
-Setting up a public repository
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Setting up a public repository
 
 Assume your personal repository is in the directory `~/proj`.  We
 first create a new clone of the repository and tell `git daemon` that it
@@ -1920,8 +1864,7 @@ public repository.  You can use scp, rsync, or whatever is most
 convenient.
 
 [[exporting-via-git]]
-Exporting a Git repository via the Git protocol
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Exporting a Git repository via the Git protocol
 
 This is the preferred method.
 
@@ -1942,8 +1885,7 @@ linkgit:git-daemon[1] man page for details.  (See especially the
 examples section.)
 
 [[exporting-via-http]]
-Exporting a git repository via HTTP
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Exporting a git repository via HTTP
 
 The Git protocol gives better performance and reliability, but on a
 host with a web server set up, HTTP exports may be simpler to set up.
@@ -1975,8 +1917,7 @@ for a slightly more sophisticated setup using WebDAV which also
 allows pushing over HTTP.)
 
 [[pushing-changes-to-a-public-repository]]
-Pushing changes to a public repository
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Pushing changes to a public repository
 
 Note that the two techniques outlined above (exporting via
 <<exporting-via-http,http>> or <<exporting-via-git,git>>) allow other
@@ -2035,8 +1976,7 @@ See the explanations of the `remote.<name>.url`,
 linkgit:git-config[1] for details.
 
 [[forcing-push]]
-What to do when a push fails
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== What to do when a push fails
 
 If a push would not result in a <<fast-forwards,fast-forward>> of the
 remote branch, then it will fail with an error like:
@@ -2090,8 +2030,7 @@ pull, or by a fetch followed by a rebase; see the
 linkgit:gitcvs-migration[7] for more.
 
 [[setting-up-a-shared-repository]]
-Setting up a shared repository
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Setting up a shared repository
 
 Another way to collaborate is by using a model similar to that
 commonly used in CVS, where several developers with special rights
@@ -2121,8 +2060,7 @@ advantages over the central shared repository:
 	  "out".
 
 [[setting-up-gitweb]]
-Allowing web browsing of a repository
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Allowing web browsing of a repository
 
 The gitweb cgi script provides users an easy way to browse your
 project's revisions, file contents and logs without having to install
@@ -2138,8 +2076,7 @@ linkgit:gitweb[1] for instructions on details setting up a permanent
 installation with a CGI or Perl capable server.
 
 [[how-to-get-a-git-repository-with-minimal-history]]
-How to get a Git repository with minimal history
-------------------------------------------------
+=== How to get a Git repository with minimal history
 
 A <<def_shallow_clone,shallow clone>>, with its truncated
 history, is useful when one is interested only in recent history
@@ -2158,12 +2095,10 @@ have to result in huge conflicts.  This limitation may make such
 a repository unsuitable to be used in merge based workflows.
 
 [[sharing-development-examples]]
-Examples
---------
+=== Examples
 
 [[maintaining-topic-branches]]
-Maintaining topic branches for a Linux subsystem maintainer
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Maintaining topic branches for a Linux subsystem maintainer
 
 This describes how Tony Luck uses Git in his role as maintainer of the
 IA64 architecture for the Linux kernel.
@@ -2459,8 +2394,7 @@ done
 
 
 [[cleaning-up-history]]
-Rewriting history and maintaining patch series
-==============================================
+== Rewriting history and maintaining patch series
 
 Normally commits are only added to a project, never taken away or
 replaced.  Git is designed with this assumption, and violating it will
@@ -2470,8 +2404,7 @@ However, there is a situation in which it can be useful to violate this
 assumption.
 
 [[patch-series]]
-Creating the perfect patch series
----------------------------------
+=== Creating the perfect patch series
 
 Suppose you are a contributor to a large project, and you want to add a
 complicated feature, and to present it to the other developers in a way
@@ -2503,8 +2436,7 @@ use them, and then explain some of the problems that can arise because
 you are rewriting history.
 
 [[using-git-rebase]]
-Keeping a patch series up to date using git rebase
---------------------------------------------------
+=== Keeping a patch series up to date using git rebase
 
 Suppose that you create a branch `mywork` on a remote-tracking branch
 `origin`, and create some commits on top of it:
@@ -2591,8 +2523,7 @@ the rebase.  See <<interactive-rebase>> for details, and
 <<reordering-patch-series>> for alternatives.
 
 [[rewriting-one-commit]]
-Rewriting a single commit
--------------------------
+=== Rewriting a single commit
 
 We saw in <<fixing-a-mistake-by-rewriting-history>> that you can replace the
 most recent commit using
@@ -2610,8 +2541,7 @@ If you need to amend commits from deeper in your history, you can
 use <<interactive-rebase,interactive rebase's `edit` instruction>>.
 
 [[reordering-patch-series]]
-Reordering or selecting from a patch series
--------------------------------------------
+=== Reordering or selecting from a patch series
 
 Sometimes you want to edit a commit deeper in your history.  One
 approach is to use `git format-patch` to create a series of patches
@@ -2630,8 +2560,7 @@ $ git am *.patch
 -------------------------------------------------
 
 [[interactive-rebase]]
-Using interactive rebases
--------------------------
+=== Using interactive rebases
 
 You can also edit a patch series with an interactive rebase.  This is
 the same as <<reordering-patch-series,reordering a patch series using
@@ -2688,16 +2617,14 @@ For a more detailed discussion of the procedure and additional tips,
 see the "INTERACTIVE MODE" section of linkgit:git-rebase[1].
 
 [[patch-series-tools]]
-Other tools
------------
+=== Other tools
 
 There are numerous other tools, such as StGit, which exist for the
 purpose of maintaining a patch series.  These are outside of the scope of
 this manual.
 
 [[problems-With-rewriting-history]]
-Problems with rewriting history
--------------------------------
+=== Problems with rewriting history
 
 The primary problem with rewriting the history of a branch has to do
 with merging.  Suppose somebody fetches your branch and merges it into
@@ -2745,8 +2672,7 @@ For true distributed development that supports proper merging,
 published branches should never be rewritten.
 
 [[bisect-merges]]
-Why bisecting merge commits can be harder than bisecting linear history
------------------------------------------------------------------------
+=== Why bisecting merge commits can be harder than bisecting linear history
 
 The linkgit:git-bisect[1] command correctly handles history that
 includes merge commits.  However, when the commit that it finds is a
@@ -2811,12 +2737,10 @@ linear by rebasing against the latest upstream version before
 publishing.
 
 [[advanced-branch-management]]
-Advanced branch management
-==========================
+== Advanced branch management
 
 [[fetching-individual-branches]]
-Fetching individual branches
-----------------------------
+=== Fetching individual branches
 
 Instead of using linkgit:git-remote[1], you can also choose just
 to update one branch at a time, and to store it locally under an
@@ -2844,8 +2768,7 @@ already have a branch named example-master, it will attempt to
 master branch.  In more detail:
 
 [[fetch-fast-forwards]]
-git fetch and fast-forwards
----------------------------
+=== git fetch and fast-forwards
 
 In the previous example, when updating an existing branch, `git fetch`
 checks to make sure that the most recent commit on the remote
@@ -2882,8 +2805,7 @@ unless you've already created a reference of your own pointing to
 them.
 
 [[forcing-fetch]]
-Forcing git fetch to do non-fast-forward updates
-------------------------------------------------
+=== Forcing git fetch to do non-fast-forward updates
 
 If git fetch fails because the new head of a branch is not a
 descendant of the old head, you may force the update with:
@@ -2903,8 +2825,7 @@ Be aware that commits that the old version of example/master pointed at
 may be lost, as we saw in the previous section.
 
 [[remote-branch-configuration]]
-Configuring remote-tracking branches
-------------------------------------
+=== Configuring remote-tracking branches
 
 We saw above that `origin` is just a shortcut to refer to the
 repository that you originally cloned from.  This information is
@@ -2955,8 +2876,7 @@ the refspec syntax.
 
 
 [[git-concepts]]
-Git concepts
-============
+== Git concepts
 
 Git is built on a small number of simple but powerful ideas.  While it
 is possible to get things done without understanding them, you will find
@@ -2966,8 +2886,7 @@ We start with the most important, the  <<def_object_database,object
 database>> and the <<def_index,index>>.
 
 [[the-object-database]]
-The Object Database
--------------------
+=== The Object Database
 
 
 We already saw in <<understanding-commits>> that all commits are stored
@@ -3011,8 +2930,7 @@ There are four different types of objects: "blob", "tree", "commit", and
 The object types in some more detail:
 
 [[commit-object]]
-Commit Object
-~~~~~~~~~~~~~
+==== Commit Object
 
 The "commit" object links a physical state of a tree with a description
 of how we got there and why.  Use the `--pretty=raw` option to
@@ -3064,8 +2982,7 @@ commit whose parent is normally the current HEAD, and whose tree is
 taken from the content currently stored in the index.
 
 [[tree-object]]
-Tree Object
-~~~~~~~~~~~
+==== Tree Object
 
 The ever-versatile linkgit:git-show[1] command can also be used to
 examine tree objects, but linkgit:git-ls-tree[1] will give you more
@@ -3104,8 +3021,7 @@ Note that the files all have mode 644 or 755: Git actually only pays
 attention to the executable bit.
 
 [[blob-object]]
-Blob Object
-~~~~~~~~~~~
+==== Blob Object
 
 You can use linkgit:git-show[1] to examine the contents of a blob; take,
 for example, the blob in the entry for `COPYING` from the tree above:
@@ -3134,8 +3050,7 @@ sometimes be useful for browsing the contents of a tree that is not
 currently checked out.
 
 [[trust]]
-Trust
-~~~~~
+==== Trust
 
 If you receive the SHA-1 name of a blob from one source, and its contents
 from another (possibly untrusted) source, you can still trust that those
@@ -3164,8 +3079,7 @@ like GPG/PGP.
 To assist in this, Git also provides the tag object...
 
 [[tag-object]]
-Tag Object
-~~~~~~~~~~
+==== Tag Object
 
 A tag object contains an object, object type, tag name, the name of the
 person ("tagger") who created the tag, and a message, which may contain
@@ -3194,8 +3108,7 @@ objects.  (Note that linkgit:git-tag[1] can also be used to create
 references whose names begin with `refs/tags/`).
 
 [[pack-files]]
-How Git stores objects efficiently: pack files
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== How Git stores objects efficiently: pack files
 
 Newly created objects are initially created in a file named after the
 object's SHA-1 hash (stored in `.git/objects`).
@@ -3253,8 +3166,7 @@ The linkgit:git-gc[1] command performs packing, pruning, and more for
 you, so is normally the only high-level command you need.
 
 [[dangling-objects]]
-Dangling objects
-~~~~~~~~~~~~~~~~
+==== Dangling objects
 
 The linkgit:git-fsck[1] command will sometimes complain about dangling
 objects.  They are not a problem.
@@ -3334,8 +3246,7 @@ don't want to do that while the filesystem is mounted.
 accesses to a repository but you might receive confusing or scary messages.)
 
 [[recovering-from-repository-corruption]]
-Recovering from repository corruption
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== Recovering from repository corruption
 
 By design, Git treats data trusted to it with caution.  However, even in
 the absence of bugs in Git itself, it is still possible that hardware or
@@ -3452,8 +3363,7 @@ whole thing. It's up to you--Git does *have* a lot of information, it is
 just missing one particular blob version.
 
 [[the-index]]
-The index
----------
+=== The index
 
 The index is a binary file (generally kept in `.git/index`) containing a
 sorted list of path names, each with permissions and the SHA-1 of a blob
@@ -3511,8 +3421,7 @@ If you blow the index away entirely, you generally haven't lost any
 information as long as you have the name of the tree that it described.
 
 [[submodules]]
-Submodules
-==========
+== Submodules
 
 Large projects are often composed of smaller, self-contained modules.  For
 example, an embedded Linux distribution's source tree would include every
@@ -3699,8 +3608,7 @@ You have to run `git submodule update` after `git pull` if you want to update
 submodules, too.
 
 [[pitfalls-with-submodules]]
-Pitfalls with submodules
-------------------------
+=== Pitfalls with submodules
 
 Always publish the submodule change before publishing the change to the
 superproject that references it. If you forget to publish the submodule change,
@@ -3769,8 +3677,7 @@ submodule update` will not overwrite them.  Instead, you get the usual
 warning about not being able switch from a dirty branch.
 
 [[low-level-operations]]
-Low-level Git operations
-========================
+== Low-level Git operations
 
 Many of the higher-level commands were originally implemented as shell
 scripts using a smaller core of low-level Git commands.  These can still
@@ -3778,8 +3685,7 @@ be useful when doing unusual things with Git, or just as a way to
 understand its inner workings.
 
 [[object-manipulation]]
-Object access and manipulation
-------------------------------
+=== Object access and manipulation
 
 The linkgit:git-cat-file[1] command can show the contents of any object,
 though the higher-level linkgit:git-show[1] is usually more useful.
@@ -3796,8 +3702,7 @@ verified by linkgit:git-verify-tag[1], though it is normally simpler to
 use linkgit:git-tag[1] for both.
 
 [[the-workflow]]
-The Workflow
-------------
+=== The Workflow
 
 High-level operations such as linkgit:git-commit[1] and
 linkgit:git-restore[1] work by moving data
@@ -3812,8 +3717,7 @@ the database or the working directory. Thus there are four main
 combinations:
 
 [[working-directory-to-index]]
-working directory -> index
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== working directory -> index
 
 The linkgit:git-update-index[1] command updates the index with
 information from the working directory.  You generally update the
@@ -3849,8 +3753,7 @@ The previously introduced linkgit:git-add[1] is just a wrapper for
 linkgit:git-update-index[1].
 
 [[index-to-object-database]]
-index -> object database
-~~~~~~~~~~~~~~~~~~~~~~~~
+==== index -> object database
 
 You write your current index file to a "tree" object with the program
 
@@ -3865,8 +3768,7 @@ use that tree to re-generate the index at any time by going in the
 other direction:
 
 [[object-database-to-index]]
-object database -> index
-~~~~~~~~~~~~~~~~~~~~~~~~
+==== object database -> index
 
 You read a "tree" file from the object database, and use that to
 populate (and overwrite--don't do this if your index contains any
@@ -3882,8 +3784,7 @@ earlier. However, that is only your 'index' file: your working
 directory contents have not been modified.
 
 [[index-to-working-directory]]
-index -> working directory
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+==== index -> working directory
 
 You update your working directory from the index by "checking out"
 files. This is not a very common operation, since normally you'd just
@@ -3912,8 +3813,7 @@ Finally, there are a few odds and ends which are not purely moving
 from one representation to the other:
 
 [[tying-it-all-together]]
-Tying it all together
-~~~~~~~~~~~~~~~~~~~~~
+==== Tying it all together
 
 To commit a tree you have instantiated with `git write-tree`, you'd
 create a "commit" object that refers to that tree and the history
@@ -3987,8 +3887,7 @@ Here is a picture that illustrates how various pieces fit together:
 
 
 [[examining-the-data]]
-Examining the data
-------------------
+=== Examining the data
 
 You can examine the data represented in the object database and the
 index with various helper tools. For every object, you can use
@@ -4023,8 +3922,7 @@ $ git cat-file commit HEAD
 to see what the top commit was.
 
 [[merging-multiple-trees]]
-Merging multiple trees
-----------------------
+=== Merging multiple trees
 
 Git can help you perform a three-way merge, which can in turn be
 used for a many-way merge by repeating the merge procedure several
@@ -4074,8 +3972,7 @@ index file, and you can just write the result out with
 
 
 [[merging-multiple-trees-2]]
-Merging multiple trees, continued
----------------------------------
+=== Merging multiple trees, continued
 
 Sadly, many merges aren't trivial. If there are files that have
 been added, moved or removed, or if both branches have modified the
@@ -4145,15 +4042,13 @@ $ git merge-index git-merge-one-file hello.c
 and that is what higher level `git merge -s resolve` is implemented with.
 
 [[hacking-git]]
-Hacking Git
-===========
+== Hacking Git
 
 This chapter covers internal details of the Git implementation which
 probably only Git developers need to understand.
 
 [[object-details]]
-Object storage format
----------------------
+=== Object storage format
 
 All objects have a statically determined "type" which identifies the
 format of the object (i.e. how it is used, and how it can refer to other
@@ -4183,8 +4078,7 @@ of all objects, and verifies their internal consistency (in addition
 to just verifying their superficial consistency through the hash).
 
 [[birdview-on-the-source-code]]
-A birds-eye view of Git's source code
--------------------------------------
+=== A birds-eye view of Git's source code
 
 It is not always easy for new developers to find their way through Git's
 source code.  This section gives you a little guidance to show where to
@@ -4393,25 +4287,22 @@ You see, Git is actually the best tool to find out about the source of Git
 itself!
 
 [[glossary]]
-Git Glossary
-============
+== Git Glossary
 
 [[git-explained]]
-Git explained
--------------
+=== Git explained
 
 include::glossary-content.txt[]
 
 [[git-quick-start]]
-Appendix A: Git Quick Reference
-===============================
+[appendix]
+== Git Quick Reference
 
 This is a quick summary of the major commands; the previous chapters
 explain how these work in more detail.
 
 [[quick-creating-a-new-repository]]
-Creating a new repository
--------------------------
+=== Creating a new repository
 
 From a tarball:
 
@@ -4432,8 +4323,7 @@ $ cd project
 -----------------------------------------------
 
 [[managing-branches]]
-Managing branches
------------------
+=== Managing branches
 
 -----------------------------------------------
 $ git branch			# list all local branches in this repo
@@ -4497,8 +4387,7 @@ $ git branch -r			# list all remote branches
 
 
 [[exploring-history]]
-Exploring history
------------------
+=== Exploring history
 
 -----------------------------------------------
 $ gitk			    # visualize and browse history
@@ -4533,8 +4422,7 @@ $ git bisect bad		# if this revision is bad.
 -----------------------------------------------
 
 [[making-changes]]
-Making changes
---------------
+=== Making changes
 
 Make sure Git knows who to blame:
 
@@ -4564,8 +4452,7 @@ $ git commit -a	   # use latest content of all tracked files
 -----------------------------------------------
 
 [[merging]]
-Merging
--------
+=== Merging
 
 -----------------------------------------------
 $ git merge test   # merge branch "test" into the current branch
@@ -4575,8 +4462,7 @@ $ git pull . test  # equivalent to git merge test
 -----------------------------------------------
 
 [[sharing-your-changes]]
-Sharing your changes
---------------------
+=== Sharing your changes
 
 Importing or exporting patches:
 
@@ -4621,8 +4507,7 @@ $ git push example test
 -----------------------------------------------
 
 [[repository-maintenance]]
-Repository maintenance
-----------------------
+=== Repository maintenance
 
 Check for corruption:
 
@@ -4638,12 +4523,11 @@ $ git gc
 
 
 [[todo]]
-Appendix B: Notes and todo list for this manual
-===============================================
+[appendix]
+== Notes and todo list for this manual
 
 [[todo-list]]
-Todo list
----------
+=== Todo list
 
 This is a work in progress.
 
-- 
2.23.0

