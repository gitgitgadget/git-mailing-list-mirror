From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Assorted typo fixes
Date: Sat, 03 Feb 2007 23:49:16 -0500
Message-ID: <20070204044916.9196.84265.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 05:49:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDZJa-00019w-B8
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 05:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbXBDEtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 23:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbXBDEtU
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 23:49:20 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:56188 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbXBDEtT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 23:49:19 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDZIS-0007es-Db
	for git@vger.kernel.org; Sat, 03 Feb 2007 23:48:12 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDZJU-0002Ob-Cj
	for git@vger.kernel.org; Sat, 03 Feb 2007 23:49:16 -0500
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38646>


---

 Documentation/config.txt        |    2 +-
 Documentation/diff-format.txt   |    2 +-
 Documentation/git-send-pack.txt |    2 +-
 Documentation/git-svn.txt       |    2 +-
 Documentation/gitk.txt          |    2 +-
 Documentation/user-manual.txt   |   10 +++++-----
 builtin-blame.c                 |    6 +++---
 builtin-branch.c                |    2 +-
 builtin-for-each-ref.c          |    2 +-
 builtin-fsck.c                  |    2 +-
 daemon.c                        |    2 +-
 git-merge-resolve.sh            |    2 +-
 git-quiltimport.sh              |    2 +-
 gitweb/gitweb.perl              |    2 +-
 merge-recursive.c               |    8 ++++----
 perl/Git.pm                     |    2 +-
 perl/private-Error.pm           |    2 +-
 ppc/sha1ppc.S                   |    6 +++---
 sha1_file.c                     |    2 +-
 t/t1004-read-tree-m-u-wf.sh     |    2 +-
 t/t1020-subdirectory.sh         |    6 +++---
 t/t3800-mktag.sh                |    4 ++--
 t/t5000-tar-tree.sh             |    2 +-
 t/t5600-clone-fail-cleanup.sh   |    2 +-
 t/t9101-git-svn-props.sh        |    2 +-
 templates/Makefile              |    2 +-
 templates/hooks--update         |    2 +-
 27 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e5e019f..4e650af 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -39,7 +39,7 @@ in the section header, like in example below:
 
 Subsection names can contain any characters except newline (doublequote
 '`"`' and backslash have to be escaped as '`\"`' and '`\\`',
-respecitvely) and are case sensitive.  Section header cannot span multiple
+respectively) and are case sensitive.  Section header cannot span multiple
 lines.  Variables may belong directly to a section or to a given subsection.
 You can have `[section]` if you have `[section "subsection"]`, but you
 don't need to.
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 883c1bb..378e72f 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -159,7 +159,7 @@ or like this (when '--cc' option is used):
        deleted file mode <mode>,<mode>
 +
 The `mode <mode>,<mode>..<mode>` line appears only if at least one of
-the <mode> is diferent from the rest. Extended headers with
+the <mode> is different from the rest. Extended headers with
 information about detected contents movement (renames and
 copying detection) are designed to work with diff of two
 <tree-ish> and are not used by combined diff format.
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 2f6267c..205bfd2 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -3,7 +3,7 @@ git-send-pack(1)
 
 NAME
 ----
-git-send-pack - Push objects over git protocol to another reposiotory
+git-send-pack - Push objects over git protocol to another repository
 
 
 SYNOPSIS
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index aea4a6b..6ce6a39 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -133,7 +133,7 @@ manually joining branches on commit.
 
 'multi-init'::
 	This command supports git-svnimport-like command-line syntax for
-	importing repositories that are layed out as recommended by the
+	importing repositories that are laid out as recommended by the
 	SVN folks.  This is a bit more tolerant than the git-svnimport
 	command-line syntax and doesn't require the user to figure out
 	where the repository URL ends and where the repository path
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 5bdaa60..48c5894 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -54,7 +54,7 @@ frequently used options.
 
 	Limit commits to the ones touching files in the given paths. Note, to
 	avoid ambiguity wrt. revision names use "--" to separate the paths
-	from any preceeding options.
+	from any preceding options.
 
 Examples
 --------
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6576625..c5e9ea8 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -425,8 +425,8 @@ if commit X is an ancestor of commit Y.  Equivalently, you could say
 that Y is a descendent of X, or that there is a chain of parents
 leading from commit Y to commit X.
 
-Undestanding history: History diagrams
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Understanding history: History diagrams
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 We will sometimes represent git history using diagrams like the one
 below.  Commits are shown as "o", and the links between them with
