From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 6/8] docs: use <tree> instead of <tree-ish>
Date: Sat, 18 Dec 2010 00:38:43 -0500
Message-ID: <1292650725-21149-7-git-send-email-lodatom@gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 06:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTpVx-0006oi-Kc
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 06:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab0LRFjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 00:39:19 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40775 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab0LRFjG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 00:39:06 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so2354117qyj.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 21:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EuwlnYwxg0YVwdfHdbsnFA55XHEkoBt/1JBSmHWiRu4=;
        b=ELptxEnnILGdOD3QRAVEHy77b/Y0Gg1/SfOvcvwkusLhwkZdwn/zlklCdGwHaFKI2y
         L6w4nN0t6wCKnR6MbIy+Po7iTJvM1a8BJRk/tRPO19dgxBgLtssVr1eadD69fEsikdBk
         vLodMcthm6yS7UR/EtdQL7xOtqu9afL/U/pB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s5KDX4R9m/kNr2W5FGIEOXGZqyiQqNrufoF/OprM4dXbwFyvMIZPF5QQ/IK/hH/Ht4
         5DY0E5yG5EdTtnuDA1v2hPV15vK5xOz2fWD8dcKqY9l7CYyA5DlIX+oFTyIyYpcpzO2o
         fWzzJzNrqYRGjNGbMuhhNQMSkCXWfkYA+p774=
Received: by 10.224.2.74 with SMTP id 10mr1622970qai.119.1292650746262;
        Fri, 17 Dec 2010 21:39:06 -0800 (PST)
Received: from localhost.localdomain (c-68-49-150-7.hsd1.dc.comcast.net [68.49.150.7])
        by mx.google.com with ESMTPS id n7sm683569qcu.28.2010.12.17.21.39.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 21:39:05 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163906>

No git command, besides commit-tree, accepts only a tree and not
a tree-ish, so let us remove the latter term from common usage in the
documentation in order to reduce the amount of jargon.

The term "tree-ish" was left in the following situations:
 - all comments in the code
 - situations where "tree-ish" is being contrasted to "tree"
 - error messages, to prevent porcelains from changing
 - tests
 - the glossary

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/RelNotes/1.6.2.4.txt    |    2 +-
 Documentation/diff-format.txt         |   10 +++++-----
 Documentation/diff-generate-patch.txt |    2 +-
 Documentation/git-archive.txt         |    4 ++--
 Documentation/git-cat-file.txt        |    2 +-
 Documentation/git-checkout.txt        |   16 ++++++++--------
 Documentation/git-commit-tree.txt     |    3 ++-
 Documentation/git-diff-index.txt      |    4 ++--
 Documentation/git-diff-tree.txt       |   14 +++++++-------
 Documentation/git-grep.txt            |    4 ++--
 Documentation/git-ls-files.txt        |    6 +++---
 Documentation/git-ls-tree.txt         |    6 +++---
 Documentation/git-merge-tree.txt      |    2 +-
 Documentation/git-read-tree.txt       |   10 +++++-----
 Documentation/git-svn.txt             |    6 +++---
 Documentation/git-tar-tree.txt        |    4 ++--
 Documentation/git.txt                 |   11 ++++-------
 Documentation/gitcli.txt              |    4 ++--
 Documentation/gittutorial-2.txt       |    6 ++----
 archive.c                             |    4 ++--
 builtin/diff-index.c                  |    2 +-
 builtin/diff-tree.c                   |    2 +-
 builtin/ls-files.c                    |    4 ++--
 builtin/ls-tree.c                     |    2 +-
 builtin/read-tree.c                   |    2 +-
 builtin/tar-tree.c                    |    2 +-
 git-svn.perl                          |    6 +++---
 t/t4100/t-apply-3.patch               |    8 ++++----
 t/t4100/t-apply-7.patch               |    8 ++++----
 29 files changed, 76 insertions(+), 80 deletions(-)

diff --git a/Documentation/RelNotes/1.6.2.4.txt b/Documentation/RelNotes/1.6.2.4.txt
index f4bf1d0..0e36786 100644
--- a/Documentation/RelNotes/1.6.2.4.txt
+++ b/Documentation/RelNotes/1.6.2.4.txt
@@ -13,7 +13,7 @@ Fixes since v1.6.2.3
 * "git-add -p" lacked a way to say "q"uit to refuse staging any hunks for
   the remaining paths.  You had to say "d" and then ^C.
 
