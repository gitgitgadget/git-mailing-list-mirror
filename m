Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A96A1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfHTPLR (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:11:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47073 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbfHTPLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so12768313wru.13
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QJPb+iKjptWGwlJcvqT4OFWZn8qSw/BkTfJCA4PsK7Y=;
        b=h0ct3kBIlp/Evh4rOxV1KHWztqkNtoA2D50cbcc6HkCAzbebVUa4UU8R7NjQx0GMRq
         c8tWBohXeFGMTK6D7gjtoDq/V90vc2Q172uSlr+vLqGQqMYl+PzsNPH+WJXrzC1U66UB
         j+trh94yV3UAxlRgtgmsE6qXH1eaR2ZEw4gN/CdNm1EhleCahDHurL+dkbAS1uU2uDrR
         pgLRdKjrgv7xOO+g6oawbgm/nrg5KmsDuQf2fwG5LRCZV5osI+BcMnX4JuscHUJ7pRnD
         AeqZcq2m8D57hnaalzC+uIrhkw9Lpv0Ts+oeFh1MYod63qOtC3JZZEZ0kNgZHKyHYqRq
         SY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QJPb+iKjptWGwlJcvqT4OFWZn8qSw/BkTfJCA4PsK7Y=;
        b=dnuhFSJPsBF320KJj2is9rK1Bc7ZzaaTKmXD8EPUFihAeX8R8d9pwHyl6UslBFDxjQ
         haSCPoxRz2T7B1crNsZd4Q6LS3kqfi/7G7VYoJHN5yI20BQ7s4QgbwvABn6nJucUBm92
         UXdLYNPk/YzJ2Pu0KuR6XaAHlUJVSbtESsyBz7LaMLGC31f7Mhx9f39wTK81ivLh6j66
         sovYJZ2gbHIKTMnuzzFhPE9et6UW4kw5xSVD0BmZNFOOI8JcuvC8Cb7FgUe+4YoBtL2x
         p7mXoUJcUIEpy9syD/9pEbfCVd7pq7UpeIPnCb5pCiw+9B+cc3/a7NYw6nASHTRkvoDh
         e2Hg==
X-Gm-Message-State: APjAAAXCyQ0JCrrnFYzMFoczBxJC8D6PmOe0o+xKbDQIWmssim2aDjoH
        oocVW7v3HU67viWr7QaajPsufduk
X-Google-Smtp-Source: APXvYqzQ1ni2XF9usqrmeXu50Y+Z/yQvdgo208obSU+S0iTkPsBg5ESGrRScENsLwbnnkrlVP588nw==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr34690679wrv.299.1566313874293;
        Tue, 20 Aug 2019 08:11:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm266120wmf.27.2019.08.20.08.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:11:13 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:11:13 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 15:11:05 GMT
Message-Id: <568fda2d0395ae82e8b0c43f6e5757d45b50a508.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 9/9] sparse-checkout: init and add in cone mode
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

To make the cone pattern set easy to use, update the behavior of
'git sparse-checkout [init|add]'.

Add '--cone' flag to 'git sparse-checkout init' to set the config
option 'core.sparseCheckout=cone'.

When running 'git sparse-checkout add' in cone mode, a user only
needs to supply a list of recursive folder matches. Git will
automatically add the necessary parent matches for the leading
directories.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 134 +++++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh |  35 ++++++++
 2 files changed, 164 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 77e5235720..0a4e101ddd 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -6,15 +6,22 @@
 #include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout [init|add|list|disable]"),
 	NULL
 };
 
+static const char * const builtin_sparse_checkout_init_usage[] = {
+	N_("git sparse-checkout init [--cone]"),
+	NULL
+};
+
 struct opts_sparse_checkout {
 	const char *subcommand;
 	int read_stdin;
+	int cone;
 } opts;
 
 static char *get_sparse_checkout_filename(void)
@@ -41,6 +48,60 @@ static void write_excludes_to_file(FILE *fp, struct exclude_list *el)
 	}
 }
 
+static void write_cone_to_file(FILE *fp, struct exclude_list *el)
+{
+	int i;
+	struct exclude_entry *entry;
+	struct hashmap_iter iter;
+	struct string_list sl = STRING_LIST_INIT_DUP;
+
+	hashmap_iter_init(&el->parent_hashmap, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		char *pattern = xstrdup(entry->pattern);
+		char *converted = pattern;
+		if (pattern[0] == '/')
+			converted++;
+		if (pattern[entry->patternlen - 1] == '/')
+			pattern[entry->patternlen - 1] = 0;
+		string_list_insert(&sl, converted);
+		free(pattern);
+	}
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = sl.items[i].string;
+
+		if (!strcmp(pattern, ""))
+			fprintf(fp, "/*\n!/*/*\n");
+		else
+			fprintf(fp, "/%s/*\n!/%s/*/*\n", pattern, pattern);
+	}
+
+	string_list_clear(&sl, 0);
+
+	hashmap_iter_init(&el->recursive_hashmap, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		char *pattern = xstrdup(entry->pattern);
+		char *converted = pattern;
+		if (pattern[0] == '/')
+			converted++;
+		if (pattern[entry->patternlen - 1] == '/')
+			pattern[entry->patternlen - 1] = 0;
+		string_list_insert(&sl, converted);
+		free(pattern);
+	}
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = sl.items[i].string;
+		fprintf(fp, "/%s/*\n", pattern);
+	}
+}
+
 static int sparse_checkout_list(int argc, const char **argv)
 {
 	struct exclude_list el;
@@ -141,8 +202,21 @@ static int sparse_checkout_init(int argc, const char **argv)
 	char *sparse_filename;
 	FILE *fp;
 	int res;
+	enum sparse_checkout_mode mode;
 
-	if (sc_set_config(SPARSE_CHECKOUT_FULL))
+	static struct option builtin_sparse_checkout_init_options[] = {
+		OPT_BOOL(0, "cone", &opts.cone,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_sparse_checkout_init_options,
+			     builtin_sparse_checkout_init_usage, 0);
+
+	mode = opts.cone ? SPARSE_CHECKOUT_CONE : SPARSE_CHECKOUT_FULL;
+
+	if (sc_set_config(mode))
 		return 1;
 
 	memset(&el, 0, sizeof(el));
@@ -183,6 +257,34 @@ static int sparse_checkout_init(int argc, const char **argv)
 	return sc_read_tree();
 }
 
+static void insert_recursive_pattern(struct exclude_list *el, struct strbuf *path)
+{
+	struct exclude_entry *e = xmalloc(sizeof(struct exclude_entry));
+	e->patternlen = path->len;
+	e->pattern = strbuf_detach(path, NULL);
+	hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
+
+	hashmap_add(&el->recursive_hashmap, e);
+
+	while (e->patternlen) {
+		char *slash = strrchr(e->pattern, '/');
+		char *oldpattern = e->pattern;
+		size_t newlen;
+
+		if (!slash)
+			break;
+
+		newlen = slash - e->pattern;
+		e = xmalloc(sizeof(struct exclude_entry));
+		e->patternlen = newlen;
+		e->pattern = xstrndup(oldpattern, newlen);
+		hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
+
+		if (!hashmap_get(&el->parent_hashmap, e, NULL))
+			hashmap_add(&el->parent_hashmap, e);
+	}
+}
+
 static int sparse_checkout_add(int argc, const char **argv)
 {
 	struct exclude_list el;
@@ -196,11 +298,33 @@ static int sparse_checkout_add(int argc, const char **argv)
 	add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
 
 	fp = fopen(sparse_filename, "w");
-	write_excludes_to_file(fp, &el);
 
-	while (!strbuf_getline(&line, stdin)) {
-		strbuf_trim(&line);
-		fprintf(fp, "%s\n", line.buf);
+	if (core_sparse_checkout == SPARSE_CHECKOUT_FULL) {
+		write_excludes_to_file(fp, &el);
+
+		while (!strbuf_getline(&line, stdin)) {
+			strbuf_trim(&line);
+			fprintf(fp, "%s\n", line.buf);
+		}
+	} else if (core_sparse_checkout == SPARSE_CHECKOUT_CONE) {
+		while (!strbuf_getline(&line, stdin)) {
+			strbuf_trim(&line);
+
+			strbuf_trim_trailing_dir_sep(&line);
+
+			if (!line.len)
+				continue;
+
+			if (line.buf[0] == '/')
+				strbuf_remove(&line, 0, 1);
+
+			if (!line.len)
+				continue;
+
+			insert_recursive_pattern(&el, &line);
+		}
+
+		write_cone_to_file(fp, &el);
 	}
 
 	fclose(fp);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 60f10864a1..3412bafdff 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -157,4 +157,39 @@ test_expect_success 'sparse-checkout disable' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: init and add' '
+	git -C repo sparse-checkout init --cone &&
+	git -C repo config --list >config &&
+	test_i18ngrep "core.sparsecheckout=cone" config &&
+	ls repo >dir  &&
+	echo a >expect &&
+	test_cmp expect dir &&
+	echo deep/deeper1/deepest | git -C repo sparse-checkout add &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deep
+	EOF
+	ls repo/deep >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deeper1
+	EOF
+	ls repo/deep/deeper1 >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deepest
+	EOF
+	test_cmp expect dir &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/*
+		/deep/*
+		!/deep/*/*
+		/deep/deeper1/*
+		!/deep/deeper1/*/*
+		/deep/deeper1/deepest/*
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout
+'
 test_done
\ No newline at end of file
-- 
gitgitgadget
