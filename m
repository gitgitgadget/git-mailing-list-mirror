Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FBA1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfJUN4n (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38740 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJUN4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so2863661wrq.5
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mO+or5JG+DSecj8vOEGlNCblM9TvT5SCVngeLbH9uOo=;
        b=k/R3ELZHa4emUUetMIo3JaSkUAuUdSV++2N2t/worEtWvK0laBXicbzFOe9DT4Ovu+
         1R0s+6ZSHOwwP1CK6U7Frmrsx9AZazag7HbsqzwnYHcnxGHGohTzuBX+1qEIAubv0vVd
         gio7AYx5Jjg/oR0edx+PTiKImqCuTlBVru+AAhqk1uiEBiDJASsk/q4hhxijlCwqHyFj
         37iHzKccfNa7O9KjFyjc+WGW4VugY2qJyRepaKnCVBThkV4EkQn+TV//ht3Z+35pKlem
         n1sam/Z0OnIlYg/LhoSX3f5ni7bAQRjjNLAcV/oTJZsxx7HOra8Z7rC8ZTgz2ONvGFtP
         3X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mO+or5JG+DSecj8vOEGlNCblM9TvT5SCVngeLbH9uOo=;
        b=hkJmC+kb1MbrnhW4ubeMN33aS9y6dWWU1K5h90c4O/OuQ5+UHlzj1pktIC0gdN56NP
         EEslNhz50t8PCtHOmiQEeP86J35P3GLrMo2VJF2n7sTsLcUdZEsPyIPFPcb1V6U3mheN
         tLz3Jamg5Nn4EFpfFdb0Z7tT+OMWhETpMRetKyW4EZFsZMqPUv7kr9Y58JrPRMfWX9Ys
         VpfGveGLqJF5Vp4wnkddTKPjtK3ww002z/BDhj+IIgegPSPH9N0H2ZZ5u5SyXYERa5il
         XM1PRzyC5dW8j9y89FXlOTf8YItGHvmxNLPFh6iRh38LpAELYZOdRF8VKs1ilwF5rv8R
         s+oA==
X-Gm-Message-State: APjAAAVY825voFMo3BQzM5NoBjxQF9NiBLxcGvMprJZtZm6Xxo/HuiP4
        gFXgvHv6UZRO4kWrfjTyHl0cjXWf
X-Google-Smtp-Source: APXvYqylKRtp4aIF/cxXMAdp4midmFrJA6pS6HuyO2wfHyr0rlSQzexSpvfRH0GuyhASlwlazNabeA==
X-Received: by 2002:adf:f004:: with SMTP id j4mr21589039wro.68.1571666196814;
        Mon, 21 Oct 2019 06:56:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm1440345wmj.42.2019.10.21.06.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:36 -0700 (PDT)
Message-Id: <0258ee80265f5f27a7de9b81eaf166648b4511d4.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:19 +0000
Subject: [PATCH v5 10/17] sparse-checkout: init and set in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To make the cone pattern set easy to use, update the behavior of
'git sparse-checkout [init|set]'.

Add '--cone' flag to 'git sparse-checkout init' to set the config
option 'core.sparseCheckoutCone=true'.

When running 'git sparse-checkout set' in cone mode, a user only
needs to supply a list of recursive folder matches. Git will
automatically add the necessary parent matches for the leading
directories.

When testing 'git sparse-checkout set' in cone mode, check the
error stream to ensure we do not see any errors. Specifically,
we want to avoid the warning that the patterns do not match
the cone-mode patterns.

Helped-by: Eric Wong <e@80x24.org>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 159 +++++++++++++++++++++++++++--
 dir.c                              |   8 +-
 dir.h                              |   4 +
 t/t1091-sparse-checkout-builtin.sh |  51 +++++++++
 4 files changed, 208 insertions(+), 14 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 9fdcc6c4ef..6c3bf68c89 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -6,6 +6,7 @@
 #include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout (init|list|set|disable) <options>"),
@@ -77,11 +78,13 @@ static int update_working_directory(void)
 enum sparse_checkout_mode {
 	MODE_NO_PATTERNS = 0,
 	MODE_ALL_PATTERNS = 1,
+	MODE_CONE_PATTERNS = 2,
 };
 
 static int sc_set_config(enum sparse_checkout_mode mode)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct argv_array cone_argv = ARGV_ARRAY_INIT;
 
 	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
 		error(_("failed to set extensions.worktreeConfig setting"));
@@ -100,9 +103,31 @@ static int sc_set_config(enum sparse_checkout_mode mode)
 		return 1;
 	}
 