-* "git-checkout <tree-ish> <submodule>" did not update the index entry at
+* "git-checkout <tree> <submodule>" did not update the index entry at
   the named path; it now does.
 
 * "git-fast-export" choked when seeing a tag that does not point at commit.
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 15c7e79..83272a0 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -7,13 +7,13 @@ The raw output format from "git-diff-index", "git-diff-tree",
 These commands all compare two sets of things; what is
 compared differs:
 
-git-diff-index <tree-ish>::
-        compares the <tree-ish> and the files on the filesystem.
+git-diff-index <tree>::
+        compares the <tree> and the files on the filesystem.
 
-git-diff-index --cached <tree-ish>::
-        compares the <tree-ish> and the index.
+git-diff-index --cached <tree>::
+        compares the <tree> and the index.
 
-git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
+git-diff-tree [-r] <tree-1> <tree-2> [<pattern>...]::
         compares the trees named by the two arguments.
 
 git-diff-files [<pattern>...]::
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 3ac2bea..e0802de 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -131,7 +131,7 @@ The `mode <mode>,<mode>..<mode>` line appears only if at least one of
 the <mode> is different from the rest. Extended headers with
 information about detected contents movement (renames and
 copying detection) are designed to work with diff of two
-<tree-ish> and are not used by combined diff format.
+<tree> and are not used by combined diff format.
 
 3.   It is followed by two-line from-file/to-file header
 
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 4163a1b..bb4943f 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
 	      [-o | --output=<file>] [--worktree-attributes]
-	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
+	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree>
 	      [<path>...]
 
 DESCRIPTION
@@ -70,7 +70,7 @@ OPTIONS
 	Used with --remote to specify the path to the
 	'git-upload-archive' on the remote side.
 
-<tree-ish>::
+<tree>::
 	The tree or commit to produce an archive for.
 
 <path>::
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 544ba7b..4861007 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -54,7 +54,7 @@ OPTIONS
 
 --textconv::
 	Show the content as transformed by a textconv filter. In this case,
-	<object> has be of the form <treeish>:<path>, or :<path> in order
+	<object> has be of the form <tree>:<path>, or :<path> in order
 	to apply the filter to the content recorded in the index at <path>.
 
 --batch::
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 880763d..0199e10 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' --patch [<tree-ish>] [--] [<paths>...]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree>] [--] <paths>...
+'git checkout' --patch [<tree>] [--] [<paths>...]
 
 DESCRIPTION
 -----------
@@ -43,14 +43,14 @@ $ git checkout <branch>
 that is to say, the branch is not reset/created unless "git checkout" is
 successful.
 
-'git checkout' [--patch] [<tree-ish>] [--] <pathspec>...::
+'git checkout' [--patch] [<tree>] [--] <pathspec>...::
 
 	When <paths> or `--patch` are given, 'git checkout' does *not*
 	switch branches.  It updates the named paths in the working tree