@@ -806,7 +806,7 @@ display options.
 
 Note that git log starts with the most recent commit and works
 backwards through the parents; however, since git history can contain
-multiple independant lines of development, the particular order that
+multiple independent lines of development, the particular order that
 commits are listed in may be somewhat arbitrary.
 
 Generating diffs
@@ -1075,7 +1075,7 @@ $ git commit
 -------------------------------------------------
 
 and git will prompt you for a commit message and then create the new
-commmit.  Check to make sure it looks like what you expected with
+commit.  Check to make sure it looks like what you expected with
 
 -------------------------------------------------
 $ git show
@@ -2953,7 +2953,7 @@ Include cross-references to the glossary, where appropriate.
 Document shallow clones?  See draft 1.5.0 release notes for some
 documentation.
 
-Add a sectin on working with other version control systems, including
+Add a section on working with other version control systems, including
 CVS, Subversion, and just imports of series of release tarballs.
 
 More details on gitweb?
diff --git a/builtin-blame.c b/builtin-blame.c
index 3033e9b..1c21204 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -550,7 +550,7 @@ static void free_patch(struct patch *p)
 }
 
 /*
- * Link in a new blame entry to the scorebord.  Entries that cover the
+ * Link in a new blame entry to the scoreboard.  Entries that cover the
  * same line range have been removed from the scoreboard previously.
  */
 static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
@@ -1392,7 +1392,7 @@ static void found_guilty_entry(struct blame_entry *ent)
 
 /*
  * The main loop -- while the scoreboard has lines whose true origin
- * is still unknown, pick one brame_entry, and allow its current
+ * is still unknown, pick one blame_entry, and allow its current
  * suspect to pass blames to its parents.
  */
 static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
