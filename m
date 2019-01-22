Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBBD1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfAVURa (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:17:30 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:1888 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVURa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:17:30 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 7552F20040F;
        Tue, 22 Jan 2019 21:16:38 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc: tidy asciidoc style
Date:   Tue, 22 Jan 2019 21:16:35 +0100
Message-Id: <20190122201635.15961-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This mainly refers to enforcing indentation on additional lines of
items of lists.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-add.txt          |  8 ++--
 Documentation/git-branch.txt       |  8 ++--
 Documentation/git-checkout.txt     | 16 +++----
 Documentation/git-cherry-pick.txt  | 14 +++---
 Documentation/git-diff.txt         | 18 ++++----
 Documentation/git-fetch.txt        |  2 +-
 Documentation/git-format-patch.txt | 14 +++---
 Documentation/git-help.txt         |  4 +-
 Documentation/git-p4.txt           |  8 ++--
 Documentation/git-reset.txt        | 70 +++++++++++++++---------------
 Documentation/git-send-email.txt   |  2 +-
 Documentation/git-tag.txt          | 16 +++----
 Documentation/git-upload-pack.txt  |  1 -
 Documentation/rev-list-options.txt |  6 +--
 14 files changed, 93 insertions(+), 94 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 45652fe4a6..37bcab94d5 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -58,9 +58,9 @@ OPTIONS
 	specifying `dir` will record not just a file `dir/file1`
 	modified in the working tree, a file `dir/file2` added to
 	the working tree, but also a file `dir/file3` removed from
-	the working tree.  Note that older versions of Git used
+	the working tree). Note that older versions of Git used
 	to ignore removed files; use `--no-all` option if you want
-	to add modified or new files but ignore removed	ones.
+	to add modified or new files but ignore removed ones.
 +
 For more details about the <pathspec> syntax, see the 'pathspec' entry
 in linkgit:gitglossary[7].
@@ -124,7 +124,7 @@ subdirectories).
 --no-ignore-removal::
 	Update the index not only where the working tree has a file
 	matching <pathspec> but also where the index already has an
-	entry.	This adds, modifies, and removes index entries to
+	entry. This adds, modifies, and removes index entries to
 	match the working tree.
 +
 If no <pathspec> is given when `-A` option is used, all
@@ -206,7 +206,7 @@ EXAMPLES
 --------
 
 * Adds content from all `*.txt` files under `Documentation` directory
-and its subdirectories:
+  and its subdirectories:
 +
 ------------
 $ git add Documentation/\*.txt
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bf5316ffa9..3bd83a7cbd 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -297,7 +297,7 @@ $ git checkout my2.6.14
 ------------
 +
 <1> This step and the next one could be combined into a single step with
-"checkout -b my2.6.14 v2.6.14".
+    "checkout -b my2.6.14 v2.6.14".
 
 Delete an unneeded branch::
 +
@@ -309,10 +309,10 @@ $ git branch -D test                                    <2>
 ------------
 +
 <1> Delete the remote-tracking branches "todo", "html" and "man". The next
-'fetch' or 'pull' will create them again unless you configure them not to.
-See linkgit:git-fetch[1].
+    'fetch' or 'pull' will create them again unless you configure them not to.
+    See linkgit:git-fetch[1].
 <2> Delete the "test" branch even if the "master" branch (or whichever branch
-is currently checked out) does not have all commits from the test branch.
+    is currently checked out) does not have all commits from the test branch.
 
 
 NOTES
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ce7d38b8b7..f8dc7ad180 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -434,14 +434,14 @@ $ git tag foo           <3>
 ------------
 
 <1> creates a new branch 'foo', which refers to commit 'f', and then
-updates HEAD to refer to branch 'foo'. In other words, we'll no longer
-be in detached HEAD state after this command.
+    updates HEAD to refer to branch 'foo'. In other words, we'll no longer
+    be in detached HEAD state after this command.
 
 <2> similarly creates a new branch 'foo', which refers to commit 'f',
-but leaves HEAD detached.
+    but leaves HEAD detached.
 
 <3> creates a new tag 'foo', which refers to commit 'f',
-leaving HEAD detached.
+    leaving HEAD detached.
 
 If we have moved away from commit 'f', then we must first recover its object
 name (typically by using git reflog), and then we can create a reference to
@@ -469,8 +469,8 @@ EXAMPLES
 --------
 
 . The following sequence checks out the `master` branch, reverts
-the `Makefile` to two revisions back, deletes hello.c by
-mistake, and gets it back from the index.
+  the `Makefile` to two revisions back, deletes hello.c by
+  mistake, and gets it back from the index.
 +
 ------------
 $ git checkout master             <1>
@@ -504,7 +504,7 @@ $ git checkout -- hello.c
 ------------
 
 . After working in the wrong branch, switching to the correct
-branch would be done using:
+  branch would be done using:
 +
 ------------
 $ git checkout mytopic
@@ -532,7 +532,7 @@ registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
 . When a merge conflict happens during switching branches with
-the `-m` option, you would see something like this:
+  the `-m` option, you would see something like this:
 +
 ------------
 $ git checkout -m mytopic
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771fc8..b8cfeec67e 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -213,16 +213,16 @@ $ git reset --merge ORIG_HEAD        <3>
 $ git cherry-pick -Xpatience topic^  <4>
 ------------
 <1> apply the change that would be shown by `git show topic^`.
-In this example, the patch does not apply cleanly, so
-information about the conflict is written to the index and
-working tree and no new commit results.
+    In this example, the patch does not apply cleanly, so
+    information about the conflict is written to the index and
+    working tree and no new commit results.
 <2> summarize changes to be reconciled
 <3> cancel the cherry-pick.  In other words, return to the
-pre-cherry-pick state, preserving any local modifications you had in
-the working tree.
+    pre-cherry-pick state, preserving any local modifications
+    you had in the working tree.
 <4> try to apply the change introduced by `topic^` again,
-spending extra time to avoid mistakes based on incorrectly matching
-context lines.
+    spending extra time to avoid mistakes based on incorrectly
+    matching context lines.
 
 SEE ALSO
 --------
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 030f162f30..72179d993c 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -132,9 +132,9 @@ $ git diff HEAD       <3>
 +
 <1> Changes in the working tree not yet staged for the next commit.
 <2> Changes between the index and your last commit; what you
-would be committing if you run "git commit" without "-a" option.
+    would be committing if you run "git commit" without "-a" option.
 <3> Changes in the working tree since your last commit; what you
-would be committing if you run "git commit -a"
+    would be committing if you run "git commit -a"
 
 Comparing with arbitrary commits::
 +
@@ -145,10 +145,10 @@ $ git diff HEAD^ HEAD      <3>
 ------------
 +
 <1> Instead of using the tip of the current branch, compare with the
-tip of "test" branch.
+    tip of "test" branch.
 <2> Instead of comparing with the tip of "test" branch, compare with
-the tip of the current branch, but limit the comparison to the
-file "test".
+    the tip of the current branch, but limit the comparison to the
+    file "test".
 <3> Compare the version before the last commit and the last commit.
 
 Comparing branches::
@@ -162,7 +162,7 @@ $ git diff topic...master  <3>
 <1> Changes between the tips of the topic and the master branches.
 <2> Same as above.
 <3> Changes that occurred on the master branch since when the topic
-branch was started off it.
+    branch was started off it.
 
 Limiting the diff output::
 +
@@ -173,9 +173,9 @@ $ git diff arch/i386 include/asm-i386   <3>
 ------------
 +
 <1> Show only modification, rename, and copy, but not addition
-or deletion.
+    or deletion.
 <2> Show only names and the nature of change, but not actual
-diff output.
+    diff output.
 <3> Limit diff output to named subtrees.
 
 Munging the diff output::
