Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E43441F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfICSFD (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:05:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52916 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfICSFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:05:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so477576wmi.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h+X9Ygv4hIlJlqdI44YVAXuekhRky5SLDouu/y0e6J8=;
        b=pYQpFatNcN1xAA6a3Rp4ZaeXckXWTXgkGMMIX6tQcHw6qyH8JB7cNQQMo8j94g/zoc
         8mixkMDV6FLh24IDqshe2qg+8YNApYzMRH9fW0Qy8s87NLzjNxQnptF649BRh0Sh6Gcx
         CSDXsSbRo3V4uox7U7/X3uzhCL2FuTPg6ngBeMiKxci6KMO/e+ypQkcJ3nKI6npCjQAI
         g/2DspNRS0x7Nw0S5GUo/WDJG/T1gzJBz3h6uZiroTKnzHOm7UGlLY+641sttEdnB+4N
         AgO15GnTmqxPtDcfBM5/wMe4C9wf3ZxHZT6s6Z97H994uwRi8lsc6e2O1LUbiXNGhlfk
         UFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h+X9Ygv4hIlJlqdI44YVAXuekhRky5SLDouu/y0e6J8=;
        b=PGdSOvrJpWyrQyEWIFrjYEtqNK3Bie8dqqbtZ5BG5QUmr7pOLiTfBypFt+WGkdHAa+
         Y5jLqo2+9zjkfRnWpNx/YCdQ0vTiAJByj5cP8HcOm9Y9Rabn6XpvN41suzs7x67J1OGO
         SCUiD/XK0oXBKOO5HsS0gFrscVx5gTg3/2YLC3xOsDAdCvydMGEw70q4PhXERcYk9mPw
         phbPe9Hlzq52SZd4tZ7QGmQzihxQQcmEKb+Uqa7XPfhi4ejpZ4sfIr1MR2ALGQ83pTRF
         v2R78GPoM/N9giVXQqz0eyHPHpSQbwue84/fpBlYBxic8iuCpFMewPpM0D8Spwb+eNTm
         q7Ig==
X-Gm-Message-State: APjAAAWoLwsUQfXhE5fRKTlZeN1zTzeIkAT9s3LWiTngCb83h78g1PZc
        9+mgUT7745HEMIW5qJe6Nlwo4HXq
X-Google-Smtp-Source: APXvYqw5u7X4M2gALXcXeAcbappjvJ0z58n1HgHo0Ts+iDen5VPrPLeX1CDOqRzjeXEsM4fw4k6gEQ==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr682485wme.41.1567533898235;
        Tue, 03 Sep 2019 11:04:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18sm24830304wrt.18.2019.09.03.11.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:04:57 -0700 (PDT)
Date:   Tue, 03 Sep 2019 11:04:57 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 18:04:52 GMT
Message-Id: <53ca8ec87791773edf056435dac9644f3935f421.1567533893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.329.git.gitgitgadget@gmail.com>
References: <pull.329.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/5] treewide: rename 'exclude' methods to 'pattern'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, pclouds@gmail.com, peff@peff.net,
        jon@jonsimons.org, matvore@comcast.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The first consumer of pattern-matching filenames was the
.gitignore feature. In that context, storing a list of patterns
as a 'struct exclude_list'  makes sense. However, the
sparse-checkout feature then adopted these structures and methods,
but with the opposite meaning: these patterns match the files
that should be included!

It would be clearer to rename this entire library as a "pattern
matching" library, and the callers apply exclusion/inclusion
logic accordingly based on their needs.

This commit renames several methods defined in dir.h to make
more sense with the renamed 'struct exclude_list' to 'struct
pattern_list' and 'struct exclude' to 'struct path_pattern':

 * last_exclude_matching() -> last_matching_pattern()
 * parse_exclude() -> parse_path_pattern()

In addition, the word 'exclude' was replaced with 'pattern'
in the methods below:

 * add_exclude_list()
 * add_excludes_from_file_to_list()
 * add_excludes_from_file()
 * add_excludes_from_blob_to_list()
 * add_exclude()
 * clear_exclude_list()

