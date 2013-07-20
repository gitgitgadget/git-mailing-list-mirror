From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: [PATCH 2/2] Fix typos in comments
Date: Sat, 20 Jul 2013 21:13:12 +0200
Message-ID: <20130720191311.GB30044@domone>
References: <20130720190707.GA30044@domone>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 21:13:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0car-00037k-GS
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 21:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab3GTTNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 15:13:21 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:45884 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab3GTTNS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 15:13:18 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id C00E4681A5
	for <git@vger.kernel.org>; Sat, 20 Jul 2013 21:13:12 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id 7414D5FB94; Sat, 20 Jul 2013 21:13:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130720190707.GA30044@domone>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	LONGWORDS,UNPARSEABLE_RELAY autolearn=no version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230902>

Hi, I wrote a tool that effectively fixes typos in comments and only in
comments.
It can be downloaded here:

https://github.com/neleai/stylepp

Now I fix specific typos. First I need to generate list of likely typos. 
This is done by running following commands in desired directory

STYLEPP/script/stylepp_spellcheck # then
STYLEPP/script/stylepp_dictionary 

This creates an dictionary so we can use

STYLEPP/script/stylepp_skeleton stylepp_fix_comment


A dictionary that I generated is following, patch is below.

           accreting accrediting
             alloted allocated
           apporiate appropriate
              becaue because
           behaviour behavior
            coalesed coalesced
           colourful colorful
            commentz comments
             commmit commit
          converison conversion
        correspoding corresponding
          descendent descendant
         descendents descendants
          ententries entries
        environement environment
            erroring erring
         explicitely explicitly
             happear appear
           identifer identifier
          initialied initialized
         initialised initialized
           intialize initialize
             matcing matching
          programing programming
          sastisfies satisfies
            satisify satisfy
           sequemces sequences
             timming trimming
             traling trailing
           transiton transition
           writeable writable


---
 builtin/apply.c             |    2 +-
 builtin/checkout.c          |    2 +-
 builtin/fast-export.c       |    2 +-
 builtin/log.c               |    2 +-
 builtin/mktree.c            |    2 +-
 builtin/push.c              |    2 +-
 builtin/tar-tree.c          |    2 +-
 builtin/update-index.c      |    2 +-
 cache.h                     |    2 +-
 combine-diff.c              |    2 +-
 commit-slab.h               |    2 +-
 compat/nedmalloc/malloc.c.h |    8 ++++----
 compat/obstack.h            |    2 +-
 compat/poll/poll.h          |    2 +-
 compat/precompose_utf8.c    |    2 +-
 compat/regex/regcomp.c      |    8 ++++----
 compat/regex/regexec.c      |    4 ++--
 convert.c                   |    2 +-
 convert.h                   |    2 +-
 diff-no-index.c             |    2 +-
 diff.c                      |    4 ++--
 kwset.c                     |   10 +++++-----
 notes.h                     |    8 ++++----
 read-cache.c                |    2 +-
 refs.h                      |    2 +-
 revision.c                  |    2 +-
 sha1_name.c                 |    2 +-
 transport-helper.c          |    4 ++--
 write_or_die.c              |    2 +-
 xdiff/xprepare.c            |    2 +-
 30 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4f4dd56..541dc6b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -132,7 +132,7 @@ static void set_default_whitespace_mode(const char *whitespace_option)
 }
 
 /*
- * For "diff-stat" like behaviour, we keep track of the biggest change
+ * For "diff-stat" like behavior, we keep track of the biggest change
  * we've seen, and the longest filename. That allows us to do simple
  * scaling.
  */
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7fe0bff..9f29bb2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1137,7 +1137,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 *  3) git checkout <something> [<paths>]
 	 *
 	 * including "last branch" syntax and DWIM-ery for names of
