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
	by dcvr.yhbt.net (Postfix) with ESMTP id 426641F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfICSFA (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:05:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41594 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfICSE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:04:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so18473525wrr.8
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iF0qOG6YO/niZYgZ4gApNon9GUUo3+0R6PkvbytSw3s=;
        b=P/0/mRtuDlR7NyKa1Jr3RSfD6m+rUcLLQS0YMhUwG4je4jHq8CKrz6Ti/MUSUY+SCc
         oiiHgePZnfj23F86YkjC4vLO1A3MUHgQ1oNvwsyyktJBS0LcUxF1X8UmXnE/wRjNRKDz
         UONLp5BwQjcD0TlCqU2vMwyharzP08D8+D4fEEcBNFkPRAxoyPPfJsIMB20RRlAlKWGN
         4FhkjmmRG64jTA/xFm00oF6ImGPsTx+kvoa9KOMeJuOpC/6bhf3zigRGG7hwt2u35Rlq
         V5FVUXcofdMgNkjN0sHE609dALzX2t5RiS4js8S6MVmGM7yTP3Qva4FfxezNsz18GImi
         yqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iF0qOG6YO/niZYgZ4gApNon9GUUo3+0R6PkvbytSw3s=;
        b=A++giSOIchjiPwmK5QKfo45rJOWQMBMLCjuyHCr00MlNN2xBlwzjjj7R84uQx+8/Aa
         DmG2P7AXfrUsiGW1E14JAmBEmk2bDabbAtlg60eH9N6wqneldtuURdPgf49PBmAbI6sh
         sIw3CbZG5WSP+kHc2EEXndTSU+7f9Y2SYbD99cJLlls0mPelEClG9VYP2ysPBDP+XxQF
         TTP+ahmwJZkBpEa8x+5YnDS5bxgcTkMQqG+tWC8aQbMmBN3Ip58drlfJ0fvlKQtutEY6
         wPuqvwxoxnfMwoqr47hK3CXzEpBEJR8WI/6ME4bxT3ZbClFn0tnK0CXmddOMdgDESaCT
         o/Wg==
X-Gm-Message-State: APjAAAWzdLnDyHo1IcchwtKsrMQ+POGPK+dTiuW1bFWS/uKuBuTZRjt9
        WVncTrogK88b45Yaw9h0yrop0l3U
X-Google-Smtp-Source: APXvYqxQBLxMnYpVpJfZ/KdJyazeeF8W77KPKID2lmxl1aHZwUqJOraZbPtReXmdpGxxR09ltsjRaQ==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr4404628wrn.55.1567533895790;
        Tue, 03 Sep 2019 11:04:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y186sm464273wmb.41.2019.09.03.11.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:04:55 -0700 (PDT)
Date:   Tue, 03 Sep 2019 11:04:55 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 18:04:49 GMT
Message-Id: <8cdffbd1c82c34a7dbdb18cb396e5e422889aad6.1567533893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.329.git.gitgitgadget@gmail.com>
References: <pull.329.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/5] treewide: rename 'struct exclude' to 'struct
 path_pattern'
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
as a list of 'struct exclude' items makes sense. However, the
sparse-checkout feature then adopted these structures and methods,
but with the opposite meaning: these patterns match the files
that should be included!

It would be clearer to rename this entire library as a "pattern
matching" library, and the callers apply exclusion/inclusion
logic accordingly based on their needs.

This commit renames 'struct exclude' to 'struct path_pattern'
and renames several variable names to match. 'struct pattern'
was already taken by attr.c, and this more completely describes
that the patterns are specific to file paths.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/check-ignore.c |  34 ++++++------
 dir.c                  | 115 +++++++++++++++++++++--------------------
 dir.h                  |   8 +--
 3 files changed, 80 insertions(+), 77 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 599097304b..9a0f234514 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -32,19 +32,19 @@ static const struct option check_ignore_options[] = {
 	OPT_END()
 };
 
