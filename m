From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 07/12] docs: use <tree> instead of <tree-ish>
Date: Fri, 12 Mar 2010 23:52:59 -0500
Message-ID: <1268455984-19061-8-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:54:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJMi-0007qX-50
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933579Ab0CMExl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:41 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:38432 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756992Ab0CMExT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:19 -0500
Received: by qw-out-2122.google.com with SMTP id 9so447878qwb.37
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cy7odt2KWETm+9ce0bQzFQd3CDRKlx1SiUaYbDSeQew=;
        b=UPHB0sSOOCDCs61TUN74yCVST1beSoJ4gsrv9JhyePaaqX3pHEFZ8W+UFskv/saPbb
         CIFlioRdOqFMqz4t2FLjvQl48NM4UeJPFeBPjGFNFNrQNOQ5qZAAUPx+2YVq84Gg9ECZ
         1WFoaK9rr5mkVp5i5jPlR+lAPR1mS0RSM+8ek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xd6LOi9FpUoVm0RW11Vgy6Pn3hjstb5kJ4C1sb3Fj6roK3LEYGoT0xYrq6PNMlhBzp
         RPw7q0K6F89xe1LBCgWXmJP9wmNWo5Kz0VwwgFHYAXWGFHc++simUlfxfqv2aWtu/t2n
         pJj+fordgubas6BeISVvEu3bh8Z/o0wxdqFuo=
Received: by 10.224.50.144 with SMTP id z16mr777015qaf.378.1268455999105;
        Fri, 12 Mar 2010 20:53:19 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:18 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142085>

There is no longer any reference to <tree> in the documentation, since
all commands now accept a <tree-ish>, so remove the latter in favor
of the former.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
I expect that this, along with the removal of <commit-ish>, is the most 
controversial part of the patch series.  I just don't see any reason to 
use the ugly and long <tree-ish> when <tree> is going unused!

 Documentation/RelNotes-1.6.2.4.txt    |    2 +-
 Documentation/diff-format.txt         |    8 ++++----
 Documentation/diff-generate-patch.txt |    2 +-
 Documentation/git-archive.txt         |    4 ++--
 Documentation/git-checkout.txt        |   14 +++++++-------
 Documentation/git-commit-tree.txt     |    4 ++--
 Documentation/git-diff-index.txt      |    4 ++--
 Documentation/git-diff-tree.txt       |   14 +++++++-------
 Documentation/git-diff.txt            |    2 +-
 Documentation/git-grep.txt            |    4 ++--
 Documentation/git-ls-files.txt        |    6 +++---
 Documentation/git-ls-tree.txt         |    4 ++--
 Documentation/git-read-tree.txt       |    4 ++--
 Documentation/git-tar-tree.txt        |    4 ++--
 Documentation/git.txt                 |   11 ++++-------
 archive.c                             |    4 ++--
 builtin/commit-tree.c                 |    2 +-
 builtin/diff-index.c                  |    2 +-
 builtin/diff-tree.c                   |    2 +-
 builtin/ls-files.c                    |    2 +-
 builtin/ls-tree.c                     |    2 +-
 builtin/tar-tree.c                    |    2 +-
 git-svn.perl                          |    2 +-
 t/t4100/t-apply-3.patch               |    8 ++++----
 t/t4100/t-apply-7.patch               |    8 ++++----
 25 files changed, 59 insertions(+), 62 deletions(-)

diff --git a/Documentation/RelNotes-1.6.2.4.txt b/Documentation/RelNotes-1.6.2.4.txt
index f4bf1d0..0e36786 100644
--- a/Documentation/RelNotes-1.6.2.4.txt
+++ b/Documentation/RelNotes-1.6.2.4.txt
@@ -13,7 +13,7 @@ Fixes since v1.6.2.3
 * "git-add -p" lacked a way to say "q"uit to refuse staging any hunks for
   the remaining paths.  You had to say "d" and then ^C.
 
