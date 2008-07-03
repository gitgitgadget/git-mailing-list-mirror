From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 13/15] manpages: italicize nongit command names (if they are
 in teletype font)
Date: Thu, 3 Jul 2008 00:55:07 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030050110.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Jon Loeliger <jdl@jdl.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7s-0002yW-In
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbYGCG7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbYGCG6M
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:12 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:52853 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbYGCF4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:56:12 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635t8sr024233;
	Thu, 3 Jul 2008 00:55:08 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635t7AB019589;
	Thu, 3 Jul 2008 00:55:07 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87251>

Some manual pages use teletype font to set command names. We
change them to use italics, instead.  This creates a visual
distinction between names of commands and command lines that
can be typed at the command line. It is also more consistent
with other man pages outside Git.

In this patch, the commands named are non-git commands like bash.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-apply.txt        |    2 +-
 Documentation/git-cvsserver.txt    |    4 ++--
 Documentation/git-fsck.txt         |    2 +-
 Documentation/git-merge-file.txt   |    4 ++--
 Documentation/git-merge-index.txt  |    4 ++--
 Documentation/git-rerere.txt       |    2 +-
 Documentation/git-svn.txt          |    2 +-
 Documentation/git.txt              |    2 +-
 Documentation/gitattributes.txt    |    6 +++---
 Documentation/gitcore-tutorial.txt |   14 +++++++-------
 Documentation/gitcvs-migration.txt |    4 ++--
 Documentation/gitdiffcore.txt      |    2 +-
 12 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f82c2ce..ca60efd 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -121,7 +121,7 @@ discouraged.
 --no-add::
 	When applying a patch, ignore additions made by the
 	patch.  This can be used to extract the common part between
-	two files by first running `diff` on them and applying
+	two files by first running 'diff' on them and applying
 	the result with this option, which would apply the
 	deletion part but not addition part.
 
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 1804701..2aacdc6 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -115,7 +115,7 @@ This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
 variable.  SSH users restricted to 'git-shell' don't need to override the default
 with CVS_SERVER (and shouldn't) as 'git-shell' understands `cvs` to mean
-'git-cvsserver' and pretends that the other end runs the real `cvs` better.
+'git-cvsserver' and pretends that the other end runs the real 'cvs' better.
 --
 2. For each repo that you want accessible from CVS you need to edit config in
    the repo and add the following section.
@@ -328,7 +328,7 @@ is left blank. But if `gitcvs.allbinary` is set to "guess", then
 the correct '-k' mode will be guessed based on the contents of
 the file.
 
-For best consistency with `cvs`, it is probably best to override the
+For best consistency with 'cvs', it is probably best to override the
 defaults by setting `gitcvs.usecrlfattr` to true,
 and `gitcvs.allbinary` to "guess".
 
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 524e0b1..d5a7647 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -87,7 +87,7 @@ sorted properly etc), but on the whole if 'git-fsck' is happy, you
 do have a valid tree.
 
 Any corrupt objects you will have to find in backups or other archives
