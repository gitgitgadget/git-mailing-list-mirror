From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 3/7] use 'treeish' instead of 'tree-ish'
Date: Mon,  2 Sep 2013 01:34:22 -0400
Message-ID: <1378100066-31889-4-git-send-email-rhansen@bbn.com>
References: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 02 08:19:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNU8-0007IT-0k
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab3IBGT3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Sep 2013 02:19:29 -0400
Received: from smtp.bbn.com ([128.33.0.80]:57827 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713Ab3IBGT1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 02:19:27 -0400
X-Greylist: delayed 2682 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Sep 2013 02:19:27 EDT
Received: from socket.bbn.com ([192.1.120.102]:55318)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VGMmi-000NLT-5f; Mon, 02 Sep 2013 01:34:44 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 3017E401B7
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233604>

Replace all instances of 'tree-ish' with 'treeish':
  * to standardize on a single spelling (the documentation contained a
    mix of 'treeish' and 'tree-ish')
  * to be consistent with variable names (hyphens are not usually
    allowed in variable names)
  * to be consistent with 'committish'
  * some search engines don't handle hyphens gracefully

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/RelNotes/1.6.0.5.txt       |  2 +-
 Documentation/RelNotes/1.6.2.4.txt       |  2 +-
 Documentation/RelNotes/1.8.1.2.txt       |  2 +-
 Documentation/RelNotes/1.8.2.txt         |  2 +-
 Documentation/diff-format.txt            | 10 +++++-----
 Documentation/diff-generate-patch.txt    |  2 +-
 Documentation/git-archive.txt            |  4 ++--
 Documentation/git-checkout.txt           | 16 ++++++++--------
 Documentation/git-diff-index.txt         |  4 ++--
 Documentation/git-diff-tree.txt          | 14 +++++++-------
 Documentation/git-ls-files.txt           |  6 +++---
 Documentation/git-ls-tree.txt            |  6 +++---
 Documentation/git-read-tree.txt          | 10 +++++-----
 Documentation/git-reset.txt              | 16 ++++++++--------
 Documentation/git-svn.txt                |  6 +++---
 Documentation/git-tar-tree.txt           |  4 ++--
 Documentation/git.txt                    |  4 ++--
 Documentation/gitcli.txt                 |  2 +-
 Documentation/gittutorial-2.txt          |  2 +-
 Documentation/glossary-content.txt       |  2 +-
 Documentation/revisions.txt              |  2 +-
 archive.c                                |  6 +++---
 builtin/checkout.c                       |  6 +++---
 builtin/diff-index.c                     |  2 +-
 builtin/diff-tree.c                      |  2 +-
 builtin/diff.c                           |  2 +-
 builtin/ls-files.c                       |  8 ++++----
 builtin/ls-tree.c                        |  2 +-
 builtin/read-tree.c                      |  2 +-
 builtin/reset.c                          |  4 ++--
 builtin/tar-tree.c                       | 12 ++++++------
 contrib/examples/git-checkout.sh         | 10 +++++-----
 fast-import.c                            |  2 +-
 git-svn.perl                             |  6 +++---
 gitweb/gitweb.perl                       |  4 ++--
 po/de.po                                 | 16 ++++++++--------
 po/fr.po                                 | 16 ++++++++--------
 po/git.pot                               | 16 ++++++++--------
 po/sv.po                                 | 16 ++++++++--------
 po/vi.po                                 | 33 ++++++++++++++++--------=
--------
 po/zh_CN.po                              | 16 ++++++++--------
 t/t1512-rev-parse-disambiguation.sh      | 10 +++++-----
 t/t2010-checkout-ambiguous.sh            |  2 +-
 t/t4100/t-apply-3.patch                  |  8 ++++----
 t/t4100/t-apply-7.patch                  |  8 ++++----
 t/t9300-fast-import.sh                   |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh   |  2 +-
 t/t9501-gitweb-standalone-http-status.sh |  8 ++++----
 48 files changed, 169 insertions(+), 170 deletions(-)

diff --git a/Documentation/RelNotes/1.6.0.5.txt b/Documentation/RelNote=
s/1.6.0.5.txt
index a08bb96..d47386b 100644
--- a/Documentation/RelNotes/1.6.0.5.txt
+++ b/Documentation/RelNotes/1.6.0.5.txt
@@ -13,7 +13,7 @@ Fixes since v1.6.0.4
 * "git diff" always allowed GIT_EXTERNAL_DIFF and --no-ext-diff was no=
-op for
   the command.
=20
-* Giving 3 or more tree-ish to "git diff" is supposed to show the comb=
ined
+* Giving 3 or more treeish to "git diff" is supposed to show the combi=
ned
   diff from second and subsequent trees to the first one, but the orde=
r was
   screwed up.
=20
diff --git a/Documentation/RelNotes/1.6.2.4.txt b/Documentation/RelNote=
s/1.6.2.4.txt
index f4bf1d0..f75086d 100644
--- a/Documentation/RelNotes/1.6.2.4.txt
+++ b/Documentation/RelNotes/1.6.2.4.txt
@@ -13,7 +13,7 @@ Fixes since v1.6.2.3
 * "git-add -p" lacked a way to say "q"uit to refuse staging any hunks =
for
   the remaining paths.  You had to say "d" and then ^C.
=20
-* "git-checkout <tree-ish> <submodule>" did not update the index entry=
 at
+* "git-checkout <treeish> <submodule>" did not update the index entry =
at
   the named path; it now does.
=20
 * "git-fast-export" choked when seeing a tag that does not point at co=
mmit.
diff --git a/Documentation/RelNotes/1.8.1.2.txt b/Documentation/RelNote=
s/1.8.1.2.txt
index 5ab7b18..0cdb2f9 100644
--- a/Documentation/RelNotes/1.8.1.2.txt
+++ b/Documentation/RelNotes/1.8.1.2.txt
@@ -12,7 +12,7 @@ Fixes since v1.8.1.1
    after completing a single directory name.
=20
  * Command line completion leaked an unnecessary error message while
-   looking for possible matches with paths in <tree-ish>.
+   looking for possible matches with paths in <treeish>.
=20
  * "git archive" did not record uncompressed size in the header when
    streaming a zip archive, which confused some implementations of unz=
ip.
diff --git a/Documentation/RelNotes/1.8.2.txt b/Documentation/RelNotes/=
1.8.2.txt
index fc606ae..70fda04 100644
--- a/Documentation/RelNotes/1.8.2.txt
+++ b/Documentation/RelNotes/1.8.2.txt
@@ -421,7 +421,7 @@ details).
    to add a newline after such a line.
=20
  * Command line completion leaked an unnecessary error message while
-   looking for possible matches with paths in <tree-ish>.
+   looking for possible matches with paths in <treeish>.
=20
  * Command line completion for "tcsh" emitted an unwanted space
    after completing a single directory name.
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.=
txt
index 15c7e79..28cef30 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -7,13 +7,13 @@ The raw output format from "git-diff-index", "git-dif=
f-tree",
 These commands all compare two sets of things; what is
 compared differs:
=20
-git-diff-index <tree-ish>::
-        compares the <tree-ish> and the files on the filesystem.
+git-diff-index <treeish>::
+        compares the <treeish> and the files on the filesystem.
=20
-git-diff-index --cached <tree-ish>::
-        compares the <tree-ish> and the index.
+git-diff-index --cached <treeish>::
+        compares the <treeish> and the index.
=20
-git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
+git-diff-tree [-r] <treeish-1> <treeish-2> [<pattern>...]::
         compares the trees named by the two arguments.
=20
 git-diff-files [<pattern>...]::
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff=
-generate-patch.txt
index 55f499a..3458c22 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -134,7 +134,7 @@ The `mode <mode>,<mode>..<mode>` line appears only =
if at least one of
 the <mode> is different from the rest. Extended headers with
 information about detected contents movement (renames and
 copying detection) are designed to work with diff of two