@@ -2001,7 +2001,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	/*
 	 * We have collected options unknown to us in argv[1..unk]
 	 * which are to be passed to revision machinery if we are
-	 * going to do the "bottom" procesing.
+	 * going to do the "bottom" processing.
 	 *
 	 * The remaining are:
 	 *
diff --git a/builtin-branch.c b/builtin-branch.c
index d60690b..35886c9 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -358,7 +358,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	unsigned char sha1[20];
 
 	if (!oldname)
-		die("cannot rename the curren branch while not on any.");
+		die("cannot rename the current branch while not on any.");
 
 	if (snprintf(oldref, sizeof(oldref), "refs/heads/%s", oldname) > sizeof(oldref))
 		die("Old branchname too long");
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 9d5f266..16c785f 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -135,7 +135,7 @@ static const char *find_next(const char *cp)
 	while (*cp) {
 		if (*cp == '%') {
 			/* %( is the start of an atom;
-			 * %% is a quoteed per-cent.
+			 * %% is a quoted per-cent.
 			 */
 			if (cp[1] == '(')
 				return cp;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index fec1cbd..f6f1967 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -117,7 +117,7 @@ static void check_unreachable_object(struct object *obj)
 
 	/*
 	 * "!used" means that nothing at all points to it, including
-	 * other unreacahble objects. In other words, it's the "tip"
+	 * other unreachable objects. In other words, it's the "tip"
 	 * of some set of unreachable objects, usually a commit that
 	 * got dropped.
 	 *
diff --git a/daemon.c b/daemon.c
index 9590372..2a20ca5 100644
--- a/daemon.c
+++ b/daemon.c
@@ -408,7 +408,7 @@ static void make_service_overridable(const char *name, int ena) {
 
 /*
  * Separate the "extra args" information as supplied by the client connection.
- * Any resulting data is squirrelled away in the given interpolation table.
+ * Any resulting data is squirreled away in the given interpolation table.
  */
 static void parse_extra_args(struct interp *table, char *extra_args, int buflen)
 {
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
index 0a8ef21..75e1de4 100755
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2005 Junio C Hamano
 #
-# Resolve two trees, using enhancd multi-base read-tree.
+# Resolve two trees, using enhanced multi-base read-tree.
 
 # The first parameters up to -- are merge bases; the rest are heads.
 bases= head= remotes= sep_seen=
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 2ae1f20..671a5ff 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -59,7 +59,7 @@ if ! [ -d "$QUILT_PATCHES" ] ; then
 	exit 1
 fi
 
-# Temporay directories
+# Temporary directories
 tmp_dir=.dotest
 tmp_msg="$tmp_dir/msg"
 tmp_patch="$tmp_dir/patch"
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b606c1d..a2076a6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -834,7 +834,7 @@ sub file_type_long {
 
 ## ----------------------------------------------------------------------
 ## functions returning short HTML fragments, or transforming HTML fragments
-## which don't beling to other sections
+## which don't belong to other sections
 
 # format line of commit message.
 sub format_log_line_html {
diff --git a/merge-recursive.c b/merge-recursive.c
index fa320eb..a5e6845 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -386,7 +386,7 @@ struct rename
 };
 
 /*
- * Get information of all renames which occured between 'o_tree' and
+ * Get information of all renames which occurred between 'o_tree' and
  * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
  * 'b_tree') to be able to associate the correct cache entries with
  * the rename information. 'tree' is always equal to either a_tree or b_tree.
@@ -1175,7 +1175,7 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
 
 /*
  * Merge the commits h1 and h2, return the resulting virtual
- * commit object and a flag indicating the cleaness of the merge.
+ * commit object and a flag indicating the cleanness of the merge.
  */
 static int merge(struct commit *h1,
 		 struct commit *h2,
@@ -1222,8 +1222,8 @@ static int merge(struct commit *h1,
 		/*
 		 * When the merge fails, the result contains files
 		 * with conflict markers. The cleanness flag is
-		 * ignored, it was never acutally used, as result of
-		 * merge_trees has always overwritten it: the commited
+		 * ignored, it was never actually used, as result of
+		 * merge_trees has always overwritten it: the committed
 		 * "conflicts" were already resolved.
 		 */
 		discard_cache();
diff --git a/perl/Git.pm b/perl/Git.pm
index 5d1ccaa..f2c156c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -354,7 +354,7 @@ sub command_input_pipe {
 =item command_close_pipe ( PIPE [, CTX ] )
 
 Close the C<PIPE> as returned from C<command_*_pipe()>, checking
-whether the command finished successfuly. The optional C<CTX> argument
+whether the command finished successfully. The optional C<CTX> argument
 is required if you want to see the command name in the error message,
 and it is the second value returned by C<command_*_pipe()> when
 called in array context. The call idiom is:
diff --git a/perl/private-Error.pm b/perl/private-Error.pm
index 8fff866..11e9cd9 100644
--- a/perl/private-Error.pm
+++ b/perl/private-Error.pm
@@ -781,7 +781,7 @@ that is a plain string. (Unless C<$Error::ObjectifyCallback> is modified)
 
 This variable holds a reference to a subroutine that converts errors that
 are plain strings to objects. It is used by Error.pm to convert textual
-errors to objects, and can be overrided by the user.
+errors to objects, and can be overridden by the user.
 
 It accepts a single argument which is a hash reference to named parameters.
 Currently the only named parameter passed is C<'text'> which is the text
diff --git a/ppc/sha1ppc.S b/ppc/sha1ppc.S
index 140cb53..f132696 100644
--- a/ppc/sha1ppc.S
+++ b/ppc/sha1ppc.S
@@ -18,7 +18,7 @@
  * %r0 - temp
  * %r3 - argument (pointer to 5 words of SHA state)
  * %r4 - argument (pointer to data to hash)
- * %r5 - Contant K in SHA round (initially number of blocks to hash)
+ * %r5 - Constant K in SHA round (initially number of blocks to hash)
  * %r6-%r10 - Working copies of SHA variables A..E (actually E..A order)
  * %r11-%r26 - Data being hashed W[].
  * %r27-%r31 - Previous copies of A..E, for final add back.
@@ -48,7 +48,7 @@
  * E += ROTL(A,5) + F(B,C,D) + W[i] + K;  B = ROTL(B,30)
  * Then the variables are renamed: (A,B,C,D,E) = (E,A,B,C,D).
  *
- * Every 20 rounds, the function F() and the contant K changes:
+ * Every 20 rounds, the function F() and the constant K changes:
  * - 20 rounds of f0(b,c,d) = "bit wise b ? c : d" =  (^b & d) + (b & c)
  * - 20 rounds of f1(b,c,d) = b^c^d = (b^d)^c
  * - 20 rounds of f2(b,c,d) = majority(b,c,d) = (b&d) + ((b^d)&c)
@@ -57,7 +57,7 @@
  * These are all scheduled for near-optimal performance on a G4.
  * The G4 is a 3-issue out-of-order machine with 3 ALUs, but it can only
  * *consider* starting the oldest 3 instructions per cycle.  So to get
- * maximum performace out of it, you have to treat it as an in-order
+ * maximum performance out of it, you have to treat it as an in-order
  * machine.  Which means interleaving the computation round t with the
  * computation of W[t+4].
  *
diff --git a/sha1_file.c b/sha1_file.c
index 45e410e..1526a28 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1163,7 +1163,7 @@ static unsigned long unpack_object_header(struct packed_git *p,
 
 	/* use_pack() assures us we have [base, base + 20) available
 	 * as a range that we can look at at.  (Its actually the hash
-	 * size that is assurred.)  With our object header encoding
+	 * size that is assured.)  With our object header encoding
 	 * the maximum deflated object size is 2^137, which is just
 	 * insane, so we know won't exceed what we have been given.
 	 */
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 4f664f6..c11420a 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -87,7 +87,7 @@ test_expect_success 'three-way not complaining on an untracked path in both' '
 	git-read-tree -m -u branch-point master side
 '
 
-test_expect_success 'three-way not cloberring a working tree file' '
+test_expect_success 'three-way not clobbering a working tree file' '
 
 	git reset --hard &&
 	rm -f file2 subdir/file2 file3 subdir/file3 &&
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index c090c96..1e8f9e5 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -106,21 +106,21 @@ test_expect_success 'read-tree' '
 	cmp ../one ../original.one
 '
 
-test_expect_success 'no file/rev ambuguity check inside .git' '
+test_expect_success 'no file/rev ambiguity check inside .git' '
 	cd $HERE &&
 	git commit -a -m 1 &&
 	cd $HERE/.git &&
 	git show -s HEAD
 '
 
-test_expect_success 'no file/rev ambuguity check inside a bare repo' '
+test_expect_success 'no file/rev ambiguity check inside a bare repo' '
 	cd $HERE &&
 	git clone -s --bare .git foo.git &&
 	cd foo.git && GIT_DIR=. git show -s HEAD
 '
 
 # This still does not work as it should...
-: test_expect_success 'no file/rev ambuguity check inside a bare repo' '
+: test_expect_success 'no file/rev ambiguity check inside a bare repo' '
 	cd $HERE &&
 	git clone -s --bare .git foo.git &&
 	cd foo.git && git show -s HEAD
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index ede4d42..7c7e433 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -172,7 +172,7 @@ EOF
 check_verify_failure 'verify tag-name check'
 
 ############################################################
-# 11. tagger line lable check #1
+# 11. tagger line label check #1
 
 cat >tag.sig <<EOF
 object $head
@@ -187,7 +187,7 @@ EOF
 check_verify_failure '"tagger" line label check #1'
 
 ############################################################
-# 12. tagger line lable check #2
+# 12. tagger line label check #2
 
 cat >tag.sig <<EOF
 object $head
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index cf08e92..ac835fe 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -10,7 +10,7 @@ commit id embedding:
 
   The contents of the repository is compared to the extracted tar
   archive.  The repository contains simple text files, symlinks and a
-  binary file (/bin/sh).  Only pathes shorter than 99 characters are
+  binary file (/bin/sh).  Only paths shorter than 99 characters are
   used.
 
   git-tar-tree applies the commit date to every file in the archive it
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 041be04..1776b37 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -36,7 +36,7 @@ test_expect_success \
     'git-clone foo bar'
 
 test_expect_success \
-    'successfull clone must leave the directory' \
+    'successful clone must leave the directory' \
     'cd bar'
 
 test_done
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 46fcec5..a2c4dc3 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -70,7 +70,7 @@ name='test svn:keywords ignoring'
 test_expect_success "$name" \
 	'git checkout -b mybranch remotes/git-svn &&
 	echo Hi again >> kw.c &&
-	git commit -a -m "test keywoards ignoring" &&
+	git commit -a -m "test keywords ignoring" &&
 	git-svn set-tree remotes/git-svn..mybranch &&
 	git pull . remotes/git-svn'
 
diff --git a/templates/Makefile b/templates/Makefile
index 9e1ae1a..0eeee43 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -6,7 +6,7 @@ prefix ?= $(HOME)
 template_dir ?= $(prefix)/share/git-core/templates/
 # DESTDIR=
 
-# Shell quote (do not use $(call) to accomodate ancient setups);
+# Shell quote (do not use $(call) to accommodate ancient setups);
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 
diff --git a/templates/hooks--update b/templates/hooks--update
index 4bd9d96..d4253cb 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -61,7 +61,7 @@ newrev_type=$(git-cat-file -t "$newrev")
 
 case "$refname","$newrev_type" in
 	refs/tags/*,commit)
-		# un-annoted tag
+		# un-annotated tag
 		refname_type="tag"
 		short_refname=${refname##refs/tags/}
 		if [ $allowunannotated != "true" ]; then
