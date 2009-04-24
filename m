From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] Documentation: replace sha1 by SHA-1
Date: Fri, 24 Apr 2009 16:49:34 +0200
Message-ID: <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 16:52:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxMlV-0005Ku-7g
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 16:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390AbZDXOtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 10:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756659AbZDXOtv
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 10:49:51 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39030 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756525AbZDXOtq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 10:49:46 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A305C3228A0;
	Fri, 24 Apr 2009 10:49:45 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 24 Apr 2009 10:49:45 -0400
X-Sasl-enc: O3pEPrE1kAjiwyb3CmN/1dg82mzBWd6qqPvm6LDDsnK0 1240584584
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B18D13CE9E;
	Fri, 24 Apr 2009 10:49:44 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.51.gea0b7
In-Reply-To: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117446>

Replace sha1 by SHA-1 with the following exceptions:

* code samples
* irc conversations contained as documentation
  (Documentation/technical/pack-heuristics.txt)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/diff-format.txt               |    8 +++---
 Documentation/git-blame.txt                 |    4 +-
 Documentation/git-branch.txt                |    8 +++---
 Documentation/git-cat-file.txt              |    4 +-
 Documentation/git-cherry.txt                |    4 +-
 Documentation/git-cvsexportcommit.txt       |    4 +-
 Documentation/git-diff-index.txt            |    8 +++---
 Documentation/git-filter-branch.txt         |    6 ++--
 Documentation/git-fsck.txt                  |    8 +++---
 Documentation/git-init.txt                  |    2 +-
 Documentation/git-mktag.txt                 |    2 +-
 Documentation/git-name-rev.txt              |    2 +-
 Documentation/git-receive-pack.txt          |   32 +++++++++++++-------------
 Documentation/git-reflog.txt                |    4 +-
 Documentation/git-svn.txt                   |    4 +-
 Documentation/git-unpack-file.txt           |    2 +-
 Documentation/git-update-index.txt          |   12 +++++-----
 Documentation/git-update-ref.txt            |    8 +++---
 Documentation/git.txt                       |    2 +-
 Documentation/howto/update-hook-example.txt |    6 ++--
 Documentation/pretty-formats.txt            |   14 ++++++------
 21 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 1eeb1c7..53da361 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -35,9 +35,9 @@ That is, from the left to the right:
 . a space.
 . mode for "dst"; 000000 if deletion or unmerged.
 . a space.
-. sha1 for "src"; 0\{40\} if creation or unmerged.
+. SHA-1 for "src"; 0\{40\} if creation or unmerged.
 . a space.
-. sha1 for "dst"; 0\{40\} if creation, unmerged or "look at work tree".
+. SHA-1 for "dst"; 0\{40\} if creation, unmerged or "look at work tree".
 . a space.
 . status, followed by optional "score" number.
 . a tab or a NUL when '-z' option is used.
@@ -62,7 +62,7 @@ Status letters C and R are always followed by a score (denoting the
 percentage of similarity between the source and target of the move or
 copy), and are the only ones to be so.
 
-<sha1> is shown as all 0's if a file is new on the filesystem
+<SHA-1> is shown as all 0's if a file is new on the filesystem
 and it is out of sync with the index.
 
 Example:
@@ -84,7 +84,7 @@ to generate diff output also for merge commits.  The output differs
 from the format described above in the following way:
 
 . there is a colon for each parent
-. there are more "src" modes and "src" sha1
+. there are more "src" modes and "src" SHA-1
 . status is concatenated status characters for each parent
 . no optional "score" number
 . single path, only for "dst"
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 8c7b7b0..139a05f 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -158,7 +158,7 @@ annotated.
 
 . Each blame entry always starts with a line of:
 
-	<40-byte hex sha1> <sourceline> <resultline> <num_lines>
+	<40-byte hex SHA-1> <sourceline> <resultline> <num_lines>
 +
 Line numbers count from 1.
 
@@ -177,7 +177,7 @@ parser (which should be quite natural for most scripting languages).
 +
 [NOTE]
 For people who do parsing: to make it more robust, just ignore any
