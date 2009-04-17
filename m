From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH 3/3] Fix typos / spelling in comments
Date: Fri, 17 Apr 2009 19:13:30 +0100
Message-ID: <1239992010-16698-4-git-send-email-mike@abacus.co.uk>
References: <1239992010-16698-1-git-send-email-mike@abacus.co.uk>
 <1239992010-16698-2-git-send-email-mike@abacus.co.uk>
 <1239992010-16698-3-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:40:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lusyk-0008E2-T3
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758881AbZDQSiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbZDQSiV
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:38:21 -0400
Received: from [82.109.193.99] ([82.109.193.99]:31742 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759323AbZDQSiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 14:38:14 -0400
X-Greylist: delayed 1556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2009 14:38:13 EDT
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id 2662C1D539C; Fri, 17 Apr 2009 19:13:30 +0100 (BST)
X-Mailer: git-send-email 1.6.0.2.229.g1293c
In-Reply-To: <1239992010-16698-3-git-send-email-mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116770>

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 builtin-checkout.c       |    2 +-
 builtin-ls-files.c       |    2 +-
 builtin-pack-objects.c   |    2 +-
 builtin-reflog.c         |    2 +-
 builtin-reset.c          |    2 +-
 compat/cygwin.c          |    2 +-
 compat/fnmatch/fnmatch.c |    4 ++--
 compat/mingw.c           |    2 +-
 compat/regex/regex.c     |    4 ++--
 diffcore-rename.c        |    2 +-
 fast-import.c            |    6 +++---
 fsck.h                   |    2 +-
 git.c                    |    2 +-
 graph.c                  |    2 +-
 levenshtein.c            |    2 +-
 parse-options.h          |    8 ++++----
 revision.c               |    2 +-
 strbuf.h                 |    2 +-
 tree-diff.c              |    2 +-
 xdiff/xdiffi.c           |    2 +-
 20 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index ee1edd4..383598c 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -178,7 +178,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	/*
 	 * NEEDSWORK:
 	 * There is absolutely no reason to write this as a blob object
-	 * and create a phoney cache entry just to leak.  This hack is
+	 * and create a phony cache entry just to leak.  This hack is
 	 * primarily to get to the write_entry() machinery that massages
 	 * the contents to work-tree format and writes out which only
 	 * allows it for a cache entry.  The code in write_entry() needs
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 88e2697..da2daf4 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -512,7 +512,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 
 	pathspec = get_pathspec(prefix, argv);
 
-	/* be nice with submodule patsh ending in a slash */
+	/* be nice with submodule paths ending in a slash */
 	read_cache();
 	if (pathspec)
 		strip_trailing_slash_from_submodules();
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d3360ac..1af6c62 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -293,7 +293,7 @@ static unsigned long write_object(struct sha1file *f,
 				die("unable to read %s", sha1_to_hex(entry->idx.sha1));
 			/*
 			 * make sure no cached delta data remains from a
-			 * previous attempt before a pack split occured.
+			 * previous attempt before a pack split occurred.
 			 */
 			free(entry->delta_data);
 			entry->delta_data = NULL;
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 249ad2a..ff8b4f6 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -243,7 +243,7 @@ static void mark_reachable(struct commit *commit, unsigned long expire_limit)
 	 * We need to compute if commit on either side of an reflog
 	 * entry is reachable from the tip of the ref for all entries.
 	 * Mark commits that are reachable from the tip down to the
-	 * time threashold first; we know a commit marked thusly is
+	 * time threshold first; we know a commit marked thusly is
 	 * reachable from the tip without running in_merge_bases()
 	 * at all.
 	 */
diff --git a/builtin-reset.c b/builtin-reset.c
index c0cb915..7e7ebab 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -228,7 +228,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		}
 		/*
 		 * Otherwise, argv[i] could be either <rev> or <paths> and
-		 * has to be unambigous.
+		 * has to be unambiguous.
 		 */
 		else if (!get_sha1(argv[i], sha1)) {
 			/*
diff --git a/compat/cygwin.c b/compat/cygwin.c
index ebac148..1192874 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -92,7 +92,7 @@ static int cygwin_stat(const char *path, struct stat *buf)
  * Reading this option is not always possible immediately as git_dir may be
  * not be set yet. So until it is set, use cygwin lstat/stat functions.
  * However, if core.filemode is set, we must use the Cygwin posix
- * stat/lstat as the Windows stat fuctions do not determine posix filemode.
+ * stat/lstat as the Windows stat functions do not determine posix filemode.
  *
  * Note that git_cygwin_config() does NOT call git_default_config() and this
  * is deliberate.  Many commands read from config to establish initial
diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 1f4ead5..03157a4 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -39,7 +39,7 @@
 # include <stdlib.h>
 #endif
 
-/* For platform which support the ISO C amendement 1 functionality we
+/* For platform which support the ISO C amendment 1 functionality we
    support user defined character classes.  */
 #if defined _LIBC || (defined HAVE_WCTYPE_H && defined HAVE_WCHAR_H)
 /* Solaris 2.5 has a bug: <wchar.h> must be included before <wctype.h>.  */
@@ -90,7 +90,7 @@
 
 # if defined _LIBC || (defined HAVE_WCTYPE_H && defined HAVE_WCHAR_H)
 /* The GNU C library provides support for user-defined character classes
-   and the functions from ISO C amendement 1.  */
+   and the functions from ISO C amendment 1.  */
 #  ifdef CHARCLASS_NAME_MAX
 #   define CHAR_CLASS_MAX_LENGTH CHARCLASS_NAME_MAX
 #  else
diff --git a/compat/mingw.c b/compat/mingw.c
index 2839d9d..32d4c0c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -396,7 +396,7 @@ repeat:
 		 * its own input data to become available. But since
 		 * the process (pack-objects) is itself CPU intensive,
 		 * it will happily pick up the time slice that we are
-		 * relinguishing here.
+		 * relinquishing here.
 		 */
 		Sleep(0);
 		goto repeat;
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 87b33e4..5ea0075 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -1043,7 +1043,7 @@ regex_compile (pattern, size, syntax, bufp)
      they can be reliably used as array indices.  */
   register unsigned char c, c1;
 
-  /* A random tempory spot in PATTERN.  */
+  /* A random temporary spot in PATTERN.  */
   const char *p1;
 
   /* Points to the end of the buffer, where we should append.  */
@@ -1796,7 +1796,7 @@ regex_compile (pattern, size, syntax, bufp)
 		    we're all done, the pattern will look like:
 		      set_number_at <jump count> <upper bound>
 		      set_number_at <succeed_n count> <lower bound>
-		      succeed_n <after jump addr> <succed_n count>
+		      succeed_n <after jump addr> <succeed_n count>
 		      <body of loop>
 		      jump_n <succeed_n addr> <jump count>
 		    (The upper bound and `jump_n' are omitted if
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0b0d6b8..63ac998 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -267,7 +267,7 @@ static int find_identical_files(struct file_similarity *src,
 			int score;
 			struct diff_filespec *source = p->filespec;
 
-			/* False hash collission? */
+			/* False hash collision? */
 			if (hashcmp(source->sha1, target->sha1))
 				continue;
 			/* Non-regular files? If so, the modes must match! */
diff --git a/fast-import.c b/fast-import.c
index 23c496d..53617a1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -76,7 +76,7 @@ Format of STDIN stream:
     delim lf;
 
      # note: declen indicates the length of binary_data in bytes.
-     # declen does not include the lf preceeding the binary data.
+     # declen does not include the lf preceding the binary data.
      #
   exact_data ::= 'data' sp declen lf
     binary_data;
@@ -134,7 +134,7 @@ Format of STDIN stream:
      #
      # In case it is not clear, the '#' that starts the comment
      # must be the first character on that the line (an lf have
-     # preceeded it).
+     # preceded it).
      #
   comment ::= '#' not_lf* lf;
   not_lf  ::= # Any byte that is not ASCII newline (LF);
@@ -953,7 +953,7 @@ static void end_packfile(void)
 		close(pack_data->pack_fd);
 		idx_name = keep_pack(create_index());
 
-		/* Register the packfile with core git's machinary. */
+		/* Register the packfile with core git's machinery. */
 		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
diff --git a/fsck.h b/fsck.h
index 990ee02..008456b 100644
--- a/fsck.h
+++ b/fsck.h
@@ -23,7 +23,7 @@ int fsck_error_function(struct object *obj, int type, const char *fmt, ...);
  * the return value is:
  *    -1	error in processing the object
  *    <0	return value of the callback, which lead to an abort
- *    >0	return value of the first sigaled error >0 (in the case of no other errors)
+ *    >0	return value of the first signaled error >0 (in the case of no other errors)
  *    0		everything OK
  */
 int fsck_walk(struct object *obj, fsck_walk_func walk, void *data);
diff --git a/git.c b/git.c
index bfb6508..cc5aaa7 100644
--- a/git.c
+++ b/git.c
@@ -497,7 +497,7 @@ int main(int argc, const char **argv)
 
 	/*
 	 * We use PATH to find git commands, but we prepend some higher
-	 * precidence paths: the "--exec-path" option, the GIT_EXEC_PATH
+	 * precedence paths: the "--exec-path" option, the GIT_EXEC_PATH
 	 * environment, and the $(gitexecdir) from the Makefile at build
 	 * time.
 	 */
diff --git a/graph.c b/graph.c
index 162a516..0daf5de 100644
--- a/graph.c
+++ b/graph.c
@@ -34,7 +34,7 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
  * newline.  A new graph line will not be printed after the final newline.
  * If the strbuf is empty, no output will be printed.
  *
- * Since the first line will not include the graph ouput, the caller is
+ * Since the first line will not include the graph output, the caller is
  * responsible for printing this line's graph (perhaps via
  * graph_show_commit() or graph_show_oneline()) before calling
  * graph_show_strbuf().
diff --git a/levenshtein.c b/levenshtein.c
index a32f4cd..fc28159 100644
--- a/levenshtein.c
+++ b/levenshtein.c
@@ -27,7 +27,7 @@
  *
  * It does so by calculating the costs of the path ending in characters
  * i (in string1) and j (in string2), respectively, given that the last
- * operation is a substition, a swap, a deletion, or an insertion.
+ * operation is a substitution, a swap, a deletion, or an insertion.
  *
  * This implementation allows the costs to be weighted:
  *
diff --git a/parse-options.h b/parse-options.h
index f8ef1db..b54eec1 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -52,7 +52,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `argh`::
  *   token to explain the kind of argument this option wants. Keep it
- *   homogenous across the repository.
+ *   homogeneous across the repository.
  *
  * `help`::
  *   the short help associated to what the option does.
@@ -61,7 +61,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `flags`::
  *   mask of parse_opt_option_flags.
- *   PARSE_OPT_OPTARG: says that the argument is optionnal (not for BOOLEANs)
+ *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
  *   PARSE_OPT_NOARG: says that this option takes no argument, for CALLBACKs
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN this option is skipped in the default usage, showed in
@@ -105,7 +105,7 @@ struct option {
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
 
 /* parse_options() will filter out the processed options and leave the
- * non-option argments in argv[].
+ * non-option arguments in argv[].
  * Returns the number of arguments left in argv[].
  */
 extern int parse_options(int argc, const char **argv,
@@ -115,7 +115,7 @@ extern int parse_options(int argc, const char **argv,
 extern NORETURN void usage_with_options(const char * const *usagestr,
                                         const struct option *options);
 
-/*----- incremantal advanced APIs -----*/
+/*----- incremental advanced APIs -----*/
 
 enum {
 	PARSE_OPT_HELP = -1,
diff --git a/revision.c b/revision.c
index b6215cc..6007a2c 100644
--- a/revision.c
+++ b/revision.c
@@ -209,7 +209,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 	}
 
 	/*
-	 * Tree object? Either mark it uniniteresting, or add it
+	 * Tree object? Either mark it uninteresting, or add it
 	 * to the list of objects to look at later..
 	 */
 	if (object->type == OBJ_TREE) {
diff --git a/strbuf.h b/strbuf.h
index 9ee908a..eaa8704 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -11,7 +11,7 @@
  *    build complex strings/buffers whose final size isn't easily known.
  *
  *    It is NOT legal to copy the ->buf pointer away.
- *    `strbuf_detach' is the operation that detachs a buffer from its shell
+ *    `strbuf_detach' is the operation that detaches a buffer from its shell
  *    while keeping the shell valid wrt its invariants.
  *
  * 2. the ->buf member is a byte array that has at least ->len + 1 bytes
diff --git a/tree-diff.c b/tree-diff.c
index b05d0f4..edd8394 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -374,7 +374,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	}
 
 	/*
-	 * Then, discard all the non-relevane file pairs...
+	 * Then, discard all the non-relevant file pairs...
 	 */
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 02184d9..1ebab68 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -456,7 +456,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			/*
 			 * Record the end-of-group position in case we are matched
 			 * with a group of changes in the other file (that is, the
-			 * change record before the enf-of-group index in the other
+			 * change record before the end-of-group index in the other
 			 * file is set).
 			 */
 			ixref = rchgo[ixo - 1] ? ix: nrec;
-- 
1.6.0.2.229.g1293c.dirty
