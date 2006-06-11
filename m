From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Make Documentation (somehwat more) consistent
Date: Sun, 11 Jun 2006 16:37:48 -0400
Message-ID: <11500582752231-git-send-email-vonbrand@inf.utfsm.cl>
References: <11500582682293-git-send-email-vonbrand@inf.utfsm.cl>
Reply-To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 22:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpWhN-0002eH-Fx
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 22:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWFKUiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 16:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWFKUiO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 16:38:14 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6292 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750987AbWFKUiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 16:38:10 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k5BKbtHf019440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Jun 2006 16:37:58 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k5BKbuJX007330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Jun 2006 16:37:57 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k5BKbtMY007329;
	Sun, 11 Jun 2006 16:37:55 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0.g1b2d
In-Reply-To: <11500582682293-git-send-email-vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 11 Jun 2006 16:38:03 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21668>

Fix the quoting of the command names, files, etc
The commands should be used as 'git foo', not 'git-foo'
Fix some messed up grammar and typing

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-ls-remote.txt          |   10 ++--
 Documentation/git-ls-tree.txt            |    8 ++-
 Documentation/git-mailinfo.txt           |   20 ++++----
 Documentation/git-mailsplit.txt          |    6 +-
 Documentation/git-merge-base.txt         |    8 ++-
 Documentation/git-merge-index.txt        |    6 +-
 Documentation/git-merge-one-file.txt     |    6 +-
 Documentation/git-merge-tree.txt         |    4 +-
 Documentation/git-merge.txt              |   20 ++++----
 Documentation/git-mktag.txt              |    2 -
 Documentation/git-mktree.txt             |    2 -
 Documentation/git-mv.txt                 |    8 ++-
 Documentation/git-name-rev.txt           |    9 ++--
 Documentation/git-p4import.txt           |   28 ++++++-----
 Documentation/git-pack-objects.txt       |   20 ++++----
 Documentation/git-pack-redundant.txt     |    8 ++-
 Documentation/git-patch-id.txt           |   10 ++--
 Documentation/git-peek-remote.txt        |   22 ++++-----
 Documentation/git-prune-packed.txt       |    4 +-
 Documentation/git-prune.txt              |    4 +-
 Documentation/git-pull.txt               |    2 -
 Documentation/git-push.txt               |    2 -
 Documentation/git-quiltimport.txt        |    8 ++-
 Documentation/git-read-tree.txt          |   74 +++++++++++++++---------------
 Documentation/git-rebase.txt             |   30 ++++++------
 Documentation/git-receive-pack.txt       |   26 +++++------
 Documentation/git-relink.txt             |    9 ++--
 Documentation/git-repack.txt             |   12 ++---
 Documentation/git-repo-config.txt        |   28 ++++++-----
 Documentation/git-request-pull.txt       |    2 -
 Documentation/git-rerere.txt             |   18 ++++---
 Documentation/git-reset.txt              |   10 ++--
 Documentation/git-resolve.txt            |    2 -
 Documentation/git-rev-list.txt           |   16 +++---
 Documentation/git-rev-parse.txt          |   12 ++---
 Documentation/git-revert.txt             |    2 -
 Documentation/git-rm.txt                 |   16 +++---
 Documentation/git-send-email.txt         |   30 ++++++------
 Documentation/git-send-pack.txt          |   18 ++++---
 Documentation/git-shell.txt              |    2 -
 Documentation/git-shortlog.txt           |    4 +-
 Documentation/git-show-branch.txt        |   20 ++++----
 Documentation/git-show-index.txt         |    6 +-
 Documentation/git-show.txt               |    8 ++-
 Documentation/git-ssh-fetch.txt          |   10 ++--
 Documentation/git-ssh-upload.txt         |    8 ++-
 Documentation/git-status.txt             |    8 ++-
 Documentation/git-stripspace.txt         |    2 -
 Documentation/git-svnimport.txt          |   34 +++++++-------
 Documentation/git-symbolic-ref.txt       |    4 +-
 Documentation/git-tag.txt                |    6 +-
 Documentation/git-tar-tree.txt           |    8 ++-
 Documentation/git-unpack-file.txt        |    2 -
 Documentation/git-unpack-objects.txt     |    2 -
 Documentation/git-update-index.txt       |   46 +++++++++----------
 Documentation/git-update-ref.txt         |   10 ++--
 Documentation/git-update-server-info.txt |    2 -
 Documentation/git-upload-pack.txt        |    2 -
 Documentation/git-upload-tar.txt         |    2 -
 Documentation/git-var.txt                |    6 +-
 Documentation/git-verify-pack.txt        |    4 +-
 Documentation/git-verify-tag.txt         |    2 -
 Documentation/git-whatchanged.txt        |    6 +-
 Documentation/git-write-tree.txt         |    2 -
 64 files changed, 365 insertions(+), 363 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index ae4c1a2..db5dcf6 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -8,7 +8,7 @@ git-ls-remote - Look at references other
 
 SYNOPSIS
 --------
-'git-ls-remote' [--heads] [--tags] <repository> <refs>...
+'git ls-remote' [--heads] [--tags] <repository> <refs>...
 
 DESCRIPTION
 -----------
@@ -18,18 +18,18 @@ Displays the references other repository
 OPTIONS
 -------
 -h|--heads, -t|--tags::
-	Limit to only refs/heads and refs/tags, respectively.
+	Limit to only `refs/heads` and `refs/tags`, respectively.
 	These options are _not_ mutually exclusive; when given
-	both, references stored in refs/heads and refs/tags are
+	both, references stored in `refs/heads` and `refs/tags` are
 	displayed.
 
 <repository>::
 	Location of the repository.  The shorthand defined in
-	$GIT_DIR/branches/ can be used.
+	`$GIT_DIR/branches/` can be used.
 
 <refs>...::
 	When unspecified, all references, after filtering done
-	with --heads and --tags, are shown.  When <refs>... are
+	with `--heads` and `--tags`, are shown.  When <refs>... are
 	specified, only references matching the given patterns
 	are displayed.
 
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index f283bac..8ee3e62 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -9,7 +9,7 @@ git-ls-tree - Lists the contents of a tr
 SYNOPSIS
 --------
 [verse]
-'git-ls-tree' [-d] [-r] [-t] [-z]
+'git ls-tree' [-d] [-r] [-t] [-z]
 	    [--name-only] [--name-status] [--full-name] [--abbrev=[<n>]]
 	    <tree-ish> [paths...]
 
@@ -18,7 +18,7 @@ DESCRIPTION
 Lists the contents of a given tree object, like what "/bin/ls -a" does
 in the current working directory. Note that the usage is subtly different,
 though - 'paths' denote just a list of patterns to match, e.g. so specifying
-directory name (without '-r') will behave differently, and order of the
+directory name (without `-r`) will behave differently, and order of the
 arguments does not matter.
 
 OPTIONS
@@ -34,7 +34,7 @@ OPTIONS
 
 -t::
 	Show tree entries even when going to recurse them. Has no effect
-	if '-r' was not passed. '-d' implies '-t'.
+	if `-r` was not passed. `-d` implies `-t`.
 
 -z::
 	\0 line termination on output.
@@ -46,7 +46,7 @@ OPTIONS
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show only handful hexdigits prefix.
-	Non default number of digits can be specified with --abbrev=<n>.
+	Non default number of digits can be specified with `--abbrev=<n>`.
 
 --full-name::
 	Instead of showing the path names relative to the current working
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index ea0a065..6e83438 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -8,7 +8,7 @@ git-mailinfo - Extracts patch from a sin
 
 SYNOPSIS
 --------
-'git-mailinfo' [-k] [-u | --encoding=<encoding>] <msg> <patch>
+'git mailinfo' [-k] [-u | --encoding=<encoding>] <msg> <patch>
 
 
 DESCRIPTION
@@ -16,7 +16,7 @@ DESCRIPTION
 Reading a single e-mail message from the standard input, and
 writes the commit log message in <msg> file, and the patches in
 <patch> file.  The author name, e-mail and e-mail subject are
-written out to the standard output to be used by git-applypatch
+written out to the standard output to be used by `git-applypatch`
 to create a commit.  It is usually not necessary to use this
 command directly.
 
@@ -24,13 +24,13 @@ command directly.
 OPTIONS
 -------
 -k::
-	Usually the program 'cleans up' the Subject: header line
+	Usually the program 'cleans up' the "Subject:" header line
 	to extract the title line for the commit log message,
-	among which (1) remove 'Re:' or 're:', (2) leading
-	whitespaces, (3) '[' up to ']', typically '[PATCH]', and
+	among which (1) remove "Re:" or "re:", (2) leading
+	whitespaces, (3) "[" up to "]", typically "[PATCH]", and
 	then prepends "[PATCH] ".  This flag forbids this
-	munging, and is most useful when used to read back 'git
-	format-patch --mbox' output.
+	munging, and is most useful when used to read back `git
+	format-patch --mbox` output.
 
 -u::
 	By default, the commit log message, author name and
@@ -38,14 +38,14 @@ OPTIONS
 	charset conversion, after minimally decoding MIME
 	transfer encoding.  This flag causes the resulting
 	commit to be encoded in the encoding specified by
-	i18n.commitencoding configuration (defaults to utf-8) by
+	`i18n.commitencoding` configuration (defaults to utf-8) by
 	transliterating them. 
 	Note that the patch is always used as is without charset
 	conversion, even with this flag.
 
 --encoding=<encoding>::
-	Similar to -u but if the local convention is different
-	from what is specified by i18n.commitencoding, this flag
+	Similar to `-u` but if the local convention is different
+	from what is specified by `i18n.commitencoding`, this flag
 	can be used to override it.
 
 <msg>::
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 209e36b..4f9354f 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -7,7 +7,7 @@ git-mailsplit - Totally braindamaged mbo
 
 SYNOPSIS
 --------
-'git-mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>...]
+'git mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>...]
 
 DESCRIPTION
 -----------
@@ -24,7 +24,7 @@ OPTIONS
 	Directory in which to place the individual messages.
 
 -b::
-	If any file doesn't begin with a From line, assume it is a
+	If any file doesn't begin with a "From" line, assume it is a
 	single mail message instead of signalling error.
 
 -d<prec>::
@@ -33,7 +33,7 @@ OPTIONS
 	filenames.
 
 -f<nn>::
-	Skip the first <nn> numbers, for example if -f3 is specified,
+	Skip the first <nn> numbers, for example if `-f3` is specified,
 	start the numbering with 0004.
 
 Author
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 6099be2..3c4c9ed 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -13,15 +13,15 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-"git-merge-base" finds as good a common ancestor as possible between
-the two commits. That is, given two commits A and B 'git-merge-base A
-B' will output a commit which is reachable from both A and B through
+`git-merge-base` finds as good a common ancestor as possible between
+the two commits. That is, given two commits A and B `git-merge-base A
+B` will output a commit which is reachable from both A and B through
 the parent relationship.
 
 Given a selection of equally good common ancestors it should not be
 relied on to decide in any particular way.
 
-The "git-merge-base" algorithm is still in flux - use the source...
+The `git-merge-base` algorithm is still in flux - use the source...
 
 OPTIONS
 -------
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index eb8e019..7348682 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -43,7 +43,7 @@ code.
 Typically this is run with the a script calling the merge command from
 the RCS package.
 
