From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 3/4] Documentation: format full commands in typewriter font
Date: Sun, 10 Jan 2010 01:02:41 +0100
Message-ID: <9d10ee6a8526dc9f9c220cc6bb4b509c8cc73b0a.1263081032.git.trast@student.ethz.ch>
References: <cover.1263081032.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 01:03:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTlH0-0004Qp-48
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 01:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab0AJADK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 19:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967Ab0AJADJ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 19:03:09 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:17336 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab0AJADH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 19:03:07 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:03:04 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:02:43 +0100
X-Mailer: git-send-email 1.6.6.218.g502b0
In-Reply-To: <cover.1263081032.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136543>

Use `code snippet` style instead of 'emphasis' for `git cmd ...`
according to the following rules:

* The SYNOPSIS sections are left untouched.

* If the intent is that the user type the command exactly as given, it
  is `code`.
  If the user is only loosely referred to a command and/or option, it
  remains 'emphasised'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/config.txt            |   12 ++++++------
 Documentation/git-add.txt           |    2 +-
 Documentation/git-bisect.txt        |    2 +-
 Documentation/git-cvsserver.txt     |    2 +-
 Documentation/git-filter-branch.txt |    6 +++---
 Documentation/git-ls-tree.txt       |    4 ++--
 Documentation/git-merge.txt         |   14 +++++++-------
 Documentation/git-replace.txt       |    2 +-
 Documentation/git-revert.txt        |    4 ++--
 Documentation/git-stash.txt         |    2 +-
 Documentation/git-submodule.txt     |    4 ++--
 Documentation/git-var.txt           |    2 +-
 12 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 23a965e..6bfd9e1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -741,15 +741,15 @@ diff.mnemonicprefix::
 	standard "a/" and "b/" depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
 	the order of the prefixes:
-'git-diff';;
+`git diff`;;
 	compares the (i)ndex and the (w)ork tree;
-'git-diff HEAD';;
+`git diff HEAD`;;
 	 compares a (c)ommit and the (w)ork tree;
-'git diff --cached';;
+`git diff --cached`;;
 	compares a (c)ommit and the (i)ndex;
-'git-diff HEAD:file1 file2';;
+`git-diff HEAD:file1 file2`;;
 	compares an (o)bject and a (w)ork tree entity;
-'git diff --no-index a b';;
+`git diff --no-index a b`;;
 	compares two non-git things (1) and (2).
 
 diff.renameLimit::
@@ -1015,7 +1015,7 @@ gui.spellingdictionary::
 	off.
 
 gui.fastcopyblame::
-	If true, 'git gui blame' uses '-C' instead of '-C -C' for original
+	If true, 'git gui blame' uses `-C` instead of `-C -C` for original
 	location detection. It makes blame significantly faster on huge
 	repositories at the expense of less thorough copy detection.
 
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 1f1b199..f74fcf3 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -39,7 +39,7 @@ The `git add` command will not add ignored files by default.  If any
 ignored files were explicitly specified on the command line, `git add`
 will fail with a list of ignored files.  Ignored files reached by
 directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The `add` command can
+globs before the shell) will be silently ignored.  The 'git add' command can
 be used to add ignored files with the `-f` (force) option.
 
 Please see linkgit:git-commit[1] for alternative ways to add content to a
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index c39d957..f91c7ac 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -26,7 +26,7 @@ on the subcommand:
  git bisect log
  git bisect run <cmd>...
 
-This command uses 'git rev-list --bisect' to help drive the
+This command uses `git rev-list --bisect` to help drive the
 binary search process to find which change introduced a bug, given an
 old "good" commit object name and a later "bad" commit object name.
 
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 99a7c14..19b1daf 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -294,7 +294,7 @@ To get a checkout with the Eclipse CVS client:
 Protocol notes: If you are using anonymous access via pserver, just select that.
 Those using SSH access should choose the 'ext' protocol, and configure 'ext'
 access on the Preferences->Team->CVS->ExtConnection pane. Set CVS_SERVER to
-"'git cvsserver'". Note that password support is not good when using 'ext',
+"`git cvsserver`". Note that password support is not good when using 'ext',
 you will definitely want to have SSH keys setup.
 
 Alternatively, you can just use the non-standard extssh protocol that Eclipse
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 394a77a..544836a 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -129,8 +129,8 @@ convenience functions, too.  For example, calling 'skip_commit "$@"'
 will leave out the current commit (but not its changes! If you want
 that, use 'git-rebase' instead).
 +
-You can also use the 'git_commit_non_empty_tree "$@"' instead of
-'git commit-tree "$@"' if you don't wish to keep commits with a single parent
+You can also use the `git_commit_non_empty_tree "$@"` instead of
+`git commit-tree "$@"` if you don't wish to keep commits with a single parent
 and that makes no change to the tree.
 
 --tag-name-filter <command>::