+	argv_array_pushl(&cone_argv, "config", "--worktree",
+			 "core.sparseCheckoutCone", NULL);
+
+	if (mode == MODE_CONE_PATTERNS)
+		argv_array_push(&cone_argv, "true");
+	else
+		argv_array_push(&cone_argv, "false");
+
+	if (run_command_v_opt(cone_argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to enable core.sparseCheckoutCone"));
+		return 1;
+	}
+
 	return 0;
 }
 
+static char const * const builtin_sparse_checkout_init_usage[] = {
+	N_("git sparse-checkout init [--cone]"),
+	NULL
+};
+
+static struct sparse_checkout_init_opts {
+	int cone_mode;
+} init_opts;
+
 static int sparse_checkout_init(int argc, const char **argv)
 {
 	struct pattern_list pl;
@@ -110,8 +135,21 @@ static int sparse_checkout_init(int argc, const char **argv)
 	FILE *fp;
 	int res;
 	struct object_id oid;
+	int mode;
 
-	if (sc_set_config(MODE_ALL_PATTERNS))
+	static struct option builtin_sparse_checkout_init_options[] = {
+		OPT_BOOL(0, "cone", &init_opts.cone_mode,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_sparse_checkout_init_options,
+			     builtin_sparse_checkout_init_usage, 0);
+
+	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
+
+	if (sc_set_config(mode))
 		return 1;
 
 	memset(&pl, 0, sizeof(pl));
@@ -140,6 +178,70 @@ static int sparse_checkout_init(int argc, const char **argv)
 	return update_working_directory();
 }
 
+static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
+{
+	struct pattern_entry *e = xmalloc(sizeof(*e));
+	e->patternlen = path->len;
+	e->pattern = strbuf_detach(path, NULL);
+	hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
+
+	hashmap_add(&pl->recursive_hashmap, &e->ent);
+
+	while (e->patternlen) {
+		char *slash = strrchr(e->pattern, '/');
+		char *oldpattern = e->pattern;
+		size_t newlen;
+
+		if (slash == e->pattern)
+			break;
+
+		newlen = slash - e->pattern;
+		e = xmalloc(sizeof(struct pattern_entry));
+		e->patternlen = newlen;
+		e->pattern = xstrndup(oldpattern, newlen);
+		hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
+
+		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
+			hashmap_add(&pl->parent_hashmap, &e->ent);
+	}
+}
+
+static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
+{
+	int i;
+	struct pattern_entry *pe;
+	struct hashmap_iter iter;
+	struct string_list sl = STRING_LIST_INIT_DUP;
+
+	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent)
+		string_list_insert(&sl, pe->pattern);
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	fprintf(fp, "/*\n!/*/\n");
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = sl.items[i].string;
+
+		if (strlen(pattern))
+			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
+	}
+
+	string_list_clear(&sl, 0);
+
+	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent)
+		string_list_insert(&sl, pe->pattern);
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = sl.items[i].string;
+		fprintf(fp, "%s/\n", pattern);
+	}
+}
+
 static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
@@ -147,13 +249,33 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
 	sparse_filename = get_sparse_checkout_filename();
 	fp = fopen(sparse_filename, "w");
-	write_patterns_to_file(fp, pl);
+
+	if (core_sparse_checkout_cone)
+		write_cone_to_file(fp, pl);
+	else
+		write_patterns_to_file(fp, pl);
+
 	fclose(fp);
 	free(sparse_filename);
 
 	return update_working_directory();
 }
 
