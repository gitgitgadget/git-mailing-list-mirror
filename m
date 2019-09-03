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
	by dcvr.yhbt.net (Postfix) with ESMTP id A868D1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfICSFB (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:05:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37760 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfICSFA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:05:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id r195so516556wme.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dBKHNhnxbenGPmuMV8y5vu48yaSzY4dPS419WXkvjeg=;
        b=LYUrX+czdU0RgPIBk00+/d+d5h8bw7lWL5tI2MTLBe1/gNymUlHTjrdFD+Hm9jq2Ux
         m9zww+IYwL9rztzyhULT+Dk/iTlw6Mw1ezVYhhJssSfrS2/WebO43bB6y5yOupSZ0YDQ
         P9TAuu49r6OQgYMJYsjBX47gz03lZ4JMJiJsKdveSKJt1B2+4kz4e7evm2OvpC6V7XMV
         Kq7Uhy56tysVn11k3Af8Nf10/JStdGwr+ubZgEA1DxbF56+Uia8IEYeRTLn1FiSnCRx7
         Bh5OZN7H6JPROsSmzXyshsgEAfylpshG+S+rC6B8FyVutPjiek8bVaWRj4lNLX5b2q/v
         rHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dBKHNhnxbenGPmuMV8y5vu48yaSzY4dPS419WXkvjeg=;
        b=p5Ado6Jd/0/0HtX2ZmVmWHuJQNSaqB8CWLtFVibxZB8o6glYelcfdPodSPI0efacez
         viB3mLTAHaorAcihoMFsinoF6x4rIIU6lZl1K2kMbSoDxxa1038EgkWvnNJhn8Jnoq12
         MatWdNYc3gQTvZ9b+t2PuX3DPQGlwT6A2Phf/cxiEtyFSHe4zwdgPjL3LE2pGTSub57e
         C9XHD511sHxNzMIEaz/bge6zRtadojwSkWGLnbsKSZ2OV85GR3uXapdtOi9VwOQxYVOR
         lwNukfpGalvK6bvky05saVIxCC/G9sd4Oovp+0xvlzesiuuDhQa/JydYAZ3cVh2TT52M
         RzZA==
X-Gm-Message-State: APjAAAV60qhywfVaK8rT2h3V4+FidpkcbngtoyBIviiFo+jKRNdGO+Oz
        WXW7kV1ZH0Iw73aGxebYyEXwWbt0
X-Google-Smtp-Source: APXvYqzYOXh+zV0zKzErxgbA62F1wLX0I3JNwJH7kntRGRNAADRhlMa9+jJxGvddU5QI1CjGTPMsBA==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr653541wmj.37.1567533896512;
        Tue, 03 Sep 2019 11:04:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm157604wmj.48.2019.09.03.11.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:04:56 -0700 (PDT)
Date:   Tue, 03 Sep 2019 11:04:56 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 18:04:50 GMT
Message-Id: <908c92205488f986de4aa0bfb432ce87fde6cfa9.1567533893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.329.git.gitgitgadget@gmail.com>
References: <pull.329.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/5] treewide: rename 'struct exclude_list' to 'struct
 pattern_list'
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

This commit renames 'struct exclude_list' to 'struct pattern_list'
and renames several variables called 'el' to 'pl'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/check-ignore.c |   4 +-
 builtin/clean.c        |  12 ++---
 builtin/ls-files.c     |   6 +--
 dir.c                  | 106 ++++++++++++++++++++---------------------
 dir.h                  |  18 +++----
 list-objects-filter.c  |   8 ++--
 unpack-trees.c         |  42 ++++++++--------
 unpack-trees.h         |   4 +-
 8 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 9a0f234514..97108ccb9c 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -41,7 +41,7 @@ static void output_pattern(const char *path, struct path_pattern *pattern)
 			write_name_quoted(path, stdout, '\n');
 		} else {
 			if (pattern) {
-				quote_c_style(pattern->el->src, NULL, stdout, 0);
+				quote_c_style(pattern->pl->src, NULL, stdout, 0);
 				printf(":%d:%s%s%s\t",
 				       pattern->srcpos,
 				       bang, pattern->pattern, slash);
@@ -58,7 +58,7 @@ static void output_pattern(const char *path, struct path_pattern *pattern)
 		} else {
 			if (pattern)
 				printf("%s%c%d%c%s%s%s%c%s%c",
-				       pattern->el->src, '\0',
+				       pattern->pl->src, '\0',
 				       pattern->srcpos, '\0',
 				       bang, pattern->pattern, slash, '\0',
 				       path, '\0');
diff --git a/builtin/clean.c b/builtin/clean.c
index aaba4af3c2..d8c847d9fd 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -647,7 +647,7 @@ static int filter_by_patterns_cmd(void)
 	struct strbuf confirm = STRBUF_INIT;
 	struct strbuf **ignore_list;
 	struct string_list_item *item;
-	struct exclude_list *el;
+	struct pattern_list *pl;
 	int changed = -1, i;
 
 	for (;;) {
@@ -670,7 +670,7 @@ static int filter_by_patterns_cmd(void)
 			break;
 
 		memset(&dir, 0, sizeof(dir));
-		el = add_exclude_list(&dir, EXC_CMDL, "manual exclude");
+		pl = add_exclude_list(&dir, EXC_CMDL, "manual exclude");
 		ignore_list = strbuf_split_max(&confirm, ' ', 0);
 
 		for (i = 0; ignore_list[i]; i++) {
@@ -678,7 +678,7 @@ static int filter_by_patterns_cmd(void)
 			if (!ignore_list[i]->len)
 				continue;
 
-			add_exclude(ignore_list[i]->buf, "", 0, el, -(i+1));
+			add_exclude(ignore_list[i]->buf, "", 0, pl, -(i+1));
 		}
 
 		changed = 0;
@@ -900,7 +900,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
-	struct exclude_list *el;
+	struct pattern_list *pl;
 	struct string_list_item *item;
 	const char *qname;
 	struct option options[] = {
@@ -957,9 +957,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
+	pl = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++)
-		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
+		add_exclude(exclude_list.items[i].string, "", 0, pl, -(i+1));
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7f83c9a6f2..df8918a128 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -516,7 +516,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	int require_work_tree = 0, show_tag = 0, i;
 	const char *max_prefix;
 	struct dir_struct dir;
-	struct exclude_list *el;
+	struct pattern_list *pl;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option builtin_ls_files_options[] = {
 		/* Think twice before adding "--nul" synonym to this */
@@ -594,9 +594,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
-	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
+	pl = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++) {
-		add_exclude(exclude_list.items[i].string, "", 0, el, --exclude_args);
+		add_exclude(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
diff --git a/dir.c b/dir.c
index 4128d59d7a..b522d61ee0 100644
--- a/dir.c
+++ b/dir.c
@@ -600,7 +600,7 @@ void parse_exclude_pattern(const char **pattern,
 }
 
 void add_exclude(const char *string, const char *base,
-		 int baselen, struct exclude_list *el, int srcpos)
+		 int baselen, struct pattern_list *pl, int srcpos)
 {
 	struct path_pattern *pattern;
 	int patternlen;
@@ -620,9 +620,9 @@ void add_exclude(const char *string, const char *base,
 	pattern->baselen = baselen;
 	pattern->flags = flags;
 	pattern->srcpos = srcpos;
-	ALLOC_GROW(el->patterns, el->nr + 1, el->alloc);
-	el->patterns[el->nr++] = pattern;
-	pattern->el = el;
+	ALLOC_GROW(pl->patterns, pl->nr + 1, pl->alloc);
+	pl->patterns[pl->nr++] = pattern;
+	pattern->pl = pl;
 }
 
 static int read_skip_worktree_file_from_index(const struct index_state *istate,
@@ -643,19 +643,19 @@ static int read_skip_worktree_file_from_index(const struct index_state *istate,
 }
 
 /*
- * Frees memory within el which was allocated for exclude patterns and
- * the file buffer.  Does not free el itself.
+ * Frees memory within pl which was allocated for exclude patterns and
+ * the file buffer.  Does not free pl itself.
  */
-void clear_exclude_list(struct exclude_list *el)
+void clear_exclude_list(struct pattern_list *pl)
 {
 	int i;
 
-	for (i = 0; i < el->nr; i++)
-		free(el->patterns[i]);
-	free(el->patterns);
-	free(el->filebuf);
+	for (i = 0; i < pl->nr; i++)
+		free(pl->patterns[i]);
+	free(pl->patterns);
+	free(pl->filebuf);
 
-	memset(el, 0, sizeof(*el));
+	memset(pl, 0, sizeof(*pl));
 }
 
 static void trim_trailing_spaces(char *buf)
@@ -764,19 +764,19 @@ static void invalidate_directory(struct untracked_cache *uc,
 
 static int add_excludes_from_buffer(char *buf, size_t size,
 				    const char *base, int baselen,
-				    struct exclude_list *el);
+				    struct pattern_list *pl);
 
 /*
  * Given a file with name "fname", read it (either from disk, or from
  * an index if 'istate' is non-null), parse it and store the
- * exclude rules in "el".
+ * exclude rules in "pl".
  *
  * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
  * stat data from disk (only valid if add_excludes returns zero). If
  * ss_valid is non-zero, "ss" must contain good value as input.
  */
 static int add_excludes(const char *fname, const char *base, int baselen,
-			struct exclude_list *el, struct index_state *istate,
+			struct pattern_list *pl, struct index_state *istate,
 			struct oid_stat *oid_stat)
 {
 	struct stat st;
@@ -837,21 +837,21 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		}
 	}
 
-	add_excludes_from_buffer(buf, size, base, baselen, el);
+	add_excludes_from_buffer(buf, size, base, baselen, pl);
 	return 0;
 }
 
 static int add_excludes_from_buffer(char *buf, size_t size,
 				    const char *base, int baselen,
-				    struct exclude_list *el)
+				    struct pattern_list *pl)
 {
 	int i, lineno = 1;
 	char *entry;
 
-	el->filebuf = buf;
+	pl->filebuf = buf;
 
 	if (skip_utf8_bom(&buf, size))
-		size -= buf - el->filebuf;
+		size -= buf - pl->filebuf;
 
 	entry = buf;
 
@@ -860,7 +860,7 @@ static int add_excludes_from_buffer(char *buf, size_t size,
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
 				trim_trailing_spaces(entry);
-				add_exclude(entry, base, baselen, el, lineno);
+				add_exclude(entry, base, baselen, pl, lineno);
 			}
 			lineno++;
 			entry = buf + i + 1;
@@ -870,16 +870,16 @@ static int add_excludes_from_buffer(char *buf, size_t size,
 }
 
 int add_excludes_from_file_to_list(const char *fname, const char *base,
-				   int baselen, struct exclude_list *el,
+				   int baselen, struct pattern_list *pl,
 				   struct index_state *istate)
 {
-	return add_excludes(fname, base, baselen, el, istate, NULL);
+	return add_excludes(fname, base, baselen, pl, istate, NULL);
 }
 
 int add_excludes_from_blob_to_list(
 	struct object_id *oid,
 	const char *base, int baselen,
-	struct exclude_list *el)
+	struct pattern_list *pl)
 {
 	char *buf;
 	size_t size;
@@ -889,22 +889,22 @@ int add_excludes_from_blob_to_list(
 	if (r != 1)
 		return r;
 
-	add_excludes_from_buffer(buf, size, base, baselen, el);
+	add_excludes_from_buffer(buf, size, base, baselen, pl);
 	return 0;
 }
 
-struct exclude_list *add_exclude_list(struct dir_struct *dir,
+struct pattern_list *add_exclude_list(struct dir_struct *dir,
 				      int group_type, const char *src)
 {
-	struct exclude_list *el;
+	struct pattern_list *pl;
 	struct exclude_list_group *group;
 
 	group = &dir->exclude_list_group[group_type];
-	ALLOC_GROW(group->el, group->nr + 1, group->alloc);
-	el = &group->el[group->nr++];
-	memset(el, 0, sizeof(*el));
-	el->src = src;
-	return el;
+	ALLOC_GROW(group->pl, group->nr + 1, group->alloc);
+	pl = &group->pl[group->nr++];
+	memset(pl, 0, sizeof(*pl));
+	pl->src = src;
+	return pl;
 }
 
 /*
@@ -913,7 +913,7 @@ struct exclude_list *add_exclude_list(struct dir_struct *dir,
 static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
 				     struct oid_stat *oid_stat)
 {
-	struct exclude_list *el;
+	struct pattern_list *pl;
 	/*
 	 * catch setup_standard_excludes() that's called before
 	 * dir->untracked is assigned. That function behaves
@@ -921,8 +921,8 @@ static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
 	 */
 	if (!dir->untracked)
 		dir->unmanaged_exclude_files++;
-	el = add_exclude_list(dir, EXC_FILE, fname);
-	if (add_excludes(fname, "", 0, el, NULL, oid_stat) < 0)
+	pl = add_exclude_list(dir, EXC_FILE, fname);
+	if (add_excludes(fname, "", 0, pl, NULL, oid_stat) < 0)
 		die(_("cannot use %s as an exclude file"), fname);
 }
 
@@ -1025,17 +1025,17 @@ static struct path_pattern *last_exclude_matching_from_list(const char *pathname
 						       int pathlen,
 						       const char *basename,
 						       int *dtype,
-						       struct exclude_list *el,
+						       struct pattern_list *pl,
 						       struct index_state *istate)
 {
 	struct path_pattern *res = NULL; /* undecided */
 	int i;
 
-	if (!el->nr)
+	if (!pl->nr)
 		return NULL;	/* undefined */
 
-	for (i = el->nr - 1; 0 <= i; i--) {
-		struct path_pattern *pattern = el->patterns[i];
+	for (i = pl->nr - 1; 0 <= i; i--) {
+		struct path_pattern *pattern = pl->patterns[i];
 		const char *exclude = pattern->pattern;
 		int prefix = pattern->nowildcardlen;
 
@@ -1077,11 +1077,11 @@ static struct path_pattern *last_exclude_matching_from_list(const char *pathname
  */
 int is_excluded_from_list(const char *pathname,
 			  int pathlen, const char *basename, int *dtype,
-			  struct exclude_list *el, struct index_state *istate)
+			  struct pattern_list *pl, struct index_state *istate)
 {
 	struct path_pattern *pattern;
 	pattern = last_exclude_matching_from_list(pathname, pathlen, basename,
-						  dtype, el, istate);
+						  dtype, pl, istate);
 	if (pattern)
 		return pattern->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return -1; /* undecided */
@@ -1100,7 +1100,7 @@ static struct path_pattern *last_exclude_matching_from_lists(
 		for (j = group->nr - 1; j >= 0; j--) {
 			pattern = last_exclude_matching_from_list(
 				pathname, pathlen, basename, dtype_p,
-				&group->el[j], istate);
+				&group->pl[j], istate);
 			if (pattern)
 				return pattern;
 		}
@@ -1117,7 +1117,7 @@ static void prep_exclude(struct dir_struct *dir,
 			 const char *base, int baselen)
 {
 	struct exclude_list_group *group;
-	struct exclude_list *el;
+	struct pattern_list *pl;
 	struct exclude_stack *stk = NULL;
 	struct untracked_cache_dir *untracked;
 	int current;
@@ -1133,11 +1133,11 @@ static void prep_exclude(struct dir_struct *dir,
 		if (stk->baselen <= baselen &&
 		    !strncmp(dir->basebuf.buf, base, stk->baselen))
 			break;
-		el = &group->el[dir->exclude_stack->exclude_ix];
+		pl = &group->pl[dir->exclude_stack->exclude_ix];
 		dir->exclude_stack = stk->prev;
 		dir->pattern = NULL;
-		free((char *)el->src); /* see strbuf_detach() below */
-		clear_exclude_list(el);
+		free((char *)pl->src); /* see strbuf_detach() below */
+		clear_exclude_list(pl);
 		free(stk);
 		group->nr--;
 	}
@@ -1184,7 +1184,7 @@ static void prep_exclude(struct dir_struct *dir,
 		stk->baselen = cp - base;
 		stk->exclude_ix = group->nr;
 		stk->ucd = untracked;
-		el = add_exclude_list(dir, EXC_DIRS, NULL);
+		pl = add_exclude_list(dir, EXC_DIRS, NULL);
 		strbuf_add(&dir->basebuf, base + current, stk->baselen - current);
 		assert(stk->baselen == dir->basebuf.len);
 
@@ -1234,8 +1234,8 @@ static void prep_exclude(struct dir_struct *dir,
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addbuf(&sb, &dir->basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
-			el->src = strbuf_detach(&sb, NULL);
-			add_excludes(el->src, el->src, stk->baselen, el, istate,
+			pl->src = strbuf_detach(&sb, NULL);
+			add_excludes(pl->src, pl->src, stk->baselen, pl, istate,
 				     untracked ? &oid_stat : NULL);
 		}
 		/*
@@ -2530,18 +2530,18 @@ void clear_directory(struct dir_struct *dir)
 {
 	int i, j;
 	struct exclude_list_group *group;
-	struct exclude_list *el;
+	struct pattern_list *pl;
 	struct exclude_stack *stk;
 
 	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
 		group = &dir->exclude_list_group[i];
 		for (j = 0; j < group->nr; j++) {
-			el = &group->el[j];
+			pl = &group->pl[j];
 			if (i == EXC_DIRS)
-				free((char *)el->src);
-			clear_exclude_list(el);
+				free((char *)pl->src);
+			clear_exclude_list(pl);
 		}
-		free(group->el);
+		free(group->pl);
 	}
 
 	stk = dir->exclude_stack;
diff --git a/dir.h b/dir.h
index e8b90fc482..4114d6bf78 100644
--- a/dir.h
+++ b/dir.h
@@ -21,7 +21,7 @@ struct path_pattern {
 	 * This allows callers of last_exclude_matching() etc.
 	 * to determine the origin of the matching pattern.
 	 */
-	struct exclude_list *el;
+	struct pattern_list *pl;
 
 	const char *pattern;
 	int patternlen;
@@ -44,7 +44,7 @@ struct path_pattern {
  * can also be used to represent the list of --exclude values passed
  * via CLI args.
  */
-struct exclude_list {
+struct pattern_list {
 	int nr;
 	int alloc;
 
@@ -72,7 +72,7 @@ struct exclude_stack {
 
 struct exclude_list_group {
 	int nr, alloc;
-	struct exclude_list *el;
+	struct pattern_list *pl;
 };
 
 struct oid_stat {
@@ -232,7 +232,7 @@ int read_directory(struct dir_struct *, struct index_state *istate,
 
 int is_excluded_from_list(const char *pathname, int pathlen,
 			  const char *basename, int *dtype,
-			  struct exclude_list *el,
+			  struct pattern_list *pl,
 			  struct index_state *istate);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
@@ -256,18 +256,18 @@ int is_excluded(struct dir_struct *dir,
 		struct index_state *istate,
 		const char *name, int *dtype);
 
-struct exclude_list *add_exclude_list(struct dir_struct *dir,
+struct pattern_list *add_exclude_list(struct dir_struct *dir,
 				      int group_type, const char *src);
 int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
-				   struct exclude_list *el, struct  index_state *istate);
+				   struct pattern_list *pl, struct  index_state *istate);
 void add_excludes_from_file(struct dir_struct *, const char *fname);
 int add_excludes_from_blob_to_list(struct object_id *oid,
 				   const char *base, int baselen,
-				   struct exclude_list *el);
+				   struct pattern_list *pl);
 void parse_exclude_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
 void add_exclude(const char *string, const char *base,
-		 int baselen, struct exclude_list *el, int srcpos);
-void clear_exclude_list(struct exclude_list *el);
+		 int baselen, struct pattern_list *pl, int srcpos);
+void clear_exclude_list(struct pattern_list *pl);
 void clear_directory(struct dir_struct *dir);
 
 int repo_file_exists(struct repository *repo, const char *path);
diff --git a/list-objects-filter.c b/list-objects-filter.c
index d664264d65..a1fedf8bd8 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -347,7 +347,7 @@ struct frame {
 };
 
 struct filter_sparse_data {
-	struct exclude_list el;
+	struct pattern_list pl;
 
 	size_t nr, alloc;
 	struct frame *array_frame;
@@ -374,7 +374,7 @@ static enum list_objects_filter_result filter_sparse(
 		assert(obj->type == OBJ_TREE);
 		dtype = DT_DIR;
 		val = is_excluded_from_list(pathname, strlen(pathname),
-					    filename, &dtype, &filter_data->el,
+					    filename, &dtype, &filter_data->pl,
 					    r->index);
 		if (val < 0)
 			val = filter_data->array_frame[filter_data->nr - 1].defval;
@@ -436,7 +436,7 @@ static enum list_objects_filter_result filter_sparse(
 
 		dtype = DT_REG;
 		val = is_excluded_from_list(pathname, strlen(pathname),
-					    filename, &dtype, &filter_data->el,
+					    filename, &dtype, &filter_data->pl,
 					    r->index);
 		if (val < 0)
 			val = frame->defval;
@@ -483,7 +483,7 @@ static void filter_sparse_oid__init(
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
 	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
-					   NULL, 0, &d->el) < 0)
+					   NULL, 0, &d->pl) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
diff --git a/unpack-trees.c b/unpack-trees.c
index 50189909b8..c4dc21affb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1265,7 +1265,7 @@ static int clear_ce_flags_1(struct index_state *istate,
 			    struct cache_entry **cache, int nr,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
-			    struct exclude_list *el, int defval);
+			    struct pattern_list *pl, int defval);
 
 /* Whole directory matching */
 static int clear_ce_flags_dir(struct index_state *istate,
@@ -1273,12 +1273,12 @@ static int clear_ce_flags_dir(struct index_state *istate,
 			      struct strbuf *prefix,
 			      char *basename,
 			      int select_mask, int clear_mask,
-			      struct exclude_list *el, int defval)
+			      struct pattern_list *pl, int defval)
 {
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
 	int ret = is_excluded_from_list(prefix->buf, prefix->len,
-					basename, &dtype, el, istate);
+					basename, &dtype, pl, istate);
 	int rc;
 
 	strbuf_addch(prefix, '/');
@@ -1294,7 +1294,7 @@ static int clear_ce_flags_dir(struct index_state *istate,
 	}
 
 	/*
-	 * TODO: check el, if there are no patterns that may conflict
+	 * TODO: check pl, if there are no patterns that may conflict
 	 * with ret (iow, we know in advance the incl/excl
 	 * decision for the entire directory), clear flag here without
 	 * calling clear_ce_flags_1(). That function will call
@@ -1303,14 +1303,14 @@ static int clear_ce_flags_dir(struct index_state *istate,
 	rc = clear_ce_flags_1(istate, cache, cache_end - cache,
 			      prefix,
 			      select_mask, clear_mask,
-			      el, ret);
+			      pl, ret);
 	strbuf_setlen(prefix, prefix->len - 1);
 	return rc;
 }
 
 /*
  * Traverse the index, find every entry that matches according to
- * o->el. Do "ce_flags &= ~clear_mask" on those entries. Return the
+ * o->pl. Do "ce_flags &= ~clear_mask" on those entries. Return the
  * number of traversed entries.
  *
  * If select_mask is non-zero, only entries whose ce_flags has on of
@@ -1327,7 +1327,7 @@ static int clear_ce_flags_1(struct index_state *istate,
 			    struct cache_entry **cache, int nr,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
-			    struct exclude_list *el, int defval)
+			    struct pattern_list *pl, int defval)
 {
 	struct cache_entry **cache_end = cache + nr;
 
@@ -1362,7 +1362,7 @@ static int clear_ce_flags_1(struct index_state *istate,
 						       prefix,
 						       prefix->buf + prefix->len - len,
 						       select_mask, clear_mask,
-						       el, defval);
+						       pl, defval);
 
 			/* clear_c_f_dir eats a whole dir already? */
 			if (processed) {
@@ -1374,7 +1374,7 @@ static int clear_ce_flags_1(struct index_state *istate,
 			strbuf_addch(prefix, '/');
 			cache += clear_ce_flags_1(istate, cache, cache_end - cache,
 						  prefix,
-						  select_mask, clear_mask, el, defval);
+						  select_mask, clear_mask, pl, defval);
 			strbuf_setlen(prefix, prefix->len - len - 1);
 			continue;
 		}
@@ -1382,7 +1382,7 @@ static int clear_ce_flags_1(struct index_state *istate,
 		/* Non-directory */
 		dtype = ce_to_dtype(ce);
 		ret = is_excluded_from_list(ce->name, ce_namelen(ce),
-					    name, &dtype, el, istate);
+					    name, &dtype, pl, istate);
 		if (ret < 0)
 			ret = defval;
 		if (ret > 0)
@@ -1394,7 +1394,7 @@ static int clear_ce_flags_1(struct index_state *istate,
 
 static int clear_ce_flags(struct index_state *istate,
 			  int select_mask, int clear_mask,
-			  struct exclude_list *el)
+			  struct pattern_list *pl)
 {
 	static struct strbuf prefix = STRBUF_INIT;
 
@@ -1405,13 +1405,13 @@ static int clear_ce_flags(struct index_state *istate,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
-				el, 0);
+				pl, 0);
 }
 
 /*
  * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-checkout
  */
-static void mark_new_skip_worktree(struct exclude_list *el,
+static void mark_new_skip_worktree(struct pattern_list *pl,
 				   struct index_state *istate,
 				   int select_flag, int skip_wt_flag)
 {
@@ -1437,7 +1437,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(istate, select_flag, skip_wt_flag, el);
+	clear_ce_flags(istate, select_flag, skip_wt_flag, pl);
 }
 
 static int verify_absent(const struct cache_entry *,
@@ -1453,21 +1453,21 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 {
 	int i, ret;
 	static struct cache_entry *dfc;
-	struct exclude_list el;
+	struct pattern_list pl;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
 	trace_performance_enter();
-	memset(&el, 0, sizeof(el));
+	memset(&pl, 0, sizeof(pl));
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		char *sparse = git_pathdup("info/sparse-checkout");
-		if (add_excludes_from_file_to_list(sparse, "", 0, &el, NULL) < 0)
+		if (add_excludes_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
 			o->skip_sparse_checkout = 1;
 		else
-			o->el = &el;
+			o->pl = &pl;
 		free(sparse);
 	}
 
@@ -1498,7 +1498,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
 	if (!o->skip_sparse_checkout)
-		mark_new_skip_worktree(o->el, o->src_index, 0, CE_NEW_SKIP_WORKTREE);
+		mark_new_skip_worktree(o->pl, o->src_index, 0, CE_NEW_SKIP_WORKTREE);
 
 	if (!dfc)
 		dfc = xcalloc(1, cache_entry_size(0));
@@ -1563,7 +1563,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		 * If the will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
 		 * so apply_sparse_checkout() won't attempt to remove it from worktree
 		 */
-		mark_new_skip_worktree(o->el, &o->result, CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
+		mark_new_skip_worktree(o->pl, &o->result, CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
 
 		ret = 0;
 		for (i = 0; i < o->result.cache_nr; i++) {
@@ -1631,7 +1631,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 done:
 	trace_performance_leave("unpack_trees");
-	clear_exclude_list(&el);
+	clear_exclude_list(&pl);
 	return ret;
 
 return_failed:
diff --git a/unpack-trees.h b/unpack-trees.h
index d344d7d296..f2eee0c7c5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -10,7 +10,7 @@
 
 struct cache_entry;
 struct unpack_trees_options;
-struct exclude_list;
+struct pattern_list;
 
 typedef int (*merge_fn_t)(const struct cache_entry * const *src,
 		struct unpack_trees_options *options);
@@ -83,7 +83,7 @@ struct unpack_trees_options {
 	struct index_state *src_index;
 	struct index_state result;
 
-	struct exclude_list *el; /* for internal use */
+	struct pattern_list *pl; /* for internal use */
 };
 
 int unpack_trees(unsigned n, struct tree_desc *t,
-- 
gitgitgadget

