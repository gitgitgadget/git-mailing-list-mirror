From: Christian Meder <chris@absolutegiganten.org>
Subject: [PATCH] Some typos and light editing of various manpages
Date: Wed, 05 Oct 2005 23:48:10 +0200
Message-ID: <1128548890.11363.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 05 23:50:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENH8H-0004wW-GI
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 23:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVJEVs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 17:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVJEVs6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 17:48:58 -0400
Received: from a15181680.alturo-server.de ([217.160.108.75]:31461 "EHLO
	a15181680.alturo-server.de") by vger.kernel.org with ESMTP
	id S965060AbVJEVs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 17:48:57 -0400
Received: from p54a2345f.dip0.t-ipconnect.de ([84.162.52.95] helo=localhost)
	by a15181680.alturo-server.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.52)
	id 1ENH8C-0001UP-2i
	for git@vger.kernel.org; Wed, 05 Oct 2005 23:48:56 +0200
Received: from chris by localhost with local (Exim 4.52)
	id 1ENH7S-0004lC-VV
	for git@vger.kernel.org; Wed, 05 Oct 2005 23:48:10 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9736>

Typos, light editing and clarifications.

Signed-off-by: Christian Meder <chris@absolutegiganten.org>

--- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)


diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -24,7 +24,7 @@ The good news is that most people don't 
 people think it's a bug in CVS that makes it tag (and check in changes)
 one file at a time.  So most projects you'll ever see will use CVS
 'as if' it was sane.  In which case you'll find it very easy indeed to
-move over to Git. 
+move over to git. 
 
 First off: this is not a git tutorial. See
 link:tutorial.html[Documentation/tutorial.txt] for how git
@@ -229,7 +229,7 @@ does rename or copy would not show in th
 "o-file.c", it would find the commit that changed the statement
 when it was in "o-file.c".
 
-NOTE: The current versions of "git-diff-tree -C" is not eager
+NOTE: The current version of "git-diff-tree -C" is not eager
   enough to find copies, and it will miss the fact that a-file.c
   was created by copying o-file.c unless o-file.c was somehow
   changed in the same commit.
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -1,8 +1,8 @@
 The output format from "git-diff-index", "git-diff-tree" and
 "git-diff-files" are very similar.
 
-These commands all compare two sets of things; what are
-compared are different:
+These commands all compare two sets of things; what is 
+compared differs:
 
 git-diff-index <tree-ish>::
         compares the <tree-ish> and the files on the filesystem.
@@ -46,7 +46,7 @@ That is, from the left to the right:
 . path for "dst"; only exists for C or R.
 . an LF or a NUL when '-z' option is used, to terminate the record.
 
-<sha1> is shown as all 0's if new is a file on the filesystem
+<sha1> is shown as all 0's if a file is new on the filesystem
 and it is out of sync with the cache.
 
 Example:
@@ -91,7 +91,7 @@ For a path that is added, removed, or mo
 where:
 
      <old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
-		      contents of <old|ne>,
+		      contents of <old|new>,
      <old|new>-hex:: are the 40-hexdigit SHA1 hashes,
      <old|new>-mode:: are the octal representation of the file modes.
 
@@ -121,12 +121,11 @@ The `a/` and `b/` filenames are the same
 involved.  Especially, even for a creation or a deletion,
 `/dev/null` is _not_ used in place of `a/` or `b/` filenames.
 +
-When rename/copy is involved, `file1` and `file2` shows the
+When rename/copy is involved, `file1` and `file2` show the
 name of the source file of the rename/copy and the name of
 the file that rename/copy produces, respectively.
 
-2.   It is followed by extended header lines that are one or
-     more of:
+2.   It is followed by one or more extended header lines:
 
        old mode <mode>
        new mode <mode>
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -5,9 +5,8 @@
 	Synonym for "-p".
 
 -r::
-	Look recursively in subdirectories; this flag does not
-	mean anything to commands other than "git-diff-tree";
-	other diff commands always look at all the subdirectories.
+	Look recursively in subdirectories; only used by "git-diff-tree";
+	other diff commands always work recursively.
 
 -z::
 	\0 line termination on output
@@ -28,26 +27,26 @@
 	Detect copies as well as renames.
 
 --find-copies-harder::
-	By default, -C option finds copies only if the original
-	file of the copy was modified in the same changeset for
-	performance reasons.  This flag makes the command
+	For performance reasons, by default, -C option finds copies only 
+	if the original file of the copy was modified in the same 
+	changeset.  This flag makes the command
 	inspect unmodified files as candidates for the source of
 	copy.  This is a very expensive operation for large
 	projects, so use it with caution.
 
 -l<num>::
 	-M and -C options require O(n^2) processing time where n
-	in the number of potential rename/copy targets.  This
+	is the number of potential rename/copy targets.  This
 	option prevents rename/copy detection from running if
-	the number of rename/copy targets exceed the specified
+	the number of rename/copy targets exceeds the specified
 	number.
 
 -S<string>::
-	Look for differences that contains the change in <string>.
+	Look for differences that contain the change in <string>.
 
 --pickaxe-all::
 	When -S finds a change, show all the changes in that
-	changeset, not just the files that contains the change
+	changeset, not just the files that contain the change
 	in <string>.
 
 -O<orderfile>::