+static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
+{
+	strbuf_trim(line);
+
+	strbuf_trim_trailing_dir_sep(line);
+
+	if (!line->len)
+		return;
+
+	if (line->buf[0] != '/')
+		strbuf_insert(line, 0, "/", 1);
+
+	insert_recursive_pattern(pl, line);
+}
+
 static char const * const builtin_sparse_checkout_set_usage[] = {
 	N_("git sparse-checkout set [--stdin|<patterns>]"),
 	NULL
@@ -184,17 +306,34 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	if (set_opts.use_stdin) {
+	if (core_sparse_checkout_cone) {
 		struct strbuf line = STRBUF_INIT;
-
-		while (!strbuf_getline(&line, stdin)) {
-			size_t len;
-			char *buf = strbuf_detach(&line, &len);
-			add_pattern(buf, empty_base, 0, &pl, 0);
+		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
+		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
+
+		if (set_opts.use_stdin) {
+			while (!strbuf_getline(&line, stdin))
+				strbuf_to_cone_pattern(&line, &pl);
+		} else {
+			for (i = 0; i < argc; i++) {
+				strbuf_setlen(&line, 0);
+				strbuf_addstr(&line, argv[i]);
+				strbuf_to_cone_pattern(&line, &pl);
+			}
 		}
 	} else {
-		for (i = 0; i < argc; i++)
-			add_pattern(argv[i], empty_base, 0, &pl, 0);
+		if (set_opts.use_stdin) {
+			struct strbuf line = STRBUF_INIT;
+
+			while (!strbuf_getline(&line, stdin)) {
+				size_t len;
+				char *buf = strbuf_detach(&line, &len);
+				add_pattern(buf, empty_base, 0, &pl, 0);
+			}
+		} else {
+			for (i = 0; i < argc; i++)
+				add_pattern(argv[i], empty_base, 0, &pl, 0);
+		}
 	}
 
 	if (!core_apply_sparse_checkout) {
diff --git a/dir.c b/dir.c
index dfabf9982f..35c1ca9e24 100644
--- a/dir.c
+++ b/dir.c
@@ -611,10 +611,10 @@ void parse_path_pattern(const char **pattern,
 	*patternlen = len;
 }
 
-static int pl_hashmap_cmp(const void *unused_cmp_data,
-			  const struct hashmap_entry *a,
-			  const struct hashmap_entry *b,
-			  const void *key)
+int pl_hashmap_cmp(const void *unused_cmp_data,
+		   const struct hashmap_entry *a,
+		   const struct hashmap_entry *b,
+		   const void *key)
 {
 	const struct pattern_entry *ee1 =
 			container_of(a, struct pattern_entry, ent);
diff --git a/dir.h b/dir.h
index f8edbca72b..8e232085cd 100644
--- a/dir.h
+++ b/dir.h
@@ -299,6 +299,10 @@ int is_excluded(struct dir_struct *dir,
 		struct index_state *istate,
 		const char *name, int *dtype);
 
+int pl_hashmap_cmp(const void *unused_cmp_data,
+		   const struct hashmap_entry *a,
+		   const struct hashmap_entry *b,
+		   const void *key);
 int hashmap_contains_parent(struct hashmap *map,
 			    const char *path,
 			    struct strbuf *buffer);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 9907278fc1..ae99803d40 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -186,4 +186,55 @@ test_expect_success 'sparse-checkout disable' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: init and set' '
+	git -C repo sparse-checkout init --cone &&
+	git -C repo config --list >config &&
+	test_i18ngrep "core.sparsecheckoutcone=true" config &&
+	ls repo >dir  &&
+	echo a >expect &&
+	test_cmp expect dir &&
+	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
+	test_line_count = 0 err &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deep
+	EOF
+	test_cmp expect dir &&
+	ls repo/deep >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deeper1
+	EOF
+	test_cmp expect dir &&
+	ls repo/deep/deeper1 >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deepest
+	EOF
+	test_cmp expect dir &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/deep/
+		!/deep/*/
+		/deep/deeper1/
+		!/deep/deeper1/*/
+		/deep/deeper1/deepest/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout set --stdin 2>err <<-EOF &&
+		folder1
+		folder2
+	EOF
+	test_line_count = 0 err &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	ls repo >dir &&
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget

