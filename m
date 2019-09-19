Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19BD1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbfISOnV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54505 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389040AbfISOnT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so4880398wmp.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P73PzyKQxO7LFzalWzLbks2iJjAj49RGhuHcshMsQfo=;
        b=IdZLXi6YyAxn5F52cgmt9s5O/Y6ex70p7Ov7ZP6WQzlj6y5AK0PyiXUANXNVgI0tLf
         N1S9C+9GKPFL4J9DUGSTSKnTPk+jmdZTAoUaLzwFlu8fhiLbvGTsNc5+bZy+kC1/bmZ7
         qgmXblwopdxRhdXnWY3RuNAp2e+OdwiTMMejIiIrn7hv4/layuDAtOjACXFO8oYyCXrK
         uN/YI64wBQBWe+nvLxiCGdLZ+IxQn/03b14TCQhQAJRdt58BBrPMFxZkZolfdAWD7Lf1
         CVPUkE23Vc/8P3+y0U4SLO1SEpK0JBm0pNvYPT3wjF3dbr8ygLn8l1C3b+4d39XnfQqT
         qWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P73PzyKQxO7LFzalWzLbks2iJjAj49RGhuHcshMsQfo=;
        b=P2KyoUApnkqbKR+qnlg3ZxqgshAJrV6zrOxLGtRVbBUV7FhccWzHgYOE2mj69TbBge
         UwGFYs/qzfb1vs67mGWoiz+LkFX7pcLQrHdePG5TqEaQlk4vsTRK5wziWIPiESRBXElE
         ZOBEp/AK0zdcCI01+tz+s2eQoo98PfNHSfxbdY0diiHPOa6ZL9Wzry/wPPu9gE1u8qp4
         a9TZePOUcN9ZJeZr5kDNfPQNKE70yM4d/woilS89ZtXmzHWBsblU5Pv4ZUOgjpTtTXaf
         Q3wDZ2gSWPlWlkVNscO7vSlsrL9JzMPw+WOUtSCMUmfoGJnp8Sz5JqRm6eVttIQIwQ7L
         corg==
X-Gm-Message-State: APjAAAXNdP2UZaOD6KYexYip0/FN2DG3R34BKaMb9CmLJFz1yD5wgd2r
        7IgbqAun8dPBp7eJKKAb592ZBL2X
X-Google-Smtp-Source: APXvYqxaxE2vm+L4jhY4tWO3t8LvtboNtmPahLz2hSHNxQ36kqdXHNKCyJ7Mo28p9WjcTOKaggm78w==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr3481693wmc.0.1568904197368;
        Thu, 19 Sep 2019 07:43:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k26sm2306474wmj.33.2019.09.19.07.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:16 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:16 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:43:06 GMT
Message-Id: <95a3285bc6021daa236d98d7e1bbdc5c45fc73b0.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/11] sparse-checkout: use hashmaps for cone patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The parent and recursive patterns allowed by the "cone mode"
option in sparse-checkout are restrictive enough that we
can avoid using the regex parsing. Everything is based on
prefix matches, so we can use hashsets to store the prefixes
from the sparse-checkout file. When checking a path, we can
strip path entries from the path and check the hashset for
an exact match.

As a test, I created a cone-mode sparse-checkout file for the
Linux repository that actually includes every file. This was
constructed by taking every folder in the Linux repo and creating
the pattern pairs here:

	/$folder/
	!/$folder/*/

This resulted in a sparse-checkout file sith 8,296 patterns.
Running 'git read-tree -mu HEAD' on this file had the following
performance:

	core.sparseCheckout=false: 0.21 s (0.00 s)
	 core.sparseCheckout=true: 3.75 s (3.50 s)
	 core.sparseCheckout=cone: 0.23 s (0.01 s)

The times in parentheses above correspond to the time spent
in the first clear_ce_flags() call, according to the trace2
performance traces.

While this example is contrived, it demonstrates how these
patterns can slow the sparse-checkout feature.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 173 +++++++++++++++++++++++++++--
 dir.h                              |  27 +++++
 t/t1091-sparse-checkout-builtin.sh |  11 +-
 3 files changed, 202 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 34972abdaf..4fc57187e9 100644
--- a/dir.c
+++ b/dir.c
@@ -599,6 +599,109 @@ void parse_path_pattern(const char **pattern,
 	*patternlen = len;
 }
 
+static int pl_hashmap_cmp(const void *unused_cmp_data,
+			  const void *a, const void *b, const void *key)
+{
+	const struct pattern_entry *ee1 = (const struct pattern_entry *)a;
+	const struct pattern_entry *ee2 = (const struct pattern_entry *)b;
+
+	size_t min_len = ee1->patternlen <= ee2->patternlen
+			 ? ee1->patternlen
+			 : ee2->patternlen;
+
+	return strncmp(ee1->pattern, ee2->pattern, min_len);
+}
+
+static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern *given)
+{
+	struct pattern_entry *translated;
+	char *truncated;
+	char *data = NULL;
+
+	if (!pl->use_cone_patterns)
+		return;
+
+	if (!strcmp(given->pattern, "/*"))
+		return;
+
+	if (given->patternlen > 2 &&
+	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
+		if (!(given->flags & PATTERN_FLAG_NEGATIVE)) {
+			/* Not a cone pattern. */
+			pl->use_cone_patterns = 0;
+			warning(_("unrecognized pattern: '%s'"), given->pattern);
+			goto clear_hashmaps;
+		}
+
+		truncated = xstrdup(given->pattern);
+		truncated[given->patternlen - 2] = 0;
+
+		translated = xmalloc(sizeof(struct pattern_entry));
+		translated->pattern = truncated;
+		translated->patternlen = given->patternlen - 2;
+		hashmap_entry_init(translated,
+				   memhash(translated->pattern, translated->patternlen));
+
+		if (!hashmap_get(&pl->recursive_hashmap, translated, NULL)) {
+			/* We did not see the "parent" included */
+			warning(_("unrecognized negative pattern: '%s'"),
+				given->pattern);
+			free(truncated);
+			free(translated);
+			goto clear_hashmaps;
+		}
+
+		hashmap_add(&pl->parent_hashmap, translated);
+		hashmap_remove(&pl->recursive_hashmap, translated, &data);
+		free(data);
+		return;
+	}
+
+	if (given->flags & PATTERN_FLAG_NEGATIVE) {
+		warning(_("unrecognized negative pattern: '%s'"),
+			given->pattern);
+		goto clear_hashmaps;
+	}
+
+	translated = xmalloc(sizeof(struct pattern_entry));
+
+	translated->pattern = xstrdup(given->pattern);
+	translated->patternlen = given->patternlen;
+	hashmap_entry_init(translated,
+			   memhash(translated->pattern, translated->patternlen));
+
+	hashmap_add(&pl->recursive_hashmap, translated);
+
+	if (hashmap_get(&pl->parent_hashmap, translated, NULL)) {
+		/* we already included this at the parent level */
+		warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
+			given->pattern);
+		hashmap_remove(&pl->parent_hashmap, translated, &data);
+		free(data);
+		free(translated);
+	}
+
+	return;
+
+clear_hashmaps:
+	warning(_("disabling cone pattern matching"));
+	hashmap_free(&pl->parent_hashmap, 1);
+	hashmap_free(&pl->recursive_hashmap, 1);
+	pl->use_cone_patterns = 0;
+}
+
+static int hashmap_contains_path(struct hashmap *map,
+				 struct strbuf *pattern)
+{
+	struct pattern_entry p;
+
+	/* Check straight mapping */
+	p.pattern = pattern->buf;
+	p.patternlen = pattern->len;
+	hashmap_entry_init(&p, memhash(p.pattern, p.patternlen));
+	return !!hashmap_get(map, &p, NULL);
+}
+
 void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos)
 {
@@ -623,6 +726,8 @@ void add_pattern(const char *string, const char *base,
 	ALLOC_GROW(pl->patterns, pl->nr + 1, pl->alloc);
 	pl->patterns[pl->nr++] = pattern;
 	pattern->pl = pl;
+
+	add_pattern_to_hashsets(pl, pattern);
 }
 
 static int read_skip_worktree_file_from_index(const struct index_state *istate,
@@ -848,6 +953,10 @@ static int add_patterns_from_buffer(char *buf, size_t size,
 	int i, lineno = 1;
 	char *entry;
 
+	pl->use_cone_patterns = core_sparse_checkout_cone;
+	hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
+	hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
+
 	pl->filebuf = buf;
 
 	if (skip_utf8_bom(&buf, size))
@@ -1084,16 +1193,64 @@ enum pattern_match_result path_matches_pattern_list(
 				struct index_state *istate)
 {
 	struct path_pattern *pattern;
-	pattern = last_matching_pattern_from_list(pathname, pathlen, basename,
-						  dtype, pl, istate);
-	if (pattern) {
-		if (pattern->flags & PATTERN_FLAG_NEGATIVE)
-			return NOT_MATCHED;
-		else
-			return MATCHED;
+	struct strbuf parent_pathname = STRBUF_INIT;
+	int result = NOT_MATCHED;
+	const char *slash_pos;
+
+	if (!pl->use_cone_patterns) {
+		pattern = last_matching_pattern_from_list(pathname, pathlen, basename,
+							dtype, pl, istate);
+		if (pattern) {
+			if (pattern->flags & PATTERN_FLAG_NEGATIVE)
+				return NOT_MATCHED;
+			else
+				return MATCHED;
+		}
+
+		return UNDECIDED;
 	}
 
-	return UNDECIDED;
+	strbuf_addch(&parent_pathname, '/');
+	strbuf_add(&parent_pathname, pathname, pathlen);
+
+	if (hashmap_contains_path(&pl->recursive_hashmap,
+					&parent_pathname)) {
+		result = MATCHED;
+		goto done;
+	}
+
+	slash_pos = strrchr(parent_pathname.buf, '/');
+
+	if (slash_pos == parent_pathname.buf) {
+		/* include every file in root */
+		result = MATCHED;
+		goto done;
+	}
+
+	strbuf_setlen(&parent_pathname, slash_pos - parent_pathname.buf);
+
+	if (hashmap_contains_path(&pl->parent_hashmap, &parent_pathname)) {
+		result = MATCHED;
+		goto done;
+	}
+
+	while (parent_pathname.len) {
+		if (hashmap_contains_path(&pl->recursive_hashmap,
+					  &parent_pathname)) {
+			result = UNDECIDED;
+			goto done;
+		}
+
+		slash_pos = strrchr(parent_pathname.buf, '/');
+		if (slash_pos == parent_pathname.buf)
+			break;
+
+		strbuf_setlen(&parent_pathname, slash_pos - parent_pathname.buf);
+	}
+
+done:
+	strbuf_release(&parent_pathname);
+	return result;
 }
 
 static struct path_pattern *last_matching_pattern_from_lists(
diff --git a/dir.h b/dir.h
index 608696c958..bbd5bd1cc9 100644
--- a/dir.h
+++ b/dir.h
@@ -4,6 +4,7 @@
 /* See Documentation/technical/api-directory-listing.txt */
 
 #include "cache.h"
+#include "hashmap.h"
 #include "strbuf.h"
 
 struct dir_entry {
@@ -37,6 +38,13 @@ struct path_pattern {
 	int srcpos;
 };
 
+/* used for hashmaps for cone patterns */
+struct pattern_entry {
+	struct hashmap_entry ent;
+	char *pattern;
+	size_t patternlen;
+};
+
 /*
  * Each excludes file will be parsed into a fresh exclude_list which
  * is appended to the relevant exclude_list_group (either EXC_DIRS or
@@ -55,6 +63,25 @@ struct pattern_list {
 	const char *src;
 
 	struct path_pattern **patterns;
+
+	/*
+	 * While scanning the excludes, we attempt to match the patterns
+	 * with a more restricted set that allows us to use hashsets for
+	 * matching logic, which is faster than the linear lookup in the
+	 * excludes array above. If non-zero, that check succeeded.
+	 */
+	unsigned use_cone_patterns;
+
+	/*
+	 * Stores paths where everything starting with those paths
+	 * is included.
+	 */
+	struct hashmap recursive_hashmap;
+
+	/*
+	 * Used to check single-level parents of blobs.
+	 */
+	struct hashmap parent_hashmap;
 };
 
 /*
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 9b089c98c4..f726205d21 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -143,7 +143,8 @@ test_expect_success 'set sparse-checkout using --stdin' '
 test_expect_success 'cone mode: match patterns' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	rm -rf repo/a repo/folder1 repo/folder2 &&
-	git -C repo read-tree -mu HEAD &&
+	git -C repo read-tree -mu HEAD 2>err &&
+	test_i18ngrep ! "disabling cone patterns" err &&
 	git -C repo reset --hard &&
 	ls repo >dir  &&
 	cat >expect <<-EOF &&
@@ -154,6 +155,14 @@ test_expect_success 'cone mode: match patterns' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: warn on bad pattern' '
+	test_when_finished mv sparse-checkout repo/.git/info/ &&
+	cp repo/.git/info/sparse-checkout . &&
+	echo "!/deep/deeper/*" >>repo/.git/info/sparse-checkout &&
+	git -C repo read-tree -mu HEAD 2>err &&
+	test_i18ngrep "unrecognized negative pattern" err
+'
+
 test_expect_success 'sparse-checkout disable' '
 	git -C repo sparse-checkout disable &&
 	test_path_is_missing repo/.git/info/sparse-checkout &&
-- 
gitgitgadget