-* "git-checkout <tree-ish> <submodule>" did not update the index entry at
+* "git-checkout <tree> <submodule>" did not update the index entry at
   the named path; it now does.
 
 * "git-fast-export" choked when seeing a tag that does not point at commit.
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 15c7e79..e1311fb 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -7,11 +7,11 @@ The raw output format from "git-diff-index", "git-diff-tree",
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
 
 git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
         compares the trees named by the two arguments.
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 0f25ba7..e0eb126 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -110,7 +110,7 @@ The `mode <mode>,<mode>..<mode>` line appears only if at least one of
 the <mode> is different from the rest. Extended headers with
 information about detected contents movement (renames and
 copying detection) are designed to work with diff of two
-<tree-ish> and are not used by combined diff format.
+<tree> and are not used by combined diff format.
 
 3.   It is followed by two-line from-file/to-file header
 
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 8d3e666..1d520fc 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
 	      [-o | --output=<file>] [--worktree-attributes]
-	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
+	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree>
 	      [path...]
 
 DESCRIPTION
@@ -70,7 +70,7 @@ OPTIONS
 	Used with --remote to specify the path to the
 	'git-upload-archive' on the remote side.
 
-<tree-ish>::
+<tree>::
 	The tree or commit to produce an archive for.
 
 path::
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 37c1810..b1061d5 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
 'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' --patch [<tree-ish>] [--] [<paths>...]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree>] [--] <paths>...
+'git checkout' --patch [<tree>] [--] [<paths>...]
 
 DESCRIPTION
 -----------
@@ -28,9 +28,9 @@ creation; see the description of --track below.
 
 When <paths> or --patch are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
-the index file, or from a named <tree-ish> (most often a commit).  In
+the index file, or from a named <tree> (most often a commit).  In
 this case, the `-b` and `--track` options are meaningless and giving
-either of them results in an error. The <tree-ish> argument can be
+either of them results in an error. The <tree> argument can be
 used to specify a specific tree-ish (i.e. commit, tag or tree)
 to update the index for the given paths before updating the
 working tree.
@@ -119,9 +119,9 @@ the conflicted merge in the specified paths.
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
@@ -144,7 +144,7 @@ checks out the branch (instead of detaching).  You may also specify
 	The name of a commit at which to start the new branch; see
 	linkgit:git-branch[1] for details. Defaults to HEAD.
 
-<tree-ish>::
+<tree>::
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
 
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 67b6bc0..6188854 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -8,7 +8,7 @@ git-commit-tree - Create a new commit object
 
 SYNOPSIS
 --------
-'git commit-tree' <tree-ish> [-p <parent commit>]\* < changelog
+'git commit-tree' <tree> [-p <parent commit>]\* < changelog
 
 DESCRIPTION
 -----------
@@ -35,7 +35,7 @@ state was.
 
 OPTIONS
 -------
-<tree-ish>::
+<tree>::
 	An existing tree object
 
 -p <parent commit>::
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
index 5d0310b..e566188 100644
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
 	reads lines containing <sha1>'s: either two trees, one commit, or
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
 
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 723a648..4582179 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -65,7 +65,7 @@ forced by --no-index.
 Just in case if you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
 for the last two forms that use ".." notations, can be any
-<tree-ish>.
+<tree>.
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 02d6306..4b32322 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -21,7 +21,7 @@ SYNOPSIS
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [--cached | --no-index | <tree-ish>...]
+	   [--cached | --no-index | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -168,7 +168,7 @@ OPTIONS
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
-<tree-ish>...::
+<tree>...::
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.
 
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3521637..ed63f21 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
 		[--exclude-standard]
-		[--error-unmatch] [--with-tree=<tree-ish>]
+		[--error-unmatch] [--with-tree=<tree>]
 		[--full-name] [--abbrev] [--] [<file>]\*
 
 DESCRIPTION
@@ -98,11 +98,11 @@ OPTIONS
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
index 1f89d36..4964787 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev=[<n>]]
-	    <tree-ish> [paths...]
+	    <tree> [paths...]
 
 DESCRIPTION
 -----------