-<tree-ish> and are not used by combined diff format.
+<treeish> and are not used by combined diff format.
=20
 3.   It is followed by two-line from-file/to-file header
=20
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index b97aaab..5c6aef9 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [<ext=
ra>]
 	      [-o <file> | --output=3D<file>] [--worktree-attributes]
-	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
+	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <treeish>
 	      [<path>...]
=20
 DESCRIPTION
@@ -71,7 +71,7 @@ OPTIONS
 	Used with --remote to specify the path to the
 	'git-upload-archive' on the remote side.
=20
-<tree-ish>::
+<treeish>::
 	The tree or commit to produce an archive for.
=20
 <path>::
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index ca118ac..ea12697 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [<branch>]
 'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_=
point>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>] [--] <paths>...
-'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<treeish>=
] [--] <paths>...
+'git checkout' [-p|--patch] [<treeish>] [--] [<paths>...]
=20
 DESCRIPTION
 -----------
@@ -76,14 +76,14 @@ the option, giving a branch name to the command wou=
ld check out the branch,
 instead of detaching HEAD at it), or the current commit,
 if no <branch> is specified.
=20
-'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
+'git checkout' [-p|--patch] [<treeish>] [--] <pathspec>...::
=20
 	When <paths> or `--patch` are given, 'git checkout' does *not*
 	switch branches.  It updates the named paths in the working tree
-	from the index file or from a named <tree-ish> (most often a
+	from the index file or from a named <treeish> (most often a
 	commit).  In this case, the `-b` and `--track` options are
 	meaningless and giving either of them results in an error.  The
-	<tree-ish> argument can be used to specify a specific tree-ish
+	<treeish> argument can be used to specify a specific treeish
 	(i.e.  commit, tag or tree) to update the index for the given
 	paths before updating the working tree.
 +
@@ -215,9 +215,9 @@ the conflicted merge in the specified paths.
 -p::
 --patch::
 	Interactively select hunks in the difference between the
-	<tree-ish> (or the index, if unspecified) and the working
+	<treeish> (or the index, if unspecified) and the working
 	tree.  The chosen hunks are then applied in reverse to the
-	working tree (and if a <tree-ish> was specified, the index).
+	working tree (and if a <treeish> was specified, the index).
 +
 This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
@@ -245,7 +245,7 @@ leave out at most one of `A` and `B`, in which case=
 it defaults to `HEAD`.
 	The name of a commit at which to start the new branch; see
 	linkgit:git-branch[1] for details. Defaults to HEAD.
=20
-<tree-ish>::
+<treeish>::
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
=20
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-=
index.txt
index a86cf62..23bff68 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -9,7 +9,7 @@ git-diff-index - Compare a tree to the working tree or =
index
 SYNOPSIS
 --------
 [verse]
-'git diff-index' [-m] [--cached] [<common diff options>] <tree-ish> [<=
path>...]
+'git diff-index' [-m] [--cached] [<common diff options>] <treeish> [<p=
ath>...]
=20
 DESCRIPTION
 -----------
@@ -23,7 +23,7 @@ OPTIONS
 -------
 include::diff-options.txt[]
=20
-<tree-ish>::
+<treeish>::
 	The id of a tree object to diff against.
=20
 --cached::
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-t=
ree.txt
index 1439486..523d9e4 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -11,13 +11,13 @@ SYNOPSIS
 [verse]
 'git diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
 	      [-t] [-r] [-c | --cc] [--root] [<common diff options>]
-	      <tree-ish> [<tree-ish>] [<path>...]
+	      <treeish> [<treeish>] [<path>...]
=20
 DESCRIPTION
 -----------
 Compares the content and mode of the blobs found via two tree objects.
=20
-If there is only one <tree-ish> given, the commit is compared with its=
 parents
+If there is only one <treeish> given, the commit is compared with its =
parents
 (see --stdin below).
=20
 Note that 'git diff-tree' can use the tree encapsulated in a commit ob=
ject.
@@ -26,7 +26,7 @@ OPTIONS
 -------
 include::diff-options.txt[]
=20
-<tree-ish>::
+<treeish>::
 	The id of a tree object.
=20
 <path>...::
@@ -48,7 +48,7 @@ include::diff-options.txt[]
=20
 --stdin::
 	When '--stdin' is specified, the command does not take
-	<tree-ish> arguments from the command line.  Instead, it
+	<treeish> arguments from the command line.  Instead, it
 	reads lines containing either two <tree>, one <commit>, or a
 	list of <commit> from its standard input.  (Use a single space
 	as separator.)
@@ -91,7 +91,7 @@ include::pretty-options.txt[]
 -c::
 	This flag changes the way a merge commit is displayed
 	(which means it is useful only when the command is given
-	one <tree-ish>, or '--stdin').  It shows the differences
+	one <treeish>, or '--stdin').  It shows the differences
 	from each of the parents to the merge result simultaneously
 	instead of showing pairwise diff between a parent and the
 	result one at a time (which is what the '-m' option does).
@@ -121,13 +121,13 @@ Limiting Output
 If you're only interested in differences in a subset of files, for
 example some architecture-specific files, you might do:
=20
-	git diff-tree -r <tree-ish> <tree-ish> arch/ia64 include/asm-ia64
+	git diff-tree -r <treeish> <treeish> arch/ia64 include/asm-ia64
=20
 and it will only show you what changed in those two directories.
=20
 Or if you are searching for what changed in just `kernel/sched.c`, jus=
t do
=20
-	git diff-tree -r <tree-ish> <tree-ish> kernel/sched.c
+	git diff-tree -r <treeish> <treeish> kernel/sched.c
=20
 and it will ignore all differences to other files.
=20
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index c0856a6..13f37dc 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 		[-X <file>|--exclude-from=3D<file>]
 		[--exclude-per-directory=3D<file>]
 		[--exclude-standard]
-		[--error-unmatch] [--with-tree=3D<tree-ish>]
+		[--error-unmatch] [--with-tree=3D<treeish>]
 		[--full-name] [--abbrev] [--] [<file>...]
=20
 DESCRIPTION
@@ -99,11 +99,11 @@ OPTIONS
 	If any <file> does not appear in the index, treat this as an
 	error (return 1).
=20
---with-tree=3D<tree-ish>::
+--with-tree=3D<treeish>::
 	When using --error-unmatch to expand the user supplied
 	<file> (i.e. path pattern) arguments to paths, pretend
 	that paths which were removed in the index since the
-	named <tree-ish> are still present.  Using this option
+	named <treeish> are still present.  Using this option
 	with `-s` or `-u` options does not make any sense.
=20
 -t::
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.=
txt
index 16e87fd..8c99cda 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbr=
ev[=3D<n>]]
-	    <tree-ish> [<path>...]
+	    <treeish> [<path>...]
=20
 DESCRIPTION
 -----------
@@ -35,8 +35,8 @@ in the current working directory.  Note that:
=20
 OPTIONS
 -------
-<tree-ish>::
-	Id of a tree-ish.
+<treeish>::
+	Id of a treeish.
=20
 -d::
 	Show only the named tree entry itself, not its children.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index c4bde65..98ba1f6 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -12,12 +12,12 @@ SYNOPSIS
 'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>]
 		[-u [--exclude-per-directory=3D<gitignore>] | -i]]
 		[--index-output=3D<file>] [--no-sparse-checkout]
-		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
+		(--empty | <treeish1> [<treeish2> [<treeish3>]])
=20
=20
 DESCRIPTION
 -----------
-Reads the tree information given by <tree-ish> into the index,
+Reads the tree information given by <treeish> into the index,
 but does not actually *update* any of the files it "caches". (see:
 linkgit:git-checkout-index[1])
=20
@@ -83,7 +83,7 @@ OPTIONS
=20
 --prefix=3D<prefix>/::
 	Keep the current index contents, and read the contents
