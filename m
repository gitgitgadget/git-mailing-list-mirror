From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: [PATCH 1/2] Fix generic typos in comments
Date: Sat, 20 Jul 2013 21:07:07 +0200
Message-ID: <20130720190707.GA30044@domone>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 21:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0cac-00032W-Tz
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 21:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab3GTTNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 15:13:05 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:45876 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab3GTTNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 15:13:01 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jul 2013 15:13:00 EDT
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 5243D43003
	for <git@vger.kernel.org>; Sat, 20 Jul 2013 21:07:08 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id E578D5FB94; Sat, 20 Jul 2013 21:07:07 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230901>

Hi, I wrote a tool that effectively fixes typos in comments and only in
comments.
It can be downloaded here:

https://github.com/neleai/stylepp

For typos you need identify them, write replacement dictionary and run
STYLEPP/script/stylepp_skeleton stylepp_fix_comment

Here generic dictionary is used that was taken from wikipedia.
https://github.com/neleai/stylepp/blob/master/maintained/dictionary_wiki

---
 bisect.c                      |    2 +-
 builtin/apply.c               |    6 +++---
 builtin/clean.c               |    2 +-
 builtin/update-index.c        |    4 ++--
 compat/regex/regcomp.c        |   10 +++++-----
 compat/regex/regex_internal.c |    2 +-
 compat/regex/regexec.c        |    4 ++--
 connect.c                     |    2 +-
 daemon.c                      |    2 +-
 diff.c                        |    2 +-
 dir.c                         |    2 +-
 entry.c                       |    2 +-
 fast-import.c                 |    2 +-
 parse-options.c               |    2 +-
 read-cache.c                  |    2 +-
 refs.c                        |    2 +-
 remote.c                      |   14 +++++++-------
 revision.c                    |    2 +-
 sha1-lookup.c                 |    2 +-
 sha1_file.c                   |    2 +-
 sha1_name.c                   |    2 +-
 transport.c                   |    2 +-
 22 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/bisect.c b/bisect.c
index 71c1958..9c225bd 100644
--- a/bisect.c
+++ b/bisect.c
@@ -845,7 +845,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
 		goto done;
 
-	/* Bisecting with no good rev is ok. */
+	/* Bisecting with no good rev is OK. */
 	if (good_revs.nr == 0)
 		goto done;
 
diff --git a/builtin/apply.c b/builtin/apply.c
index ff01ebf..4f4dd56 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3659,12 +3659,12 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 
 		if (S_ISGITLINK(patch->old_mode)) {
 			if (!preimage_sha1_in_gitlink_patch(patch, sha1))
-				; /* ok, the textual part looks sane */
+				; /* OK, the textual part looks sane */
 			else
 				die("sha1 information is lacking or useless for submoule %s",
 				    name);
 		} else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
-			; /* ok */
+			; /* OK */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
 			if (get_current_sha1(patch->old_name, sha1))
@@ -3755,7 +3755,7 @@ static void show_rename_copy(struct patch *p)
 		old = slash_old + 1;
 		new = slash_new + 1;
 	}
-	/* p->old_name thru old is the common prefix, and old and new
+	/* p->old_name through old is the common prefix, and old and new
 	 * through the end of names are renames
 	 */
 	if (old != p->old_name)
diff --git a/builtin/clean.c b/builtin/clean.c
index 04e396b..badbad3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -89,7 +89,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
 		if (lstat(path->buf, &st))