-A sample script called "git-merge-one-file" is included in the
+A sample script called `git-merge-one-file` is included in the
 distribution.
 
 ALERT ALERT ALERT! The git "merge object order" is different from the
@@ -68,10 +68,10 @@ or 
   This is added AA in the branch B.
   fatal: merge program failed
 
-where the latter example shows how "git-merge-index" will stop trying to
+where the latter example shows how `git-merge-index` will stop trying to
 merge once anything has returned an error (i.e., "cat" returned an error
 for the AA file, because it didn't exist in the original, and thus
-"git-merge-index" didn't even try to merge the MM thing).
+`git-merge-index` didn't even try to merge the MM thing).
 
 Author
 ------
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
index 86aad37..821930e 100644
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -8,12 +8,12 @@ git-merge-one-file - The standard helper
 
 SYNOPSIS
 --------
-'git-merge-one-file'
+'git merge-one-file'
 
 DESCRIPTION
 -----------
-This is the standard helper program to use with "git-merge-index"
-to resolve a merge after the trivial merge done with "git-read-tree -m".
+This is the standard helper program to use with `git-merge-index`
+to resolve a merge after the trivial merge done with `git-read-tree -m`.
 
 Author
 ------
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 35fb4fb..461d7b3 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -8,13 +8,13 @@ git-merge-tree - Show three-way merge wi
 
 SYNOPSIS
 --------
-'git-merge-tree' <base-tree> <branch1> <branch2>
+'git merge-tree' <base-tree> <branch1> <branch2>
 
 DESCRIPTION
 -----------
 Reads three treeish, and output trivial merge results and
 conflicting stages to the standard output.  This is similar to
-what three-way read-tree -m does, but instead of storing the
+what three-way read-tree `-m` does, but instead of storing the
 results in the index, the command outputs the entries to the
 standard output.
 
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4ce799b..bfbeebf 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -8,7 +8,7 @@ git-merge - Grand Unified Merge Driver
 
 SYNOPSIS
 --------
-'git-merge' [-n] [--no-commit] [-s <strategy>]... <msg> <head> <remote> <remote>...
+'git merge' [-n] [--no-commit] [-s <strategy>]... <msg> <head> <remote> <remote>...
 
 
 DESCRIPTION
@@ -23,7 +23,7 @@ include::merge-options.txt[]
 
 <msg>::
 	The commit message to be used for the merge commit (in case
-	it is created). The `git-fmt-merge-msg` script can be used
+	it is created). The `git fmt-merge-msg` script can be used
 	to give a good default for automated `git-merge` invocations.
 
 <head>::
@@ -48,7 +48,7 @@ HOW MERGE WORKS
 A merge is always between the current `HEAD` and one or more
 remote branch heads, and the index file must exactly match the
 tree of `HEAD` commit (i.e. the contents of the last commit) when
-it happens.  In other words, `git-diff --cached HEAD` must
+it happens.  In other words, `git diff --cached HEAD` must
 report no changes.
 
 [NOTE]
@@ -69,11 +69,11 @@ fail.
 Otherwise, merge will refuse to do any harm to your repository
 (that is, it may fetch the objects from remote, and it may even
 update the local branch used to keep track of the remote branch
-with `git pull remote rbranch:lbranch`, but your working tree,
+with `git-pull remote rbranch:lbranch`, but your working tree,
 `.git/HEAD` pointer and index file are left intact).
 
 You may have local modifications in the working tree files.  In
-other words, `git-diff` is allowed to report changes.
+other words, `git diff` is allowed to report changes.
 However, the merge uses your working tree as the working area,
 and in order to prevent the merge operation from losing such
 changes, it makes sure that they do not interfere with the
@@ -116,7 +116,7 @@ When there are conflicts, these things h
 3. For conflicting paths, the index file records up to three
    versions; stage1 stores the version from the common ancestor,
    stage2 from `HEAD`, and stage3 from the remote branch (you
-   can inspect the stages with `git-ls-files -u`).  The working
+   can inspect the stages with `git ls-files -u`).  The working
    tree files have the result of "merge" program; i.e. 3-way
    merge result with familiar conflict markers `<<< === >>>`.
 
@@ -129,14 +129,14 @@ After seeing a conflict, you can do two 
 
  * Decide not to merge.  The only clean-up you need are to reset
    the index file to the `HEAD` commit to reverse 2. and to clean
-   up working tree changes made by 2. and 3.; `git-reset` can
+   up working tree changes made by 2. and 3.; `git reset` can
    be used for this.
 
- * Resolve the conflicts.  `git-diff` would report only the
+ * Resolve the conflicts.  `git diff` would report only the
    conflicting paths because of the above 2. and 3..  Edit the
-   working tree files into a desirable shape, `git-update-index`
+   working tree files into a desirable shape, `git update-index`
    them, to make the index file contain what the merge result
-   should be, and run `git-commit` to commit the result.
+   should be, and run `git commit` to commit the result.
 
 
 SEE ALSO
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index d78d2dc..25fea49 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -8,7 +8,7 @@ git-mktag - Creates a tag object
 
 SYNOPSIS
 --------
-'git-mktag' < signature_file
+'git mktag' < signature_file
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 5f9ee60..c687006 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -8,7 +8,7 @@ git-mktree - Build a tree-object from ls
 
 SYNOPSIS
 --------
-'git-mktree' [-z]
+'git mktree' [-z]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 207c43a..3ac538c 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -8,14 +8,14 @@ git-mv - Move or rename a file, director
 
 SYNOPSIS
 --------
-'git-mv' <options>... <args>...
+'git mv' <options>... <args>...
 
 DESCRIPTION
 -----------
 This script is used to move or rename a file, directory or symlink.
 
- git-mv [-f] [-n] <source> <destination>
- git-mv [-f] [-n] [-k] <source> ... <destination directory>
+ git mv [-f] [-n] <source> <destination>
+ git mv [-f] [-n] [-k] <source> ... <destination directory>
 
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
@@ -33,7 +33,7 @@ OPTIONS
         Skip move or rename actions which would lead to an error
 	condition. An error happens when a source is neither existing nor
         controlled by GIT, or when it would overwrite an existing
-        file unless '-f' is given.
+        file unless `-f` is given.
 -n::
 	Do nothing; only show what would happen
 
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 0c8e8e3..52241bf 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -8,12 +8,12 @@ git-name-rev - Find symbolic names for g
 
 SYNOPSIS
 --------
-'git-name-rev' [--tags] ( --all | --stdin | <committish>... )
+'git name-rev' [--tags] ( --all | --stdin | <committish>... )
 
 DESCRIPTION
 -----------
 Finds symbolic names suitable for human digestion for revisions given in any
-format parsable by git-rev-parse.
+format parsable by `git-rev-parse`.
 
 
 OPTIONS
@@ -37,14 +37,15 @@ wrote you about that phantastic commit 3
 Of course, you look into the commit, but that only tells you what happened, but
 not the context.
 
-Enter git-name-rev:
+Enter `git name-rev`:
 
 ------------
 % git name-rev 33db5f4d9027a10e477ccf054b2c1ab94f74c85a
 33db5f4d9027a10e477ccf054b2c1ab94f74c85a tags/v0.99^0~940
 ------------
 
-Now you are wiser, because you know that it happened 940 revisions before v0.99.
+Now you are wiser, because you know that it happened 940 revisions before
+v0.99.
 
 Another nice thing you can do is:
 
diff --git a/Documentation/git-p4import.txt b/Documentation/git-p4import.txt
index c198ff2..2d9dc67 100644
--- a/Documentation/git-p4import.txt
+++ b/Documentation/git-p4import.txt
@@ -8,11 +8,11 @@ git-p4import - Import a Perforce reposit
 
 SYNOPSIS
 --------
-`git-p4import` [-q|-v] [--authors <file>] [-t <timezone>] <//p4repo/path> <branch>
+`git p4import` [-q|-v] [--authors <file>] [-t <timezone>] <//p4repo/path> <branch>
 
-`git-p4import` --stitch <//p4repo/path>
+`git p4import` --stitch <//p4repo/path>
 
-`git-p4import`
+`git p4import`
 
 
 DESCRIPTION
@@ -23,11 +23,11 @@ given name will be created and the initi
 
 Once the initial import is complete you can do an incremental import
 of new commits from the Perforce repository.  You do this by checking
-out the appropriate git branch and then running `git-p4import` without
+out the appropriate git branch and then running `git p4import` without
 any options.
 
-The standard p4 client is used to communicate with the Perforce
-repository; it must be configured correctly in order for `git-p4import`
+The standard `p4` client is used to communicate with the Perforce
+repository; it must be configured correctly in order for `git p4import`
 to operate (see below).
 
 
@@ -65,7 +65,7 @@ OPTIONS
 
 P4 Client
 ---------
-You must make the `p4` client command available in your $PATH and
+You must make the `p4` client command available in your `$PATH` and
 configure it to communicate with the target Perforce repository.
 Typically this means you must set the "$P4PORT" and "$P4CLIENT"
 environment variables.
@@ -97,7 +97,7 @@ perforce branch into a branch named "jam
 
 Multiple Branches
 -----------------
-Note that by creating multiple "views" you can use `git-p4import`
+Note that by creating multiple "views" you can use `git p4import`
 to import additional branches into the same git repository.
 However, the `p4` client has a limitation in that it silently
 ignores all but the last "view" that maps into the same local
@@ -122,17 +122,17 @@ one per "view" instead of listing the ac
 
 Tags
 ----
-A git tag of the form p4/xx is created for every change imported from
-the Perforce repository where xx is the Perforce changeset number.
+A git tag of the form `p4/xx` is created for every change imported from
+the Perforce repository where `xx` is the Perforce changeset number.
 Therefore after the import you can use git to access any commit by its
-Perforce number, eg. git show p4/327.
+Perforce number, eg. `git show p4/327`.
 
-The tag associated with the HEAD commit is also how `git-p4import`
+The tag associated with the HEAD commit is also how `git p4import`
 determines if there are new changes to incrementally import from the
 Perforce repository.
 
 If you import from a repository with many thousands of changes
-you will have an equal number of p4/xxxx git tags.  Git tags can
+you will have an equal number of `p4/xxxx` git tags.  Git tags can
 be expensive in terms of disk space and repository operations.
 If you don't need to perform further incremental imports, you
 may delete the tags.
@@ -146,7 +146,7 @@ without worry.
 Author information is automatically determined by querying the
 Perforce "users" table using the id associated with each change.
 However, if you want to manually supply these mappings you can do
-so with the "--authors" option.  It accepts a file containing a list
+so with the `--authors` option.  It accepts a file containing a list
 of mappings with each line containing one mapping in the format:
 
 ------------
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 4991f88..d968afe 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -9,7 +9,7 @@ git-pack-objects - Create a packed archi
 SYNOPSIS
 --------
 [verse]
-'git-pack-objects' [-q] [--no-reuse-delta] [--non-empty]
+'git pack-objects' [-q] [--no-reuse-delta] [--non-empty]
 	[--local] [--incremental] [--window=N] [--depth=N]
 	{--stdout | base-name} < object-list
 
@@ -21,19 +21,19 @@ archive with specified base-name, or to 
 
 A packed archive is an efficient way to transfer set of objects
 between two repositories, and also is an archival format which