@@ -186,7 +186,7 @@ $ git diff -R                          <2>
 ------------
 +
 <1> Spend extra cycles to find renames, copies and complete
-rewrites (very expensive).
+    rewrites (very expensive).
 <2> Output diff in reverse.
 
 SEE ALSO
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e319935597..266d63cf11 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -266,7 +266,7 @@ The `pu` branch will be updated even if it is does not fast-forward,
 because it is prefixed with a plus sign; `tmp` will not be.
 
 * Peek at a remote's branch, without configuring the remote in your local
-repository:
+  repository:
 +
 ------------------------------------------------
 $ git fetch git://git.kernel.org/pub/scm/git/git.git maint
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 27304428a1..1af85d404f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -504,9 +504,9 @@ Toggle it to make sure it is set to `false`. Also, search for
 "mailnews.wraplength" and set the value to 0.
 
 3. Disable the use of format=flowed:
-Edit..Preferences..Advanced..Config Editor.  Search for
-"mailnews.send_plaintext_flowed".
-Toggle it to make sure it is set to `false`.
+   Edit..Preferences..Advanced..Config Editor.  Search for
+   "mailnews.send_plaintext_flowed".
+   Toggle it to make sure it is set to `false`.
 
 After that is done, you should be able to compose email as you
 otherwise would (cut + paste, 'git format-patch' | 'git imap-send', etc),
@@ -629,14 +629,14 @@ EXAMPLES
 --------
 
 * Extract commits between revisions R1 and R2, and apply them on top of
-the current branch using 'git am' to cherry-pick them:
+  the current branch using 'git am' to cherry-pick them:
 +
 ------------
 $ git format-patch -k --stdout R1..R2 | git am -3 -k
 ------------
 
 * Extract all commits which are in the current branch but not in the
-origin branch:
+  origin branch:
 +
 ------------
 $ git format-patch origin
@@ -645,7 +645,7 @@ $ git format-patch origin
 For each commit a separate file is created in the current directory.
 
 * Extract all commits that lead to 'origin' since the inception of the
-project:
+  project:
 +
 ------------
 $ git format-patch --root origin
@@ -664,7 +664,7 @@ Note that non-Git "patch" programs won't understand renaming patches, so
 use it only when you know the recipient uses Git to apply your patch.
 
 * Extract three topmost commits from the current branch and format them
-as e-mailable patches:
+  as e-mailable patches:
 +
 ------------
 $ git format-patch -3
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index aab5453bbb..c318bf87e1 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -118,9 +118,9 @@ format is chosen. The following values are currently supported:
 
 * "man": use the 'man' program as usual,
 * "woman": use 'emacsclient' to launch the "woman" mode in emacs
-(this only works starting with emacsclient versions 22),
+  (this only works starting with emacsclient versions 22),
 * "konqueror": use 'kfmclient' to open the man page in a new konqueror
-tab (see 'Note about konqueror' below).
+  tab (see 'Note about konqueror' below).
 
 Values for other tools can be used if there is a corresponding
 `man.<tool>.cmd` configuration entry (see below).
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f0a0280954..3494a1db3e 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -71,12 +71,12 @@ $ git p4 clone //depot/path/project
 ------------
 This:
 
-1.   Creates an empty Git repository in a subdirectory called 'project'.
+1. Creates an empty Git repository in a subdirectory called 'project'.
 +
-2.   Imports the full contents of the head revision from the given p4
-depot path into a single commit in the Git branch 'refs/remotes/p4/master'.
+2. Imports the full contents of the head revision from the given p4
+   depot path into a single commit in the Git branch 'refs/remotes/p4/master'.
 +
-3.   Creates a local branch, 'master' from this remote and checks it out.
+3. Creates a local branch, 'master' from this remote and checks it out.
 
 To reproduce the entire p4 history in Git, use the '@all' modifier on
 the depot path:
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 9f69ae8b69..132f8e55f6 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -115,17 +115,17 @@ $ git pull git://info.example.com/ nitfol  <4>
 ------------
 +
 <1> You are happily working on something, and find the changes