-			; /* fall thru */
+			; /* fall through */
 		else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5c7762e..b558e09 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -71,10 +71,10 @@ static int remove_one_path(const char *path)
 
 /*
  * Handle a path that couldn't be lstat'ed. It's either:
- *  - missing file (ENOENT or ENOTDIR). That's ok if we're
+ *  - missing file (ENOENT or ENOTDIR). That's OK if we're
  *    supposed to be removing it and the removal actually
  *    succeeds.
- *  - permission error. That's never ok.
+ *  - permission error. That's never OK.
  */
 static int process_lstat_error(const char *path, int err)
 {
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index d0025bd..8afd4ff 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2617,7 +2617,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
      Build the range expression which starts from START_ELEM, and ends
      at END_ELEM.  The result are written to MBCSET and SBCSET.
      RANGE_ALLOC is the allocated size of mbcset->range_starts, and
-     mbcset->range_ends, is a pointer argument sinse we may
+     mbcset->range_ends, is a pointer argument since we may
      update it.  */
 
 static reg_errcode_t
@@ -2896,7 +2896,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
      Build the range expression which starts from START_ELEM, and ends
      at END_ELEM.  The result are written to MBCSET and SBCSET.
      RANGE_ALLOC is the allocated size of mbcset->range_starts, and
-     mbcset->range_ends, is a pointer argument sinse we may
+     mbcset->range_ends, is a pointer argument since we may
      update it.  */
 
   auto inline reg_errcode_t
@@ -2980,7 +2980,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
      Build the collating element which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      COLL_SYM_ALLOC is the allocated size of mbcset->coll_sym, is a
-     pointer argument sinse we may update it.  */
+     pointer argument since we may update it.  */
 
   auto inline reg_errcode_t
   __attribute ((always_inline))
@@ -3419,7 +3419,7 @@ parse_bracket_symbol (bracket_elem_t *elem, re_string_t *regexp,
      Build the equivalence class which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      EQUIV_CLASS_ALLOC is the allocated size of mbcset->equiv_classes,
-     is a pointer argument sinse we may update it.  */
+     is a pointer argument since we may update it.  */
 
 static reg_errcode_t
 #ifdef RE_ENABLE_I18N
@@ -3515,7 +3515,7 @@ build_equiv_class (bitset_t sbcset, const unsigned char *name)
      Build the character class which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      CHAR_CLASS_ALLOC is the allocated size of mbcset->char_classes,
-     is a pointer argument sinse we may update it.  */
+     is a pointer argument since we may update it.  */
 
 static reg_errcode_t
 #ifdef RE_ENABLE_I18N
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index d4121f2..c270210 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -973,7 +973,7 @@ re_node_set_alloc (re_node_set *set, int size)
   /*
    * ADR: valgrind says size can be 0, which then doesn't
    * free the block of size 0.  Harumph. This seems
-   * to work ok, though.
+   * to work OK, though.
    */
   if (size == 0)
     {
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 0cd6e0e..ef1e410 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -455,7 +455,7 @@ re_search_stub (struct re_pattern_buffer *bufp,
 
   rval = 0;
 
-  /* I hope we needn't fill ther regs with -1's when no match was found.  */
+  /* I hope we needn't fill their regs with -1's when no match was found.  */
   if (result != REG_NOERROR)
     rval = -1;
   else if (regs != NULL)
@@ -1071,7 +1071,7 @@ acquire_init_state_context (reg_errcode_t *err, const re_match_context_t *mctx,
    FL_LONGEST_MATCH means we want the POSIX longest matching.
    If P_MATCH_FIRST is not NULL, and the match fails, it is set to the
    next place where we may want to try matching.
-   Note that the matcher assume that the maching starts from the current
+   Note that the matcher assume that the matching starts from the current
    index of the buffer.  */
 
 static int
diff --git a/connect.c b/connect.c
index a0783d4..078a597 100644
--- a/connect.c
+++ b/connect.c
@@ -33,7 +33,7 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
 		return 1;
 
-	/* All type bits clear means that we are ok with anything */
+	/* All type bits clear means that we are OK with anything */
 	return !(flags & ~REF_NORMAL);
 }
 
diff --git a/daemon.c b/daemon.c
index 6aeddcb..d5684db 100644
--- a/daemon.c
+++ b/daemon.c
@@ -339,7 +339,7 @@ static int run_service(char *dir, struct daemon_service *service)
 	 *
 	 * We want a readable HEAD, usable "objects" directory, and
 	 * a "git-daemon-export-ok" flag that says that the other side
-	 * is ok with us doing this.
+	 * is OK with us doing this.
 	 *
 	 * path_ok() uses enter_repo() and does whitelist checking.
 	 * We only need to make sure the repository is exported.
diff --git a/diff.c b/diff.c
index e53ddad..e73cccf 100644
--- a/diff.c
+++ b/diff.c
@@ -2043,7 +2043,7 @@ static int is_conflict_marker(const char *line, int marker_size, unsigned long l
 	for (cnt = 1; cnt < marker_size; cnt++)
 		if (line[cnt] != firstchar)
 			return 0;
-	/* line[1] thru line[marker_size-1] are same as firstchar */
+	/* line[1] through line[marker_size-1] are same as firstchar */
 	if (len < marker_size + 1 || !isspace(line[marker_size]))
 		return 0;
 	return 1;
diff --git a/dir.c b/dir.c
index 0480419..6586b39 100644
--- a/dir.c
+++ b/dir.c
@@ -1502,7 +1502,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
 		if (lstat(path->buf, &st))
-			; /* fall thru */
+			; /* fall through */
 		else if (S_ISDIR(st.st_mode)) {
 			if (!remove_dir_recurse(path, flag, &kept_down))
 				continue; /* happy */
diff --git a/entry.c b/entry.c
index d7c131d..0e33123 100644
--- a/entry.c
+++ b/entry.c
@@ -26,7 +26,7 @@ static void create_directories(const char *path, int path_len,
 		 * stat() function instead of the lstat() function.
 		 */
 		if (has_dirs_only_path(buf, len, state->base_dir_len))
-			continue; /* ok, it is already a directory. */
+			continue; /* OK, it is already a directory. */
 
 		/*
 		 * If this mkdir() would fail, it could be that there
diff --git a/fast-import.c b/fast-import.c
index 23f625f..35a1004 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2281,7 +2281,7 @@ static void file_change_m(struct branch *b)
 	case S_IFLNK:
 	case S_IFDIR:
 	case S_IFGITLINK:
-		/* ok */
+		/* OK */
 		break;
 	default:
 		die("Corrupt mode: %s", command_buf.buf);
diff --git a/parse-options.c b/parse-options.c
index c2cbca2..17b77cf 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -328,7 +328,7 @@ static void parse_options_check(const struct option *opts)
 			    !(opts->flags & PARSE_OPT_NOARG))
 				err |= optbug(opts, "should not accept an argument");
 		default:
-			; /* ok. (usually accepts an argument) */
+			; /* OK. (usually accepts an argument) */
 		}
 	}
 	if (err)
diff --git a/read-cache.c b/read-cache.c
index d5201f9..0bd0b0c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -874,7 +874,7 @@ static int has_dir_name(struct index_state *istate,
 		/*
 		 * Trivial optimization: if we find an entry that
 		 * already matches the sub-directory, then we know
-		 * we're ok, and we can exit.
+		 * we're OK, and we can exit.
 		 */
 		while (pos < istate->cache_nr) {
 			struct cache_entry *p = istate->cache[pos];
diff --git a/refs.c b/refs.c
index 4302206..a961b3e 100644
--- a/refs.c
+++ b/refs.c
@@ -3073,7 +3073,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 				scanp = buf - 1; /* leave loop */
 			} else {
 				/*
-				 * (bp + 1) thru endp is the beginning of the
+				 * (bp + 1) through endp is the beginning of the
 				 * current line we have in sb
 				 */
 				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
diff --git a/remote.c b/remote.c
index efcba93..498ee46 100644
--- a/remote.c
+++ b/remote.c
@@ -566,20 +566,20 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 
 			/* LHS */
 			if (!*rs[i].src)
-				; /* empty is ok; it means "HEAD" */
+				; /* empty is OK; it means "HEAD" */
 			else if (llen == 40 && !get_sha1_hex(rs[i].src, unused))
-				rs[i].exact_sha1 = 1; /* ok */
+				rs[i].exact_sha1 = 1; /* OK */
 			else if (!check_refname_format(rs[i].src, flags))
-				; /* valid looking ref is ok */
+				; /* valid looking ref is OK */
 			else
 				goto invalid;
 			/* RHS */
 			if (!rs[i].dst)
-				; /* missing is ok; it is the same as empty */
+				; /* missing is OK; it is the same as empty */
 			else if (!*rs[i].dst)
-				; /* empty is ok; it means "do not store" */
+				; /* empty is OK; it means "do not store" */
 			else if (!check_refname_format(rs[i].dst, flags))
-				; /* valid looking ref is ok */
+				; /* valid looking ref is OK */
 			else
 				goto invalid;
 		} else {
@@ -591,7 +591,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			 *   there is no existing way to validate this.
 			 */
 			if (!*rs[i].src)
-				; /* empty is ok */
+				; /* empty is OK */
 			else if (is_glob) {
 				if (check_refname_format(rs[i].src, flags))
 					goto invalid;
diff --git a/revision.c b/revision.c
index 2f0142f..1fd9672 100644
--- a/revision.c
+++ b/revision.c
@@ -157,7 +157,7 @@ void mark_parents_uninteresting(struct commit *commit)
 
 		while (commit) {
 			/*
-			 * A missing commit is ok iff its parent is marked
+			 * A missing commit is OK iff its parent is marked
 			 * uninteresting.
 			 *
 			 * We just mark such a thing parsed, so that when
diff --git a/sha1-lookup.c b/sha1-lookup.c
index c4dc55d..580d2b3 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -201,7 +201,7 @@ int sha1_entry_pos(const void *table,
 					break;
 			ofs_0 = ofs;
 			/*
-			 * byte 0 thru (ofs-1) are the same between
+			 * byte 0 through (ofs-1) are the same between
 			 * lo and hi; ofs is the first byte that is
 			 * different.
 			 */
diff --git a/sha1_file.c b/sha1_file.c
index 4c2365f..2012620 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -974,7 +974,7 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 		return NULL;
 	}
 
-	/* ok, it looks sane as far as we can check without
+	/* OK, it looks sane as far as we can check without
 	 * actually mapping the pack file.
 	 */
 	p->pack_size = st.st_size;
diff --git a/sha1_name.c b/sha1_name.c
index 1a75fac..61c4212 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1052,7 +1052,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
  * If the input is not of the accepted format, it returns a negative
  * number to signal an error.
  *
- * If the input was ok but there are not N branch switches in the
+ * If the input was OK but there are not N branch switches in the
  * reflog, it returns 0.
  */
 int interpret_branch_name(const char *name, struct strbuf *buf)
diff --git a/transport.c b/transport.c
index e15db98..52ad18e 100644
--- a/transport.c
+++ b/transport.c
@@ -1298,7 +1298,7 @@ char *transport_anonymize_url(const char *url)
 			switch (*cp) {
 				/* RFC 1738 2.1 */
 			case '+': case '.': case '-':
-				break; /* ok */
+				break; /* OK */
 			default:
 				if (isalnum(*cp))
 					break;
-- 
1.7.10.4