-static void output_exclude(const char *path, struct exclude *exclude)
+static void output_pattern(const char *path, struct path_pattern *pattern)
 {
-	char *bang  = (exclude && exclude->flags & EXC_FLAG_NEGATIVE)  ? "!" : "";
-	char *slash = (exclude && exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
+	char *bang  = (pattern && pattern->flags & EXC_FLAG_NEGATIVE)  ? "!" : "";
+	char *slash = (pattern && pattern->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
 	if (!nul_term_line) {
 		if (!verbose) {
 			write_name_quoted(path, stdout, '\n');
 		} else {
-			if (exclude) {
-				quote_c_style(exclude->el->src, NULL, stdout, 0);
+			if (pattern) {
+				quote_c_style(pattern->el->src, NULL, stdout, 0);
 				printf(":%d:%s%s%s\t",
-				       exclude->srcpos,
-				       bang, exclude->pattern, slash);
+				       pattern->srcpos,
+				       bang, pattern->pattern, slash);
 			}
 			else {
 				printf("::\t");
@@ -56,11 +56,11 @@ static void output_exclude(const char *path, struct exclude *exclude)
 		if (!verbose) {
 			printf("%s%c", path, '\0');
 		} else {
-			if (exclude)
+			if (pattern)
 				printf("%s%c%d%c%s%s%s%c%s%c",
-				       exclude->el->src, '\0',
-				       exclude->srcpos, '\0',
-				       bang, exclude->pattern, slash, '\0',
+				       pattern->el->src, '\0',
+				       pattern->srcpos, '\0',
+				       bang, pattern->pattern, slash, '\0',
 				       path, '\0');
 			else
 				printf("%c%c%c%s%c", '\0', '\0', '\0', path, '\0');
@@ -74,7 +74,7 @@ static int check_ignore(struct dir_struct *dir,
 	const char *full_path;
 	char *seen;
 	int num_ignored = 0, i;
-	struct exclude *exclude;
+	struct path_pattern *pattern;
 	struct pathspec pathspec;
 
 	if (!argc) {
@@ -103,15 +103,15 @@ static int check_ignore(struct dir_struct *dir,
 	seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
 	for (i = 0; i < pathspec.nr; i++) {
 		full_path = pathspec.items[i].match;
-		exclude = NULL;
+		pattern = NULL;
 		if (!seen[i]) {
 			int dtype = DT_UNKNOWN;
-			exclude = last_exclude_matching(dir, &the_index,
+			pattern = last_exclude_matching(dir, &the_index,
 							full_path, &dtype);
 		}
-		if (!quiet && (exclude || show_non_matching))
-			output_exclude(pathspec.items[i].original, exclude);
-		if (exclude)
+		if (!quiet && (pattern || show_non_matching))
+			output_pattern(pathspec.items[i].original, pattern);
+		if (pattern)
 			num_ignored++;
 	}
 	free(seen);
diff --git a/dir.c b/dir.c
index ba4a51c296..4128d59d7a 100644
--- a/dir.c
+++ b/dir.c
@@ -602,27 +602,27 @@ void parse_exclude_pattern(const char **pattern,
 void add_exclude(const char *string, const char *base,
 		 int baselen, struct exclude_list *el, int srcpos)
 {
-	struct exclude *x;
+	struct path_pattern *pattern;
 	int patternlen;
 	unsigned flags;
 	int nowildcardlen;
 
 	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
 	if (flags & EXC_FLAG_MUSTBEDIR) {
-		FLEXPTR_ALLOC_MEM(x, pattern, string, patternlen);
+		FLEXPTR_ALLOC_MEM(pattern, pattern, string, patternlen);
 	} else {
-		x = xmalloc(sizeof(*x));
-		x->pattern = string;
+		pattern = xmalloc(sizeof(*pattern));
+		pattern->pattern = string;
 	}
-	x->patternlen = patternlen;
-	x->nowildcardlen = nowildcardlen;
-	x->base = base;
-	x->baselen = baselen;
-	x->flags = flags;
-	x->srcpos = srcpos;
-	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
-	el->excludes[el->nr++] = x;
-	x->el = el;
+	pattern->patternlen = patternlen;
+	pattern->nowildcardlen = nowildcardlen;
+	pattern->base = base;
+	pattern->baselen = baselen;
+	pattern->flags = flags;
+	pattern->srcpos = srcpos;
+	ALLOC_GROW(el->patterns, el->nr + 1, el->alloc);
+	el->patterns[el->nr++] = pattern;
+	pattern->el = el;
 }
 
 static int read_skip_worktree_file_from_index(const struct index_state *istate,
@@ -651,8 +651,8 @@ void clear_exclude_list(struct exclude_list *el)
 	int i;
 
 	for (i = 0; i < el->nr; i++)
-		free(el->excludes[i]);
-	free(el->excludes);
+		free(el->patterns[i]);
+	free(el->patterns);
 	free(el->filebuf);
 
 	memset(el, 0, sizeof(*el));
@@ -1021,51 +1021,54 @@ int match_pathname(const char *pathname, int pathlen,
  * any, determines the fate.  Returns the exclude_list element which
  * matched, or NULL for undecided.
  */
-static struct exclude *last_exclude_matching_from_list(const char *pathname,
+static struct path_pattern *last_exclude_matching_from_list(const char *pathname,
 						       int pathlen,
 						       const char *basename,
 						       int *dtype,
 						       struct exclude_list *el,
 						       struct index_state *istate)
 {
-	struct exclude *exc = NULL; /* undecided */
+	struct path_pattern *res = NULL; /* undecided */
 	int i;
 
 	if (!el->nr)
 		return NULL;	/* undefined */
 
 	for (i = el->nr - 1; 0 <= i; i--) {
-		struct exclude *x = el->excludes[i];
-		const char *exclude = x->pattern;
-		int prefix = x->nowildcardlen;
+		struct path_pattern *pattern = el->patterns[i];
+		const char *exclude = pattern->pattern;
+		int prefix = pattern->nowildcardlen;
 
-		if (x->flags & EXC_FLAG_MUSTBEDIR) {
+		if (pattern->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype == DT_UNKNOWN)
 				*dtype = get_dtype(NULL, istate, pathname, pathlen);
 			if (*dtype != DT_DIR)
 				continue;
 		}
 
-		if (x->flags & EXC_FLAG_NODIR) {
+		if (pattern->flags & EXC_FLAG_NODIR) {
 			if (match_basename(basename,
 					   pathlen - (basename - pathname),
-					   exclude, prefix, x->patternlen,
-					   x->flags)) {
-				exc = x;
+					   exclude, prefix, pattern->patternlen,
+					   pattern->flags)) {
+				res = pattern;
 				break;
 			}
 			continue;
 		}
 
-		assert(x->baselen == 0 || x->base[x->baselen - 1] == '/');
+		assert(pattern->baselen == 0 ||
+		       pattern->base[pattern->baselen - 1] == '/');
 		if (match_pathname(pathname, pathlen,
-				   x->base, x->baselen ? x->baselen - 1 : 0,
-				   exclude, prefix, x->patternlen, x->flags)) {
-			exc = x;
+				   pattern->base,
+				   pattern->baselen ? pattern->baselen - 1 : 0,
+				   exclude, prefix, pattern->patternlen,
+				   pattern->flags)) {
+			res = pattern;
 			break;
 		}
 	}
-	return exc;
+	return res;
 }
 
 /*
@@ -1076,30 +1079,30 @@ int is_excluded_from_list(const char *pathname,
 			  int pathlen, const char *basename, int *dtype,
 			  struct exclude_list *el, struct index_state *istate)
 {
-	struct exclude *exclude;
-	exclude = last_exclude_matching_from_list(pathname, pathlen, basename,
+	struct path_pattern *pattern;
+	pattern = last_exclude_matching_from_list(pathname, pathlen, basename,
 						  dtype, el, istate);
-	if (exclude)
-		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
+	if (pattern)
+		return pattern->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return -1; /* undecided */
 }
 
-static struct exclude *last_exclude_matching_from_lists(struct dir_struct *dir,
-							struct index_state *istate,
-		const char *pathname, int pathlen, const char *basename,
-		int *dtype_p)
+static struct path_pattern *last_exclude_matching_from_lists(
+		struct dir_struct *dir, struct index_state *istate,
+		const char *pathname, int pathlen,
+		const char *basename, int *dtype_p)
 {
 	int i, j;
 	struct exclude_list_group *group;
-	struct exclude *exclude;
+	struct path_pattern *pattern;
 	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
 		group = &dir->exclude_list_group[i];
 		for (j = group->nr - 1; j >= 0; j--) {
-			exclude = last_exclude_matching_from_list(
+			pattern = last_exclude_matching_from_list(
 				pathname, pathlen, basename, dtype_p,
 				&group->el[j], istate);
-			if (exclude)
-				return exclude;
+			if (pattern)
+				return pattern;
 		}
 	}
 	return NULL;
@@ -1132,7 +1135,7 @@ static void prep_exclude(struct dir_struct *dir,
 			break;
 		el = &group->el[dir->exclude_stack->exclude_ix];
 		dir->exclude_stack = stk->prev;
-		dir->exclude = NULL;
+		dir->pattern = NULL;
 		free((char *)el->src); /* see strbuf_detach() below */
 		clear_exclude_list(el);
 		free(stk);
@@ -1140,7 +1143,7 @@ static void prep_exclude(struct dir_struct *dir,
 	}
 
 	/* Skip traversing into sub directories if the parent is excluded */
-	if (dir->exclude)
+	if (dir->pattern)
 		return;
 
 	/*
@@ -1189,15 +1192,15 @@ static void prep_exclude(struct dir_struct *dir,
 		if (stk->baselen) {
 			int dt = DT_DIR;
 			dir->basebuf.buf[stk->baselen - 1] = 0;
-			dir->exclude = last_exclude_matching_from_lists(dir,
+			dir->pattern = last_exclude_matching_from_lists(dir,
 									istate,
 				dir->basebuf.buf, stk->baselen - 1,
 				dir->basebuf.buf + current, &dt);
 			dir->basebuf.buf[stk->baselen - 1] = '/';
-			if (dir->exclude &&
-			    dir->exclude->flags & EXC_FLAG_NEGATIVE)
-				dir->exclude = NULL;
-			if (dir->exclude) {
+			if (dir->pattern &&
+			    dir->pattern->flags & EXC_FLAG_NEGATIVE)
+				dir->pattern = NULL;
+			if (dir->pattern) {
 				dir->exclude_stack = stk;
 				return;
 			}
@@ -1223,7 +1226,7 @@ static void prep_exclude(struct dir_struct *dir,
 			/*
 			 * dir->basebuf gets reused by the traversal, but we
 			 * need fname to remain unchanged to ensure the src
-			 * member of each struct exclude correctly
+			 * member of each struct path_pattern correctly
 			 * back-references its source file.  Other invocations
 			 * of add_exclude_list provide stable strings, so we
 			 * strbuf_detach() and free() here in the caller.
@@ -1266,7 +1269,7 @@ static void prep_exclude(struct dir_struct *dir,
  * Returns the exclude_list element which matched, or NULL for
  * undecided.
  */
-struct exclude *last_exclude_matching(struct dir_struct *dir,
+struct path_pattern *last_exclude_matching(struct dir_struct *dir,
 				      struct index_state *istate,
 				      const char *pathname,
 				      int *dtype_p)
@@ -1277,8 +1280,8 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
 
 	prep_exclude(dir, istate, pathname, basename-pathname);
 
-	if (dir->exclude)
-		return dir->exclude;
+	if (dir->pattern)
+		return dir->pattern;
 
 	return last_exclude_matching_from_lists(dir, istate, pathname, pathlen,
 			basename, dtype_p);
@@ -1292,10 +1295,10 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
 int is_excluded(struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int *dtype_p)
 {
-	struct exclude *exclude =
+	struct path_pattern *pattern =
 		last_exclude_matching(dir, istate, pathname, dtype_p);
-	if (exclude)
-		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
+	if (pattern)
+		return pattern->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
 }
 
diff --git a/dir.h b/dir.h
index 680079bbe3..e8b90fc482 100644
--- a/dir.h
+++ b/dir.h
@@ -16,7 +16,7 @@ struct dir_entry {
 #define EXC_FLAG_MUSTBEDIR 8
 #define EXC_FLAG_NEGATIVE 16
 
-struct exclude {
+struct path_pattern {
 	/*
 	 * This allows callers of last_exclude_matching() etc.
 	 * to determine the origin of the matching pattern.
@@ -54,7 +54,7 @@ struct exclude_list {
 	/* origin of list, e.g. path to filename, or descriptive string */
 	const char *src;
 
-	struct exclude **excludes;
+	struct path_pattern **patterns;
 };
 
 /*
@@ -191,7 +191,7 @@ struct dir_struct {
 	 * matching exclude struct if the directory is excluded.
 	 */
 	struct exclude_stack *exclude_stack;
-	struct exclude *exclude;
+	struct path_pattern *pattern;
 	struct strbuf basebuf;
 
 	/* Enable untracked file cache if set */
@@ -248,7 +248,7 @@ int match_pathname(const char *, int,
 		   const char *, int,
 		   const char *, int, int, unsigned);
 
-struct exclude *last_exclude_matching(struct dir_struct *dir,
+struct path_pattern *last_exclude_matching(struct dir_struct *dir,
 				      struct index_state *istate,
 				      const char *name, int *dtype);
 
-- 
gitgitgadget