-	 * remote branches, erroring out for invalid or ambiguous cases.
+	 * remote branches, erring out for invalid or ambiguous cases.
 	 */
 	if (argc) {
 		unsigned char rev[20];
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d1d68e9..8e19058 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -379,7 +379,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	int tagged_mark;
 	struct commit *p;
 
-	/* Trees have no identifer in fast-export output, thus we have no way
+	/* Trees have no identifier in fast-export output, thus we have no way
 	 * to output tags of trees, tags of tags of trees, etc.  Simply omit
 	 * such tags.
 	 */
diff --git a/builtin/log.c b/builtin/log.c
index 2625f98..b97f56e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1348,7 +1348,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 		if (rev.max_count < 0 && !rev.show_root_diff) {
 			/*
-			 * This is traditional behaviour of "git format-patch
+			 * This is traditional behavior of "git format-patch
 			 * origin" that prepares what the origin side still
 			 * does not have.
 			 */
diff --git a/builtin/mktree.c b/builtin/mktree.c
index f92ba40..c415a67 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -176,7 +176,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 			/*
 			 * Execution gets here if the last tree entry is terminated with a
 			 * new-line.  The final new-line has been made optional to be
-			 * consistent with the original non-batch behaviour of mktree.
+			 * consistent with the original non-batch behavior of mktree.
 			 */
 			; /* skip creating an empty tree */
 		} else {
diff --git a/builtin/push.c b/builtin/push.c
index 6d36c24..04f0eaf 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -92,7 +92,7 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	if (!short_upstream)
 		short_upstream = branch->merge[0]->src;
 	/*
-	 * Don't show advice for people who explicitely set
+	 * Don't show advice for people who explicitly set
 	 * push.default.
 	 */
 	if (push_default == PUSH_DEFAULT_UNSPECIFIED)
diff --git a/builtin/tar-tree.c b/builtin/tar-tree.c
index 3f1e701..c7186d6 100644
--- a/builtin/tar-tree.c
+++ b/builtin/tar-tree.c
@@ -42,7 +42,7 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * Because it's just a compatibility wrapper, tar-tree supports only
-	 * the old behaviour of reading attributes from the work tree.
+	 * the old behavior of reading attributes from the work tree.
 	 */
 	nargv[nargc++] = "--worktree-attributes";
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b558e09..53be19c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -124,7 +124,7 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
  *    exist as such any more. If removal isn't allowed, it's
  *    an error.
  *
- *    (NOTE! This is old and arguably fairly strange behaviour.
+ *    (NOTE! This is old and arguably fairly strange behavior.
  *    We might want to make this an error unconditionally, and
  *    use "--force-remove" if you actually want to force removal).
  *
diff --git a/cache.h b/cache.h
index 2d06169..67f9fae 100644
--- a/cache.h
+++ b/cache.h
@@ -489,7 +489,7 @@ extern void *read_blob_data_from_index(struct index_state *, const char *, unsig
 extern int ie_match_stat(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
-#define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONESTAR */
+#define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspec() */
diff --git a/combine-diff.c b/combine-diff.c
index 6dc0609..88525b3 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -165,7 +165,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 
 	/*
 	 * Coalesce new lines into base by finding the LCS
-	 * - Create the table to run dynamic programing
+	 * - Create the table to run dynamic programming
 	 * - Compute the LCS
 	 * - Then reverse read the direction structure:
 	 *   - If we have MATCH, assign parent to base flag, and consume
diff --git a/commit-slab.h b/commit-slab.h
index 7d48163..4f1c796 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -22,7 +22,7 @@
  *
  *   Initializes the indegree slab that associates an array of integers
  *   to each commit. 'stride' specifies how big each array is.  The slab
- *   that id initialied by the variant without "_with_stride" associates
+ *   that id initialized by the variant without "_with_stride" associates
  *   each commit with an array of one integer.
  */
 
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 5a44dea..ca0d0d7 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1558,7 +1558,7 @@ static FORCEINLINE void* win32direct_mmap(size_t size) {
   return (ptr != 0)? ptr: MFAIL;
 }
 
-/* This function supports releasing coalesed segments */
+/* This function supports releasing coalesced segments */
 static FORCEINLINE int win32munmap(void* ptr, size_t size) {
   MEMORY_BASIC_INFORMATION minfo;
   char* cptr = (char*)ptr;
@@ -2478,7 +2478,7 @@ typedef struct malloc_segment* msegmentptr;
 
   Trim support
     Fields holding the amount of unused topmost memory that should trigger
-    timming, and a counter to force periodic scanning to release unused
+    trimming, and a counter to force periodic scanning to release unused
     non-topmost segments.
 
   Locking
@@ -3602,8 +3602,8 @@ static void internal_malloc_stats(mstate m) {
      and choose its bk node as its replacement.
   2. If x was the last node of its size, but not a leaf node, it must
      be replaced with a leaf node (not merely one with an open left or
-     right), to make sure that lefts and rights of descendents
-     correspond properly to bit masks.  We use the rightmost descendent
+     right), to make sure that lefts and rights of descendants
+     correspond properly to bit masks.  We use the rightmost descendant
      of x.  We could use any other leaf, but this is easy to locate and
      tends to counteract removal of leftmosts elsewhere, and so keeps
      paths shorter than minimally guaranteed.  This doesn't loop much
diff --git a/compat/obstack.h b/compat/obstack.h
index ceb4bdb..72af819 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -80,7 +80,7 @@ change its address during its lifetime.
 When the chars burst over a chunk boundary, we allocate a larger
 chunk, and then copy the partly formed object from the end of the old
 chunk to the beginning of the new larger chunk.  We then carry on
-accreting characters to the end of the object as we normally would.
+accrediting characters to the end of the object as we normally would.
 
 A special macro is provided to add a single char at a time to a
 growing object.  This allows the use of register variables, which
diff --git a/compat/poll/poll.h b/compat/poll/poll.h
index b7aa59d..36b2b10 100644
--- a/compat/poll/poll.h
+++ b/compat/poll/poll.h
@@ -25,7 +25,7 @@
 /* fake a poll(2) environment */
 #define POLLIN      0x0001      /* any readable data available   */
 #define POLLPRI     0x0002      /* OOB/Urgent readable data      */
-#define POLLOUT     0x0004      /* file descriptor is writeable  */
+#define POLLOUT     0x0004      /* file descriptor is writable  */
 #define POLLERR     0x0008      /* some poll error occurred      */
 #define POLLHUP     0x0010      /* file descriptor was "hung up" */
 #define POLLNVAL    0x0020      /* requested events "invalid"    */
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 7980abd..300d0bb 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -148,7 +148,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 				if (errno || inleft) {
 					/*
 					 * iconv() failed and errno could be E2BIG, EILSEQ, EINVAL, EBADF
-					 * MacOS X avoids illegal byte sequemces.
+					 * MacOS X avoids illegal byte sequences.
 					 * If they occur on a mounted drive (e.g. NFS) it is not worth to
 					 * die() for that, but rather let the user see the original name
 					*/
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 8afd4ff..9c0ac4a 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2788,7 +2788,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
   const int32_t *symb_table;
   const unsigned char *extra;
 
-  /* Local function for parse_bracket_exp used in _LIBC environement.
+  /* Local function for parse_bracket_exp used in _LIBC environment.
      Seek the collating symbol entry correspondings to NAME.
      Return the index of the symbol in the SYMB_TABLE.  */
 
@@ -2892,7 +2892,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
       return UINT_MAX;
     }
 
-  /* Local function for parse_bracket_exp used in _LIBC environement.
+  /* Local function for parse_bracket_exp used in _LIBC environment.
      Build the range expression which starts from START_ELEM, and ends
      at END_ELEM.  The result are written to MBCSET and SBCSET.
      RANGE_ALLOC is the allocated size of mbcset->range_starts, and
@@ -2976,7 +2976,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
       return REG_NOERROR;
     }
 
-  /* Local function for parse_bracket_exp used in _LIBC environement.
+  /* Local function for parse_bracket_exp used in _LIBC environment.
      Build the collating element which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      COLL_SYM_ALLOC is the allocated size of mbcset->coll_sym, is a
@@ -3455,7 +3455,7 @@ build_equiv_class (bitset_t sbcset, const unsigned char *name)
 	/* This isn't a valid character.  */
 	return REG_ECOLLATE;
 
-      /* Build single byte matcing table for this equivalence class.  */
+      /* Build single byte matching table for this equivalence class.  */
       char_buf[1] = (unsigned char) '\0';
       len = weights[idx1 & 0xffffff];
       for (ch = 0; ch < SBC_MAX; ++ch)
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index ef1e410..7c329ad 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -2421,7 +2421,7 @@ find_recover_state (reg_errcode_t *err, re_match_context_t *mctx)
 /* From the node set CUR_NODES, pick up the nodes whose types are
    OP_OPEN_SUBEXP and which have corresponding back references in the regular
    expression. And register them to use them later for evaluating the
-   correspoding back references.  */
+   corresponding back references.  */
 
 static reg_errcode_t
 internal_function
@@ -3348,7 +3348,7 @@ build_trtable (const re_dfa_t *dfa, re_dfastate_t *state)
   dests_node = dests_alloc->dests_node;
   dests_ch = dests_alloc->dests_ch;
 
-  /* Initialize transiton table.  */
+  /* Initialize transition table.  */
   state->word_trtable = state->trtable = NULL;
 
   /* At first, group all nodes belonging to `state' into several
diff --git a/convert.c b/convert.c
index 2a2e46c..11a95fc 100644
--- a/convert.c
+++ b/convert.c
@@ -835,7 +835,7 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 
 /*****************************************************************
  *
- * Streaming converison support
+ * Streaming conversion support
  *
  *****************************************************************/
 
diff --git a/convert.h b/convert.h
index ec5fd69..0c2143c 100644
--- a/convert.h
+++ b/convert.h
@@ -48,7 +48,7 @@ static inline int would_convert_to_git(const char *path, const char *src,
 
 /*****************************************************************
  *
- * Streaming converison support
+ * Streaming conversion support
  *
  *****************************************************************/
 
diff --git a/diff-no-index.c b/diff-no-index.c
index e66fdf3..81a393b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -208,7 +208,7 @@ void diff_no_index(struct rev_info *revs,
 		 * when a path outside the repository is given,
 		 * e.g. "git diff /var/tmp/[12]", or "git diff
 		 * Makefile /var/tmp/Makefile", allow it to be used as
-		 * a colourful "diff" replacement.
+		 * a colorful "diff" replacement.
 		 */
 		if ((argc != i + 2) ||
 		    (path_inside_repo(prefix, argv[i]) &&
diff --git a/diff.c b/diff.c
index e73cccf..ab247f7 100644
--- a/diff.c
+++ b/diff.c
@@ -1396,7 +1396,7 @@ static int scale_linear(int it, int width, int max_change)
 	/*
 	 * make sure that at least one '-' or '+' is printed if
 	 * there is any change to this path. The easiest way is to
-	 * scale linearly as if the alloted width is one column shorter
+	 * scale linearly as if the allocated width is one column shorter
 	 * than it is, and then add 1 to the result.
 	 */
 	return 1 + (it * (width - 1) / max_change);
@@ -4460,7 +4460,7 @@ void diff_flush(struct diff_options *options)
 	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
 		/*
 		 * run diff_flush_patch for the exit status. setting
-		 * options->file to /dev/null should be safe, becaue we
+		 * options->file to /dev/null should be safe, because we
 		 * aren't supposed to produce any output anyway.
 		 */
 		if (options->close_file)
diff --git a/kwset.c b/kwset.c
index 5800999..a0f49b3 100644
--- a/kwset.c
+++ b/kwset.c
@@ -65,7 +65,7 @@ struct trie
   struct trie *fail;		/* Aho-Corasick failure function. */
   int depth;			/* Depth of this node from the root. */
   int shift;			/* Shift function for search failures. */
-  int maxshift;			/* Max shift of self and descendents. */
+  int maxshift;			/* Max shift of self and descendants. */
 };
 
 /* Structure returned opaquely to the caller, containing everything. */
@@ -308,7 +308,7 @@ treefails (register struct tree const *tree, struct trie const *fail,
   treefails(tree->rlink, fail, recourse);
 
   /* Find, in the chain of fails going back to the root, the first
-     node that has a descendent on the current label. */
+     node that has a descendant on the current label. */
   while (fail)
     {
       link = fail->links;
@@ -426,13 +426,13 @@ kwsprep (kwset_t kws)
 	 computing the delta table, failure function, and shift function. */
       for (curr = last = kwset->trie; curr; curr = curr->next)
 	{
-	  /* Enqueue the immediate descendents in the level order queue. */
+	  /* Enqueue the immediate descendants in the level order queue. */
 	  enqueue(curr->links, &last);
 
 	  curr->shift = kwset->mind;
 	  curr->maxshift = kwset->mind;
 
-	  /* Update the delta table for the descendents of this node. */
+	  /* Update the delta table for the descendants of this node. */
 	  treedelta(curr->links, curr->depth, delta);
 
 	  /* Compute the failure function for the descendants of this node. */
@@ -450,7 +450,7 @@ kwsprep (kwset_t kws)
 		  fail->shift = curr->depth - fail->depth;
 
 	      /* If the current node is accepting then the shift at the
-		 fail and its descendents should be no larger than the
+		 fail and its descendants should be no larger than the
 		 difference of their depths. */
 	      if (curr->accepting && fail->maxshift > curr->depth - fail->depth)
 		fail->maxshift = curr->depth - fail->depth;
diff --git a/notes.h b/notes.h
index 3324c48..c78d5a8 100644
--- a/notes.h
+++ b/notes.h
@@ -64,9 +64,9 @@ extern struct notes_tree {
 const char *default_notes_ref(void);
 
 /*
- * Flags controlling behaviour of notes tree initialization
+ * Flags controlling behavior of notes tree initialization
  *
- * Default behaviour is to initialize the notes tree from the tree object
+ * Default behavior is to initialize the notes tree from the tree object
  * specified by the given (or default) notes ref.
  */
 #define NOTES_INIT_EMPTY 1
@@ -152,9 +152,9 @@ int copy_note(struct notes_tree *t,
 	      int force, combine_notes_fn combine_notes);
 
 /*
- * Flags controlling behaviour of for_each_note()
+ * Flags controlling behavior of for_each_note()
  *
- * Default behaviour of for_each_note() is to traverse every single note object
+ * Default behavior of for_each_note() is to traverse every single note object
  * in the given notes tree, unpacking subtree entries along the way.
  * The following flags can be used to alter the default behaviour:
  *
diff --git a/read-cache.c b/read-cache.c
index 0bd0b0c..0ccce3f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -489,7 +489,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 }
 
 /*
- * Remove all cache ententries marked for removal, that is where
+ * Remove all cache entries marked for removal, that is where
  * CE_REMOVE is set in ce_flags.  This is much more effective than
  * calling remove_index_entry_at() for each entry to be removed.
  */
diff --git a/refs.h b/refs.h
index 9e5db3a..f1f95cf 100644
--- a/refs.h
+++ b/refs.h
@@ -105,7 +105,7 @@ extern int commit_packed_refs(void);
 extern void rollback_packed_refs(void);
 
 /*
- * Flags for controlling behaviour of pack_refs()
+ * Flags for controlling behavior of pack_refs()
  * PACK_REFS_PRUNE: Prune loose refs after packing
  * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
  */
diff --git a/revision.c b/revision.c
index 1fd9672..5ba4216 100644
--- a/revision.c
+++ b/revision.c
@@ -1944,7 +1944,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	 * NOTE!
 	 *
 	 * Commands like "git shortlog" will not accept the options below
-	 * unless parse_revision_opt queues them (as opposed to erroring
+	 * unless parse_revision_opt queues them (as opposed to erring
 	 * out).
 	 *
 	 * When implementing your new pseudo-option, remember to
diff --git a/sha1_name.c b/sha1_name.c
index 61c4212..bcc1e94 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -52,7 +52,7 @@ static void update_candidates(struct disambiguate_state *ds, const unsigned char
 	}
 
 	if (!ds->candidate_ok) {
-		/* discard the candidate; we know it does not satisify fn */
+		/* discard the candidate; we know it does not satisfy fn */
 		hashcpy(ds->candidate, current);
 		ds->candidate_checked = 0;
 		return;
diff --git a/transport-helper.c b/transport-helper.c
index db9bd18..c32ae50 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1131,7 +1131,7 @@ static void *udt_copy_task_routine(void *udt)
 #ifndef NO_PTHREADS
 
 /*
- * Join thread, with apporiate errors on failure. Name is name for the
+ * Join thread, with appropriate errors on failure. Name is name for the
  * thread (for error messages). Returns 0 on success, 1 on failure.
  */
 static int tloop_join(pthread_t thread, const char *name)
@@ -1197,7 +1197,7 @@ static void udt_kill_transfer(struct unidirectional_transfer *t)
 }
 
 /*
- * Join process, with apporiate errors on failure. Name is name for the
+ * Join process, with appropriate errors on failure. Name is name for the
  * process (for error messages). Returns 0 on success, 1 on failure.
  */
 static int tloop_join(pid_t pid, const char *name)
diff --git a/write_or_die.c b/write_or_die.c
index b50f99a..b97af10 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -13,7 +13,7 @@ static void check_pipe(int err)
 /*
  * Some cases use stdio, but want to flush after the write
  * to get error handling (and to get better interactive
- * behaviour - not buffering excessively).
+ * behavior - not buffering excessively).
  *
  * Of course, if the flush happened within the write itself,
  * we've already lost the error code, and cannot report it any
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 63a22c6..8d3dce0 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -379,7 +379,7 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 /*
  * Try to reduce the problem complexity, discard records that have no
  * matches on the other file. Also, lines that have multiple matches
- * might be potentially discarded if they happear in a run of discardable.
+ * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, nm, nreff, mlim;
-- 
1.7.10.4