-	of the named tree-ish under the directory at `<prefix>`.
+	of the named treeish under the directory at `<prefix>`.
 	The command will refuse to overwrite entries that already
 	existed in the original index file. Note that the `<prefix>/`
 	value must end with a slash.
@@ -123,7 +123,7 @@ OPTIONS
 	Instead of reading tree object(s) into the index, just empty
 	it.
=20
-<tree-ish#>::
+<treeish#>::
 	The id of the tree object(s) to be read/merged.
=20
=20
@@ -283,7 +283,7 @@ merge. The different stages represent the "result t=
ree" (stage 0, aka
 you are trying to merge (stage 2 and 3 respectively).
=20
 The order of stages 1, 2 and 3 (hence the order of three
-<tree-ish> command line arguments) are significant when you
+<treeish> command line arguments) are significant when you
 start a 3-way merge with an index file that is already
 populated.  Here is an outline of how the algorithm works:
=20
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f445cb3..058f578 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,20 +8,20 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [-q] [<tree-ish>] [--] <paths>...
-'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
+'git reset' [-q] [<treeish>] [--] <paths>...
+'git reset' (--patch | -p) [<treeish>] [--] [<paths>...]
 'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<comm=
it>]
=20
 DESCRIPTION
 -----------
-In the first and second form, copy entries from <tree-ish> to the inde=
x.
+In the first and second form, copy entries from <treeish> to the index=
=2E
 In the third form, set the current branch head (HEAD) to <commit>, opt=
ionally
-modifying index and working tree to match.  The <tree-ish>/<commit> de=
faults
+modifying index and working tree to match.  The <treeish>/<commit> def=
aults
 to HEAD in all forms.
=20
-'git reset' [-q] [<tree-ish>] [--] <paths>...::
+'git reset' [-q] [<treeish>] [--] <paths>...::
 	This form resets the index entries for all <paths> to their