-in these files are in good order.  You do not want to see them
-when you run `git diff`, because you plan to work on other files
-and changes with these files are distracting.
+    in these files are in good order.  You do not want to see them
+    when you run `git diff`, because you plan to work on other files
+    and changes with these files are distracting.
 <2> Somebody asks you to pull, and the changes sound worthy of merging.
 <3> However, you already dirtied the index (i.e. your index does
-not match the `HEAD` commit).  But you know the pull you are going
-to make does not affect `frotz.c` or `filfre.c`, so you revert the
-index changes for these two files.  Your changes in working tree
-remain there.
+    not match the `HEAD` commit).  But you know the pull you are going
+    to make does not affect `frotz.c` or `filfre.c`, so you revert the
+    index changes for these two files.  Your changes in working tree
+    remain there.
 <4> Then you can pull and merge, leaving `frotz.c` and `filfre.c`
-changes still in the working tree.
+    changes still in the working tree.
 
 Undo a commit and redo::
 +
@@ -137,12 +137,12 @@ $ git commit -a -c ORIG_HEAD  <3>
 ------------
 +
 <1> This is most often done when you remembered what you
-just committed is incomplete, or you misspelled your commit
-message, or both.  Leaves working tree as it was before "reset".
+    just committed is incomplete, or you misspelled your commit
+    message, or both.  Leaves working tree as it was before "reset".
 <2> Make corrections to working tree files.
 <3> "reset" copies the old head to `.git/ORIG_HEAD`; redo the
-commit by starting with its log message.  If you do not need to
-edit the message further, you can give `-C` option instead.
+    commit by starting with its log message.  If you do not need to
+    edit the message further, you can give `-C` option instead.
 +
 See also the `--amend` option to linkgit:git-commit[1].
 
@@ -155,9 +155,9 @@ $ git checkout topic/wip   <3>
 ------------
 +
 <1> You have made some commits, but realize they were premature
-to be in the `master` branch.  You want to continue polishing
-them in a topic branch, so create `topic/wip` branch off of the
-current `HEAD`.
+    to be in the `master` branch.  You want to continue polishing
+    them in a topic branch, so create `topic/wip` branch off of the
+    current `HEAD`.
 <2> Rewind the master branch to get rid of those three commits.
 <3> Switch to `topic/wip` branch and keep working.
 
@@ -169,10 +169,10 @@ $ git reset --hard HEAD~3   <1>
 ------------
 +
 <1> The last three commits (`HEAD`, `HEAD^`, and `HEAD~2`) were bad
-and you do not want to ever see them again.  Do *not* do this if
-you have already given these commits to somebody else.  (See the
-"RECOVERING FROM UPSTREAM REBASE" section in linkgit:git-rebase[1] for
-the implications of doing so.)
+    and you do not want to ever see them again.  Do *not* do this if
+    you have already given these commits to somebody else.  (See the
+    "RECOVERING FROM UPSTREAM REBASE" section in linkgit:git-rebase[1]
+    for the implications of doing so.)
 
 Undo a merge or pull::
 +
@@ -189,18 +189,18 @@ $ git reset --hard ORIG_HEAD       <4>
 ------------
 +
 <1> Try to update from the upstream resulted in a lot of
-conflicts; you were not ready to spend a lot of time merging
-right now, so you decide to do that later.
+    conflicts; you were not ready to spend a lot of time merging
+    right now, so you decide to do that later.
 <2> "pull" has not made merge commit, so `git reset --hard`
-which is a synonym for `git reset --hard HEAD` clears the mess
-from the index file and the working tree.
+    which is a synonym for `git reset --hard HEAD` clears the mess
+    from the index file and the working tree.
 <3> Merge a topic branch into the current branch, which resulted