diff --git a/Documentation/diffcore.txt b/Documentation/diffcore.txt
--- a/Documentation/diffcore.txt
+++ b/Documentation/diffcore.txt
@@ -177,7 +177,7 @@ diffcore-merge-broken
 ---------------------
 
 This transformation is used to merge filepairs broken by
-diffcore-break, and were not transformed into rename/copy by
+diffcore-break, and not transformed into rename/copy by
 diffcore-rename, back into a single modification.  This always
 runs when diffcore-break is used.
 
@@ -206,10 +206,10 @@ like these:
 * -B/60 (the same as above, since diffcore-break defaults to 50%).
 
 Note that earlier implementation left a broken pair as a separate
-creation and deletion patches.  This was unnecessary hack and
+creation and deletion patches.  This was an unnecessary hack and
 the latest implementation always merges all the broken pairs
 back into modifications, but the resulting patch output is
-formatted differently to still let the reviewing easier for such
+formatted differently for easier review in case of such
 a complete rewrite by showing the entire contents of old version
 prefixed with '-', followed by the entire contents of new
 version prefixed with '+'.
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-A simple wrapper to git-update-index to add files to the cache for people used
+A simple wrapper for git-update-index to add files to the cache for people used
 to do "cvs add".
 
 OPTIONS
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads supplied diff output and applies it on a GIT index file
+Reads supplied diff output and applies it on a git index file
 and a work tree.
 
 OPTIONS
diff --git a/Documentation/git-applymbox.txt b/Documentation/git-applymbox.txt
--- a/Documentation/git-applymbox.txt
+++ b/Documentation/git-applymbox.txt
@@ -22,7 +22,7 @@ OPTIONS
 -q::
 	Apply patches interactively.  The user will be given
 	opportunity to edit the log message and the patch before
-	attempting to apply patch in each e-mail message.
+	attempting to apply it.
 
 -k::
 	Usually the program 'cleans up' the Subject: header line
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -20,20 +20,23 @@ it will just import it as a regular comm
 as a merge whenever possible (see discussion below). 
 
 The script expects you to provide the key roots where it can start the import 
-from an 'initial import' or 'tag' type of Arch commit. It will follow and import 
-new branches within the provided roots. 
+from an 'initial import' or 'tag' type of Arch commit. It will follow and 
+import new branches within the provided roots. 
 
 It expects to be dealing with one project only. If it sees 
-branches that have different roots, it will refuse to run. In that case, edit your
-<archive/branch> parameters to define clearly the scope of the import. 
+branches that have different roots, it will refuse to run. In that case, 
+edit your <archive/branch> parameters to define clearly the scope of the 
+import. 
 
-`git-archimport` uses `tla` extensively in the background to access the Arch repository.
+`git-archimport` uses `tla` extensively in the background to access the 
+Arch repository.
 Make sure you have a recent version of `tla` available in the path. `tla` must
 know about the repositories you pass to `git-archimport`. 
 
 For the initial import `git-archimport` expects to find itself in an empty 
 directory. To follow the development of a project that uses Arch, rerun 
-`git-archimport` with the same parameters as the initial import to perform incremental imports.
+`git-archimport` with the same parameters as the initial import to perform 
+incremental imports.
 
 MERGES
 ------
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -76,7 +76,7 @@ During the bisection process, you can sa
 
 to see the currently remaining suspects in `gitk`.
 
-The good/bad you told the command is logged, and `git bisect
+The good/bad input is logged, and `git bisect
 log` shows what you have done so far.  You can truncate its
 output somewhere and save it in a file, and run
 
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -23,7 +23,7 @@ OPTIONS
 	The name of the branch to create.
 
 start-point::
-	Where to make the branch; defaults to HEAD.
+	Where to create the branch; defaults to HEAD.
 
 Author
 ------
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -32,7 +32,7 @@ OPTIONS
 
 <type>::
 	Typically this matches the real type of <object> but asking
-	for a type that can trivially dereferenced from the given
+	for a type that can trivially be dereferenced from the given
 	<object> is also permitted.  An example is to ask for a
 	"tree" with <object> being a commit object that contains it,
 	or to ask for a "blob" with <object> being a tag object that
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -22,7 +22,7 @@ OPTIONS
 	Commit to cherry-pick.
 
 -r::
-	Usuall the command appends which commit was
+	Usually the command appends which commit was
 	cherry-picked after the original commit message when
 	making a commit.  This option, '--replay', causes it to
 	use the original commit message intact.  This is useful
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
--- a/Documentation/git-clone-pack.txt
+++ b/Documentation/git-clone-pack.txt
@@ -26,8 +26,8 @@ OPTIONS
 
 --exec=<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
-	remote side, if is not found on your $PATH.
-	Installations of sshd ignores the user's environment
+	remote side, if it is not found on your $PATH.
+	Installations of sshd ignore the user's environment
 	setup scripts for login shells (e.g. .bash_profile) and
 	your privately installed GIT may not be found on the system
 	default $PATH.  Another workaround suggested is to set
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -36,7 +36,7 @@ OPTIONS
 	An existing tree object
 
 -p <parent commit>::
-	Each '-p' indicates a the id of a parent commit object.
+	Each '-p' indicates the id of a parent commit object.
 	
 
 Commit Information