-	from the index file or from a named <tree-ish> (most often a
+	from the index file or from a named <tree> (most often a
 	commit).  In this case, the `-b` and `--track` options are
 	meaningless and giving either of them results in an error.  The
-	<tree-ish> argument can be used to specify a specific tree-ish
+	<tree> argument can be used to specify a specific tree-ish
 	(i.e.  commit, tag or tree) to update the index for the given
 	paths before updating the working tree.
 +
@@ -169,9 +169,9 @@ the conflicted merge in the specified paths.
 -p::
 --patch::
 	Interactively select hunks in the difference between the
-	<tree-ish> (or the index, if unspecified) and the working
+	<tree> (or the index, if unspecified) and the working
 	tree.  The chosen hunks are then applied in reverse to the
-	working tree (and if a <tree-ish> was specified, the index).
+	working tree (and if a <tree> was specified, the index).
 +
 This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree.
@@ -198,7 +198,7 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 	The name of a commit at which to start the new branch; see
 	linkgit:git-branch[1] for details. Defaults to HEAD.
 
-<tree-ish>::
+<tree>::
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
 
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 5dcf427..92687d8 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -36,7 +36,8 @@ state was.
 OPTIONS
 -------
 <tree>::
-	An existing tree object
+	An existing tree object.  Unlike other git commands, this must
+	be an actual tree object, not a commit or tag.
 
 -p <parent commit>::
 	Each '-p' indicates the id of a parent commit object.
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 162cb74..c725357 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -8,7 +8,7 @@ git-diff-index - Compares content and mode of blobs between the index and reposi
 
 SYNOPSIS
 --------
-'git diff-index' [-m] [--cached] [<common diff options>] <tree-ish> [<path>...]
+'git diff-index' [-m] [--cached] [<common diff options>] <tree> [<path>...]
 
 DESCRIPTION
 -----------
@@ -22,7 +22,7 @@ OPTIONS
 -------
 include::diff-options.txt[]
 
-<tree-ish>::
+<tree>::
 	The id of a tree object to diff against.
 
 --cached::
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 6b357a5..692d83b 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -11,13 +11,13 @@ SYNOPSIS
 [verse]
 'git diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
 	      [-t] [-r] [-c | --cc] [--root] [<common diff options>]
-	      <tree-ish> [<tree-ish>] [<path>...]
+	      <tree> [<tree>] [<path>...]
 
 DESCRIPTION
 -----------
 Compares the content and mode of the blobs found via two tree objects.
 
-If there is only one <tree-ish> given, the commit is compared with its parents
+If there is only one <tree> given, the commit is compared with its parents
 (see --stdin below).
 
 Note that 'git diff-tree' can use the tree encapsulated in a commit object.
@@ -26,7 +26,7 @@ OPTIONS
 -------
 include::diff-options.txt[]
 
-<tree-ish>::
+<tree>::
 	The id of a tree object.
 
 <path>...::
@@ -48,7 +48,7 @@ include::diff-options.txt[]
 
 --stdin::
 	When '--stdin' is specified, the command does not take
-	<tree-ish> arguments from the command line.  Instead, it
+	<tree> arguments from the command line.  Instead, it
 	reads lines containing <sha1>s: either two trees, one commit, or
 	multiple commits from its standard input.  (Use a single space
 	as separator.)
@@ -91,7 +91,7 @@ include::pretty-options.txt[]
 -c::
 	This flag changes the way a merge commit is displayed
 	(which means it is useful only when the command is given
-	one <tree-ish>, or '--stdin').  It shows the differences
+	one <tree>, or '--stdin').  It shows the differences
 	from each of the parents to the merge result simultaneously
 	instead of showing pairwise diff between a parent and the
 	result one at a time (which is what the '-m' option does).
@@ -121,13 +121,13 @@ Limiting Output
 If you're only interested in differences in a subset of files, for
 example some architecture-specific files, you might do:
 
-	git diff-tree -r <tree-ish> <tree-ish> arch/ia64 include/asm-ia64
+	git diff-tree -r <tree> <tree> arch/ia64 include/asm-ia64
 
 and it will only show you what changed in those two directories.
 
 Or if you are searching for what changed in just `kernel/sched.c`, just do
 
-	git diff-tree -r <tree-ish> <tree-ish> kernel/sched.c
+	git diff-tree -r <tree> <tree> kernel/sched.c
 
 and it will ignore all differences to other files.
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 54ea24a..dab0a78 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -22,7 +22,7 @@ SYNOPSIS
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [--cached | --no-index | <tree-ish>...]
+	   [--cached | --no-index | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -176,7 +176,7 @@ OPTIONS
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
-<tree-ish>...::
+<tree>...::
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.
 
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 86abd13..1192859 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
 		[--exclude-standard]
-		[--error-unmatch] [--with-tree=<tree-ish>]
+		[--error-unmatch] [--with-tree=<tree>]
 		[--full-name] [--abbrev] [--] [<file>...]
 
 DESCRIPTION
@@ -99,11 +99,11 @@ OPTIONS
 	If any <file> does not appear in the index, treat this as an
 	error (return 1).
 
---with-tree=<tree-ish>::
+--with-tree=<tree>::
 	When using --error-unmatch to expand the user supplied
 	<file> (i.e. path pattern) arguments to paths, pretend
 	that paths which were removed in the index since the
-	named <tree-ish> are still present.  Using this option
+	named <tree> are still present.  Using this option
 	with `-s` or `-u` options does not make any sense.
 
 -t::
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 76ed625..b0bb226 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
-	    <tree-ish> [<path>...]
+	    <tree> [<path>...]
 
 DESCRIPTION
 -----------
@@ -35,8 +35,8 @@ in the current working directory.  Note that:
 
 OPTIONS
 -------
-<tree-ish>::
-	Id of a tree-ish.
+<tree>::
+	The id of a tree object.
 
 -d::
 	Show only the named tree entry itself, not its children.
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index f869a7f..0a9eb0d 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads three treeish, and output trivial merge results and
+Reads three <tree>s, and output trivial merge results and
 conflicting stages to the standard output.  This is similar to
 what three-way 'git read-tree -m' does, but instead of storing the
 results in the index, the command outputs the entries to the
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index e88e9c2..24d9b87 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -11,12 +11,12 @@ SYNOPSIS
 'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
 		[-u [--exclude-per-directory=<gitignore>] | -i]]
 		[--index-output=<file>] [--no-sparse-checkout]