@@ -179,7 +179,7 @@ the nearest ancestor that was not excluded.
 	and only one parent, it will hence keep merges points. Also, this
 	option is not compatible with the use of '--commit-filter'. Though you
 	just need to use the function 'git_commit_non_empty_tree "$@"' instead
-	of the 'git commit-tree "$@"' idiom in your commit filter to make that
+	of the `git commit-tree "$@"` idiom in your commit filter to make that
 	happen.
 
 --original <namespace>::
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index c3fdccb..1f89d36 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -28,7 +28,7 @@ in the current working directory.  Note that:
    in a directory 'sub' that has a directory 'dir', you can run 'git
    ls-tree -r HEAD dir' to list the contents of the tree (that is
    'sub/dir' in 'HEAD').  You don't want to give a tree that is not at the
-   root level (e.g. 'git ls-tree -r HEAD:sub dir') in this case, as that
+   root level (e.g. `git ls-tree -r HEAD:sub dir`) in this case, as that
    would result in asking for 'sub/sub/dir' in the 'HEAD' commit.
    However, the current working directory can be ignored by passing
    --full-tree option.
@@ -84,7 +84,7 @@ Output Format
 
 Unless the `-z` option is used, TAB, LF, and backslash characters
 in pathnames are represented as `\t`, `\n`, and `\\`, respectively.
-This output format is compatible with what '--index-info --stdin' of
+This output format is compatible with what `--index-info --stdin` of
 'git update-index' expects.
 
 When the `-l` option is used, format changes to
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3277f4e..04c21d3 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -193,7 +193,7 @@ After seeing a conflict, you can do two things:
 
  * Decide not to merge.  The only clean-ups you need are to reset
    the index file to the `HEAD` commit to reverse 2. and to clean
-   up working tree changes made by 2. and 3.; 'git-reset --hard' can
+   up working tree changes made by 2. and 3.; `git-reset --hard` can
    be used for this.
 
  * Resolve the conflicts.  Git will mark the conflicts in
@@ -202,19 +202,19 @@ After seeing a conflict, you can do two things:
 
 You can work through the conflict with a number of tools:
 
- * Use a mergetool.  'git mergetool' to launch a graphical
+ * Use a mergetool.  `git mergetool` to launch a graphical
    mergetool which will work you through the merge.
 
- * Look at the diffs.  'git diff' will show a three-way diff,
+ * Look at the diffs.  `git diff` will show a three-way diff,
    highlighting changes from both the HEAD and their versions.
 
- * Look at the diffs on their own. 'git log --merge -p <path>'
+ * Look at the diffs on their own. `git log --merge -p <path>`
    will show diffs first for the HEAD version and then
    their version.
 
- * Look at the originals.  'git show :1:filename' shows the
-   common ancestor, 'git show :2:filename' shows the HEAD
-   version and 'git show :3:filename' shows their version.
+ * Look at the originals.  `git show :1:filename` shows the
+   common ancestor, `git show :2:filename` shows the HEAD
+   version and `git show :3:filename` shows their version.
 
 
 EXAMPLES
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 65a0da5..fde2092 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -65,7 +65,7 @@ OPTIONS
 BUGS
 ----
 Comparing blobs or trees that have been replaced with those that
-replace them will not work properly. And using 'git reset --hard' to
+replace them will not work properly. And using `git reset --hard` to
 go back to a replaced commit will move the branch to the replacement
 commit instead of the replaced commit.
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 5e11758..36f3bc3 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -20,8 +20,8 @@ effect of an earlier commit (often a faulty one).  If you want to
 throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the '--hard' option.  If
 you want to extract specific files as they were in another commit, you
-should see linkgit:git-checkout[1], specifically the 'git checkout
-<commit> -- <filename>' syntax.  Take care with these alternatives as
+should see linkgit:git-checkout[1], specifically the `git checkout
+<commit> -- <filename>` syntax.  Take care with these alternatives as
 both will discard uncommitted changes in your working directory.
 
 OPTIONS
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 3f14b72..f001d0e 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Use 'git stash' when you want to record the current state of the
+Use `git stash` when you want to record the current state of the
 working directory and the index, but want to go back to a clean
 working directory.  The command saves your local modifications away
 and reverts the working directory to match the `HEAD` commit.
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4ef70c4..68f656c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -114,8 +114,8 @@ init::
 	The key used in .git/config is `submodule.$name.url`.
 	This command does not alter existing information in .git/config.
 	You can then customize the submodule clone URLs in .git/config
-	for your local setup and proceed to 'git submodule update';
-	you can also just use 'git submodule update --init' without
+	for your local setup and proceed to `git submodule update`;
+	you can also just use `git submodule update --init` without
 	the explicit 'init' step if you do not intend to customize
 	any submodule locations.
 
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index ef6aa81..bb98182 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -20,7 +20,7 @@ OPTIONS
 	Cause the logical variables to be listed. In addition, all the
 	variables of the git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
-	is deprecated in favor of 'git config -l'.)
+	is deprecated in favor of `git config -l`.)
 
 EXAMPLE
 --------
-- 
1.6.6.218.g502b0