-	state at <tree-ish>.  (It does not affect the working tree, nor
+	state at <treeish>.  (It does not affect the working tree, nor
 	the current branch.)
 +
 This means that `git reset <paths>` is the opposite of `git add
@@ -34,9 +34,9 @@ Alternatively, using linkgit:git-checkout[1] and spec=
ifying a commit, you
 can copy the contents of a path out of a commit to the index and to th=
e
 working tree in one go.
=20
-'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]::
+'git reset' (--patch | -p) [<treeish>] [--] [<paths>...]::
 	Interactively select hunks in the difference between the index
-	and <tree-ish> (defaults to HEAD).  The chosen hunks are applied
+	and <treeish> (defaults to HEAD).  The chosen hunks are applied
 	in reverse to the index.
 +
 This means that `git reset -p` is the opposite of `git add -p`, i.e.
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4dd3bcb..e6cb24a 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -363,8 +363,8 @@ Any other arguments are passed directly to 'git log=
'
 'find-rev'::
 	When given an SVN revision number of the form 'rN', returns the
 	corresponding Git commit hash (this can optionally be followed by a
-	tree-ish to specify which branch should be searched).  When given a
-	tree-ish, returns the corresponding SVN revision number.
+	treeish to specify which branch should be searched).  When given a
+	treeish, returns the corresponding SVN revision number.
 +
 --before;;
 	Don't require an exact match if given an SVN revision, instead find
@@ -406,7 +406,7 @@ Any other arguments are passed directly to 'git log=
'
 	more information.)
=20
 'commit-diff'::
-	Commits the diff of two tree-ish arguments from the
+	Commits the diff of two treeish arguments from the
 	command-line.  This command does not rely on being inside an `git svn
 	init`-ed repository.  This command takes three arguments, (a) the
 	original tree to diff against, (b) the new tree result, (c) the
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tre=
e.txt
index f7362dc..75417c6 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -9,7 +9,7 @@ git-tar-tree - Create a tar archive of the files in the=
 named tree object
 SYNOPSIS
 --------
 [verse]
-'git tar-tree' [--remote=3D<repo>] <tree-ish> [ <base> ]
+'git tar-tree' [--remote=3D<repo>] <treeish> [ <base> ]
=20
 DESCRIPTION
 -----------
@@ -30,7 +30,7 @@ It can be extracted using 'git get-tar-commit-id'.
 OPTIONS
 -------
=20
-<tree-ish>::
+<treeish>::
 	The tree or commit to produce tar archive for.  If it is
 	the object name of a commit object.
=20
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 83edf30..c07915b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -600,9 +600,9 @@ Identifier Terminology
 <commit>::
 	Indicates a commit object name.
=20
-<tree-ish>::
+<treeish>::
 	Indicates a tree, commit or tag object name.  A
-	command that takes a <tree-ish> argument ultimately wants to
+	command that takes a <treeish> argument ultimately wants to
 	operate on a <tree> object but automatically dereferences
 	<commit> and <tag> objects that point at a <tree>.
=20
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 9ac5088..4f8d4a0 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 This manual describes the convention used throughout Git CLI.
=20
 Many commands take revisions (most often "commits", but sometimes
-"tree-ish", depending on the context and command) and paths as their
+"treeish", depending on the context and command) and paths as their
 arguments.  Here are the rules:
=20
  * Revisions come first and then paths.
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutoria=
l-2.txt
index 3109ea8..c5f9903 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -212,7 +212,7 @@ ways--by the SHA-1 name for that tree, by the name =
of a commit that
 refers to the tree, by the name of a branch whose head refers to that
 tree, etc.--and most such commands can accept any of these names.
=20
-In command synopses, the word "tree-ish" is sometimes used to
+In command synopses, the word "treeish" is sometimes used to
 designate such an argument.
=20
 The index file
diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index b1993e0..257a7fe 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -498,7 +498,7 @@ should not be combined with other pathspec.
 	with refs to the associated blob and/or tree objects. A
 	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
=20
-[[def_tree-ish]]tree-ish (also treeish)::
+[[def_treeish]]treeish (also tree-ish)::
 	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
 	object>>, a <<def_tree_object,tree object>>, or a <<def_tag_object,ta=
g
 	object>> pointing to a tag or commit or tree object.
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d477b3f..569b563 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -147,7 +147,7 @@ it does not have to be dereferenced even once to ge=
t to an object.
=20
 '<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
   A suffix ':' followed by a path names the blob or tree
-  at the given path in the tree-ish object named by the part
+  at the given path in the treeish object named by the part
   before the colon.
   ':path' (with an empty part before the colon)
   is a special case of the syntax described next: content
diff --git a/archive.c b/archive.c
index d254fa5..a76c068 100644
--- a/archive.c
+++ b/archive.c
@@ -7,9 +7,9 @@
 #include "unpack-trees.h"
=20
 static char const * const archive_usage[] =3D {
-	N_("git archive [options] <tree-ish> [<path>...]"),
+	N_("git archive [options] <treeish> [<path>...]"),
 	N_("git archive --list"),
-	N_("git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [=
<path>...]"),
+	N_("git archive --remote <repo> [--exec <cmd>] [options] <treeish> [<=
path>...]"),
 	N_("git archive --remote <repo> [--exec <cmd>] --list"),
 	NULL
 };
@@ -373,7 +373,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	if (!format)
 		format =3D "tar";
=20
-	/* We need at least one parameter -- tree-ish */
+	/* We need at least one parameter -- treeish */
 	if (argc < 1)
 		usage_with_options(archive_usage, opts);
 	*ar =3D lookup_archiver(format);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7025938..3b375e4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -283,7 +283,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 			continue;
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			/*
-			 * "git checkout tree-ish -- path", but this entry
+			 * "git checkout treeish -- path", but this entry
 			 * is in the original index; it will not be checked
 			 * out to the working tree and it does not matter
 			 * if pathspec matched this entry.  We will not do
@@ -291,11 +291,11 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
 			 */
 			continue;
 		/*
-		 * Either this entry came from the tree-ish we are
+		 * Either this entry came from the treeish we are
 		 * checking the paths out of, or we are checking out
 		 * of the index.
 		 *
-		 * If it comes from the tree-ish, we already know it
+		 * If it comes from the treeish, we already know it
 		 * matches the pathspec and could just stamp
 		 * CE_MATCHED to it from update_some(). But we still
 		 * need ps_matched and read_tree_recursive (and
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 1c737f7..d931078 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -7,7 +7,7 @@
=20
 static const char diff_cache_usage[] =3D
 "git diff-index [-m] [--cached] "
-"[<common diff options>] <tree-ish> [<path>...]"
+"[<common diff options>] <treeish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
=20
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index be6417d..757b2e8 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -88,7 +88,7 @@ static int diff_tree_stdin(char *line)
=20
 static const char diff_tree_usage[] =3D
 "git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-=
r] [--root] "
-"[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"[<common diff options>] <treeish> [<treeish>] [<path>...]\n"
 "  -r            diff recursively\n"
 "  --root        include the initial commit as diff against /dev/null\=
n"
 COMMON_DIFF_OPTIONS_HELP;
diff --git a/builtin/diff.c b/builtin/diff.c
index 9fc273d..05de306 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -261,7 +261,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	int result =3D 0;
=20
 	/*
-	 * We could get N tree-ish in the rev.pending_objects list.
+	 * We could get N treeish in the rev.pending_objects list.
 	 * Also there could be M blobs there, and P pathspecs.
 	 *
 	 * N=3D0, M=3D0:
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 5cf3e31..d57232a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -319,10 +319,10 @@ void overlay_tree_on_cache(const char *tree_name,=
 const char *prefix)
 	int i;
=20
 	if (get_sha1(tree_name, sha1))
-		die("tree-ish %s not found.", tree_name);
+		die("treeish %s not found.", tree_name);
 	tree =3D parse_tree_indirect(sha1);
 	if (!tree)
-		die("bad tree-ish %s", tree_name);
+		die("bad treeish %s", tree_name);
=20
 	/* Hoist the unmerged entries up to stage #3 to make room */
 	for (i =3D 0; i < active_nr; i++) {
@@ -506,8 +506,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
 		OPT_BOOLEAN(0, "error-unmatch", &error_unmatch,
 			N_("if any <file> is not in the index, treat this as an error")),
-		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
-			N_("pretend that paths removed since <tree-ish> are still present")=
),
+		OPT_STRING(0, "with-tree", &with_tree, N_("treeish"),
+			N_("pretend that paths removed since <treeish> are still present"))=
,
 		OPT__ABBREV(&abbrev),
 		OPT_BOOLEAN(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index fb76e38..948116a 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -24,7 +24,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
=20
 static const  char * const ls_tree_usage[] =3D {
-	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
+	N_("git ls-tree [<options>] <treeish> [<path>...]"),
 	NULL
 };
=20
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 0f5d7fe..14a6367 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -33,7 +33,7 @@ static int list_tree(unsigned char *sha1)
 }
=20
 static const char * const read_tree_usage[] =3D {
-	N_("git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefi=
x=3D<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-=
sparse-checkout] [--index-output=3D<file>] (--empty | <tree-ish1> [<tre=
e-ish2> [<tree-ish3>]])"),
+	N_("git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefi=
x=3D<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-=
sparse-checkout] [--index-output=3D<file>] (--empty | <treeish1> [<tree=
ish2> [<treeish3>]])"),
 	NULL
 };
=20
diff --git a/builtin/reset.c b/builtin/reset.c
index afa6e02..ecc47d9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -23,8 +23,8 @@
=20
 static const char * const git_reset_usage[] =3D {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<c=
ommit>]"),
-	N_("git reset [-q] <tree-ish> [--] <paths>..."),
-	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
+	N_("git reset [-q] <treeish> [--] <paths>..."),
+	N_("git reset --patch [<treeish>] [--] [<paths>...]"),
 	NULL
 };
=20
diff --git a/builtin/tar-tree.c b/builtin/tar-tree.c
index 3f1e701..8d751a2 100644
--- a/builtin/tar-tree.c
+++ b/builtin/tar-tree.c
@@ -8,7 +8,7 @@
 #include "quote.h"
=20
 static const char tar_tree_usage[] =3D
-"git tar-tree [--remote=3D<repo>] <tree-ish> [basedir]\n"
+"git tar-tree [--remote=3D<repo>] <treeish> [basedir]\n"
 "*** Note that this command is now deprecated; use \"git archive\" ins=
tead.";
=20
 static const char builtin_get_tar_commit_id_usage[] =3D
@@ -21,10 +21,10 @@ int cmd_tar_tree(int argc, const char **argv, const=
 char *prefix)
 	 *
 	 * $0 --remote=3D<repo> arg... =3D=3D>
 	 *	git archive --format=3Dtar --remote=3D<repo> arg...
-	 * $0 tree-ish =3D=3D>
-	 *	git archive --format=3Dtar tree-ish
-	 * $0 tree-ish basedir =3D=3D>
-	 * 	git archive --format-tar --prefix=3Dbasedir tree-ish
+	 * $0 treeish =3D=3D>
+	 *	git archive --format=3Dtar treeish
+	 * $0 treeish basedir =3D=3D>
+	 * 	git archive --format-tar --prefix=3Dbasedir treeish
 	 */
 	int i;
 	const char **nargv =3D xcalloc(sizeof(*nargv), argc + 3);
@@ -57,7 +57,7 @@ int cmd_tar_tree(int argc, const char **argv, const c=
har *prefix)
 		nargv[nargc++] =3D basedir_arg;
 		/* fallthru */
 	case 2:
-		/* tree-ish */
+		/* treeish */
 		nargv[nargc++] =3D argv[1];
 	}
 	nargv[nargc] =3D NULL;
diff --git a/contrib/examples/git-checkout.sh b/contrib/examples/git-ch=
eckout.sh
index 1a7689a..9c6a1a9 100755
--- a/contrib/examples/git-checkout.sh
+++ b/contrib/examples/git-checkout.sh
@@ -85,7 +85,7 @@ then
 	shift
 elif rev=3D$(git rev-parse --verify "$rev^{tree}" 2>/dev/null)
 then
-	# checking out selected paths from a tree-ish.
+	# checking out selected paths from a treeish.
 	new=3D"$rev"
 	new_name=3D"$rev^{tree}"
 	shift
@@ -110,7 +110,7 @@ esac
 #
 # With paths, we are _never_ switching branch, but checking out
 # the named paths from either index (when no rev is given),
-# or the named tree-ish (when rev is given).
+# or the named treeish (when rev is given).
=20
 if test "$#" -ge 1
 then
@@ -126,9 +126,9 @@ Did you intend to checkout '$@' which can not be re=
solved as commit?"
 	fi
 	if test '' !=3D "$new"
 	then
-		# from a specific tree-ish; note that this is for
+		# from a specific treeish; note that this is for
 		# rescuing paths and is never meant to remove what
-		# is not in the named tree-ish.
+		# is not in the named treeish.
 		git ls-tree --full-name -r "$new" "$@" |
 		git update-index --index-info || exit $?
 	fi
@@ -147,7 +147,7 @@ Did you intend to checkout '$@' which can not be re=
solved as commit?"
 	exit $?
 else
 	# Make sure we did not fall back on $arg^{tree} codepath
-	# since we are not checking out from an arbitrary tree-ish,
+	# since we are not checking out from an arbitrary treeish,
 	# but switching branches.
 	if test '' !=3D "$new"
 	then
diff --git a/fast-import.c b/fast-import.c
index 23f625f..b86576b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3053,7 +3053,7 @@ static void parse_ls(struct branch *b)
 		hashcpy(root->versions[1].sha1, e->idx.sha1);
 		load_tree(root);
 		if (*p++ !=3D ' ')
-			die("Missing space after tree-ish: %s", command_buf.buf);
+			die("Missing space after treeish: %s", command_buf.buf);
 	}
 	if (*p =3D=3D '"') {
 		static struct strbuf uq =3D STRBUF_INIT;
diff --git a/git-svn.perl b/git-svn.perl
index ff1ce3d..f9de11e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -216,7 +216,7 @@ my %cmd =3D (
 	           'username=3Ds' =3D> \$Git::SVN::Prompt::_username,
 	           'commit-url=3Ds' =3D> \$_commit_url } ],
 	'set-tree' =3D> [ \&cmd_set_tree,
-	                "Set an SVN repository to a git tree-ish",
+	                "Set an SVN repository to a git treeish",
 			{ 'stdin' =3D> \$_stdin, %cmt_opts, %fc_opts, } ],
 	'create-ignore' =3D> [ \&cmd_create_ignore,
 			     'Create a .gitignore per svn:ignore',
@@ -259,7 +259,7 @@ my %cmd =3D (
 			  'pager=3Ds' =3D> \$Git::SVN::Log::pager
 			} ],
 	'find-rev' =3D> [ \&cmd_find_rev,
-	                "Translate between SVN revision numbers and tree-ish"=
,
+	                "Translate between SVN revision numbers and treeish",
 			{ 'before' =3D> \$_before,
 			  'after' =3D> \$_after } ],
 	'rebase' =3D> [ \&cmd_rebase, "Fetch and rebase your working director=
y",
@@ -1431,7 +1431,7 @@ sub cmd_multi_fetch {
 sub cmd_commit_diff {
 	my ($ta, $tb, $url) =3D @_;
 	my $usage =3D "usage: $0 commit-diff -r<revision> ".
-	            "<tree-ish> <tree-ish> [<URL>]";
+	            "<treeish> <treeish> [<URL>]";
 	fatal($usage) if (!defined $ta || !defined $tb);
 	my $svn_path =3D '';
 	if (!defined $url) {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f429f75..3f4c8ae 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2765,7 +2765,7 @@ sub git_get_hash_by_path {
 	return $3;
 }
=20
-# get path of entry with given hash at given tree-ish (ref)
+# get path of entry with given hash at given treeish (ref)
 # used to get 'from' filename for combined diff (merge commit) for ren=
ames
 sub git_get_path_by_hash {
 	my $base =3D shift || return;
@@ -7235,7 +7235,7 @@ sub git_snapshot {
 	if (!$type) {
 		die_error(404, 'Object does not exist');
 	}  elsif ($type eq 'blob') {
-		die_error(400, 'Object is not a tree-ish');
+		die_error(400, 'Object is not a treeish');
 	}
=20
 	my ($name, $prefix) =3D snapshot_name($project, $hash);
diff --git a/po/de.po b/po/de.po
index 11dde11..00519b2 100644
--- a/po/de.po
+++ b/po/de.po
@@ -39,7 +39,7 @@ msgstr ""
 "oder benutzen Sie 'git commit -a'."
=20
 #: archive.c:10
-msgid "git archive [options] <tree-ish> [<path>...]"
+msgid "git archive [options] <treeish> [<path>...]"
 msgstr "git archive [Optionen] <Commit-Referenz> [<Pfad>...]"
=20
 #: archive.c:11
@@ -48,7 +48,7 @@ msgstr "git archive --list"
=20
 #: archive.c:12
 msgid ""
-"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pat=
h>...]"
+"git archive --remote <repo> [--exec <cmd>] [options] <treeish> [<path=
>...]"
 msgstr ""
 "git archive --remote <Repository> [--exec <Programm>] [Optionen] <Com=
mit-"
 "Referenz> [Pfad...]"
@@ -6494,11 +6494,11 @@ msgstr ""
 "befindet"
=20
 #: builtin/ls-files.c:509
-msgid "tree-ish"
+msgid "treeish"
 msgstr "Commit-Referenz"
=20
 #: builtin/ls-files.c:510
-msgid "pretend that paths removed since <tree-ish> are still present"
+msgid "pretend that paths removed since <treeish> are still present"
 msgstr ""
 "gibt vor, dass Pfade, die seit <Commit-Referenz> gel=C3=B6scht wurden=
, immer noch "
 "vorhanden sind"
@@ -6508,7 +6508,7 @@ msgid "show debugging data"
 msgstr "zeigt Ausgaben zur Fehlersuche an"
=20
 #: builtin/ls-tree.c:27
-msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
+msgid "git ls-tree [<options>] <treeish> [<path>...]"
 msgstr "git ls-tree [<Optionen>] <Commit-Referenz> [<Pfad>...]"
=20
 #: builtin/ls-tree.c:125
@@ -7969,7 +7969,7 @@ msgstr "Die Option --delete kann nur mit Referenz=
en verwendet werden."
 msgid ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
-"index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish=
3>]])"
+"index-output=3D<file>] (--empty | <treeish1> [<treeish2> [<treeish3>]=
])"
 msgstr ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<Prefix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
@@ -8596,11 +8596,11 @@ msgstr ""
 "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<Commi=
t>]"
=20
 #: builtin/reset.c:26
-msgid "git reset [-q] <tree-ish> [--] <paths>..."
+msgid "git reset [-q] <treeish> [--] <paths>..."
 msgstr "git reset [-q] <Commit-Referenz> [--] <Pfade>..."
=20
 #: builtin/reset.c:27
-msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
+msgid "git reset --patch [<treeish>] [--] [<paths>...]"
 msgstr "git reset --patch [<Commit-Referenz>] [--] [<Pfade>...]"
=20
 #: builtin/reset.c:33
diff --git a/po/fr.po b/po/fr.po
index fa98cfe..8d74171 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -37,7 +37,7 @@ msgstr "Corrigez-les dans l'espace de travail,\n"
 "ou utilisez 'git commit -a'."
=20
 #: archive.c:10
-msgid "git archive [options] <tree-ish> [<path>...]"
+msgid "git archive [options] <treeish> [<path>...]"
 msgstr "git archive [options] <arbre> [<chemin>...]"
=20
 #: archive.c:11
@@ -46,7 +46,7 @@ msgstr "git archive --list"
=20
 #: archive.c:12
 msgid ""
-"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pat=
h>...]"
+"git archive --remote <repo> [--exec <cmd>] [options] <treeish> [<path=
>...]"
 msgstr "git archive --remote <d=C3=A9pot> [--exec <commande>] [options=
] <arbre> [<chemin>...]"
=20
 #: archive.c:13
@@ -5959,11 +5959,11 @@ msgid "if any <file> is not in the index, treat=
 this as an error"
 msgstr ""
=20
 #: builtin/ls-files.c:503
-msgid "tree-ish"
+msgid "treeish"
 msgstr ""
=20
 #: builtin/ls-files.c:504
-msgid "pretend that paths removed since <tree-ish> are still present"
+msgid "pretend that paths removed since <treeish> are still present"
 msgstr ""
=20
 #: builtin/ls-files.c:506
@@ -5971,7 +5971,7 @@ msgid "show debugging data"
 msgstr ""
=20
 #: builtin/ls-tree.c:27
-msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
+msgid "git ls-tree [<options>] <treeish> [<path>...]"
 msgstr ""
=20
 #: builtin/ls-tree.c:125
@@ -7307,7 +7307,7 @@ msgstr ""
 msgid ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
-"index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish=
3>]])"
+"index-output=3D<file>] (--empty | <treeish1> [<treeish2> [<treeish3>]=
])"
 msgstr ""
=20
 #: builtin/read-tree.c:108
@@ -7894,11 +7894,11 @@ msgid ""
 msgstr ""
=20
 #: builtin/reset.c:26
-msgid "git reset [-q] <tree-ish> [--] <paths>..."
+msgid "git reset [-q] <treeish> [--] <paths>..."
 msgstr ""
=20
 #: builtin/reset.c:27
-msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
+msgid "git reset --patch [<treeish>] [--] [<paths>...]"
 msgstr ""
=20
 #: builtin/reset.c:33
diff --git a/po/git.pot b/po/git.pot
index cf1e446..928268f 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -36,7 +36,7 @@ msgid ""
 msgstr ""
=20
 #: archive.c:10
-msgid "git archive [options] <tree-ish> [<path>...]"
+msgid "git archive [options] <treeish> [<path>...]"
 msgstr ""
=20
 #: archive.c:11
@@ -45,7 +45,7 @@ msgstr ""
=20
 #: archive.c:12
 msgid ""
-"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pat=
h>...]"
+"git archive --remote <repo> [--exec <cmd>] [options] <treeish> [<path=
>...]"
 msgstr ""
=20
 #: archive.c:13
@@ -6084,11 +6084,11 @@ msgid "if any <file> is not in the index, treat=
 this as an error"
 msgstr ""
=20
 #: builtin/ls-files.c:509
-msgid "tree-ish"
+msgid "treeish"
 msgstr ""
=20
 #: builtin/ls-files.c:510
-msgid "pretend that paths removed since <tree-ish> are still present"
+msgid "pretend that paths removed since <treeish> are still present"
 msgstr ""
=20
 #: builtin/ls-files.c:512
@@ -6096,7 +6096,7 @@ msgid "show debugging data"
 msgstr ""
=20
 #: builtin/ls-tree.c:27
-msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
+msgid "git ls-tree [<options>] <treeish> [<path>...]"
 msgstr ""
=20
 #: builtin/ls-tree.c:125
@@ -7411,7 +7411,7 @@ msgstr ""
 msgid ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
-"index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish=
3>]])"
+"index-output=3D<file>] (--empty | <treeish1> [<treeish2> [<treeish3>]=
])"
 msgstr ""
=20
 #: builtin/read-tree.c:109
@@ -8008,11 +8008,11 @@ msgid ""
 msgstr ""
=20
 #: builtin/reset.c:26
-msgid "git reset [-q] <tree-ish> [--] <paths>..."
+msgid "git reset [-q] <treeish> [--] <paths>..."
 msgstr ""
=20
 #: builtin/reset.c:27
-msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
+msgid "git reset --patch [<treeish>] [--] [<paths>...]"
 msgstr ""
=20
 #: builtin/reset.c:33
diff --git a/po/sv.po b/po/sv.po
index 12dfca9..cdee340 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -39,7 +39,7 @@ msgstr ""
 "eller anv=C3=A4nd \"git commit -a\"."
=20
 #: archive.c:10
-msgid "git archive [options] <tree-ish> [<path>...]"
+msgid "git archive [options] <treeish> [<path>...]"
 msgstr "git archive [flaggor] <tr=C3=A4d-igt> [<s=C3=B6kv=C3=A4g>...]"
=20
 #: archive.c:11
@@ -48,7 +48,7 @@ msgstr "git archive --list"
=20
 #: archive.c:12
 msgid ""
-"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pat=
h>...]"
+"git archive --remote <repo> [--exec <cmd>] [options] <treeish> [<path=
>...]"
 msgstr ""
 "git archive --remote <arkiv> [--exec <kmd>] [flaggor] <tr=C3=A4d-igt>=
 "
 "[<s=C3=B6kv=C3=A4g>...]"
@@ -6334,11 +6334,11 @@ msgid "if any <file> is not in the index, treat=
 this as an error"
 msgstr "om en <fil> inte =C3=A4r indexet, betrakta det som ett fel"
=20
 #: builtin/ls-files.c:509
-msgid "tree-ish"
+msgid "treeish"
 msgstr "tr=C3=A4d-igt"
=20
 #: builtin/ls-files.c:510
-msgid "pretend that paths removed since <tree-ish> are still present"
+msgid "pretend that paths removed since <treeish> are still present"
 msgstr "l=C3=A5tsas att s=C3=B6kv=C3=A4gar borttagna sedan <tr=C3=A4d-=
igt> fortfarande finns"
=20
 #: builtin/ls-files.c:512
@@ -6346,7 +6346,7 @@ msgid "show debugging data"
 msgstr "visa fels=C3=B6kningsutdata"
=20
 #: builtin/ls-tree.c:27
-msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
+msgid "git ls-tree [<options>] <treeish> [<path>...]"
 msgstr "git ls-tree [<flaggor>] <tr=C3=A4d-igt> [<s=C3=B6kv=C3=A4g>...=
]"
=20
 #: builtin/ls-tree.c:125
@@ -7770,7 +7770,7 @@ msgstr "--delete kan inte anv=C3=A4ndas utan refe=
renser"
 msgid ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
-"index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish=
3>]])"
+"index-output=3D<file>] (--empty | <treeish1> [<treeish2> [<treeish3>]=
])"
 msgstr ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
@@ -8383,11 +8383,11 @@ msgstr ""
 "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<inche=
ckning>]"
=20
 #: builtin/reset.c:26
-msgid "git reset [-q] <tree-ish> [--] <paths>..."
+msgid "git reset [-q] <treeish> [--] <paths>..."
 msgstr "git reset [-q] <tr=C3=A4d-igt> [--] <s=C3=B6kv=C3=A4gar>..."
=20
 #: builtin/reset.c:27
-msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
+msgid "git reset --patch [<treeish>] [--] [<paths>...]"
 msgstr "git reset --patch [<tr=C3=A4d-igt>] [--] [<s=C3=B6kv=C3=A4gar>=
=2E..]"
=20
 #: builtin/reset.c:33
diff --git a/po/vi.po b/po/vi.po
index dd2d2a7..ebc079c 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -43,8 +43,8 @@ msgstr ""
 "ho=E1=BA=B7c l=C3=A0 d=C3=B9ng l=E1=BB=87nh \"git commit -a\"."
=20
 #: archive.c:10
-msgid "git archive [options] <tree-ish> [<path>...]"
-msgstr "git archive [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] <tree-ish> [<=C4=91=
=C6=B0=E1=BB=9Dng-d=E1=BA=ABn>...]"
+msgid "git archive [options] <treeish> [<path>...]"
+msgstr "git archive [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] <treeish> [<=C4=91=
=C6=B0=E1=BB=9Dng-d=E1=BA=ABn>...]"
=20
 #: archive.c:11
 msgid "git archive --list"
@@ -52,9 +52,9 @@ msgstr "git archive --list"
=20
 #: archive.c:12
 msgid ""
-"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pat=
h>...]"
+"git archive --remote <repo> [--exec <cmd>] [options] <treeish> [<path=
>...]"
 msgstr ""
-"git archive --remote <kho> [--exec <l=E1=BB=87nh>] [c=C3=A1c-t=C3=B9y=
-ch=E1=BB=8Dn] <tree-ish> [<=C4=91=C6=B0=E1=BB=9Dng-"
+"git archive --remote <kho> [--exec <l=E1=BB=87nh>] [c=C3=A1c-t=C3=B9y=
-ch=E1=BB=8Dn] <treeish> [<=C4=91=C6=B0=E1=BB=9Dng-"
 "d=E1=BA=ABn>...]"
=20
 #: archive.c:13
@@ -6450,21 +6450,21 @@ msgid "if any <file> is not in the index, treat=
 this as an error"
 msgstr "n=E1=BA=BFu <t=E1=BA=ADp tin> b=E1=BA=A5t k=E1=BB=B3 kh=C3=B4n=
g =E1=BB=9F trong b=E1=BA=A3ng m=E1=BB=A5c l=E1=BB=A5c, x=E1=BB=AD l=C3=
=BD n=C3=B3 nh=C6=B0 m=E1=BB=99t l=E1=BB=97i"
=20
 #: builtin/ls-files.c:509
-msgid "tree-ish"
-msgstr "tree-ish"
+msgid "treeish"
+msgstr "treeish"
=20
 #: builtin/ls-files.c:510
-msgid "pretend that paths removed since <tree-ish> are still present"
+msgid "pretend that paths removed since <treeish> are still present"
 msgstr ""
-"gi=E1=BA=A3 =C4=91=E1=BB=8Bnh r=E1=BA=B1ng c=C3=A1c =C4=91=C6=B0=E1=BB=
=9Dng d=E1=BA=ABn =C4=91=C3=A3 b=E1=BB=8B g=E1=BB=A1 b=E1=BB=8F k=E1=BB=
=83 t=E1=BB=AB <tree-ish> nay v=E1=BA=ABn hi=E1=BB=87n di=E1=BB=87n"
+"gi=E1=BA=A3 =C4=91=E1=BB=8Bnh r=E1=BA=B1ng c=C3=A1c =C4=91=C6=B0=E1=BB=
=9Dng d=E1=BA=ABn =C4=91=C3=A3 b=E1=BB=8B g=E1=BB=A1 b=E1=BB=8F k=E1=BB=
=83 t=E1=BB=AB <treeish> nay v=E1=BA=ABn hi=E1=BB=87n di=E1=BB=87n"
=20
 #: builtin/ls-files.c:512
 msgid "show debugging data"
 msgstr "hi=E1=BB=83n th=E1=BB=8B d=E1=BB=AF li=E1=BB=87u g=E1=BB=A1 l=E1=
=BB=97i"
=20
 #: builtin/ls-tree.c:27
-msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
-msgstr "git ls-tree [<c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn>] <tree-ish> [<=C4=
=91=C6=B0=E1=BB=9Dng-d=E1=BA=ABn>...]"
+msgid "git ls-tree [<options>] <treeish> [<path>...]"
+msgstr "git ls-tree [<c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn>] <treeish> [<=C4=
=91=C6=B0=E1=BB=9Dng-d=E1=BA=ABn>...]"
=20
 #: builtin/ls-tree.c:125
 msgid "only show trees"
@@ -7912,12 +7912,11 @@ msgstr "--delete kh=C3=B4ng h=E1=BB=A3p l=C3=BD=
 n=E1=BA=BFu kh=C3=B4ng c=C3=B3 b=E1=BA=A5t k=E1=BB=B3 tham chi=E1=BA=BF=
u (refs
 msgid ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
-"index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish=
3>]])"
+"index-output=3D<file>] (--empty | <treeish1> [<treeish2> [<treeish3>]=
])"
 msgstr ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<ti=E1=BB=81n-"
 "t=E1=BB=91>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no=
-sparse-checkout] "
-"[--index-output=3D<t=E1=BA=ADp-tin>] (--empty | <tree-ish1> [<tree-is=
h2> [<tree-"
-"ish3>]])"
+"[--index-output=3D<t=E1=BA=ADp-tin>] (--empty | <treeish1> [<treeish2=
> [<treeish3>]])"
=20
 #: builtin/read-tree.c:109
 msgid "write resulting index to <file>"
@@ -8529,12 +8528,12 @@ msgstr ""
 "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commi=
t>]"
=20
 #: builtin/reset.c:26
-msgid "git reset [-q] <tree-ish> [--] <paths>..."
-msgstr "git reset [-q] <tree-ish> [--] <=C4=91=C6=B0=E1=BB=9Dng-d=E1=BA=
=ABn>..."
+msgid "git reset [-q] <treeish> [--] <paths>..."
+msgstr "git reset [-q] <treeish> [--] <=C4=91=C6=B0=E1=BB=9Dng-d=E1=BA=
=ABn>..."
=20
 #: builtin/reset.c:27
-msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
-msgstr "git reset --patch [<tree-ish>] [--] [<c=C3=A1c-=C4=91=C6=B0=E1=
=BB=9Dng-d=E1=BA=ABn>...]"
+msgid "git reset --patch [<treeish>] [--] [<paths>...]"
+msgstr "git reset --patch [<treeish>] [--] [<c=C3=A1c-=C4=91=C6=B0=E1=BB=
=9Dng-d=E1=BA=ABn>...]"
=20
 #: builtin/reset.c:33
 msgid "mixed"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index b7b46f1..497d847 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -43,7 +43,7 @@ msgstr ""
 "=E6=88=96=E4=BD=BF=E7=94=A8 'git commit -a'=E3=80=82"
=20
 #: archive.c:10
-msgid "git archive [options] <tree-ish> [<path>...]"
+msgid "git archive [options] <treeish> [<path>...]"
 msgstr "git archive [=E9=80=89=E9=A1=B9] <=E6=A0=91=E6=88=96=E6=8F=90=E4=
=BA=A4> [<=E8=B7=AF=E5=BE=84>...]"
=20
 #: archive.c:11
@@ -52,7 +52,7 @@ msgstr "git archive --list"
=20
 #: archive.c:12
 msgid ""
-"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pat=
h>...]"
+"git archive --remote <repo> [--exec <cmd>] [options] <treeish> [<path=
>...]"
 msgstr ""
 "git archive --remote <=E7=89=88=E6=9C=AC=E5=BA=93> [--exec <=E5=91=BD=
=E4=BB=A4>] [=E9=80=89=E9=A1=B9] <=E6=A0=91=E6=88=96=E6=8F=90=E4=BA=A4>=
 [<=E8=B7=AF=E5=BE=84>...]"
=20
@@ -6338,11 +6338,11 @@ msgid "if any <file> is not in the index, treat=
 this as an error"
 msgstr "=E5=A6=82=E6=9E=9C=E4=BB=BB=E4=BD=95 <=E6=96=87=E4=BB=B6> =E9=83=
=BD=E4=B8=8D=E5=9C=A8=E7=B4=A2=E5=BC=95=E5=8C=BA=EF=BC=8C=E8=A7=86=E4=B8=
=BA=E9=94=99=E8=AF=AF"
=20
 #: builtin/ls-files.c:509
-msgid "tree-ish"
+msgid "treeish"
 msgstr "=E6=A0=91=E6=88=96=E6=8F=90=E4=BA=A4"
=20
 #: builtin/ls-files.c:510
-msgid "pretend that paths removed since <tree-ish> are still present"
+msgid "pretend that paths removed since <treeish> are still present"
 msgstr "=E5=81=87=E8=A3=85=E8=87=AA=E4=BB=8E <=E6=A0=91=E6=88=96=E6=8F=
=90=E4=BA=A4> =E4=B9=8B=E5=90=8E=E5=88=A0=E9=99=A4=E7=9A=84=E8=B7=AF=E5=
=BE=84=E4=BB=8D=E7=84=B6=E5=AD=98=E5=9C=A8"
=20
 #: builtin/ls-files.c:512
@@ -6350,7 +6350,7 @@ msgid "show debugging data"
 msgstr "=E6=98=BE=E7=A4=BA=E8=B0=83=E8=AF=95=E6=95=B0=E6=8D=AE"
=20
 #: builtin/ls-tree.c:27
-msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
+msgid "git ls-tree [<options>] <treeish> [<path>...]"
 msgstr "git ls-tree [<=E9=80=89=E9=A1=B9>] <=E6=A0=91=E6=88=96=E6=8F=90=
=E4=BA=A4> [<=E8=B7=AF=E5=BE=84>...]"
=20
 #: builtin/ls-tree.c:125
@@ -7740,7 +7740,7 @@ msgstr "--delete =E6=9C=AA=E6=8E=A5=E4=BB=BB=E4=BD=
=95=E5=BC=95=E7=94=A8=E6=B2=A1=E6=9C=89=E6=84=8F=E4=B9=89"
 msgid ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
-"index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish=
3>]])"
+"index-output=3D<file>] (--empty | <treeish1> [<treeish2> [<treeish3>]=
])"
 msgstr ""
 "git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<=E5=89=8D=E7=BC=80>] [-"
 "u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-checkou=
t] [--"
@@ -8350,11 +8350,11 @@ msgid ""
 msgstr "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] =
[<=E6=8F=90=E4=BA=A4>]"
=20
 #: builtin/reset.c:26
-msgid "git reset [-q] <tree-ish> [--] <paths>..."
+msgid "git reset [-q] <treeish> [--] <paths>..."
 msgstr "git reset [-q] <=E6=A0=91=E6=88=96=E6=8F=90=E4=BA=A4> [--] <=E8=
=B7=AF=E5=BE=84>..."
=20
 #: builtin/reset.c:27
-msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
+msgid "git reset --patch [<treeish>] [--] [<paths>...]"
 msgstr "git reset --patch [<=E6=A0=91=E6=88=96=E6=8F=90=E4=BA=A4>] [--=
] [<=E8=B7=AF=E5=BE=84>...]"
=20
 #: builtin/reset.c:33
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-di=
sambiguation.sh
index 4a155c8..840bb6e 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -45,12 +45,12 @@ test_expect_success 'warn ambiguity when no candida=
te matches type hint' '
 	grep "short SHA1 000000000 is ambiguous" actual
 '
=20
-test_expect_success 'disambiguate tree-ish' '
-	# feed tree-ish in an unambiguous way
+test_expect_success 'disambiguate treeish' '
+	# feed treeish in an unambiguous way
 	git rev-parse --verify 0000000000cdc:a0blgqsjc &&
=20
 	# ambiguous at the object name level, but there is only one
-	# such tree-ish (the other is a blob)
+	# such treeish (the other is a blob)
 	git rev-parse --verify 000000000:a0blgqsjc
 '
=20
@@ -159,8 +159,8 @@ test_expect_failure 'two semi-ambiguous commit-ish'=
 '
 	git log 0000000000...
 '
=20
-test_expect_failure 'three semi-ambiguous tree-ish' '
-	# Likewise for tree-ish.  HEAD, v1.0.0 and HEAD^{tree} share
+test_expect_failure 'three semi-ambiguous treeish' '
+	# Likewise for treeish.  HEAD, v1.0.0 and HEAD^{tree} share
 	# the prefix but peeling them to tree yields the same thing
 	git rev-parse --verify 0000000000^{tree}
 '
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous=
=2Esh
index 7cc0a35..9a4736c 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -41,7 +41,7 @@ test_expect_success 'check ambiguity' '
 	test_must_fail git checkout world all
 '
=20
-test_expect_success 'disambiguate checking out from a tree-ish' '
+test_expect_success 'disambiguate checking out from a treeish' '
 	echo bye > world &&
 	git checkout world -- world &&
 	git diff --exit-code --quiet
diff --git a/t/t4100/t-apply-3.patch b/t/t4100/t-apply-3.patch
index 90cdbaa..c0242f1 100644
--- a/t/t4100/t-apply-3.patch
+++ b/t/t4100/t-apply-3.patch
@@ -12,8 +12,8 @@ diff --git a/Documentation/git-ls-tree.txt b/Document=
ation/git-ls-tree.txt
 =20
  SYNOPSIS
  --------
--'git-ls-tree' [-r] [-z] <tree-ish> [paths...]
-+'git-ls-tree' [-d] [-r] [-z] <tree-ish> [paths...]
+-'git-ls-tree' [-r] [-z] <treeish> [paths...]
++'git-ls-tree' [-d] [-r] [-z] <treeish> [paths...]
 =20
  DESCRIPTION
  -----------
@@ -24,7 +24,7 @@ diff --git a/Documentation/git-ls-tree.txt b/Document=
ation/git-ls-tree.txt
 =20
  OPTIONS
  -------
- <tree-ish>::
+ <treeish>::
  	Id of a tree.
 =20
 +-d::
@@ -485,7 +485,7 @@ dissimilarity index 82%
 +}
 +
 +static const char *ls_tree_usage =3D
-+	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
++	"git-ls-tree [-d] [-r] [-z] <treeish> [path...]";
 +
 +int main(int argc, char **argv)
 +{
diff --git a/t/t4100/t-apply-7.patch b/t/t4100/t-apply-7.patch
index 07c6589..83ac01e 100644
--- a/t/t4100/t-apply-7.patch
+++ b/t/t4100/t-apply-7.patch
@@ -11,8 +11,8 @@ diff a/Documentation/git-ls-tree.txt b/Documentation/=
git-ls-tree.txt
 =20
  SYNOPSIS
  --------
--'git-ls-tree' [-r] [-z] <tree-ish> [paths...]
-+'git-ls-tree' [-d] [-r] [-z] <tree-ish> [paths...]
+-'git-ls-tree' [-r] [-z] <treeish> [paths...]
++'git-ls-tree' [-d] [-r] [-z] <treeish> [paths...]
 =20
  DESCRIPTION
  -----------
@@ -23,7 +23,7 @@ diff a/Documentation/git-ls-tree.txt b/Documentation/=
git-ls-tree.txt
 =20
  OPTIONS
  -------
- <tree-ish>::
+ <treeish>::
  	Id of a tree.
 =20
 +-d::
@@ -415,7 +415,7 @@ diff a/ls-tree.c b/ls-tree.c
 =20
 -static const char *ls_tree_usage =3D "git-ls-tree [-r] [-z] <key> [pa=
ths...]";
 +static const char *ls_tree_usage =3D
-+	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
++	"git-ls-tree [-d] [-r] [-z] <treeish> [path...]";
 =20
  int main(int argc, char **argv)
  {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ac6f3b6..4e1f2b8 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2931,7 +2931,7 @@ test_expect_success 'S: ls with garbage after sha=
1 must fail' '
 	ls ${sha1}x hello.c
 	EOF
 	cat err &&
-	test_i18ngrep "space after tree-ish" err
+	test_i18ngrep "space after treeish" err
 '
=20
 test_done
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-st=
andalone-no-errors.sh
index 6fca193..7c8cd90 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -131,7 +131,7 @@ test_expect_success \
=20
=20
 # --------------------------------------------------------------------=
--
-# commitdiff testing (implicit, one implicit tree-ish)
+# commitdiff testing (implicit, one implicit treeish)
=20
 test_expect_success \
 	'commitdiff(0): root' \
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-=
standalone-http-status.sh
index d3a5bac..54fe370 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -84,25 +84,25 @@ test_debug 'cat gitweb.headers'
 # --------------------------------------------------------------------=
--
 # snapshot hash ids
=20
-test_expect_success 'snapshots: good tree-ish id' '
+test_expect_success 'snapshots: good treeish id' '
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
 	grep "Status: 200 OK" gitweb.output
 '
 test_debug 'cat gitweb.headers'
=20
-test_expect_success 'snapshots: bad tree-ish id' '
+test_expect_success 'snapshots: bad treeish id' '
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3DfrizzumFrazzum;sf=3Dtgz" &&
 	grep "404 - Object does not exist" gitweb.output
 '
 test_debug 'cat gitweb.output'
=20
-test_expect_success 'snapshots: bad tree-ish id (tagged object)' '
+test_expect_success 'snapshots: bad treeish id (tagged object)' '
 	echo object > tag-object &&
 	git add tag-object &&
 	test_tick && git commit -m "Object to be tagged" &&
 	git tag tagged-object `git hash-object tag-object` &&
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dtagged-object;sf=3Dtgz" &&
-	grep "400 - Object is not a tree-ish" gitweb.output
+	grep "400 - Object is not a treeish" gitweb.output
 '
 test_debug 'cat gitweb.output'
=20
--=20
1.8.4