-		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
+		(--empty | <tree-1> [<tree-2> [<tree-3>]])
 
 
 DESCRIPTION
 -----------
-Reads the tree information given by <tree-ish> into the index,
+Reads the tree information given by <tree> into the index,
 but does not actually *update* any of the files it "caches". (see:
 linkgit:git-checkout-index[1])
 
@@ -77,7 +77,7 @@ OPTIONS
 
 --prefix=<prefix>/::
 	Keep the current index contents, and read the contents
-	of named tree-ish under directory at `<prefix>`.  The
+	of named tree under directory at `<prefix>`.  The
 	original index file cannot have anything at the path
 	`<prefix>` itself, and have nothing in `<prefix>/`
 	directory.  Note that the `<prefix>/` value must end
@@ -118,7 +118,7 @@ OPTIONS
 	Instead of reading tree object(s) into the index, just empty
 	it.
 
-<tree-ish#>::
+<tree-#>::
 	The id of the tree object(s) to be read/merged.
 
 
@@ -278,7 +278,7 @@ merge. The different stages represent the "result tree" (stage 0, aka
 you are trying to merge (stage 2 and 3 respectively).
 
 The order of stages 1, 2 and 3 (hence the order of three
-<tree-ish> command line arguments) are significant when you
+<tree> command line arguments) are significant when you
 start a 3-way merge with an index file that is already
 populated.  Here is an outline of how the algorithm works:
 
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 139d314..665a107 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -314,8 +314,8 @@ Any other arguments are passed directly to 'git log'
 'find-rev'::
 	When given an SVN revision number of the form 'rN', returns the
 	corresponding git commit hash (this can optionally be followed by a
-	tree-ish to specify which branch should be searched).  When given a
-	tree-ish, returns the corresponding SVN revision number.
+	<tree> to specify which branch should be searched).  When given a
+	<tree>, returns the corresponding SVN revision number.
 
 'set-tree'::
 	You should consider using 'dcommit' instead of this command.
@@ -345,7 +345,7 @@ Any other arguments are passed directly to 'git log'
 	for use after commands like "git checkout" or "git reset".
 
 'commit-diff'::
-	Commits the diff of two tree-ish arguments from the
+	Commits the diff of two <tree> arguments from the
 	command-line.  This command does not rely on being inside an `git svn
 	init`-ed repository.  This command takes three arguments, (a) the
 	original tree to diff against, (b) the new tree result, (c) the
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 3c786bd..6d0a746 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -8,7 +8,7 @@ git-tar-tree - Create a tar archive of the files in the named tree object
 
 SYNOPSIS
 --------
-'git tar-tree' [--remote=<repo>] <tree-ish> [ <base> ]
+'git tar-tree' [--remote=<repo>] <tree> [ <base> ]
 
 DESCRIPTION
 -----------
@@ -29,7 +29,7 @@ It can be extracted using 'git get-tar-commit-id'.
 OPTIONS
 -------
 
-<tree-ish>::
+<tree>::
 	The tree or commit to produce tar archive for.  If it is
 	the object name of a commit object.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7929739..376397c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -469,17 +469,14 @@ Identifier Terminology
 	Indicates a blob object name.
 
 <tree>::