-in a fast-forward.
+    in a fast-forward.
 <4> But you decided that the topic branch is not ready for public
-consumption yet.  "pull" or "merge" always leaves the original
-tip of the current branch in `ORIG_HEAD`, so resetting hard to it
-brings your index file and the working tree back to that state,
-and resets the tip of the branch to that commit.
+    consumption yet.  "pull" or "merge" always leaves the original
+    tip of the current branch in `ORIG_HEAD`, so resetting hard to it
+    brings your index file and the working tree back to that state,
+    and resets the tip of the branch to that commit.
 
 Undo a merge or pull inside a dirty working tree::
 +
@@ -214,14 +214,14 @@ $ git reset --merge ORIG_HEAD      <2>
 ------------
 +
 <1> Even if you may have local modifications in your
-working tree, you can safely say `git pull` when you know
-that the change in the other branch does not overlap with
-them.
+    working tree, you can safely say `git pull` when you know
+    that the change in the other branch does not overlap with
+    them.
 <2> After inspecting the result of the merge, you may find
-that the change in the other branch is unsatisfactory.  Running
-`git reset --hard ORIG_HEAD` will let you go back to where you
-were, but it will discard your local changes, which you do not
-want.  `git reset --merge` keeps your local changes.
+    that the change in the other branch is unsatisfactory.  Running
+    `git reset --hard ORIG_HEAD` will let you go back to where you
+    were, but it will discard your local changes, which you do not
+    want.  `git reset --merge` keeps your local changes.
 
 
 Interrupted workflow::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 62c6c76f27..1afe9fc858 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -33,7 +33,7 @@ This is what linkgit:git-format-patch[1] generates.  Most headers and MIME
 formatting are ignored.
 
 2. The original format used by Greg Kroah-Hartman's 'send_lots_of_email.pl'
-script
+   script
 +
 This format expects the first line of the file to contain the "Cc:" value
 and the "Subject:" of the message as the second line.
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index f2d644e3af..a74e7b926d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -237,16 +237,16 @@ your repository directly), then others will have already seen
 the old tag. In that case you can do one of two things:
 
 . The sane thing.
-Just admit you screwed up, and use a different name. Others have
-already seen one tag-name, and if you keep the same name, you
-may be in the situation that two people both have "version X",
-but they actually have 'different' "X"'s.  So just call it "X.1"
-and be done with it.
+  Just admit you screwed up, and use a different name. Others have
+  already seen one tag-name, and if you keep the same name, you
+  may be in the situation that two people both have "version X",
+  but they actually have 'different' "X"'s.  So just call it "X.1"
+  and be done with it.
 
 . The insane thing.
-You really want to call the new version "X" too, 'even though'
-others have already seen the old one. So just use 'git tag -f'
-again, as if you hadn't already published the old one.
+  You really want to call the new version "X" too, 'even though'
+  others have already seen the old one. So just use 'git tag -f'
+  again, as if you hadn't already published the old one.
 
 However, Git does *not* (and it should not) change tags behind
 users back. So if somebody already got the old tag, doing a
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 998f52d3df..9822c1eb1a 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -22,7 +22,6 @@ The UI for the protocol is on the 'git fetch-pack' side, and the
 program pair is meant to be used to pull updates from a remote
 repository.  For push operations, see 'git send-pack'.
 
-
 OPTIONS
 -------
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 91b3a72bda..8a4867998e 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -270,13 +270,13 @@ depending on a few rules:
 +
 --
 1. If the starting point is specified as `ref@{Nth}`, show the index
-format.
+   format.
 +
 2. If the starting point was specified as `ref@{now}`, show the
-timestamp format.
+   timestamp format.
 +
 3. If neither was used, but `--date` was given on the command line, show
-the timestamp in the format requested by `--date`.
+   the timestamp in the format requested by `--date`.
 +
 4. Otherwise, show the index format.
 --
-- 
2.20.1