-is efficient to access.  The packed archive format (.pack) is
+is efficient to access.  The packed archive format (".pack") is
 designed to be unpackable without having anything else, but for
-random access, accompanied with the pack index file (.idx).
+random access, accompanied with the pack index file (".idx").
 
-'git-unpack-objects' command can read the packed archive and
+The `git-unpack-objects` command can read the packed archive and
 expand the objects contained in the pack into "one-file
 one-object" format; this is typically done by the smart-pull
 commands when a pack is created on-the-fly for efficient network
 transport by their peers.
 
-Placing both in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
-any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
-enables git to read from such an archive.
+Placing both in the `pack/` subdirectory of `$GIT_OBJECT_DIRECTORY` (or
+any of the directories on `$GIT_ALTERNATE_OBJECT_DIRECTORIES`)
+enables `git` to read from such an archive.
 
 In a packed archive, an object is either stored as a compressed
 whole, or as a difference from some other object.  The latter is
@@ -54,15 +54,15 @@ base-name::
 
 --stdout::
 	Write the pack contents (what would have been written to
-	.pack file) out to the standard output.
+	".pack" file) out to the standard output.
 
 --window and --depth::
 	These two options affects how the objects contained in
 	the pack are stored using delta compression.  The
 	objects are first internally sorted by type, size and
 	optionally names and compared against the other objects
-	within --window to see if using delta compression saves
-	space.  --depth limits the maximum delta depth; making
+	within `--window` to see if using delta compression saves
+	space.  `--depth` limits the maximum delta depth; making
 	it too deep affects the performance on the unpacker
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index 8fb0659..e7a3aec 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -8,7 +8,7 @@ git-pack-redundant - Program used to fin
 
 SYNOPSIS
 --------
-'git-pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
+'git pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
 
 DESCRIPTION
 -----------
@@ -16,13 +16,13 @@ This program computes which packs in you
 are redundant. The output is suitable for piping to
 'xargs rm' if you are in the root of the repository.
 
-git-pack-redundant accepts a list of objects on standard input. Any objects
+`git-pack-redundant` accepts a list of objects on standard input. Any objects
 given will be ignored when checking which packs are required. This makes the 
 following command useful when wanting to remove packs which contain unreachable
 objects.
 
-git-fsck-objects --full --unreachable | cut -d ' ' -f3 | \
-git-pack-redundant --all | xargs rm
+git fsck-objects --full --unreachable | cut -d ' ' -f3 | \
+git pack-redundant --all | xargs rm
 
 OPTIONS
 -------
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index f57d2b2..79f7177 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -7,20 +7,20 @@ git-patch-id - Generate a patch ID
 
 SYNOPSIS
 --------
-'git-patch-id' < <patch>
+'git patch-id' < <patch>
 
 DESCRIPTION
 -----------
 A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
 whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
-the same time also reasonably unique, i.e., two patches that have the same "patch
-ID" are almost guaranteed to be the same thing.
+the same time also reasonably unique, i.e., two patches that have the same
+"patch ID" are almost guaranteed to be the same thing.
 
 IOW, you can use this thing to look for likely duplicate commits.
 
-When dealing with git-diff-tree output, it takes advantage of
+When dealing with `git-diff-tree` output, it takes advantage of
 the fact that the patch is prefixed with the object name of the
-commit, and outputs two 40-byte hexadecimal string.  The first
+commit, and outputs two 40-byte hexadecimal strings.  The first
 string is the patch ID, and the second string is the commit ID.
 This can be used to make a mapping from patch ID to commit ID.
 
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
index a00060c..88b65d8 100644
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -8,7 +8,7 @@ git-peek-remote - Lists the references i
 
 SYNOPSIS
 --------
-'git-peek-remote' [--exec=<git-upload-pack>] [<host>:]<directory>
+'git peek-remote' [--exec=<git-upload-pack>] [<host>:]<directory>
 
 DESCRIPTION
 -----------
@@ -18,20 +18,20 @@ stores them in the local repository unde
 OPTIONS
 -------
 --exec=<git-upload-pack>::
-	Use this to specify the path to 'git-upload-pack' on the
-	remote side, if it is not found on your $PATH. Some
-	installations of sshd ignores the user's environment
-	setup scripts for login shells (e.g. .bash_profile) and
-	your privately installed git may not be found on the system
-	default $PATH.  Another workaround suggested is to set
-	up your $PATH in ".bashrc", but this flag is for people
+	Use this to specify the path to `git-upload-pack` on the
+	remote side, if it is not found on your `$PATH`. Some
+	installations of sshd ignore the user's environment
+	setup scripts for login shells (e.g. ".bash_profile") and
+	your privately installed `git` may not be found on the system
+	default `$PATH`.  Another workaround suggested is to set
+	up your `$PATH` in ".bashrc", but this flag is for people
 	who do not want to pay the overhead for non-interactive
-	shells, but prefer having a lean .bashrc file (they set most of
-	the things up in .bash_profile).
+	shells, but prefer having a lean ".bashrc" file (they set most of
+	the things up in ".bash_profile").
 
 <host>::
 	A remote host that houses the repository.  When this
-	part is specified, 'git-upload-pack' is invoked via
+	part is specified, `git-upload-pack` is invoked via
 	ssh.
 
 <directory>::
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 2348826..cd338ee 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -9,12 +9,12 @@ residing in a pack file.
 
 SYNOPSIS
 --------
-'git-prune-packed' [-n]
+'git prune-packed' [-n]
 
 
 DESCRIPTION
 -----------
-This program search the `$GIT_OBJECT_DIR` for all objects that currently
+This program searches the `$GIT_OBJECT_DIR` for all objects that currently
 exist in a pack file as well as the independent object directories.
 
 All such extra objects are removed.
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index a11e303..3a7102a 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -8,7 +8,7 @@ git-prune - Prunes all unreachable objec
 
 SYNOPSIS
 --------
-'git-prune' [-n] [--] [<head>...]
+'git prune' [-n] [--] [<head>...]
 
 DESCRIPTION
 -----------
@@ -19,7 +19,7 @@ objects specified on the command line, a
 objects unreachable from any of these head objects from the object database.
 In addition, it
 prunes the unpacked objects that are also found in packs by
-running `git prune-packed`.
+running `git-prune-packed`.
 
 OPTIONS
 -------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 51577fc..ecc148e 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -8,7 +8,7 @@ git-pull - Pull and merge from another r
 
 SYNOPSIS
 --------
-'git-pull' <options> <repository> <refspec>...
+'git pull' <options> <repository> <refspec>...
 
 
 DESCRIPTION
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3cb33d7..b299045 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -8,7 +8,7 @@ git-push - Update remote refs along with
 
 SYNOPSIS
 --------
-'git-push' [--all] [--tags] [--force] <repository> <refspec>...
+'git push' [--all] [--tags] [--force] <repository> <refspec>...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index 6e9a8c3..02dec12 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -9,7 +9,7 @@ git-quiltimport - Applies a quilt patchs
 SYNOPSIS
 --------
 [verse]
-'git-quiltimport' [--dry-run] [--author <author>] [--patches <dir>]
+'git quiltimport' [--dry-run] [--author <author>] [--patches <dir>]
 
 
 DESCRIPTION
@@ -20,12 +20,12 @@ in the quilt patchset.
 
 For each patch the code attempts to extract the author from the
 patch description.  If that fails it falls back to the author
-specified with --author.  If the --author flag was not given
+specified with `--author`.  If the `--author` flag was not given
 the patch description is displayed and the user is asked to
 interactively enter the author of the patch.
 
 If a subject is not found in the patch description the patch name is
-preserved as the 1 line subject in the git description.
+preserved as the one-line subject in the git description.
 
 OPTIONS
 -------
@@ -44,7 +44,7 @@ OPTIONS
 	quilt series file.
 
         The default for the patch directory is patches
-	or the value of the $QUILT_PATCHES environment
+	or the value of the `$QUILT_PATCHES` environment
 	variable.
 
 Author
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index d894f53..dccd750 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -8,7 +8,7 @@ git-read-tree - Reads tree information i
 
 SYNOPSIS
 --------