-	Indicates a tree object name.
+	Indicates a tree object name, or the name of tag or commit that points
+	at a tree.  A command that takes a <tree> argument ultimately
+	wants to operate on a tree object but automatically dereferences
+	tag and commit objects until it finds a tree.
 
 <commit>::
 	Indicates a commit object name.
 
-<tree-ish>::
-	Indicates a tree, commit or tag object name.  A
-	command that takes a <tree-ish> argument ultimately wants to
-	operate on a <tree> object but automatically dereferences
-	<commit> and <tag> objects that point at a <tree>.
-
 <commit-ish>::
 	Indicates a commit or tag object name.  A
 	command that takes a <commit-ish> argument ultimately wants to
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index eb65dcf..eefee3d 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -15,8 +15,8 @@ DESCRIPTION
 
 This manual describes the convention used throughout git CLI.
 
-Many commands take revisions (most often "commits", but sometimes
-"tree-ish", depending on the context and command) and paths as their
+Many commands take revisions (most often <commit>s, but sometimes
+<tree>s, depending on the context and command) and paths as their
 arguments.  Here are the rules:
 
  * Revisions come first and then paths.
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 7fe5848..218b94d 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -209,10 +209,8 @@ Note, by the way, that lots of commands take a tree as an argument.
 But as we can see above, a tree can be referred to in many different
 ways--by the SHA1 name for that tree, by the name of a commit that
 refers to the tree, by the name of a branch whose head refers to that
-tree, etc.--and most such commands can accept any of these names.
-
-In command synopses, the word "tree-ish" is sometimes used to
-designate such an argument.
+tree, etc.--and all such commands can accept any of these names unless
+otherwise stated.
 
 The index file
 --------------
diff --git a/archive.c b/archive.c
index 1944ed4..50fb77e 100644
--- a/archive.c
+++ b/archive.c
@@ -7,9 +7,9 @@
 #include "unpack-trees.h"
 
 static char const * const archive_usage[] = {
-	"git archive [options] <tree-ish> [<path>...]",
+	"git archive [options] <tree> [<path>...]",
 	"git archive --list",
-	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<path>...]",
+	"git archive --remote <repo> [--exec <cmd>] [options] <tree> [<path>...]",
 	"git archive --remote <repo> [--exec <cmd>] --list",
 	NULL
 };
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 2eb32bd..605e326 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -7,7 +7,7 @@
 
 static const char diff_cache_usage[] =
 "git diff-index [-m] [--cached] "
-"[<common diff options>] <tree-ish> [<path>...]"
+"[<common diff options>] <tree> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0d2a3e9..d0ea2db 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -88,7 +88,7 @@ static int diff_tree_stdin(char *line)
 
 static const char diff_tree_usage[] =
 "git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"[<common diff options>] <tree> [<tree>] [<path>...]\n"
 "  -r            diff recursively\n"
 "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index fb2d5f4..8592fd0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -523,8 +523,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
 		OPT_BOOLEAN(0, "error-unmatch", &error_unmatch,
 			"if any <file> is not in the index, treat this as an error"),
-		OPT_STRING(0, "with-tree", &with_tree, "tree-ish",
-			"pretend that paths removed since <tree-ish> are still present"),
+		OPT_STRING(0, "with-tree", &with_tree, "tree",
+			"pretend that paths removed since <tree> are still present"),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOLEAN(0, "debug", &debug_mode, "show debugging data"),
 		OPT_END()
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f73e6bd..a810d9a 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -24,7 +24,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const  char * const ls_tree_usage[] = {
-	"git ls-tree [<options>] <tree-ish> [<path>...]",
+	"git ls-tree [<options>] <tree> [<path>...]",
 	NULL
 };
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 73c89ed..064711a 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -33,7 +33,7 @@ static int list_tree(unsigned char *sha1)
 }
 
 static const char * const read_tree_usage[] = {
-	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u [--exclude-per-directory=<gitignore>] | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])",
+	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u [--exclude-per-directory=<gitignore>] | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-1> [<tree-2> [<tree-3>]])",
 	NULL
 };
 