@@ -35,7 +35,7 @@ in the current working directory.  Note that:
 
 OPTIONS
 -------
-<tree-ish>::
+<tree>::
 	Id of a tree-ish.
 
 -d::
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 567671c..979793e 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads the tree information given by <tree-ish> into the index,
+Reads the tree information given by <tree> into the index,
 but does not actually *update* any of the files it "caches". (see:
 linkgit:git-checkout-index[1])
 
@@ -272,7 +272,7 @@ merge. The different stages represent the "result tree" (stage 0, aka
 you are trying to merge (stage 2 and 3 respectively).
 
 The order of stages 1, 2 and 3 (hence the order of three
-<tree-ish> command line arguments) are significant when you
+<tree> command line arguments) are significant when you
 start a 3-way merge with an index file that is already
 populated.  Here is an outline of how the algorithm works:
 
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
index 55f3842..eb87edb 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -430,7 +430,10 @@ Identifier Terminology
 	Indicates a commit-type <object>.
 
 <tree>::
-	Indicates a tree-type <object>.
+	Indicates a tree-type <object>, or a <tag> or <commit> that points at
+	a <tree>.  A command that takes a <tree> argument ultimately
+	wants to operate on a tree object but automatically dereferences
+	objects until it finds a tree.
 
 <blob>::
 	Indicates a blob-type <object>.
@@ -443,12 +446,6 @@ Identifier Terminology
 	until it finds a commit.
 	A <rev> is another name for a <commit-ish>.
 
-<tree-ish>::
-	Indicates a <tree>, or a <tag> or <commit> that points at a
-	<tree-ish>.  A command that takes a <tree-ish> argument ultimately
-	wants to operate on a tree object but automatically dereferences
-	objects until it finds a tree.
-
 <type>::
 	Indicates that an object type is required.
 	Currently one of: `blob`, `tree`, `commit`, or `tag`.
diff --git a/archive.c b/archive.c
index d700af3..4fefb64 100644
--- a/archive.c
+++ b/archive.c
@@ -7,9 +7,9 @@
 #include "unpack-trees.h"
 
 static char const * const archive_usage[] = {
-	"git archive [options] <tree-ish> [path...]",
+	"git archive [options] <tree> [path...]",
 	"git archive --list",
-	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [path...]",
+	"git archive --remote <repo> [--exec <cmd>] [options] <tree> [path...]",
 	"git archive --remote <repo> [--exec <cmd>] --list",
 	NULL
 };
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 770baa2..225e515 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -22,7 +22,7 @@ static void check_valid(unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-static const char commit_tree_usage[] = "git commit-tree <tree-ish> [-p <commit>]* < changelog";
+static const char commit_tree_usage[] = "git commit-tree <tree> [-p <commit>]* < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 0483749..5c4c5ce 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -6,7 +6,7 @@
 
 static const char diff_cache_usage[] =
 "git diff-index [-m] [--cached] "
-"[<common diff options>] <tree-ish> [<path>...]"
+"[<common diff options>] <tree> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 2380c21..e446dd5 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -87,7 +87,7 @@ static int diff_tree_stdin(char *line)
 
 static const char diff_tree_usage[] =
 "git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"[<common diff options>] <tree> [<tree>] [<path>...]\n"
 "  -r            diff recursively\n"
 "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b065061..6dc885d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -513,7 +513,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "error-unmatch", &error_unmatch,
 			"if any <file> is not in the index, treat this as an error"),
 		OPT_STRING(0, "with-tree", &with_tree, "tree-ish",
-			"pretend that paths removed since <tree-ish> are still present"),
+			"pretend that paths removed since <tree> are still present"),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 4484185..8a52e42 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -24,7 +24,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const  char * const ls_tree_usage[] = {
-	"git ls-tree [<options>] <tree-ish> [path...]",
+	"git ls-tree [<options>] <tree> [path...]",
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
index 1a26843..c80eb49 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -997,7 +997,7 @@ sub cmd_multi_fetch {
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
1.7.0.2
