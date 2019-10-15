Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31B61F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbfJON4X (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38349 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732291AbfJON4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id y18so14551000wrn.5
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bA+FnnxD18F1dqqs8AkTZa0+h8IvOqVt9b3iR1Tjwo8=;
        b=g8QRotIvvZhgCldML8h/Wof8LfNiLD5RYZEWoFmtPxBijEzDlaSn5ia/iy0+aHM3VS
         DUfvbBa7e/+ahozyQQHjEorw8NDh3B4UcBkOuEYAoLD18CwT0faxFck/1PATjY7j97bS
         2eetfa+3dtyallM441YTmcI/xEofjaw8Xz9HuycyWQv5c580XT1hp96Q7RGwzczMs6Mu
         dYRt0Ce1Ji+kESSzgwbiRY4+PWSv277WnZyGu5+KtIddv0nFk+1OvA6pWErEru/7reNI
         OLYIZXlk03z5fpI0rnukcaQLz7tVMxM6mX2299krfSHmxuM6dJTw63WCs9EKv18z0nEK
         Oulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bA+FnnxD18F1dqqs8AkTZa0+h8IvOqVt9b3iR1Tjwo8=;
        b=rX3x/Jo0bJx1Xt0hr/Ky9IXpxoKwCPGKMWDe7uoTAQSknv+opCrOLUpyZaufwPmnCA
         GSnvRSv6QtspX2L9HHlh2pmFin84QKMfL3M+j2IbJzb2OqyUqa/WaCZdduld618iKhXl
         qUxvfknD+//h4GJ/LCu1bsUd5+kFBfyYnMP1GAhNqbPxXGd/Z3XPcomxfBKN2o538Azk
         C533fSrM5g5orulRZYhu2Bd4O3fR8fGIhuwMMGspmO8OlM3ZhF72OBHKjbDFp/BG9be/
         ZA4yIq+kbuDToEqYYRCnmJI6CvMzooMowbA2j/y4MIaLUvgOhBkBOp/lD8TFVpiBR/gb
         8aHw==
X-Gm-Message-State: APjAAAUssRqC702snWXFg8tEEWMf7ZmP3ESi++UXTfDbxaB5IZCt3inE
        wdMNBARgI1//LftuVbpgPRIVBdWS
X-Google-Smtp-Source: APXvYqwRTByZ4IDjwcXiDXt57Wr1D+Z7aG8EJhh+KGnDl9nqHLPY7RaeqCS4yAHSWXZ4f0jL/Tq+9A==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr21548356wrq.35.1571147776029;
        Tue, 15 Oct 2019 06:56:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 36sm28684899wrp.30.2019.10.15.06.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:15 -0700 (PDT)
Message-Id: <2ea3d8819b35d8c5f3bce93c585614baa82ac57b.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:57 +0000
Subject: [PATCH v4 10/17] sparse-checkout: init and set in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
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
index 78a80ce119..95d9a90b84 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -6,6 +6,7 @@
 #include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout [init|list|set|disable] <options>"),
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
@@ -152,13 +254,33 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
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
@@ -188,17 +310,34 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
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
 
 	result = write_patterns_and_update(&pl);
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
index b0d5aeb33a..3a4c0e6f5d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -185,4 +185,55 @@ test_expect_success 'sparse-checkout disable' '
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