diff --git a/builtin/tar-tree.c b/builtin/tar-tree.c
index 3f1e701..abdcd0b 100644
--- a/builtin/tar-tree.c
+++ b/builtin/tar-tree.c
@@ -8,7 +8,7 @@
 #include "quote.h"
 
 static const char tar_tree_usage[] =
-"git tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
+"git tar-tree [--remote=<repo>] <tree> [basedir]\n"
 "*** Note that this command is now deprecated; use \"git archive\" instead.";
 
 static const char builtin_get_tar_commit_id_usage[] =
diff --git a/git-svn.perl b/git-svn.perl
index 177dd25..96197c0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -172,7 +172,7 @@ my %cmd = (
 	           'username=s' => \$Git::SVN::Prompt::_username,
 	           'commit-url=s' => \$_commit_url } ],
 	'set-tree' => [ \&cmd_set_tree,
-	                "Set an SVN repository to a git tree-ish",
+	                "Set an SVN repository to a git tree",
 			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'create-ignore' => [ \&cmd_create_ignore,
 			     'Create a .gitignore per svn:ignore',
@@ -215,7 +215,7 @@ my %cmd = (
 			  'pager=s' => \$Git::SVN::Log::pager
 			} ],
 	'find-rev' => [ \&cmd_find_rev,
-	                "Translate between SVN revision numbers and tree-ish",
+	                "Translate between SVN revision numbers and trees",
 			{} ],
 	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
 			{ 'merge|m|M' => \$_merge,
@@ -1002,7 +1002,7 @@ sub cmd_multi_fetch {
 sub cmd_commit_diff {
 	my ($ta, $tb, $url) = @_;
 	my $usage = "Usage: $0 commit-diff -r<revision> ".
-	            "<tree-ish> <tree-ish> [<URL>]";
+	            "<tree> <tree> [<URL>]";
 	fatal($usage) if (!defined $ta || !defined $tb);
 	my $svn_path = '';
 	if (!defined $url) {
diff --git a/t/t4100/t-apply-3.patch b/t/t4100/t-apply-3.patch
index 90cdbaa..c702866 100644
--- a/t/t4100/t-apply-3.patch
+++ b/t/t4100/t-apply-3.patch
@@ -12,8 +12,8 @@ diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
  
  SYNOPSIS
  --------
--'git-ls-tree' [-r] [-z] <tree-ish> [paths...]
-+'git-ls-tree' [-d] [-r] [-z] <tree-ish> [paths...]
+-'git-ls-tree' [-r] [-z] <tree> [paths...]
++'git-ls-tree' [-d] [-r] [-z] <tree> [paths...]
  
  DESCRIPTION
  -----------
@@ -24,7 +24,7 @@ diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
  
  OPTIONS
  -------
- <tree-ish>::
+ <tree>::
  	Id of a tree.
  
 +-d::
@@ -485,7 +485,7 @@ dissimilarity index 82%
 +}
 +
 +static const char *ls_tree_usage =
-+	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
++	"git-ls-tree [-d] [-r] [-z] <tree> [path...]";
 +
 +int main(int argc, char **argv)
 +{
diff --git a/t/t4100/t-apply-7.patch b/t/t4100/t-apply-7.patch
index 07c6589..bf8737b 100644
--- a/t/t4100/t-apply-7.patch
+++ b/t/t4100/t-apply-7.patch
@@ -11,8 +11,8 @@ diff a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
  
  SYNOPSIS
  --------
--'git-ls-tree' [-r] [-z] <tree-ish> [paths...]
-+'git-ls-tree' [-d] [-r] [-z] <tree-ish> [paths...]
+-'git-ls-tree' [-r] [-z] <tree> [paths...]
++'git-ls-tree' [-d] [-r] [-z] <tree> [paths...]
  
  DESCRIPTION
  -----------
@@ -23,7 +23,7 @@ diff a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
  
  OPTIONS
  -------
- <tree-ish>::
+ <tree>::
  	Id of a tree.
  
 +-d::
@@ -415,7 +415,7 @@ diff a/ls-tree.c b/ls-tree.c
  
 -static const char *ls_tree_usage = "git-ls-tree [-r] [-z] <key> [paths...]";
 +static const char *ls_tree_usage =
-+	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
++	"git-ls-tree [-d] [-r] [-z] <tree> [path...]";
  
  int main(int argc, char **argv)
  {
-- 
1.7.3.2
