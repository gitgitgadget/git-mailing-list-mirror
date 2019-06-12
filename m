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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ECCA1F609
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbfFLN3l (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39862 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfFLN3k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so25772973edv.6
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GUrHiDnu1aiMHZ6QfK7SMWMtXt4bwYEx0C3v4Wmj39w=;
        b=m5ALERWdmoYUlG+mvhITIeepkeAqeEhMThLs1/JSSahjTqIXfKfxeqmRzcjGhK1nME
         yZU6O4Or9LCmeKeV+ITEHBj0GXn4Tp65eGuob+ES/h+O+ZNh9uH8XjjEKJfSNSy7L0YR
         iuIQv28w0NNEvsFk+QvLLccUdASZm0x3B9h8oZVwQ43MT4NRmogUUcfH1dEka3Prg9AF
         in93T9uPESVctMV199VgorsJMTYl7zlm90h8suTbUlS7tMZvn+PftqGe1xZpECdE5vvl
         Yf2dUbdaavKoPwsVq7/Y1ndxnTTD/kx2WUorUnfAggkse8eA7xmwrKYonG8LyYxX0CgS
         udEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GUrHiDnu1aiMHZ6QfK7SMWMtXt4bwYEx0C3v4Wmj39w=;
        b=TWZt7YvysnrNatx5dH621F0nlJxNUUFj1S3H69LAjPNbulhObS/JMKBzzeFi8oUhD6
         Or5C9J+rB7O2XwHiuxYW3oKJv8QqEca8tXS54pdaNXhsdivo9LcKD92ebsEJOaz0WdgB
         NUW32PTI+t90FQZ3mS75jU4WukRgG3vuDYBBWAwFpvulJEhYREhjgWMtILU/c+B1nLCf
         gKh80CXDoBMV5V/LF8tOaCyNBHjMY3+yk6h7KzEuBHm3vADbCDs32Y0e43UC2ObXYNW+
         bbtR6sIsGewELA3M/7EiXwR0p6qhP7z22mHyuniOn6kYXKUFAorQToNLv9nQKu71rM9c
         tTlw==
X-Gm-Message-State: APjAAAWqFuJkBUbiDHNkgX2nux1dLkSeQAEKe60c+Lomgvl60u7y7+mO
        M2zroiHUjt9f8xgvBxacSMpUynhX
X-Google-Smtp-Source: APXvYqyVTzKzjYCHnsoXxBTN7o27swL0O9qFdggyGHUW56CTOh4dhe9IyyZ7p9fCeZSLlvh7h4ExaA==
X-Received: by 2002:a50:ba28:: with SMTP id g37mr66041589edc.109.1560346178002;
        Wed, 12 Jun 2019 06:29:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17sm2830959eja.58.2019.06.12.06.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:37 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:37 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:24 GMT
Message-Id: <95f66e85b2fe93a218dad4c04c16718d053fb002.1560346173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 02/11] commit-graph: return with errors during write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method uses die() to report failure and
exit when confronted with an unexpected condition. This use of
die() in a library function is incorrect and is now replaced by
error() statements and an int return type. Return zero on success
and a negative value on failure.

Now that we use 'goto cleanup' to jump to the terminal condition
on an error, we have new paths that could lead to uninitialized
values. New initializers are added to correct for this.

The builtins 'commit-graph', 'gc', and 'commit' call these methods,
so update them to check the return value. Test that 'git commit-graph
write' returns a proper error code when hitting a failure condition
in write_commit_graph().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c  | 20 +++++++-------
 builtin/commit.c        |  5 ++--
 builtin/gc.c            |  7 ++---
 commit-graph.c          | 60 ++++++++++++++++++++++++++++-------------
 commit-graph.h          | 16 +++++++----
 t/t5318-commit-graph.sh |  8 ++++++
 6 files changed, 77 insertions(+), 39 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 537fdfd0f0..2a1c4d701f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -141,6 +141,7 @@ static int graph_write(int argc, const char **argv)
 	struct string_list *pack_indexes = NULL;
 	struct string_list *commit_hex = NULL;
 	struct string_list lines;
+	int result = 0;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -168,10 +169,8 @@ static int graph_write(int argc, const char **argv)
 
 	read_replace_refs = 0;
 
-	if (opts.reachable) {
-		write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
-		return 0;
-	}
+	if (opts.reachable)
+		return write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
 
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
@@ -188,14 +187,15 @@ static int graph_write(int argc, const char **argv)
 		UNLEAK(buf);
 	}
 
-	write_commit_graph(opts.obj_dir,
-			   pack_indexes,
-			   commit_hex,
-			   opts.append,
-			   1);
+	if (write_commit_graph(opts.obj_dir,
+			       pack_indexes,
+			       commit_hex,
+			       opts.append,
+			       1))
+		result = 1;
 
 	UNLEAK(lines);
-	return 0;
+	return result;
 }
 
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
diff --git a/builtin/commit.c b/builtin/commit.c
index 2986553d5f..b9ea7222fa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1669,8 +1669,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "new_index file. Check that disk is not full and quota is\n"
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
-	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
-		write_commit_graph_reachable(get_object_directory(), 0, 0);
+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
+	    write_commit_graph_reachable(get_object_directory(), 0, 0))
+		return 1;
 
 	repo_rerere(the_repository, 0);
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
diff --git a/builtin/gc.c b/builtin/gc.c
index 020f725acc..3984addf73 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -664,9 +664,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		clean_pack_garbage();
 	}
 
-	if (gc_write_commit_graph)
-		write_commit_graph_reachable(get_object_directory(), 0,
-					     !quiet && !daemonized);
+	if (gc_write_commit_graph &&
+	    write_commit_graph_reachable(get_object_directory(), 0,
+					 !quiet && !daemonized))
+		return 1;
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
diff --git a/commit-graph.c b/commit-graph.c
index 66865acbd7..1b58d1da14 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -851,27 +851,30 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-void write_commit_graph_reachable(const char *obj_dir, int append,
-				  int report_progress)
+int write_commit_graph_reachable(const char *obj_dir, int append,
+				 int report_progress)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
+	int result;
 
 	for_each_ref(add_ref_to_list, &list);
-	write_commit_graph(obj_dir, NULL, &list, append, report_progress);
+	result = write_commit_graph(obj_dir, NULL, &list,
+				    append, report_progress);
 
 	string_list_clear(&list, 0);
+	return result;
 }
 
-void write_commit_graph(const char *obj_dir,
-			struct string_list *pack_indexes,
-			struct string_list *commit_hex,
-			int append, int report_progress)
+int write_commit_graph(const char *obj_dir,
+		       struct string_list *pack_indexes,
+		       struct string_list *commit_hex,
+		       int append, int report_progress)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
 	struct hashfile *f;
 	uint32_t i, count_distinct = 0;
-	char *graph_name;
+	char *graph_name = NULL;
 	struct lock_file lk = LOCK_INIT;
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
@@ -883,15 +886,17 @@ void write_commit_graph(const char *obj_dir,
 	uint64_t progress_cnt = 0;
 	struct strbuf progress_title = STRBUF_INIT;
 	unsigned long approx_nr_objects;
+	int res = 0;
 
 	if (!commit_graph_compatible(the_repository))
-		return;
+		return 0;
 
 	oids.nr = 0;
 	approx_nr_objects = approximate_object_count();
 	oids.alloc = approx_nr_objects / 32;
 	oids.progress = NULL;
 	oids.progress_done = 0;
+	commits.list = NULL;
 
 	if (append) {
 		prepare_commit_graph_one(the_repository, obj_dir);
@@ -932,10 +937,16 @@ void write_commit_graph(const char *obj_dir,
 			strbuf_setlen(&packname, dirlen);
 			strbuf_addstr(&packname, pack_indexes->items[i].string);
 			p = add_packed_git(packname.buf, packname.len, 1);
-			if (!p)
-				die(_("error adding pack %s"), packname.buf);
-			if (open_pack_index(p))
-				die(_("error opening index for %s"), packname.buf);
+			if (!p) {
+				error(_("error adding pack %s"), packname.buf);
+				res = -1;
+				goto cleanup;
+			}
+			if (open_pack_index(p)) {
+				error(_("error opening index for %s"), packname.buf);
+				res = -1;
+				goto cleanup;
+			}
 			for_each_object_in_pack(p, add_packed_commits, &oids,
 						FOR_EACH_OBJECT_PACK_ORDER);
 			close_pack(p);
@@ -1006,8 +1017,11 @@ void write_commit_graph(const char *obj_dir,
 	}
 	stop_progress(&progress);
 
-	if (count_distinct >= GRAPH_EDGE_LAST_MASK)
-		die(_("the commit graph format cannot write %d commits"), count_distinct);
+	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
+		error(_("the commit graph format cannot write %d commits"), count_distinct);
+		res = -1;
+		goto cleanup;
+	}
 
 	commits.nr = 0;
 	commits.alloc = count_distinct;
@@ -1039,16 +1053,21 @@ void write_commit_graph(const char *obj_dir,
 	num_chunks = num_extra_edges ? 4 : 3;
 	stop_progress(&progress);
 
-	if (commits.nr >= GRAPH_EDGE_LAST_MASK)
-		die(_("too many commits to write graph"));
+	if (commits.nr >= GRAPH_EDGE_LAST_MASK) {
+		error(_("too many commits to write graph"));
+		res = -1;
+		goto cleanup;
+	}
 
 	compute_generation_numbers(&commits, report_progress);
 
 	graph_name = get_commit_graph_filename(obj_dir);
 	if (safe_create_leading_directories(graph_name)) {
 		UNLEAK(graph_name);
-		die_errno(_("unable to create leading directories of %s"),
-			  graph_name);
+		error(_("unable to create leading directories of %s"),
+			graph_name);
+		res = -1;
+		goto cleanup;
 	}
 
 	hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
@@ -1107,9 +1126,12 @@ void write_commit_graph(const char *obj_dir,
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
+cleanup:
 	free(graph_name);
 	free(commits.list);
 	free(oids.list);
+
+	return res;
 }
 
 #define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
diff --git a/commit-graph.h b/commit-graph.h
index 7dfb8c896f..869717ca19 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -65,12 +65,18 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
  */
 int generation_numbers_enabled(struct repository *r);
 
-void write_commit_graph_reachable(const char *obj_dir, int append,
+/*
+ * The write_commit_graph* methods return zero on success
+ * and a negative value on failure. Note that if the repository
+ * is not compatible with the commit-graph feature, then the
+ * methods will return 0 without writing a commit-graph.
+ */
+int write_commit_graph_reachable(const char *obj_dir, int append,
 				  int report_progress);
-void write_commit_graph(const char *obj_dir,
-			struct string_list *pack_indexes,
-			struct string_list *commit_hex,
-			int append, int report_progress);
+int write_commit_graph(const char *obj_dir,
+		       struct string_list *pack_indexes,
+		       struct string_list *commit_hex,
+		       int append, int report_progress);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e80c1cac02..3b6fd0d728 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -23,6 +23,14 @@ test_expect_success 'write graph with no packs' '
 	test_path_is_file info/commit-graph
 '
 
+test_expect_success 'close with correct error on bad input' '
+	cd "$TRASH_DIRECTORY/full" &&
+	echo doesnotexist >in &&
+	{ git commit-graph write --stdin-packs <in 2>stderr; ret=$?; } &&
+	test "$ret" = 1 &&
+	test_i18ngrep "error adding pack" stderr
+'
+
 test_expect_success 'create commits and repack' '
 	cd "$TRASH_DIRECTORY/full" &&
 	for i in $(test_seq 3)
-- 
gitgitgadget