A few methods with the word "exclude" remain. These will
be handled seperately. In particular, the method
"is_excluded()" is concretely about the .gitignore file
relative to a specific directory. This is the important
boundary between library and consumer: is_excluded() cares
about .gitignore, but is_excluded() calls
last_matching_pattern() to make that decision.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/RelNotes/2.7.1.txt              |  2 +-
 Documentation/RelNotes/2.8.0.txt              |  2 +-
 .../technical/api-directory-listing.txt       |  6 +-
 attr.c                                        |  2 +-
 builtin/check-ignore.c                        |  2 +-
 builtin/clean.c                               |  8 +-
 builtin/ls-files.c                            |  6 +-
 dir.c                                         | 78 +++++++++----------
 dir.h                                         | 22 +++---
 list-objects-filter.c                         |  2 +-
 unpack-trees.c                                |  4 +-
 11 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/Documentation/RelNotes/2.7.1.txt b/Documentation/RelNotes/2.7.1.txt
index 6553d69e33..6323feaf64 100644
--- a/Documentation/RelNotes/2.7.1.txt
+++ b/Documentation/RelNotes/2.7.1.txt
@@ -10,7 +10,7 @@ Fixes since v2.7
    setting GIT_WORK_TREE environment themselves.
 
  * The "exclude_list" structure has the usual "alloc, nr" pair of
-   fields to be used by ALLOC_GROW(), but clear_exclude_list() forgot
+   fields to be used by ALLOC_GROW(), but clear_pattern_list() forgot
    to reset 'alloc' to 0 when it cleared 'nr' to discard the managed
    array.
 
diff --git a/Documentation/RelNotes/2.8.0.txt b/Documentation/RelNotes/2.8.0.txt
index 25079710fa..5fbe1b86ee 100644
--- a/Documentation/RelNotes/2.8.0.txt
+++ b/Documentation/RelNotes/2.8.0.txt
@@ -270,7 +270,7 @@ notes for details).
    setting GIT_WORK_TREE environment themselves.
 
  * The "exclude_list" structure has the usual "alloc, nr" pair of
-   fields to be used by ALLOC_GROW(), but clear_exclude_list() forgot
+   fields to be used by ALLOC_GROW(), but clear_pattern_list() forgot
    to reset 'alloc' to 0 when it cleared 'nr' to discard the managed
    array.
 
diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 5abb8e8b1f..76b6e4f71b 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -111,11 +111,11 @@ marked. If you to exclude files, make sure you have loaded index first.
 * Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
   sizeof(dir))`.
 
-* To add single exclude pattern, call `add_exclude_list()` and then
-  `add_exclude()`.
+* To add single exclude pattern, call `add_pattern_list()` and then
+  `add_pattern()`.
 
 * To add patterns from a file (e.g. `.git/info/exclude`), call
-  `add_excludes_from_file()` , and/or set `dir.exclude_per_dir`.  A
+  `add_patterns_from_file()` , and/or set `dir.exclude_per_dir`.  A
   short-hand function `setup_standard_excludes()` can be used to set
   up the standard set of exclude settings.
 
diff --git a/attr.c b/attr.c
index d90239869a..d02d081e28 100644
--- a/attr.c
+++ b/attr.c
@@ -400,7 +400,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		char *p = (char *)&(res->state[num_attr]);
 		memcpy(p, name, namelen);
 		res->u.pat.pattern = p;
-		parse_exclude_pattern(&res->u.pat.pattern,
+		parse_path_pattern(&res->u.pat.pattern,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
 				      &res->u.pat.nowildcardlen);
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 28b8f14999..5a4f92395f 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -106,7 +106,7 @@ static int check_ignore(struct dir_struct *dir,
 		pattern = NULL;
 		if (!seen[i]) {
 			int dtype = DT_UNKNOWN;
-			pattern = last_exclude_matching(dir, &the_index,
+			pattern = last_matching_pattern(dir, &the_index,
 							full_path, &dtype);
 		}
 		if (!quiet && (pattern || show_non_matching))
diff --git a/builtin/clean.c b/builtin/clean.c
index d8c847d9fd..4920c92593 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -670,7 +670,7 @@ static int filter_by_patterns_cmd(void)
 			break;
 
 		memset(&dir, 0, sizeof(dir));
-		pl = add_exclude_list(&dir, EXC_CMDL, "manual exclude");
+		pl = add_pattern_list(&dir, EXC_CMDL, "manual exclude");
 		ignore_list = strbuf_split_max(&confirm, ' ', 0);
 
 		for (i = 0; ignore_list[i]; i++) {
@@ -678,7 +678,7 @@ static int filter_by_patterns_cmd(void)
 			if (!ignore_list[i]->len)
 				continue;
 
-			add_exclude(ignore_list[i]->buf, "", 0, pl, -(i+1));
+			add_pattern(ignore_list[i]->buf, "", 0, pl, -(i+1));
 		}
 
 		changed = 0;
@@ -957,9 +957,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	pl = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
+	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++)
-		add_exclude(exclude_list.items[i].string, "", 0, pl, -(i+1));
+		add_pattern(exclude_list.items[i].string, "", 0, pl, -(i+1));
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index df8918a128..5acc396949 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -492,7 +492,7 @@ static int option_parse_exclude_from(const struct option *opt,
 	BUG_ON_OPT_NEG(unset);
 
 	exc_given = 1;
-	add_excludes_from_file(dir, arg);
+	add_patterns_from_file(dir, arg);
 
 	return 0;
 }
@@ -594,9 +594,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
-	pl = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
+	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++) {
-		add_exclude(exclude_list.items[i].string, "", 0, pl, --exclude_args);
+		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
diff --git a/dir.c b/dir.c
index 640f10973e..b057bd3d95 100644
--- a/dir.c
+++ b/dir.c
@@ -561,7 +561,7 @@ int no_wildcard(const char *string)
 	return string[simple_length(string)] == '\0';
 }
 
-void parse_exclude_pattern(const char **pattern,
+void parse_path_pattern(const char **pattern,
 			   int *patternlen,
 			   unsigned *flags,
 			   int *nowildcardlen)
@@ -599,7 +599,7 @@ void parse_exclude_pattern(const char **pattern,
 	*patternlen = len;
 }
 
-void add_exclude(const char *string, const char *base,
+void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos)
 {
 	struct path_pattern *pattern;
@@ -607,7 +607,7 @@ void add_exclude(const char *string, const char *base,
 	unsigned flags;
 	int nowildcardlen;
 
-	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
+	parse_path_pattern(&string, &patternlen, &flags, &nowildcardlen);
 	if (flags & PATTERN_FLAG_MUSTBEDIR) {
 		FLEXPTR_ALLOC_MEM(pattern, pattern, string, patternlen);
 	} else {
@@ -646,7 +646,7 @@ static int read_skip_worktree_file_from_index(const struct index_state *istate,
  * Frees memory within pl which was allocated for exclude patterns and
  * the file buffer.  Does not free pl itself.
  */
-void clear_exclude_list(struct pattern_list *pl)
+void clear_pattern_list(struct pattern_list *pl)
 {
 	int i;
 
@@ -762,7 +762,7 @@ static void invalidate_directory(struct untracked_cache *uc,
 		dir->dirs[i]->recurse = 0;
 }
 
-static int add_excludes_from_buffer(char *buf, size_t size,
+static int add_patterns_from_buffer(char *buf, size_t size,
 				    const char *base, int baselen,
 				    struct pattern_list *pl);
 
@@ -772,10 +772,10 @@ static int add_excludes_from_buffer(char *buf, size_t size,
  * exclude rules in "pl".
  *
  * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
- * stat data from disk (only valid if add_excludes returns zero). If
+ * stat data from disk (only valid if add_patterns returns zero). If
  * ss_valid is non-zero, "ss" must contain good value as input.
  */
-static int add_excludes(const char *fname, const char *base, int baselen,
+static int add_patterns(const char *fname, const char *base, int baselen,
 			struct pattern_list *pl, struct index_state *istate,
 			struct oid_stat *oid_stat)
 {
@@ -837,11 +837,11 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		}
 	}
 
-	add_excludes_from_buffer(buf, size, base, baselen, pl);
+	add_patterns_from_buffer(buf, size, base, baselen, pl);
 	return 0;
 }
 
-static int add_excludes_from_buffer(char *buf, size_t size,
+static int add_patterns_from_buffer(char *buf, size_t size,
 				    const char *base, int baselen,
 				    struct pattern_list *pl)
 {
@@ -860,7 +860,7 @@ static int add_excludes_from_buffer(char *buf, size_t size,
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
 				trim_trailing_spaces(entry);
-				add_exclude(entry, base, baselen, pl, lineno);
+				add_pattern(entry, base, baselen, pl, lineno);
 			}
 			lineno++;
 			entry = buf + i + 1;
@@ -869,14 +869,14 @@ static int add_excludes_from_buffer(char *buf, size_t size,
 	return 0;
 }
 
-int add_excludes_from_file_to_list(const char *fname, const char *base,
+int add_patterns_from_file_to_list(const char *fname, const char *base,
 				   int baselen, struct pattern_list *pl,
 				   struct index_state *istate)
 {
-	return add_excludes(fname, base, baselen, pl, istate, NULL);
+	return add_patterns(fname, base, baselen, pl, istate, NULL);
 }
 
-int add_excludes_from_blob_to_list(
+int add_patterns_from_blob_to_list(
 	struct object_id *oid,
 	const char *base, int baselen,
 	struct pattern_list *pl)
@@ -889,11 +889,11 @@ int add_excludes_from_blob_to_list(
 	if (r != 1)
 		return r;
 
-	add_excludes_from_buffer(buf, size, base, baselen, pl);
+	add_patterns_from_buffer(buf, size, base, baselen, pl);
 	return 0;
 }
 
-struct pattern_list *add_exclude_list(struct dir_struct *dir,
+struct pattern_list *add_pattern_list(struct dir_struct *dir,
 				      int group_type, const char *src)
 {
 	struct pattern_list *pl;
@@ -910,7 +910,7 @@ struct pattern_list *add_exclude_list(struct dir_struct *dir,
 /*
  * Used to set up core.excludesfile and .git/info/exclude lists.
  */
-static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
+static void add_patterns_from_file_1(struct dir_struct *dir, const char *fname,
 				     struct oid_stat *oid_stat)
 {
 	struct pattern_list *pl;
@@ -921,15 +921,15 @@ static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
 	 */
 	if (!dir->untracked)
 		dir->unmanaged_exclude_files++;
-	pl = add_exclude_list(dir, EXC_FILE, fname);
-	if (add_excludes(fname, "", 0, pl, NULL, oid_stat) < 0)
+	pl = add_pattern_list(dir, EXC_FILE, fname);
+	if (add_patterns(fname, "", 0, pl, NULL, oid_stat) < 0)
 		die(_("cannot use %s as an exclude file"), fname);
 }
 
-void add_excludes_from_file(struct dir_struct *dir, const char *fname)
+void add_patterns_from_file(struct dir_struct *dir, const char *fname)
 {
 	dir->unmanaged_exclude_files++; /* see validate_untracked_cache() */
-	add_excludes_from_file_1(dir, fname, NULL);
+	add_patterns_from_file_1(dir, fname, NULL);
 }
 
 int match_basename(const char *basename, int basenamelen,
@@ -1021,7 +1021,7 @@ int match_pathname(const char *pathname, int pathlen,
  * any, determines the fate.  Returns the exclude_list element which
  * matched, or NULL for undecided.
  */
-static struct path_pattern *last_exclude_matching_from_list(const char *pathname,
+static struct path_pattern *last_matching_pattern_from_list(const char *pathname,
 						       int pathlen,
 						       const char *basename,
 						       int *dtype,
@@ -1080,14 +1080,14 @@ int is_excluded_from_list(const char *pathname,
 			  struct pattern_list *pl, struct index_state *istate)
 {
 	struct path_pattern *pattern;
-	pattern = last_exclude_matching_from_list(pathname, pathlen, basename,
+	pattern = last_matching_pattern_from_list(pathname, pathlen, basename,
 						  dtype, pl, istate);
 	if (pattern)
 		return pattern->flags & PATTERN_FLAG_NEGATIVE ? 0 : 1;
 	return -1; /* undecided */
 }
 
-static struct path_pattern *last_exclude_matching_from_lists(
+static struct path_pattern *last_matching_pattern_from_lists(
 		struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int pathlen,
 		const char *basename, int *dtype_p)
@@ -1098,7 +1098,7 @@ static struct path_pattern *last_exclude_matching_from_lists(
 	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
 		group = &dir->exclude_list_group[i];
 		for (j = group->nr - 1; j >= 0; j--) {
-			pattern = last_exclude_matching_from_list(
+			pattern = last_matching_pattern_from_list(
 				pathname, pathlen, basename, dtype_p,
 				&group->pl[j], istate);
 			if (pattern)
@@ -1137,7 +1137,7 @@ static void prep_exclude(struct dir_struct *dir,
 		dir->exclude_stack = stk->prev;
 		dir->pattern = NULL;
 		free((char *)pl->src); /* see strbuf_detach() below */
-		clear_exclude_list(pl);
+		clear_pattern_list(pl);
 		free(stk);
 		group->nr--;
 	}
@@ -1184,7 +1184,7 @@ static void prep_exclude(struct dir_struct *dir,
 		stk->baselen = cp - base;
 		stk->exclude_ix = group->nr;
 		stk->ucd = untracked;
-		pl = add_exclude_list(dir, EXC_DIRS, NULL);
+		pl = add_pattern_list(dir, EXC_DIRS, NULL);
 		strbuf_add(&dir->basebuf, base + current, stk->baselen - current);
 		assert(stk->baselen == dir->basebuf.len);
 
@@ -1192,7 +1192,7 @@ static void prep_exclude(struct dir_struct *dir,
 		if (stk->baselen) {
 			int dt = DT_DIR;
 			dir->basebuf.buf[stk->baselen - 1] = 0;
-			dir->pattern = last_exclude_matching_from_lists(dir,
+			dir->pattern = last_matching_pattern_from_lists(dir,
 									istate,
 				dir->basebuf.buf, stk->baselen - 1,
 				dir->basebuf.buf + current, &dt);
@@ -1228,28 +1228,28 @@ static void prep_exclude(struct dir_struct *dir,
 			 * need fname to remain unchanged to ensure the src
 			 * member of each struct path_pattern correctly
 			 * back-references its source file.  Other invocations
-			 * of add_exclude_list provide stable strings, so we
+			 * of add_pattern_list provide stable strings, so we
 			 * strbuf_detach() and free() here in the caller.
 			 */
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addbuf(&sb, &dir->basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			pl->src = strbuf_detach(&sb, NULL);
-			add_excludes(pl->src, pl->src, stk->baselen, pl, istate,
+			add_patterns(pl->src, pl->src, stk->baselen, pl, istate,
 				     untracked ? &oid_stat : NULL);
 		}
 		/*
 		 * NEEDSWORK: when untracked cache is enabled, prep_exclude()
 		 * will first be called in valid_cached_dir() then maybe many
-		 * times more in last_exclude_matching(). When the cache is
-		 * used, last_exclude_matching() will not be called and
+		 * times more in last_matching_pattern(). When the cache is
+		 * used, last_matching_pattern() will not be called and
 		 * reading .gitignore content will be a waste.
 		 *
 		 * So when it's called by valid_cached_dir() and we can get
 		 * .gitignore SHA-1 from the index (i.e. .gitignore is not
 		 * modified on work tree), we could delay reading the
 		 * .gitignore content until we absolutely need it in
-		 * last_exclude_matching(). Be careful about ignore rule
+		 * last_matching_pattern(). Be careful about ignore rule
 		 * order, though, if you do that.
 		 */
 		if (untracked &&
@@ -1269,7 +1269,7 @@ static void prep_exclude(struct dir_struct *dir,
  * Returns the exclude_list element which matched, or NULL for
  * undecided.
  */
-struct path_pattern *last_exclude_matching(struct dir_struct *dir,
+struct path_pattern *last_matching_pattern(struct dir_struct *dir,
 				      struct index_state *istate,
 				      const char *pathname,
 				      int *dtype_p)
@@ -1283,7 +1283,7 @@ struct path_pattern *last_exclude_matching(struct dir_struct *dir,
 	if (dir->pattern)
 		return dir->pattern;
 
-	return last_exclude_matching_from_lists(dir, istate, pathname, pathlen,
+	return last_matching_pattern_from_lists(dir, istate, pathname, pathlen,
 			basename, dtype_p);
 }
 
@@ -1296,7 +1296,7 @@ int is_excluded(struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int *dtype_p)
 {
 	struct path_pattern *pattern =
-		last_exclude_matching(dir, istate, pathname, dtype_p);
+		last_matching_pattern(dir, istate, pathname, dtype_p);
 	if (pattern)
 		return pattern->flags & PATTERN_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
@@ -1811,7 +1811,7 @@ static int valid_cached_dir(struct dir_struct *dir,
 
 	/*
 	 * prep_exclude will be called eventually on this directory,
-	 * but it's called much later in last_exclude_matching(). We
+	 * but it's called much later in last_matching_pattern(). We
 	 * need it now to determine the validity of the cache for this
 	 * path. The next calls will be nearly no-op, the way
 	 * prep_exclude() is designed.
@@ -2491,14 +2491,14 @@ void setup_standard_excludes(struct dir_struct *dir)
 	if (!excludes_file)
 		excludes_file = xdg_config_home("ignore");
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
-		add_excludes_from_file_1(dir, excludes_file,
+		add_patterns_from_file_1(dir, excludes_file,
 					 dir->untracked ? &dir->ss_excludes_file : NULL);
 
 	/* per repository user preference */
 	if (startup_info->have_repository) {
 		const char *path = git_path_info_exclude();
 		if (!access_or_warn(path, R_OK, 0))
-			add_excludes_from_file_1(dir, path,
+			add_patterns_from_file_1(dir, path,
 						 dir->untracked ? &dir->ss_info_exclude : NULL);
 	}
 }
@@ -2539,7 +2539,7 @@ void clear_directory(struct dir_struct *dir)
 			pl = &group->pl[j];
 			if (i == EXC_DIRS)
 				free((char *)pl->src);
-			clear_exclude_list(pl);
+			clear_pattern_list(pl);
 		}
 		free(group->pl);
 	}
diff --git a/dir.h b/dir.h
index 87eb10662f..7babf31d88 100644
--- a/dir.h
+++ b/dir.h
@@ -18,7 +18,7 @@ struct dir_entry {
 
 struct path_pattern {
 	/*
-	 * This allows callers of last_exclude_matching() etc.
+	 * This allows callers of last_matching_pattern() etc.
 	 * to determine the origin of the matching pattern.
 	 */
 	struct pattern_list *pl;
@@ -248,26 +248,26 @@ int match_pathname(const char *, int,
 		   const char *, int,
 		   const char *, int, int, unsigned);
 
-struct path_pattern *last_exclude_matching(struct dir_struct *dir,
-				      struct index_state *istate,
-				      const char *name, int *dtype);
+struct path_pattern *last_matching_pattern(struct dir_struct *dir,
+					   struct index_state *istate,
+					   const char *name, int *dtype);
 
 int is_excluded(struct dir_struct *dir,
 		struct index_state *istate,
 		const char *name, int *dtype);
 
-struct pattern_list *add_exclude_list(struct dir_struct *dir,
+struct pattern_list *add_pattern_list(struct dir_struct *dir,
 				      int group_type, const char *src);
-int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
+int add_patterns_from_file_to_list(const char *fname, const char *base, int baselen,
 				   struct pattern_list *pl, struct  index_state *istate);
-void add_excludes_from_file(struct dir_struct *, const char *fname);
-int add_excludes_from_blob_to_list(struct object_id *oid,
+void add_patterns_from_file(struct dir_struct *, const char *fname);
+int add_patterns_from_blob_to_list(struct object_id *oid,
 				   const char *base, int baselen,
 				   struct pattern_list *pl);
-void parse_exclude_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
-void add_exclude(const char *string, const char *base,
+void parse_path_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
+void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos);
-void clear_exclude_list(struct pattern_list *pl);
+void clear_pattern_list(struct pattern_list *pl);
 void clear_directory(struct dir_struct *dir);
 
 int repo_file_exists(struct repository *repo, const char *path);
diff --git a/list-objects-filter.c b/list-objects-filter.c
index a1fedf8bd8..ccd58e61c3 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -482,7 +482,7 @@ static void filter_sparse_oid__init(
 	struct filter *filter)
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
-	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
+	if (add_patterns_from_blob_to_list(filter_options->sparse_oid_value,
 					   NULL, 0, &d->pl) < 0)
 		die("could not load filter specification");
 
diff --git a/unpack-trees.c b/unpack-trees.c
index c4dc21affb..902a799aeb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1464,7 +1464,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		char *sparse = git_pathdup("info/sparse-checkout");
-		if (add_excludes_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
+		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
 			o->skip_sparse_checkout = 1;
 		else
 			o->pl = &pl;
@@ -1631,7 +1631,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 done:
 	trace_performance_leave("unpack_trees");
-	clear_exclude_list(&pl);
+	clear_pattern_list(&pl);
 	return ret;
 
 return_failed:
-- 
gitgitgadget