-'git-read-tree' (<tree-ish> | [[-m [--aggressive]| --reset] [-u | -i]] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
+'git read-tree' (<tree-ish> | [[-m [--aggressive]| --reset] [-u | -i]] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
 
 DESCRIPTION
@@ -34,7 +34,7 @@ OPTIONS
 	started.
 
 --reset::
-        Same as -m, except that unmerged entries are discarded
+        Same as `-m`, except that unmerged entries are discarded
         instead of failing.
 
 -u::
@@ -51,7 +51,7 @@ OPTIONS
 	working tree status into a temporary index file.
 
 --aggressive::
-	Usually a three-way merge by `git-read-tree` resolves
+	Usually a 3-way merge by `git-read-tree` resolves
 	the merge for really trivial cases and leaves other
 	cases unresolved in the index, so that Porcelains can
 	implement different merge policies.  This flag makes the
@@ -69,43 +69,43 @@ OPTIONS
 
 Merging
 -------
-If `-m` is specified, `git-read-tree` can perform 3 kinds of
-merge, a single tree merge if only 1 tree is given, a
-fast-forward merge with 2 trees, or a 3-way merge if 3 trees are
+If `-m` is specified, `git-read-tree` can perform three kinds of
+merge, a single tree merge if only one tree is given, a
+fast-forward merge with two trees, or a 3-way merge if three trees are
 provided.
 
 
 Single Tree Merge
 ~~~~~~~~~~~~~~~~~
-If only 1 tree is specified, git-read-tree operates as if the user did not
+If only one tree is specified, `git-read-tree` operates as if the user did not
 specify `-m`, except that if the original index has an entry for a
 given pathname, and the contents of the path matches with the tree
 being read, the stat info from the index is used. (In other words, the
 index's stat()s take precedence over the merged tree's).
 
-That means that if you do a `git-read-tree -m <newtree>` followed by a
-`git-checkout-index -f -u -a`, the `git-checkout-index` only checks out
+That means that if you do a `git read-tree -m <newtree>` followed by a
+`git checkout-index -f -u -a`, the `git checkout-index` only checks out
 the stuff that really changed.
 
-This is used to avoid unnecessary false hits when `git-diff-files` is
-run after `git-read-tree`.
+This is used to avoid unnecessary false hits when `git diff-files` is
+run after `git read-tree`.
 
 
 Two Tree Merge
 ~~~~~~~~~~~~~~
 
-Typically, this is invoked as `git-read-tree -m $H $M`, where $H
-is the head commit of the current repository, and $M is the head
-of a foreign tree, which is simply ahead of $H (i.e. we are in a
+Typically, this is invoked as `git read-tree -m $H $M`, where `$H`
+is the head commit of the current repository, and `$M` is the head
+of a foreign tree, which is simply ahead of `$H` (i.e. we are in a
 fast forward situation).
 
-When two trees are specified, the user is telling git-read-tree
+When two trees are specified, the user is telling `git-read-tree`
 the following:
 
-     1. The current index and work tree is derived from $H, but
-        the user may have local changes in them since $H;
+     1. The current index and work tree is derived from `$H`, but
+        the user may have local changes in them since `$H`;
 
-     2. The user wants to fast-forward to $M.
+     2. The user wants to fast-forward to `$M`.
 
 In this case, the `git-read-tree -m $H $M` command makes sure
 that no local change is lost as the result of this "merge".
@@ -149,18 +149,18 @@ Here are the "carry forward" rules:
 
 In all "keep index" cases, the index entry stays as in the
 original index file.  If the entry were not up to date,
-git-read-tree keeps the copy in the work tree intact when
-operating under the -u flag.
+`git-read-tree` keeps the copy in the work tree intact when
+operating under the `-u` flag.
 
-When this form of git-read-tree returns successfully, you can
+When this form of `git-read-tree` returns successfully, you can
 see what "local changes" you made are carried forward by running
-`git-diff-index --cached $M`.  Note that this does not
-necessarily match `git-diff-index --cached $H` would have
+`git diff-index --cached $M`.  Note that this does not
+necessarily match `git diff-index --cached $H` would have
 produced before such a two tree merge.  This is because of cases
-18 and 19 --- if you already had the changes in $M (e.g. maybe
-you picked it up via e-mail in a patch form), `git-diff-index
+18 and 19 --- if you already had the changes in `$M` (e.g. maybe
+you picked it up via e-mail in a patch form), `git diff-index
 --cached $H` would have told you about the change before this
-merge, but it would not show in `git-diff-index --cached $M`
+merge, but it would not show in `git diff-index --cached $M`
 output after two-tree merge.
 
 
@@ -169,7 +169,7 @@ output after two-tree merge.
 Each "index" entry has two bits worth of "stage" state. stage 0 is the
 normal one, and is the only one you'd see in any kind of normal use.
 
-However, when you do `git-read-tree` with three trees, the "stage"
+However, when you do `git read-tree` with three trees, the "stage"
 starts out at 1.
 
 This means that you can do
@@ -190,7 +190,7 @@ a file that matches in all respects in t
 "collapses" back to "stage0":
 
    - stage 2 and 3 are the same; take one or the other (it makes no
-     difference - the same work has been done on our branch in
+     difference -- the same work has been done on our branch in
      stage 2 and their branch in stage 3)
 
    - stage 1 and stage 2 are the same and stage 3 is different; take
@@ -198,7 +198,7 @@ a file that matches in all respects in t
      ancestor in stage 1 while their branch in stage 3 worked on
      it)
 
-   - stage 1 and stage 3 are the same and stage 2 is different take
+   - stage 1 and stage 3 are the same and stage 2 is different; take
      stage 2 (we did something while they did nothing)
 
 The `git-write-tree` command refuses to write a nonsensical tree, and it
@@ -261,15 +261,15 @@ committed last to your repository:
 
 ----------------
 $ JC=`git-rev-parse --verify "HEAD^0"`
-$ git-checkout-index -f -u -a $JC
+$ git checkout-index -f -u -a $JC
 ----------------
 
-You do random edits, without running git-update-index.  And then
+You do random edits, without running `git update-index`.  And then
 you notice that the tip of your "upstream" tree has advanced
 since you pulled from him:
 
 ----------------
-$ git-fetch git://.... linus
+$ git fetch git://.... linus
 $ LT=`cat .git/FETCH_HEAD`
 ----------------
 
@@ -279,10 +279,10 @@ added or modified index entries since $J
 then does the right thing.  So with the following sequence:
 
 ----------------
-$ git-read-tree -m -u `git-merge-base $JC $LT` $JC $LT
-$ git-merge-index git-merge-one-file -a
+$ git read-tree -m -u `git merge-base $JC $LT` $JC $LT
+$ git merge-index git-merge-one-file -a
 $ echo "Merge with Linus" | \
-  git-commit-tree `git-write-tree` -p $JC -p $LT
+  git commit-tree `git write-tree` -p $JC -p $LT
 ----------------
 
 what you would commit is a pure merge between $JC and $LT without
@@ -290,14 +290,14 @@ your work-in-progress changes, and your 
 updated to the result of the merge.
 
 However, if you have local changes in the working tree that
-would be overwritten by this merge,`git-read-tree` will refuse
+would be overwritten by this merge,`git read-tree` will refuse
 to run to prevent your changes from being lost.
 
 In other words, there is no need to worry about what exists only
 in the working tree.  When you have local changes in a part of
 the project that is not involved in the merge, your changes do
 not interfere with the merge, and are kept intact.  When they
-*do* interfere, the merge does not even start (`git-read-tree`
+*do* interfere, the merge does not even start (`git read-tree`
 complains loudly and fails without modifying anything).  In such
 a case, you can simply continue doing what you were in the
 middle of doing, and when your working tree is ready (i.e. you
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 08ee4aa..2fde60f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -7,14 +7,14 @@ git-rebase - Rebase local commits to a n
 
 SYNOPSIS
 --------
-'git-rebase' [--onto <newbase>] <upstream> [<branch>]
+'git rebase' [--onto <newbase>] <upstream> [<branch>]
 
-'git-rebase' --continue | --skip | --abort
+'git rebase' --continue | --skip | --abort
 
 DESCRIPTION
 -----------
-git-rebase replaces <branch> with a new branch of the same name.  When
-the --onto option is provided the new branch starts out with a HEAD equal
+`git-rebase` replaces <branch> with a new branch of the same name.  When
+the `--onto` option is provided the new branch starts out with a HEAD equal
 to <newbase>, otherwise it is equal to <upstream>.  It then attempts to
 create a new commit for each commit from the original <branch> that does
 not exist in the <upstream> branch.
@@ -40,8 +40,8 @@ Assume the following history exists and 
 From this point, the result of either of the following commands:
 
 
-    git-rebase master
-    git-rebase master topic
+    git rebase master
+    git rebase master topic
 
 would be:
 
@@ -54,8 +54,8 @@ would be:
 While, starting from the same point, the result of either of the following
 commands:
 
-    git-rebase --onto master~1 master
-    git-rebase --onto master~1 master topic
+    git rebase --onto master~1 master
+    git rebase --onto master~1 master topic
 
 would be:
 
@@ -65,10 +65,10 @@ would be:
     D---E---F---G master
 ------------
 
-In case of conflict, git-rebase will stop at the first problematic commit
-and leave conflict markers in the tree.  You can use git diff to locate
+In case of conflict, `git-rebase` will stop at the first problematic commit
+and leave conflict markers in the tree.  You can use `git diff` to locate
 the markers (<<<<<<) and make edits to resolve the conflict.  For each
-file you edit, you need to tell git that the conflict has been resolved,
+file you edit, you need to tell `git` that the conflict has been resolved,
 typically this would be done with
 
 
@@ -82,7 +82,7 @@ desired resolution, you can continue the
     git rebase --continue
 
 
-Alternatively, you can undo the git-rebase with
+Alternatively, you can undo the `git-rebase` with
 
 
     git rebase --abort
@@ -91,7 +91,7 @@ OPTIONS
 -------
 <newbase>::
 	Starting point at which to create the new commits. If the
-	--onto option is not specified, the starting point is
+	`--onto` option is not specified, the starting point is
 	<upstream>.
 
 <upstream>::
@@ -111,10 +111,10 @@ NOTES
 When you rebase a branch, you are changing its history in a way that
 will cause problems for anyone who already has a copy of the branch
 in their repository and tries to pull updates from you.  You should
-understand the implications of using 'git rebase' on a repository that
+understand the implications of using `git rebase` on a repository that
 you share.
 
-When the git rebase command is run, it will first execute a "pre-rebase"
+When the `git-rebase` command is run, it will first execute a "pre-rebase"
 hook if one exists.  You can use this hook to do sanity checks and
 reject the rebase if it isn't appropriate.  Please see the template
 pre-rebase hook script for an example.
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index ad91e24..2ad2cd6 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -8,34 +8,34 @@ git-receive-pack - Receive what is pushe
 
 SYNOPSIS
 --------
-'git-receive-pack' <directory>
+'git receive-pack' <directory>
 
 DESCRIPTION
 -----------
-Invoked by 'git-send-pack' and updates the repository with the
+Invoked by `git-send-pack` and updates the repository with the
 information fed from the remote end.
 
 This command is usually not invoked directly by the end user.
-The UI for the protocol is on the 'git-send-pack' side, and the
+The UI for the protocol is on the `git-send-pack` side, and the
 program pair is meant to be used to push updates to remote
-repository.  For pull operations, see 'git-fetch-pack' and
-'git-clone-pack'.
+repository.  For pull operations, see `git-fetch-pack` and
+`git-clone-pack`.
 
 The command allows for creation and fast forwarding of SHA-1 refs
 (heads/tags) on the remote end (strictly speaking, it is the
 local end receive-pack runs, but to the user who is sitting at
 the send-pack end, it is updating the remote.  Confused?)
 
-Before each ref is updated, if $GIT_DIR/hooks/update file exists
+Before each ref is updated, if `$GIT_DIR/hooks/update` file exists
 and executable, it is called with three parameters:
 
        $GIT_DIR/hooks/update refname sha1-old sha1-new
 
-The refname parameter is relative to $GIT_DIR; e.g. for the
-master head this is "refs/heads/master".  Two SHA-1s are the
+The refname parameter is relative to `$GIT_DIR`; e.g. for the
+master head this is "refs/heads/master".  The two sha1s are the
 object names for the refname before and after the update.  Note
 that the hook is called before the refname is updated, so either
-sha1-old is 0{40} (meaning there is no such ref yet), or it
+sha1-old is '0{40}' (meaning there is no such ref yet), or it
 should match what is recorded in refname.
 
 The hook should exit with non-zero status if it wants to
@@ -59,13 +59,13 @@ the commits pushed to the repository:
 	mail -s "Changes to ref $1" commit-list@mydomain
 	exit 0
 
-Another hook $GIT_DIR/hooks/post-update, if exists and
+Another hook, `$GIT_DIR/hooks/post-update`, if it exists and is
 executable, is called with the list of refs that have been
-updated.  This can be used to implement repository wide cleanup
+updated.  This can be used to implement a repository wide cleanup
 task if needed.  The exit code from this hook invocation is
-ignored; the only thing left for git-receive-pack to do at that
+ignored; the only thing left for `git-receive-pack` to do at that
 point is to exit itself anyway.  This hook can be used, for
-example, to run "git-update-server-info" if the repository is
+example, to run `git-update-server-info` if the repository is
 packed and is served via a dumb transport.
 
 	#!/bin/sh
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index aca6012..8824b7c 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -7,12 +7,13 @@ git-relink - Hardlink common objects in 
 
 SYNOPSIS
 --------
-'git-relink' [--safe] <dir> <dir> [<dir>]\*
+'git relink' [--safe] <dir> <dir> [<dir>]\*
 
 DESCRIPTION
 -----------
-This will scan 2 or more object repositories and look for common objects, check
-if they are hardlinked, and replace one with a hardlink to the other if not.
+This will scan two or more object repositories and look for common objects,
+check if they are hardlinked, and replace one with a hardlink to the other
+if not.
 
 OPTIONS
 -------
@@ -21,7 +22,7 @@ OPTIONS
 	Default is to warn and continue.
 
 <dir>::
-	Directories containing a .git/objects/ subdirectory.
+	Directories containing a `.git/objects/` subdirectory.
 
 Author
 ------
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 9516227..3ebf0ff 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ objects into pack files.
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d] [-f] [-l] [-n] [-q]
+'git repack' [-a] [-d] [-f] [-l] [-n] [-q]
 
 DESCRIPTION
 -----------
@@ -33,7 +33,7 @@ OPTIONS
 	Especially useful when packing a repository that is used
 	for a private development and there no need to worry
 	about people fetching via dumb protocols from it.  Use
-	with '-d'.
+	with `-d`.
 
 -d::
 	After packing, if the newly created packs make some
@@ -41,20 +41,20 @@ OPTIONS
 	Also runs gitlink:git-prune-packed[1].
 
 -l::
-        Pass the `--local` option to `git pack-objects`, see
+        Pass the `--local` option to `git-pack-objects`, see
         gitlink:git-pack-objects[1].
 
 -f::
-        Pass the `--no-reuse-delta` option to `git pack-objects`, see
+        Pass the `--no-reuse-delta` option to `git-pack-objects`, see
         gitlink:git-pack-objects[1].
 
 -q::
-        Pass the `-q` option to `git pack-objects`, see
+        Pass the `-q` option to `git-pack-objects`, see
         gitlink:git-pack-objects[1].
 
 -n::
         Do not update the server information with
-        `git update-server-info`.
+        `git-update-server-info`.
 
 Author
 ------
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index d5142e0..348933d 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -9,13 +9,13 @@ git-repo-config - Get and set options in
 SYNOPSIS
 --------
 [verse]
-'git-repo-config' [type] name [value [value_regex]]
-'git-repo-config' [type] --replace-all name [value [value_regex]]
-'git-repo-config' [type] --get name [value_regex]
-'git-repo-config' [type] --get-all name [value_regex]
-'git-repo-config' [type] --unset name [value_regex]
-'git-repo-config' [type] --unset-all name [value_regex]
-'git-repo-config' -l | --list
+'git repo-config' [type] name [value [value_regex]]
+'git repo-config' [type] --replace-all name [value [value_regex]]
+'git repo-config' [type] --get name [value_regex]
+'git repo-config' [type] --get-all name [value_regex]
+'git repo-config' [type] --unset name [value_regex]
+'git repo-config' [type] --unset-all name [value_regex]
+'git repo-config' -l | --list
 
 DESCRIPTION
 -----------
@@ -29,16 +29,16 @@ existing values that match the regexp ar
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see EXAMPLES).
 
-The type specifier can be either '--int' or '--bool', which will make
-'git-repo-config' ensure that the variable(s) are of the given type and
+The type specifier can be either `--int` or `--bool`, which will make
+`git-repo-config` ensure that the variable(s) are of the given type and
 convert the value to the canonical form (simple decimal number for int,
 a "true" or "false" string for bool). If no type specifier is passed,
 no checks or transformations are performed on the value.
 
 This command will fail if:
 
-. The .git/config file is invalid,
-. Can not write to .git/config,
+. The `.git/config` file is invalid,
+. Can not write to `.git/config`,
 . no section was provided,
 . the section or key is invalid,
 . you try to unset an option which does not exist, or
@@ -76,7 +76,7 @@ OPTIONS
 EXAMPLE
 -------
 
-Given a .git/config like this:
+Given a `.git/config` like this:
 
 	#
 	# This is the config file, and
@@ -115,7 +115,7 @@ to "ssh".
 % git repo-config core.gitproxy '"ssh" for kernel.org' 'for kernel.org$'
 ------------
 
-This makes sure that only the key/value pair for kernel.org is replaced.
+This makes sure that only the key/value pair for 'kernel.org' is replaced.
 
 To delete the entry for renames, do
 
@@ -150,7 +150,7 @@ If you want to know all the values for a
 % git repo-config --get-all core.gitproxy
 ------------
 
-If you like to live dangerous, you can replace *all* core.gitproxy by a
+If you like to live dangerous, you can replace *all* 'core.gitproxy' by a
 new one with
 
 ------------
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 478a5fd..09a0004 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -7,7 +7,7 @@ git-request-pull - Generates a summary o
 
 SYNOPSIS
 --------
-'git-request-pull' <start> <url> [<end>]
+'git request-pull' <start> <url> [<end>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 8b6b651..f71ca9b 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -7,7 +7,7 @@ git-rerere - Reuse recorded resolve
 
 SYNOPSIS
 --------
-'git-rerere'
+'git rerere'
 
 
 DESCRIPTION
@@ -107,34 +107,34 @@ finally ready and merged into the master
 would require you to resolve the conflict, introduced by the
 commits marked with `*`.  However, often this conflict is the
 same conflict you resolved when you created the test merge you
-blew away.  `git-rerere` command helps you to resolve this final
+blew away.  `git rerere` command helps you to resolve this final
 conflicted merge using the information from your earlier hand
 resolve.
 
-Running `git-rerere` command immediately after a conflicted
+Running `git rerere` command immediately after a conflicted
 automerge records the conflicted working tree files, with the
 usual conflict markers `<<<<<<<`, `=======`, and `>>>>>>>` in
 them.  Later, after you are done resolving the conflicts,
-running `git-rerere` again records the resolved state of these
+running `git rerere` again records the resolved state of these
 files.  Suppose you did this when you created the test merge of
 master into the topic branch.
 
-Next time, running `git-rerere` after seeing a conflicted
+Next time, running `git rerere` after seeing a conflicted
 automerge, if the conflict is the same as the earlier one
 recorded, it is noticed and a three-way merge between the
 earlier conflicted automerge, the earlier manual resolution, and
 the current conflicted automerge is performed by the command.
 If this three-way merge resolves cleanly, the result is written
 out to your working tree file, so you would not have to manually
-resolve it.  Note that `git-rerere` leaves the index file alone,
+resolve it.  Note that `git rerere` leaves the index file alone,
 so you still need to do the final sanity checks with `git diff`
 (or `git diff -c`) and `git update-index` when you are
 satisfied.
 
-As a convenience measure, `git-merge` automatically invokes
-`git-rerere` when it exits with a failed automerge, which
+As a convenience measure, `git merge` automatically invokes
+`git rerere` when it exits with a failed automerge, which
 records it if it is a new conflict, or reuses the earlier hand
-resolve when it is not.  `git-commit` also invokes `git-rerere`
+resolve when it is not.  `git commit` also invokes `git-rerere`
 when recording a merge result.  What this means is that you do
 not have to do anything special yourself (Note: you still have
 to create `$GIT_DIR/rr-cache` directory to enable this command).
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 73a0ffc..5c8d395 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -7,7 +7,7 @@ git-reset - Reset current HEAD to the sp
 
 SYNOPSIS
 --------
-'git-reset' [--mixed | --soft | --hard] [<commit-ish>]
+'git reset' [--mixed | --soft | --hard] [<commit-ish>]
 
 DESCRIPTION
 -----------
@@ -92,7 +92,7 @@ Undo update-index::
 +
 ------------
 $ edit                                     <1>
-$ git-update-index frotz.c filfre.c
+$ git update-index frotz.c filfre.c
 $ mailx                                    <2>
 $ git reset                                <3>
 $ git pull git://info.example.com/ nitfol  <4>
@@ -132,13 +132,13 @@ Fast forward
 <1> try to update from the upstream resulted in a lot of
 conflicts; you were not ready to spend a lot of time merging
 right now, so you decide to do that later.
-<2> "pull" has not made merge commit, so "git reset --hard"
-which is a synonym for "git reset --hard HEAD" clears the mess
+<2> `pull` has not made merge commit, so `git reset --hard`
+which is a synonym for `git reset --hard HEAD` clears the mess
 from the index file and the working tree.
 <3> merge a topic branch into the current branch, which resulted
 in a fast forward.
 <4> but you decided that the topic branch is not ready for public
-consumption yet.  "pull" or "merge" always leaves the original
+consumption yet.  `pull` or `merge` always leaves the original
 tip of the current branch in ORIG_HEAD, so resetting hard to it
 brings your index file and the working tree back to that state,
 and resets the tip of the branch to that commit.
diff --git a/Documentation/git-resolve.txt b/Documentation/git-resolve.txt
index 4e57c2b..db38e24 100644
--- a/Documentation/git-resolve.txt
+++ b/Documentation/git-resolve.txt
@@ -8,7 +8,7 @@ git-resolve - Merge two commits
 
 SYNOPSIS
 --------
-'git-resolve' <current> <merged> <message>
+'git resolve' <current> <merged> <message>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ad6d14c..83d33a6 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,7 +9,7 @@ git-rev-list - Lists commit objects in r
 SYNOPSIS
 --------
 [verse]
-'git-rev-list' [ \--max-count=number ]
+'git rev-list' [ \--max-count=number ]
 	     [ \--max-age=timestamp ]
 	     [ \--min-age=timestamp ]
 	     [ \--sparse ]
@@ -30,7 +30,7 @@ given commit(s), taking ancestry relatio
 useful to produce human-readable log output.
 
 Commits which are stated with a preceding '{caret}' cause listing to stop at
-that point. Their parents are implied. "git-rev-list foo bar {caret}baz" thus
+that point. Their parents are implied. `git rev-list foo bar {caret}baz` thus
 means "list all the commits which are included in 'foo' and 'bar', but
 not in 'baz'".
 
@@ -49,7 +49,7 @@ OPTIONS
 
 --objects::
 	Print the object IDs of any object referenced by the listed commits.
-	'git-rev-list --objects foo ^bar' thus means "send me all object IDs
+	`git rev-list --objects foo ^bar` thus means "send me all object IDs
 	which I need to download if I have the commit object 'bar', but
 	not 'foo'".
 
@@ -67,10 +67,10 @@ OPTIONS
 
 --bisect::
 	Limit output to the one commit object which is roughly halfway
-	between the included and excluded commits. Thus, if 'git-rev-list
-	--bisect foo {caret}bar {caret}baz' outputs 'midpoint', the output
-	of 'git-rev-list foo {caret}midpoint' and 'git-rev-list midpoint
-	{caret}bar {caret}baz' would be of roughly the same length.
+	between the included and excluded commits. Thus, if `git rev-list
+	--bisect foo {caret}bar {caret}baz` outputs 'midpoint', the output
+	of `git rev-list foo {caret}midpoint` and `git rev-list midpoint
+	{caret}bar {caret}baz` would be of roughly the same length.
 	Finding the change
 	which introduces a regression is thus reduced to a binary search:
 	repeatedly generate and test new 'midpoint's until the commit chain
@@ -100,7 +100,7 @@ OPTIONS
 --topo-order::
 	By default, the commits are shown in reverse
 	chronological order.  This option makes them appear in
-	topological order (i.e. descendant commits are shown
+	topological order (i.e., descendant commits are shown
 	before their parents).
 
 Author
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 25098bd..6235834 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -8,13 +8,13 @@ git-rev-parse - Pick out and massage par
 
 SYNOPSIS
 --------
-'git-rev-parse' [ --option ] <args>...
+'git rev-parse' [ --option ] <args>...
 
 DESCRIPTION
 -----------
 
 Many git porcelainish commands take mixture of flags
-(i.e. parameters that begin with a dash '-') and parameters
+(i.e., parameters that begin with a dash '-') and parameters
 meant for underlying `git-rev-list` command they use internally
 and flags and parameters for other commands they use as the
 downstream of `git-rev-list`.  This command is used to
@@ -100,7 +100,7 @@ OPTIONS
 
 --until=datestring, --before=datestring::
 	Parses the date string, and outputs corresponding
-	--min-age= parameter for git-rev-list command.
+	`--min-age=` parameter for `git-rev-list` command.
 
 <args>...::
 	Flags and parameters to be parsed.
@@ -120,8 +120,8 @@ syntax.
   your repository whose object name starts with dae86e.
 
 * A symbolic ref name.  E.g. 'master' typically means the commit
-  object referenced by $GIT_DIR/refs/heads/master.  If you
-  happen to have both heads/master and tags/master, you can
+  object referenced by `$GIT_DIR/refs/heads/master`.  If you
+  happen to have both `heads/master` and `tags/master`, you can
   explicitly say 'heads/master' to tell git which one you mean.
 
 * A suffix '@' followed by a date specification enclosed in a brace
@@ -129,7 +129,7 @@ syntax.
   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
   of the ref at a prior point in time.  This suffix may only be
   used immediately following a ref name and the ref must have an
-  existing log ($GIT_DIR/logs/<ref>).
+  existing log (`$GIT_DIR/logs/<ref>`).
 
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 71f7815..c1042e1 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -7,7 +7,7 @@ git-revert - Revert an existing commit
 
 SYNOPSIS
 --------
-'git-revert' [--edit | --no-edit] [-n] <commit>
+'git revert' [--edit | --no-edit] [-n] <commit>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 66fc478..a7a6b22 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -7,12 +7,12 @@ git-rm - Remove files from the working t
 
 SYNOPSIS
 --------
-'git-rm' [-f] [-n] [-v] [--] <file>...
+'git rm' [-f] [-n] [-v] [--] <file>...
 
 DESCRIPTION
 -----------
-A convenience wrapper for git-update-index --remove. For those coming
-from cvs, git-rm provides an operation similar to "cvs rm" or "cvs
+A convenience wrapper for `git-update-index --remove`. For those coming
+from cvs, `git-rm` provides an operation similar to "cvs rm" or "cvs
 remove".
 
 
@@ -56,7 +56,7 @@ are not ignored/excluded by `$GIT_DIR/in
 
 EXAMPLES
 --------
-git-rm Documentation/\\*.txt::
+'git rm Documentation/\\*.txt'::
 
 	Removes all `\*.txt` files from the index that are under the
 	`Documentation` directory and any of its subdirectories. The
@@ -66,12 +66,12 @@ Note that the asterisk `\*` is quoted fr
 example; this lets the command include the files from
 subdirectories of `Documentation/` directory.
 
-git-rm -f git-*.sh::
+'git rm -f git-*.sh'::
 
-	Remove all git-*.sh scripts that are in the index. The files
-	are removed from the index, and (because of the -f option),
+	Remove all `git-*.sh` scripts that are in the index. The files
+	are removed from the index, and (because of the `-f` option),
 	from the working tree as well. Because this example lets the
-	shell expand the asterisk (i.e. you are listing the files
+	shell expand the asterisk (i.e., you are listing the files
 	explicitly), it does not remove `subdir/git-foo.sh`.
 
 See Also
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ad1b9cf..ccdc7d2 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -8,7 +8,7 @@ git-send-email - Send a collection of pa
 
 SYNOPSIS
 --------
-'git-send-email' [options] <file|directory> [... file|directory]
+'git send-email' [options] <file|directory> [... file|directory]
 
 
 
@@ -29,33 +29,33 @@ The options available are:
 
 --chain-reply-to, --no-chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
 	entire patch series.
-	Default is --chain-reply-to
+	Default is `--chain-reply-to`
 
 --compose::
-	Use $EDITOR to edit an introductory message for the
+	Use `$EDITOR` to edit an introductory message for the
 	patch series.
 
 --from::
 	Specify the sender of the emails.  This will default to
-	the value GIT_COMMITTER_IDENT, as returned by "git-var -l".
+	the value GIT_COMMITTER_IDENT, as returned by `git var -l`.
 	The user will still be prompted to confirm this entry.
 
 --in-reply-to::
-	Specify the contents of the first In-Reply-To header.
+	Specify the contents of the first "In-Reply-To:" header.
 	Subsequent emails will refer to the previous email 
-	instead of this if --chain-reply-to is set (the default)
-	Only necessary if --compose is also set.  If --compose
+	instead of this if `--chain-reply-to` is set (the default)
+	Only necessary if `--compose` is also set.  If `--compose`
 	is not set, this will be prompted for.
 
 --no-signed-off-by-cc::
-	Do not add emails found in Signed-off-by: lines to the cc list.
+	Do not add emails found in "Signed-off-by:" lines to the cc list.
 
 --quiet::
-	Make git-send-email less verbose.  One line per email should be
+	Make `git-send-email` less verbose.  One line per email should be
 	all that is output.
 
 --smtp-server::
@@ -64,12 +64,12 @@ The options available are:
 
 --subject::
    	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
+	Only necessary if `--compose` is also set.  If `--compose`
 	is not set, this will be prompted for.
 
 --suppress-from::
-	Do not add the From: address to the cc: list, if it shows up in a From:
-	line.
+	Do not add the "From:" address to the "Cc:" list, if it shows up
+        in a "From:" line.
 
 --to::
 	Specify the primary recipient of the emails generated.
@@ -81,8 +81,8 @@ Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
 
-git-send-email is originally based upon
-send_lots_of_email.pl by Greg Kroah-Hartman.
+`git-send-email` is originally based upon
+`send_lots_of_email.pl` by Greg Kroah-Hartman.
 
 Documentation
 --------------
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 9e67f17..5da43f7 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -8,21 +8,21 @@ git-send-pack - Push missing objects pac
 
 SYNOPSIS
 --------
-'git-send-pack' [--all] [--force] [--exec=<git-receive-pack>] [<host>:]<directory> [<ref>...]
+'git send-pack' [--all] [--force] [--exec=<git-receive-pack>] [<host>:]<directory> [<ref>...]
 
 DESCRIPTION
 -----------
-Invokes 'git-receive-pack' on a possibly remote repository, and
+Invokes `git-receive-pack` on a possibly remote repository, and
 updates it from the current repository, sending named refs.
 
 
 OPTIONS
 -------
 --exec=<git-receive-pack>::
-	Path to the 'git-receive-pack' program on the remote
+	Path to the `git-receive-pack` program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
-	a directory on the default $PATH.
+	a directory on the default `$PATH`.
 
 --all::
 	Instead of explicitly specifying which refs to update,
@@ -37,7 +37,7 @@ OPTIONS
 
 <host>::
 	A remote host to house the repository.  When this
-	part is specified, 'git-receive-pack' is invoked via
+	part is specified, `git-receive-pack` is invoked via
 	ssh.
 
 <directory>::
@@ -53,11 +53,11 @@ Specifying the Refs
 There are three ways to specify which refs to update on the
 remote end.
 
-With '--all' flag, all refs that exist locally are transferred to
+With `--all` flag, all refs that exist locally are transferred to
 the remote side.  You cannot specify any '<ref>' if you use
 this flag.
 
-Without '--all' and without any '<ref>', the refs that exist
+Without `--all` and without any '<ref>', the refs that exist
 both on the local side and on the remote side are updated.
 
 When one or more '<ref>' are specified explicitly, it can be either a
@@ -85,13 +85,13 @@ destination side.
      exist in the set of remote refs; the ref matched <src>
      locally is used as the name of the destination.
 
-Without '--force', the <src> ref is stored at the remote only if
+Without `--force`, the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
 ancestor) of <src>.  This check, known as "fast forward check",
 is performed in order to avoid accidentally overwriting the
 remote ref and lose other peoples' commits from there.
 
-With '--force', the fast forward check is disabled for all refs.
+With `--force`, the fast forward check is disabled for all refs.
 
 Optionally, a <ref> parameter can be prefixed with a plus '+' sign
 to disable the fast-forward check only on that ref.
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index cc4266d..d19c2f9 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 This is meant to be used as a login shell for SSH accounts you want
 to restrict to GIT pull/push access only. It permits execution only
 of server-side GIT commands implementing the pull/push functionality.
-The commands can be executed only by the '-c' option; the shell is not
+The commands can be executed only by the `-c` option; the shell is not
 interactive.
 
 Currently, only the `git-receive-pack` and `git-upload-pack` commands
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 7486ebe..3db8bf4 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -7,11 +7,11 @@ git-shortlog - Summarize 'git log' outpu
 
 SYNOPSIS
 --------
-git-log --pretty=short | 'git-shortlog'
+'git log' --pretty=short | 'git shortlog'
 
 DESCRIPTION
 -----------
-Summarizes 'git log' output in a format suitable for inclusion
+Summarizes `git log` output in a format suitable for inclusion
 in release announcements. Each commit will be grouped by author
 the first line of the commit message will be shown.
 
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 8937428..7afdea3 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -8,7 +8,7 @@ git-show-branch - Show branches and thei
 SYNOPSIS
 --------
 [verse]
-'git-show-branch' [--all] [--heads] [--tags] [--topo-order] [--current]
+'git show-branch' [--all] [--heads] [--tags] [--topo-order] [--current]
 		[--more=<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [<rev> | <glob>]...
 
@@ -16,8 +16,8 @@ DESCRIPTION
 -----------
 
 Shows the commit ancestry graph starting from the commits named
-with <rev>s or <globs>s (or all refs under $GIT_DIR/refs/heads
-and/or $GIT_DIR/refs/tags) semi-visually.
+with <rev>s or <globs>s (or all refs under `$GIT_DIR/refs/heads`
+and/or `$GIT_DIR/refs/tags`) semi-visually.
 
 It cannot show more than 29 branches and commits at a time.
 
@@ -33,13 +33,13 @@ OPTIONS
 
 <glob>::
 	A glob pattern that matches branch or tag names under
-	$GIT_DIR/refs.  For example, if you have many topic
-	branches under $GIT_DIR/refs/heads/topic, giving
+	`$GIT_DIR/refs`.  For example, if you have many topic
+	branches under `$GIT_DIR/refs/heads/topic`, giving
 	`topic/*` would show all of them.
 
 --all --heads --tags::
-	Show all refs under $GIT_DIR/refs, $GIT_DIR/refs/heads,
-	and $GIT_DIR/refs/tags, respectively.
+	Show all refs under `$GIT_DIR/refs`, `$GIT_DIR/refs/heads`,
+	and `$GIT_DIR/refs/tags`, respectively.
 
 --current::
 	With this option, the command includes the current
@@ -65,7 +65,7 @@ OPTIONS
 
 --merge-base::
 	Instead of showing the commit list, just act like the
-	'git-merge-base -a' command, except that it can accept
+	`git-merge-base -a` command, except that it can accept
 	more than two heads.
 
 --independent::
@@ -81,7 +81,7 @@ OPTIONS
 	of "master"), name them with the unique prefix of their
 	object names.
 
-Note that --more, --list, --independent and --merge-base options
+Note that `--more`, `--list`, `--independent` and `--merge-base` options
 are mutually exclusive.
 
 
@@ -89,7 +89,7 @@ OUTPUT
 ------
 Given N <references>, the first N lines are the one-line
 description from their commit message.  The branch head that is
-pointed at by $GIT_DIR/HEAD is prefixed with an asterisk `*`
+pointed at by `$GIT_DIR/HEAD` is prefixed with an asterisk `*`
 character while other heads are prefixed with a `!` character.
 
 Following these N lines, one-line log for each commit is
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index 04f1d22..b93ee80 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -8,16 +8,16 @@ git-show-index - Show packed archive ind
 
 SYNOPSIS
 --------
-'git-show-index' < idx-file
+'git show-index' < idx-file
 
 
 DESCRIPTION
 -----------
 Reads given idx file for packed git archive created with
-git-pack-objects command, and dumps its contents.
+`git-pack-objects` command, and dumps its contents.
 
 The information it outputs is subset of what you can get from
-'git-verify-pack -v'; this command only shows the packfile
+`git-verify-pack -v`; this command only shows the packfile
 offset and SHA-1 of each object.
 
 
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 2b4df3f..4160120 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -8,15 +8,15 @@ git-show - Show one commit with differen
 
 SYNOPSIS
 --------
-'git-show' <option>...
+'git show' <option>...
 
 DESCRIPTION
 -----------
 Shows commit log and textual diff for a single commit.  The
-command internally invokes 'git-rev-list' piped to
-'git-diff-tree', and takes command line options for both of
+command internally invokes `git-rev-list` piped to
+`git-diff-tree`, and takes command line options for both of
 these commands. It also presents the merge commit in a special
-format as produced by 'git-diff-tree --cc'.
+format as produced by `git-diff-tree --cc`.
 
 This manual page describes only the most frequently used options.
 
diff --git a/Documentation/git-ssh-fetch.txt b/Documentation/git-ssh-fetch.txt
index b7116b3..d6e6ba3 100644
--- a/Documentation/git-ssh-fetch.txt
+++ b/Documentation/git-ssh-fetch.txt
@@ -9,19 +9,19 @@ git-ssh-fetch - Pulls from a remote repo
 
 SYNOPSIS
 --------
-'git-ssh-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
+'git ssh-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
 
 DESCRIPTION
 -----------
 Pulls from a remote repository over ssh connection, invoking
-git-ssh-upload on the other end. It functions identically to
-git-ssh-upload, aside from which end you run it on.
+`git-ssh-upload` on the other end. It functions identically to
+`git-ssh-upload`, aside from which end you run it on.
 
 
 OPTIONS
 -------
 commit-id::
-        Either the hash or the filename under [URL]/refs/ to
+        Either the hash or the filename under `[URL]/refs/` to
         pull.
 
 -c::
@@ -33,7 +33,7 @@ commit-id::
 -v::
 	Report what is downloaded.
 -w::
-        Writes the commit-id into the filename under $GIT_DIR/refs/ on
+        Writes the commit-id into the filename under `$GIT_DIR/refs/` on
         the local end after the transfer is complete.
 
 
diff --git a/Documentation/git-ssh-upload.txt b/Documentation/git-ssh-upload.txt
index 702674e..4a17100 100644
--- a/Documentation/git-ssh-upload.txt
+++ b/Documentation/git-ssh-upload.txt
@@ -8,13 +8,13 @@ git-ssh-upload - Pushes to a remote repo
 
 SYNOPSIS
 --------
-'git-ssh-upload' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
+'git ssh-upload' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
 
 DESCRIPTION
 -----------
 Pushes from a remote repository over ssh connection, invoking
-git-ssh-fetch on the other end. It functions identically to
-git-ssh-fetch, aside from which end you run it on.
+`git-ssh-fetch` on the other end. It functions identically to
+`git-ssh-fetch`, aside from which end you run it on.
 
 OPTIONS
 -------
@@ -30,7 +30,7 @@ commit-id::
 -v::
         Report what is uploaded.
 -w::
-        Writes the commit-id into the filename under [URL]/refs/ on
+        Writes the commit-id into the filename under `[URL]/refs/` on
         the remote end after the transfer is complete.
 
 Author
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index e446f48..e11ab76 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -8,16 +8,16 @@ git-status - Show working tree status
 
 SYNOPSIS
 --------
-'git-status'
+'git status'
 
 DESCRIPTION
 -----------
 Examines paths in the working tree that has changes unrecorded
 to the index file, and changes between the index file and the
 current HEAD commit.  The former paths are what you _could_
-commit by running 'git-update-index' before running 'git
-commit', and the latter paths are what you _would_ commit by
-running 'git commit'.
+commit by running `git update-index` before running `git
+commit`, and the latter paths are what you _would_ commit by
+running `git commit`.
 
 If there is no path that is different between the index file and
 the current HEAD commit, the command exits with non-zero
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 3a03dd0..412d18e 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -8,7 +8,7 @@ git-stripspace - Filter out empty lines
 
 SYNOPSIS
 --------
-'git-stripspace' < <stream>
+'git stripspace' < <stream>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index b1b87c2..29e75d8 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -10,7 +10,7 @@ git-svnimport - Import a SVN repository 
 SYNOPSIS
 --------
 [verse]
-'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
+'git svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
 		[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
 		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
 		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
@@ -23,14 +23,14 @@ DESCRIPTION
 Imports a SVN repository into git. It will either create a new
 repository, or incrementally import into an existing one.
 
-SVN access is done by the SVN::Perl module.
+SVN access is done by the 'SVN::Perl' module.
 
-git-svnimport assumes that SVN repositories are organized into one
+`git-svnimport` assumes that SVN repositories are organized into one
 "trunk" directory where the main development happens, "branch/FOO"
 directories for branches, and "/tags/FOO" directories for tags.
 Other subdirectories are ignored.
 
-git-svnimport creates a file ".git/svn2git", which is required for
+git-svnimport creates a file `.git/svn2git`, which is required for
 incremental SVN imports.
 
 OPTIONS
@@ -42,7 +42,7 @@ OPTIONS
 -s <start_rev>::
         Start importing at this SVN change number. The  default is 1.
 +
-When importing incrementally, you might need to edit the .git/svn2git file.
+When importing incrementally, you might need to edit the `.git/svn2git` file.
 
 -i::
 	Import-only: don't perform a checkout after importing.  This option
@@ -68,10 +68,10 @@ When importing incrementally, you might 
 	subversion revision.
 
 -I <ignorefile_name>::
-	Import the svn:ignore directory property to files with this
+	Import the 'svn:ignore' directory property to files with this
 	name in each directory. (The Subversion and GIT ignore
 	syntaxes are similar enough that using the Subversion patterns
-	directly with "-I .gitignore" will almost always just work.)
+	directly with `-I .gitignore` will almost always just work.)
 
 -A <author_file>::
 	Read a file with lines on the form
@@ -86,10 +86,10 @@ author and committer for Subversion comm
 "username". If encountering a commit made by a user not in the
 list, abort.
 +
-For convenience, this data is saved to $GIT_DIR/svn-authors
-each time the -A option is provided, and read from that same
-file each time git-svnimport is run with an existing GIT
-repository without -A.
+For convenience, this data is saved to `$GIT_DIR/svn-authors`
+each time the `-A` option is provided, and read from that same
+file each time `git-svnimport` is run with an existing GIT
+repository without `-A`.
 
 -m::
 	Attempt to detect merges based on the commit message. This option
@@ -98,7 +98,7 @@ repository without -A.
 
 -M <regex>::
 	Attempt to detect merges based on the commit message with a custom
-	regex. It can be used with -m to also see the default regexes.
+	regex. It can be used with `-m` to also see the default regexes.
 	You must escape forward slashes.
 
 -l <max_rev>::
@@ -108,7 +108,7 @@ repository without -A.
 	due to SVN memory leaks. (These have been worked around.)
 
 -v::
-	Verbosity: let 'svnimport' report what it is doing.
+	Verbosity: let `svnimport` report what it is doing.
 
 -d::
 	Use direct HTTP requests if possible. The "<path>" argument is used
@@ -125,9 +125,9 @@ with a 40x error pretty quickly.
 
 <SVN_repository_URL>::
 	The URL of the SVN module you want to import. For local
-	repositories, use "file:///absolute/path".
+	repositories, use `file:///absolute/path`.
 +
-If you're using the "-d" or "-D" option, this is the URL of the SVN
+If you're using the `-d` or `-D` option, this is the URL of the SVN
 repository itself; it usually ends in "/svn".
 
 <path>::
@@ -138,9 +138,9 @@ repository itself; it usually ends in "/
 
 OUTPUT
 ------
-If '-v' is specified, the script reports what it is doing.
+If `-v` is specified, the script reports what it is doing.
 
-Otherwise, success is indicated the Unix way, i.e. by simply exiting with
+Otherwise, success is indicated the Unix way, i.e., by simply exiting with
 a zero exit status.
 
 Author
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 68ac6a6..257bf03 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -7,7 +7,7 @@ git-symbolic-ref - read and modify symbo
 
 SYNOPSIS
 --------
-'git-symbolic-ref' <name> [<ref>]
+'git symbolic-ref' <name> [<ref>]
 
 DESCRIPTION
 -----------
@@ -36,7 +36,7 @@ This can be used on a filesystem that do
 links.  Instead of doing `readlink .git/HEAD`, `git-symbolic-ref
 HEAD` can be used to find out which branch we are on.  To point
 the HEAD to `newbranch`, instead of `ln -sf refs/heads/newbranch
-.git/HEAD`, `git-symbolic-ref HEAD refs/heads/newbranch` can be
+.git/HEAD`, `git symbolic-ref HEAD refs/heads/newbranch` can be
 used.
 
 Currently, .git/HEAD uses a regular file symbolic ref on Cygwin,
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index f0f7d8c..0479a2e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,8 +9,8 @@ git-tag - Create a tag object signed wit
 SYNOPSIS
 --------
 [verse]
-'git-tag' [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <name> [<head>]
-'git-tag' -l [<pattern>]
+'git tag' [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <name> [<head>]
+'git tag' -l [<pattern>]
 
 DESCRIPTION
 -----------
@@ -25,7 +25,7 @@ creates a 'tag' object, and requires the
 in the tag message.
 
 Otherwise just the SHA-1 object name of the commit object is
-written (i.e. a lightweight tag).
+written (i.e., a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
 <key-id>` is used.  When `-u <key-id>` is not used, the
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 831537b..cd59094 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -8,7 +8,7 @@ git-tar-tree - Creates a tar archive of 
 
 SYNOPSIS
 --------
-'git-tar-tree' [--remote=<repo>] <tree-ish> [ <base> ]
+'git tar-tree' [--remote=<repo>] <tree-ish> [ <base> ]
 
 DESCRIPTION
 -----------
@@ -16,12 +16,12 @@ Creates a tar archive containing the tre
 When <base> is specified it is added as a leading path to the files in the
 generated tar archive.
 
-git-tar-tree behaves differently when given a tree ID versus when given
+`git tar-tree` behaves differently when given a tree ID versus when given
 a commit ID or tag ID.  In the first case the current time is used as
 modification time of each file in the archive.  In the latter case the
 commit time as recorded in the referenced commit object is used instead.
 Additionally the commit ID is stored in a global extended pax header.
-It can be extracted using git-get-tar-commit-id.
+It can be extracted using `git get-tar-commit-id`.
 
 OPTIONS
 -------
@@ -45,7 +45,7 @@ git tar-tree HEAD | (cd /var/tmp/ && mkd
 	latest commit on the current branch, and extracts it in
 	`/var/tmp/junk` directory.
 
-git tar-tree v2.6.17 linux-2.6.17 | gzip >linux-2.6.17.tar.gz
+git tar-tree v2.6.17 linux-2.6.17 | gzip > linux-2.6.17.tar.gz
 
 	Create a tarball for v2.6.17 release.
 
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index c7b3be1..c9da258 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -9,7 +9,7 @@ git-unpack-file - Creates a temporary fi
 
 SYNOPSIS
 --------
-'git-unpack-file' <blob>
+'git unpack-file' <blob>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index c20b38b..76ad4a4 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -8,7 +8,7 @@ git-unpack-objects - Unpack objects from
 
 SYNOPSIS
 --------
-'git-unpack-objects' [-n] [-q] <pack-file
+'git unpack-objects' [-n] [-q] <pack-file
 
 
 DESCRIPTION
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 6135601..3cd3351 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -9,7 +9,7 @@ git-update-index - Modifies the index or
 SYNOPSIS
 --------
 [verse]
-'git-update-index'
+'git update-index'
 	     [--add] [--remove | --force-remove] [--replace]
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
 	     [--cacheinfo <mode> <object> <file>]\*
@@ -27,7 +27,7 @@ Modifies the index or directory cache. E
 into the index and any 'unmerged' or 'needs updating' state is
 cleared.
 
-The way "git-update-index" handles files it is told about can be modified
+The way `git-update-index` handles files it is told about can be modified
 using the various options:
 
 OPTIONS
@@ -47,17 +47,17 @@ OPTIONS
 	updates are needed by checking stat() information.
 
 -q::
-        Quiet.  If --refresh finds that the index needs an update, the
+        Quiet.  If `--refresh` finds that the index needs an update, the
         default behavior is to error out.  This option makes
-        git-update-index continue anyway.
+        `git-update-index` continue anyway.
 
 --unmerged::
-        If --refresh finds unmerged changes in the index, the default
-        behavior is to error out.  This option makes git-update-index 
+        If `--refresh` finds unmerged changes in the index, the default
+        behavior is to error out.  This option makes `git-update-index` 
         continue anyway.
 
 --ignore-missing::
-	Ignores missing files during a --refresh
+	Ignores missing files during a `--refresh`
 
 --cacheinfo <mode> <object> <path>::
 	Directly insert the specified info into the index.
@@ -95,13 +95,13 @@ OPTIONS
 
 --force-remove::
 	Remove the file from the index even when the working directory
-	still has such a file. (Implies --remove.)
+	still has such a file. (Implies `--remove`.)
 
 --replace::
 	By default, when a file `path` exists in the index,
-	git-update-index refuses an attempt to add `path/file`.
+	`git-update-index` refuses an attempt to add `path/file`.
 	Similarly if a file `path/file` exists, a file `path`
-	cannot be added.  With --replace flag, existing entries
+	cannot be added.  With `--replace` flag, existing entries
 	that conflicts with the entry being added are
 	automatically removed with warning messages.
 
@@ -129,33 +129,33 @@ OPTIONS
 
 Using --refresh
 ---------------
-'--refresh' does not calculate a new SHA-1 file or bring the index
+`--refresh` does not calculate a new SHA-1 file or bring the index
 up-to-date for mode/content changes. But what it *does* do is to
 "re-match" the stat information of a file with the index, so that you
 can refresh the index for a file that hasn't been changed but where
 the stat entry is out of date.
 
-For example, you'd want to do this after doing a "git-read-tree", to link
+For example, you'd want to do this after doing a `git-read-tree`, to link
 up the stat index details with the proper files.
 
 Using --cacheinfo or --info-only
 --------------------------------
-'--cacheinfo' is used to register a file that is not in the
+`--cacheinfo` is used to register a file that is not in the
 current working directory.  This is useful for minimum-checkout
 merging.
 
 To pretend you have a file with mode and SHA-1 at path, say:
 
 ----------------
-$ git-update-index --cacheinfo mode SHA-1 path
+$ git update-index --cacheinfo mode SHA-1 path
 ----------------
 
-'--info-only' is used to register files without placing them in the object
+`--info-only` is used to register files without placing them in the object
 database.  This is useful for status-only repositories.
 
-Both '--cacheinfo' and '--info-only' behave similarly: the index is updated
-but the object database isn't.  '--cacheinfo' is useful when the object is
-in the database but the file isn't available locally.  '--info-only' is
+Both `--cacheinfo` and `--info-only` behave similarly: the index is updated
+but the object database isn't.  `--cacheinfo` is useful when the object is
+in the database but the file isn't available locally.  `--info-only` is
 useful when the file is available, but you do not wish to update the
 object database.
 
@@ -182,7 +182,7 @@ into the index file.
     . mode         SP SHA-1 SP stage TAB path
 +
 This format is to put higher order stages into the
-index file and matches git-ls-files --stage output.
+index file and matches `git ls-files --stage` output.
 
 To place a higher stage entry to the index, the path should
 first be removed by feeding a mode=0 entry for the path, and
@@ -242,8 +242,8 @@ paths updated with other git commands th
 working tree (e.g. `git-apply --index`, `git-checkout-index -u`,
 and `git-read-tree -u`) are automatically marked as "assume
 unchanged".  Note that "assume unchanged" bit is *not* set if
-`git-update-index --refresh` finds the working tree file matches
-the index (use `git-update-index --really-refresh` if you want
+`git update-index --refresh` finds the working tree file matches
+the index (use `git update-index --really-refresh` if you want
 to mark them as "assume unchanged").
 
 
@@ -252,7 +252,7 @@ Examples
 To update and refresh only the files already checked out:
 
 ----------------
-$ git-checkout-index -n -f -a && git-update-index --ignore-missing --refresh
+$ git checkout-index -n -f -a && git update-index --ignore-missing --refresh
 ----------------
 
 On an inefficient filesystem with `core.ignorestat` set::
@@ -293,7 +293,7 @@ unreliable, this should be set to 'false
 This causes the command to ignore differences in file modes recorded
 in the index and the file mode on the filesystem if they differ only on
 executable bit.   On such an unfortunate filesystem, you may
-need to use `git-update-index --chmod=`.
+need to use `git update-index --chmod=`.
 
 The command looks at `core.ignorestat` configuration variable.  See
 'Using "assume unchanged" bit' section above.
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index e062030..e6a6976 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -7,18 +7,18 @@ git-update-ref - update the object name 
 
 SYNOPSIS
 --------
-'git-update-ref' [-m <reason>] <ref> <newvalue> [<oldvalue>]
+'git update-ref' [-m <reason>] <ref> <newvalue> [<oldvalue>]
 
 DESCRIPTION
 -----------
 Given two arguments, stores the <newvalue> in the <ref>, possibly
-dereferencing the symbolic refs.  E.g. `git-update-ref HEAD
+dereferencing the symbolic refs.  E.g. `git update-ref HEAD
 <newvalue>` updates the current branch head to the new object.
 
 Given three arguments, stores the <newvalue> in the <ref>,
 possibly dereferencing the symbolic refs, after verifying that
 the current value of the <ref> matches <oldvalue>.
-E.g. `git-update-ref refs/heads/master <newvalue> <oldvalue>`
+E.g. `git update-ref refs/heads/master <newvalue> <oldvalue>`
 updates the master branch head to <newvalue> only if its current
 value is <oldvalue>.
 
@@ -36,7 +36,7 @@ somewhere else with a regular filename).
 
 In general, using
 
-	git-update-ref HEAD "$head"
+	git update-ref HEAD "$head"
 
 should be a _lot_ safer than doing
 
@@ -52,7 +52,7 @@ archive by creating a symlink tree).
 Logging Updates
 ---------------
 If config parameter "core.logAllRefUpdates" is true or the file
-"$GIT_DIR/logs/<ref>" exists then `git-update-ref` will append
+"$GIT_DIR/logs/<ref>" exists then `git update-ref` will append
 a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
 symbolic refs before creating the log name) describing the change
 in ref value.  Log lines are formatted as:
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 88a03c7..9f9755b 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -8,7 +8,7 @@ git-update-server-info - Update auxiliar
 
 SYNOPSIS
 --------
-'git-update-server-info' [--force]
+'git update-server-info' [--force]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 4795e98..e447f73 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -8,7 +8,7 @@ git-upload-pack - Send missing objects p
 
 SYNOPSIS
 --------
-'git-upload-pack' <directory>
+'git upload-pack' <directory>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-upload-tar.txt b/Documentation/git-upload-tar.txt
index a1019a0..4f20c4c 100644
--- a/Documentation/git-upload-tar.txt
+++ b/Documentation/git-upload-tar.txt
@@ -8,7 +8,7 @@ git-upload-tar - Send tar archive
 
 SYNOPSIS
 --------
-'git-upload-tar' <directory>
+'git upload-tar' <directory>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index a5b1a0d..d5972ac 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -8,7 +8,7 @@ git-var - Print the git users identity
 
 SYNOPSIS
 --------
-'git-var' [ -l | <variable> ]
+'git var' [ -l | <variable> ]
 
 DESCRIPTION
 -----------
@@ -20,11 +20,11 @@ OPTIONS
 	Cause the logical variables to be listed. In addition, all the
 	variables of the git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
-	is deprecated in favor of `git-repo-config -l`.)
+	is deprecated in favor of `git repo-config -l`.)
 
 EXAMPLE
 --------
-	$ git-var GIT_AUTHOR_IDENT
+	$ git var GIT_AUTHOR_IDENT
 	Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
 
 
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 4fa5923..2e2272a 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -8,13 +8,13 @@ git-verify-pack - Validate packed git ar
 
 SYNOPSIS
 --------
-'git-verify-pack' [-v] [--] <pack>.idx ...
+'git verify-pack' [-v] [--] <pack>.idx ...
 
 
 DESCRIPTION
 -----------
 Reads given idx file for packed git archive created with
-git-pack-objects command and verifies idx file and the
+`git-pack-objects` command and verifies idx file and the
 corresponding pack file.
 
 OPTIONS
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index d610a8b..7c9835c 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -7,7 +7,7 @@ git-verify-tag - Check the GPG signature
 
 SYNOPSIS
 --------
-'git-verify-tag' <tag>
+'git verify-tag' <tag>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index e8f21d0..01365ae 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -8,7 +8,7 @@ git-whatchanged - Show logs with differe
 
 SYNOPSIS
 --------
-'git-whatchanged' <option>...
+'git whatchanged' <option>...
 
 DESCRIPTION
 -----------
@@ -53,12 +53,12 @@ However, it is not very useful in genera
 
 Examples
 --------
-git-whatchanged -p v2.6.12.. include/scsi drivers/scsi::
+git whatchanged -p v2.6.12.. include/scsi drivers/scsi::
 
 	Show as patches the commits since version 'v2.6.12' that changed
 	any file in the include/scsi or drivers/scsi subdirectories
 
-git-whatchanged --since="2 weeks ago" \-- gitk::
+git whatchanged --since="2 weeks ago" \-- gitk::
 
 	Show the changes during the last two weeks to the file 'gitk'.
 	The "--" is necessary to avoid confusion with the *branch* named
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
index 77e12cb..5e6da8d 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -8,7 +8,7 @@ git-write-tree - Creates a tree object f
 
 SYNOPSIS
 --------
-'git-write-tree' [--missing-ok]
+'git write-tree' [--missing-ok]
 
 DESCRIPTION
 -----------
-- 
1.4.0.g1b2d