-(i.e., you can just remove them and do an `rsync` with some other site in
+(i.e., you can just remove them and do an 'rsync' with some other site in
 the hopes that somebody else has the object you have corrupted).
 
 Of course, "valid tree" doesn't mean that it wasn't generated by some
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 4ae4bdc..a11c475 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -42,8 +42,8 @@ lines from `<other-file>` respectively.
 The exit value of this program is negative on error, and the number of
 conflicts otherwise. If the merge was clean, the exit value is 0.
 
-'git-merge-file' is designed to be a minimal clone of RCS `merge`; that is, it
-implements all of RCS merge's functionality which is needed by
+'git-merge-file' is designed to be a minimal clone of RCS 'merge'; that is, it
+implements all of RCS 'merge''s functionality which is needed by
 linkgit:git[1].
 
 
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 5ebed57..ff088c5 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -47,9 +47,9 @@ A sample script called 'git-merge-one-file' is included in the
 distribution.
 
 ALERT ALERT ALERT! The git "merge object order" is different from the
-RCS `merge` program merge object order. In the above ordering, the
+RCS 'merge' program merge object order. In the above ordering, the
 original is first. But the argument order to the 3-way merge program
-`merge` is to have the original in the middle. Don't ask me why.
+'merge' is to have the original in the middle. Don't ask me why.
 
 Examples:
 
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 666349d..678bfd3 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -45,7 +45,7 @@ will automatically invoke this command.
 This displays diffs for the current state of the resolution.  It is
 useful for tracking what has changed while the user is resolving
 conflicts.  Additional arguments are passed directly to the system
-`diff` command installed in PATH.
+'diff' command installed in PATH.
 
 'status'::
 
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index dd12335..dc5b8f6 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -565,7 +565,7 @@ branch.
 
 'git-clone' does not clone branches under the refs/remotes/ hierarchy or
 any 'git-svn' metadata, or config.  So repositories created and managed with
-using 'git-svn' should use `rsync` for cloning, if cloning is to be done
+using 'git-svn' should use 'rsync' for cloning, if cloning is to be done
 at all.
 
 Since 'dcommit' uses rebase internally, any git branches you 'git-push' to
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 992a46d..4d54791 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -493,7 +493,7 @@ other
 'GIT_SSH'::
 	If this environment variable is set then 'git-fetch'
 	and 'git-push' will use this command instead
-	of `ssh` when they need to connect to a remote system.
+	of 'ssh' when they need to connect to a remote system.
 	The '$GIT_SSH' command will be given exactly two arguments:
 	the 'username@host' (or just 'host') from the URL and the
 	shell command to execute on that remote system.
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 0b53044..6a246eb 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -278,7 +278,7 @@ is prefixed with a line of the form:
 
 The text is called 'hunk header', and by default a line that
 begins with an alphabet, an underscore or a dollar sign is used,
-which matches what GNU `diff -p` output uses.  This default
+which matches what GNU 'diff -p' output uses.  This default
 selection however is not suited for some contents, and you can
 use customized pattern to make a selection.
 
@@ -322,7 +322,7 @@ and other programs such as `git revert` and `git cherry-pick`.
 Set::
 
 	Built-in 3-way merge driver is used to merge the
-	contents in a way similar to `merge` command of `RCS`
+	contents in a way similar to 'merge' command of `RCS`
 	suite.  This is suitable for ordinary text files.
 
 Unset::
@@ -426,7 +426,7 @@ Checking whitespace errors
 ^^^^^^^^^^^^
 
 The `core.whitespace` configuration variable allows you to define what
-`diff` and `apply` should consider whitespace errors for all paths in
+'diff' and 'apply' should consider whitespace errors for all paths in
 the project (See linkgit:git-config[1]).  This attribute gives you finer
 control per path.
 
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 3eba973..5acdeb7 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -61,7 +61,7 @@ Initialized empty Git repository in .git/
 which is just git's way of saying that you haven't been doing anything
 strange, and that it will have created a local `.git` directory setup for
 your new project. You will now have a `.git` directory, and you can
-inspect that with `ls`. For your new empty project, it should show you
+inspect that with 'ls'. For your new empty project, it should show you
 three entries, among other things:
 
  - a file called `HEAD`, that has `ref: refs/heads/master` in it.
@@ -660,7 +660,7 @@ in the new repository to make sure that the index file is up-to-date.
 
 Note that the second point is true even across machines. You can
 duplicate a remote git repository with *any* regular copy mechanism, be it
-`scp`, `rsync` or `wget`.
+'scp', 'rsync' or 'wget'.
 
 When copying a remote repository, you'll want to at a minimum update the
 index cache when you do this, and especially with other peoples'
@@ -1066,9 +1066,9 @@ most efficient way to exchange git objects between repositories.
 Local directory::
 	`/path/to/repo.git/`
 +
-This transport is the same as SSH transport but uses `sh` to run
+This transport is the same as SSH transport but uses 'sh' to run
 both ends on the local machine instead of running other end on
-the remote machine via `ssh`.
+the remote machine via 'ssh'.
 
 git Native::
 	`git://remote.machine/path/to/repo.git/`
@@ -1275,8 +1275,8 @@ fatal: merge program failed
 describe those three versions, and is responsible to leave the
 merge results in the working tree.
 It is a fairly straightforward shell script, and
-eventually calls `merge` program from RCS suite to perform a
-file-level 3-way merge.  In this case, `merge` detects
+eventually calls 'merge' program from RCS suite to perform a
+file-level 3-way merge.  In this case, 'merge' detects
 conflicts, and the merge result with conflict marks is left in
 the working tree..  This can be seen if you run `ls-files
 --stage` again at this point:
@@ -1360,7 +1360,7 @@ program on the `$PATH`.
 [NOTE]
 Many installations of sshd do not invoke your shell as the login
 shell when you directly run programs; what this means is that if
-your login shell is `bash`, only `.bashrc` is read and not
+your login shell is 'bash', only `.bashrc` is read and not
 `.bash_profile`. As a workaround, make sure `.bashrc` sets up
 `$PATH` so that you can run 'git-receive-pack' program.
 
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 41ad608..2737d10 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -34,7 +34,7 @@ $ git clone foo.com:/pub/repo.git/ my-project
 $ cd my-project
 ------------------------------------------------
 
-and hack away.  The equivalent of `cvs update` is
+and hack away.  The equivalent of 'cvs update' is
 
 ------------------------------------------------
 $ git pull origin
@@ -60,7 +60,7 @@ $ git push origin master
 ------------------------------------------------
 
 to "push" those commits to the shared repository.  If someone else has
-updated the repository more recently, 'git-push', like `cvs commit`, will
+updated the repository more recently, 'git-push', like 'cvs commit', will
 complain, in which case you must pull any changes before attempting the
 push again.
 
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 84b95a4..2bdbc3d 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -14,7 +14,7 @@ DESCRIPTION
 
 The diff commands 'git-diff-index', 'git-diff-files', and 'git-diff-tree'
 can be told to manipulate differences they find in
-unconventional ways before showing `diff` output.  The manipulation
+unconventional ways before showing 'diff' output.  The manipulation
 is collectively called "diffcore transformation".  This short note
 describes what they are and how to use them to produce 'diff' output
 that is easier to understand than the conventional kind.
-- 
1.5.5.GIT