-lines between the first and last one ("<sha1>" and "filename" lines)
+lines between the first and last one ("<SHA-1>" and "filename" lines)
 where you do not recognize the tag words (or care about that particular
 one) at the beginning of the "extended information" lines. That way, if
 there is ever added information (like the commit encoding or extended
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index cbd4275..15650c8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -73,7 +73,7 @@ OPTIONS
 -l::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
-	based sha1 expressions such as "<branchname>@\{yesterday}".
+	based SHA-1 expressions such as "<branchname>@\{yesterday}".
 
 -f::
 	Reset <branchname> to <startpoint> if <branchname> exists
@@ -100,16 +100,16 @@ OPTIONS
 
 -v::
 --verbose::
-	Show sha1 and commit subject line for each head, along with
+	Show SHA-1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
 	the name of the upstream branch, as well.
 
 --abbrev=<length>::
-	Alter the sha1's minimum display length in the output listing.
+	Alter the SHA-1's minimum display length in the output listing.
 	The default value is 7.
 
 --no-abbrev::
-	Display the full sha1s in the output listing rather than abbreviating them.
+	Display the full SHA-1s in the output listing rather than abbreviating them.
 
 --track::
 	When creating a new branch, set up configuration to mark the
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index b191276..db56d6e 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -76,7 +76,7 @@ If '--batch' is specified, output of the following form is printed for each
 object specified on stdin:
 
 ------------
-<sha1> SP <type> SP <size> LF
+<SHA-1> SP <type> SP <size> LF
 <contents> LF
 ------------
 
@@ -84,7 +84,7 @@ If '--batch-check' is specified, output of the following form is printed for
 each object specified on stdin:
 
 ------------
-<sha1> SP <type> SP <size> LF
+<SHA-1> SP <type> SP <size> LF
 ------------
 
 For both '--batch' and '--batch-check', output of the following form is printed
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 7deefda..b6fd758 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -17,7 +17,7 @@ The commits are compared with their 'patch id', obtained from
 the 'git-patch-id' program.
 
 Every commit that doesn't exist in the <upstream> branch
-has its id (sha1) reported, prefixed by a symbol.  The ones that have
+has its id (SHA-1) reported, prefixed by a symbol.  The ones that have
 equivalent change already
 in the <upstream> branch are prefixed with a minus (-) sign, and those
 that only exist in the <head> branch are prefixed with a plus (+) symbol:
@@ -38,7 +38,7 @@ to and including <limit> are not reported:
 
 
 Because 'git-cherry' compares the changeset rather than the commit id
-(sha1), you can use 'git-cherry' to find out if a commit you made locally
+(SHA-1), you can use 'git-cherry' to find out if a commit you made locally
 has been applied <upstream> under a different commit id.  For example,
 this will happen if you're feeding patches <upstream> via email rather
 than pushing or pulling commits directly.
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 2da8588..01d69bf 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -90,14 +90,14 @@ Merge one patch into CVS::
 ------------
 $ export GIT_DIR=~/project/.git
 $ cd ~/project_cvs_checkout
-$ git cvsexportcommit -v <commit-sha1>
+$ git cvsexportcommit -v <commit-SHA-1>
 $ cvs commit -F .msg <files>
 ------------
 
 Merge one patch into CVS (-c and -w options). The working directory is within the Git Repo::
 +
 ------------
-	$ git cvsexportcommit -v -c -w ~/project_cvs_checkout <commit-sha1>
+	$ git cvsexportcommit -v -c -w ~/project_cvs_checkout <commit-SHA-1>
 ------------
 
 Merge pending patches into CVS automatically -- only if you really know what you are doing::
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 26920d4..cc34cb8 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -93,7 +93,7 @@ you *could* commit. Again, the output matches the 'git-diff-tree -r'
 output to a tee, but with a twist.
 
 The twist is that if some file doesn't match the index, we don't have
-a backing store thing for it, and we use the magic "all-zero" sha1 to
+a backing store thing for it, and we use the magic "all-zero" SHA-1 to
 show that. So let's say that you have edited `kernel/sched.c`, but
 have not actually done a 'git-update-index' on it yet - there is no
 "object" associated with the new state, and you get:
@@ -102,7 +102,7 @@ have not actually done a 'git-update-index' on it yet - there is no
   *100644->100664 blob    7476bb......->000000......      kernel/sched.c
 
 i.e., it shows that the tree has changed, and that `kernel/sched.c` has is
-not up-to-date and may contain new stuff. The all-zero sha1 means that to
+not up-to-date and may contain new stuff. The all-zero SHA-1 means that to
 get the real diff, you need to look at the object in the working directory
 directly rather than do an object-to-object diff.
 
@@ -115,8 +115,8 @@ touched it. In either case, it's a note that you need to
 NOTE: You can have a mixture of files show up as "has been updated"
 and "is still dirty in the working directory" together. You can always
 tell which file is in which state, since the "has been updated" ones
-show a valid sha1, and the "not in sync with the index" ones will
-always have the special all-zero sha1.
+show a valid SHA-1, and the "not in sync with the index" ones will
+always have the special all-zero SHA-1.
 
 
 Author
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index ab527b5..e8ffe2f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -66,9 +66,9 @@ of these variables after the filters have run, are used for the new commit.
 If any evaluation of <command> returns a non-zero exit status, the whole
 operation will be aborted.
 
-A 'map' function is available that takes an "original sha1 id" argument
-and outputs a "rewritten sha1 id" if the commit has been already
-rewritten, and "original sha1 id" otherwise; the 'map' function can
+A 'map' function is available that takes an "original SHA-1 id" argument
+and outputs a "rewritten SHA-1 id" if the commit has been already
+rewritten, and "original SHA-1 id" otherwise; the 'map' function can
 return several ids on separate lines if your commit filter emitted
 multiple commits.
 
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 287c4fc..73e1dc4 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -103,8 +103,8 @@ expect dangling commits - potential heads - due to lack of head information::
 	possible to differentiate between un-parented commits and
 	root nodes.
 
-missing sha1 directory '<dir>'::
-	The directory holding the sha1 objects is missing.
+missing SHA-1 directory '<dir>'::
+	The directory holding the SHA-1 objects is missing.
 
 unreachable <type> <object>::
 	The <type> object <object>, isn't actually referred to directly
@@ -125,8 +125,8 @@ dangling <type> <object>::
 warning: git-fsck: tree <tree> has full pathnames in it::
 	And it shouldn't...
 
-sha1 mismatch <object>::
-	The database has an object who's sha1 doesn't match the
+SHA-1 mismatch <object>::
+	The database has an object who's SHA-1 doesn't match the
 	database value.
 	This indicates a serious data integrity problem.
 
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 71749c0..fb19bea 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -83,7 +83,7 @@ If the `$GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
 
 If the object storage directory is specified via the `$GIT_OBJECT_DIRECTORY`
-environment variable then the sha1 directories are created underneath -
+environment variable then the SHA-1 directories are created underneath -
 otherwise the default `$GIT_DIR/objects` directory is used.
 
 Running 'git-init' in an existing repository is safe. It will not overwrite
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 8bcc114..570dc26 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -21,7 +21,7 @@ Tag Format
 ----------
 A tag signature file has a very simple fixed format: four lines of
 
-  object <sha1>
+  object <SHA-1>
   type <typename>
   tag <tagname>
   tagger <tagger>
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 7ca8a7b..519d6a9 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -31,7 +31,7 @@ OPTIONS
 	List all commits reachable from all refs
 
 --stdin::
-	Read from stdin, append "(<rev_name>)" to all sha1's of nameable
+	Read from stdin, append "(<rev_name>)" to all SHA-1s of nameable
 	commits, and pass to stdout
 
 --name-only::
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 514f03c..d357024 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -20,7 +20,7 @@ The UI for the protocol is on the 'git-send-pack' side, and the
 program pair is meant to be used to push updates to remote
 repository.  For pull operations, see linkgit:git-fetch-pack[1].
 
-The command allows for creation and fast forwarding of sha1 refs
+The command allows for creation and fast forwarding of SHA-1 refs
 (heads/tags) on the remote end (strictly speaking, it is the
 local end 'git-receive-pack' runs, but to the user who is sitting at
 the send-pack end, it is updating the remote.  Confused?)
@@ -43,14 +43,14 @@ Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
 and is executable, it will be invoked once with no parameters.  The
 standard input of the hook will be one line per ref to be updated:
 
-       sha1-old SP sha1-new SP refname LF
+       SHA-1-old SP SHA-1-new SP refname LF
 
 The refname value is relative to $GIT_DIR; e.g. for the master
-head this is "refs/heads/master".  The two sha1 values before
+head this is "refs/heads/master".  The two SHA-1 values before
 each refname are the object names for the refname before and after
-the update.  Refs to be created will have sha1-old equal to 0\{40},
-while refs to be deleted will have sha1-new equal to 0\{40}, otherwise
-sha1-old and sha1-new should be valid objects in the repository.
+the update.  Refs to be created will have SHA-1-old equal to 0\{40},
+while refs to be deleted will have SHA-1-new equal to 0\{40}, otherwise
+SHA-1-old and SHA-1-new should be valid objects in the repository.
 
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
@@ -65,13 +65,13 @@ update Hook
 Before each ref is updated, if $GIT_DIR/hooks/update file exists
 and is executable, it is invoked once per ref, with three parameters:
 
-       $GIT_DIR/hooks/update refname sha1-old sha1-new
+       $GIT_DIR/hooks/update refname SHA-1-old SHA-1-new
 
 The refname parameter is relative to $GIT_DIR; e.g. for the master
-head this is "refs/heads/master".  The two sha1 arguments are
+head this is "refs/heads/master".  The two SHA-1 arguments are
 the object names for the refname before and after the update.
 Note that the hook is called before the refname is updated,
-so either sha1-old is 0\{40} (meaning there is no such ref yet),
+so either SHA-1-old is 0\{40} (meaning there is no such ref yet),
 or it should match what is recorded in refname.
 
 The hook should exit with non-zero status if it wants to disallow
@@ -90,14 +90,14 @@ file exists and is executable, it will be invoked once with no
 parameters.  The standard input of the hook will be one line
 for each successfully updated ref:
 
-       sha1-old SP sha1-new SP refname LF
+       SHA-1-old SP SHA-1-new SP refname LF
 
 The refname value is relative to $GIT_DIR; e.g. for the master
-head this is "refs/heads/master".  The two sha1 values before
+head this is "refs/heads/master".  The two SHA-1 values before
 each refname are the object names for the refname before and after
-the update.  Refs that were created will have sha1-old equal to
-0\{40}, while refs that were deleted will have sha1-new equal to
-0\{40}, otherwise sha1-old and sha1-new should be valid objects in
+the update.  Refs that were created will have SHA-1-old equal to
+0\{40}, while refs that were deleted will have SHA-1-new equal to
+0\{40}, otherwise SHA-1-old and SHA-1-new should be valid objects in
 the repository.
 
 Using this hook, it is easy to generate mails describing the updates
@@ -123,10 +123,10 @@ ref listing the commits pushed to the repository:
 The exit code from this hook invocation is ignored, however a
 non-zero exit code will generate an error message.
 
-Note that it is possible for refname to not have sha1-new when this
+Note that it is possible for refname to not have SHA-1-new when this
 hook runs.  This can easily occur if another user modifies the ref
 after it was updated by 'git-receive-pack', but before the hook was able
-to evaluate it.  It is recommended that hooks rely on sha1-new
+to evaluate it.  It is recommended that hooks rely on SHA-1-new
 rather than the current value of refname.
 
 post-update Hook
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 7f7a544..8d3d2e2 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -81,12 +81,12 @@ them.
 	Instead of listing <refs> explicitly, prune all refs.
 
 --updateref::
-	Update the ref with the sha1 of the top reflog entry (i.e.
+	Update the ref with the SHA-1 of the top reflog entry (i.e.
 	<ref>@\{0\}) after expiring or deleting.
 
 --rewrite::
 	While expiring or deleting, adjust each reflog entry to ensure
-	that the `old` sha1 field points to the `new` sha1 field of the
+	that the `old` SHA-1 field points to the `new` SHA-1 field of the
 	previous entry.
 
 --verbose::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 9229d45..f5be417 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -232,7 +232,7 @@ New features:
 +
 --
 --show-commit;;
-	shows the git commit sha1, as well
+	shows the git commit SHA-1, as well
 --oneline;;
 	our version of --pretty=oneline
 --
@@ -343,7 +343,7 @@ and lost.
 Only used with the 'set-tree' command.
 
 Read a list of commits from stdin and commit them in reverse
-order.  Only the leading sha1 is read from each line, so
+order.  Only the leading SHA-1 is read from each line, so
 'git-rev-list --pretty=oneline' output can be used.
 
 --rmdir::
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index 995db9f..799e5b4 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Creates a file holding the contents of the blob specified by sha1. It
+Creates a file holding the contents of the blob specified by SHA-1. It
 returns the name of the temporary file in the following format:
 	.merge_file_XXXXX
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 25e0bbe..ab98949 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -149,7 +149,7 @@ you will need to handle the situation manually.
 
 Using --refresh
 ---------------
-'--refresh' does not calculate a new sha1 file or bring the index
+'--refresh' does not calculate a new SHA-1 file or bring the index
 up-to-date for mode/content changes. But what it *does* do is to
 "re-match" the stat information of a file with the index, so that you
 can refresh the index for a file that hasn't been changed but where
@@ -164,10 +164,10 @@ Using --cacheinfo or --info-only
 current working directory.  This is useful for minimum-checkout
 merging.
 
-To pretend you have a file with mode and sha1 at path, say:
+To pretend you have a file with mode and SHA-1 at path, say:
 
 ----------------
-$ git update-index --cacheinfo mode sha1 path
+$ git update-index --cacheinfo mode SHA-1 path
 ----------------
 
 '--info-only' is used to register files without placing them in the object
@@ -187,19 +187,19 @@ Using --index-info
 multiple entry definitions from the standard input, and designed
 specifically for scripts.  It can take inputs of three formats:
 
-    . mode         SP sha1          TAB path
+    . mode         SP SHA-1          TAB path
 +
 The first format is what "git-apply --index-info"
 reports, and used to reconstruct a partial tree
 that is used for phony merge base tree when falling
 back on 3-way merge.
 
-    . mode SP type SP sha1          TAB path
+    . mode SP type SP SHA-1          TAB path
 +
 The second format is to stuff 'git-ls-tree' output
 into the index file.
 
-    . mode         SP sha1 SP stage TAB path
+    . mode         SP SHA-1 SP stage TAB path
 +
 This format is to put higher order stages into the
 index file and matches 'git-ls-files --stage' output.
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 9639f70..7b7492a 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -66,16 +66,16 @@ a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
 symbolic refs before creating the log name) describing the change
 in ref value.  Log lines are formatted as:
 
-    . oldsha1 SP newsha1 SP committer LF
+    . SHA-1-old SP SHA-1-new SP committer LF
 +
-Where "oldsha1" is the 40 character hexadecimal value previously
-stored in <ref>, "newsha1" is the 40 character hexadecimal value of
+Where "SHA-1-old" is the 40 character hexadecimal value previously
+stored in <ref>, "SHA-1-new" is the 40 character hexadecimal value of
 <newvalue> and "committer" is the committer's name, email address
 and date in the standard GIT committer ident format.
 
 Optionally with -m:
 
-    . oldsha1 SP newsha1 SP committer TAB message LF
+    . SHA-1-old SP SHA-1-new SP committer TAB message LF
 +
 Where all fields are as described above and "message" is the
 value supplied to the -m option.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 470fdc5..5d2d5b7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -443,7 +443,7 @@ git so take care if using Cogito etc.
 
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
-	environment variable then the sha1 directories are created
+	environment variable then the SHA-1 directories are created
 	underneath - otherwise the default `$GIT_DIR/objects`
 	directory is used.
 
diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index 697d918..baa6484 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -14,13 +14,13 @@ section of the documentation:
     Before each ref is updated, if $GIT_DIR/hooks/update file exists
     and executable, it is called with three parameters:
 
-           $GIT_DIR/hooks/update refname sha1-old sha1-new
+           $GIT_DIR/hooks/update refname SHA-1-old SHA-1-new
 
     The refname parameter is relative to $GIT_DIR; e.g. for the
-    master head this is "refs/heads/master".  Two sha1 are the
+    master head this is "refs/heads/master".  Two SHA-1 are the
     object names for the refname before and after the update.  Note
     that the hook is called before the refname is updated, so either
-    sha1-old is 0{40} (meaning there is no such ref yet), or it
+    SHA-1-old is 0{40} (meaning there is no such ref yet), or it
     should match what is recorded in refname.
 
 So if your policy is (1) always require fast-forward push
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2a845b1..fac8ebd 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -4,7 +4,7 @@ PRETTY FORMATS
 If the commit is a merge, and if the pretty-format
 is not 'oneline', 'email' or 'raw', an additional line is
 inserted before the 'Author:' line.  This line begins with
-"Merge: " and the sha1s of ancestral commits are printed,
+"Merge: " and the SHA-1s of ancestral commits are printed,
 separated by spaces.  Note that the listed commits may not
 necessarily be the list of the *direct* parent commits if you
 have limited your view of history: for example, if you are
@@ -15,20 +15,20 @@ Here are some additional details for each format:
 
 * 'oneline'
 
-	  <sha1> <title line>
+	  <SHA-1> <title line>
 +
 This is designed to be as compact as possible.
 
 * 'short'
 
-	  commit <sha1>
+	  commit <SHA-1>
 	  Author: <author>
 
 	      <title line>
 
 * 'medium'
 
-	  commit <sha1>
+	  commit <SHA-1>
 	  Author: <author>
 	  Date:   <author date>
 
@@ -38,7 +38,7 @@ This is designed to be as compact as possible.
 
 * 'full'
 
-	  commit <sha1>
+	  commit <SHA-1>
 	  Author: <author>
 	  Commit: <committer>
 
@@ -48,7 +48,7 @@ This is designed to be as compact as possible.
 
 * 'fuller'
 
-	  commit <sha1>
+	  commit <SHA-1>
 	  Author:     <author>
 	  AuthorDate: <author date>
 	  Commit:     <committer>
@@ -60,7 +60,7 @@ This is designed to be as compact as possible.
 
 * 'email'
 
-	  From <sha1> <date>
+	  From <SHA-1> <date>
 	  From: <author>
 	  Date: <author date>
 	  Subject: [PATCH] <title line>
-- 
1.6.3.rc1.51.gea0b7
