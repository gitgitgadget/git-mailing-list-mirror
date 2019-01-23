Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227491F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAWV7U (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:59:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40367 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAWV7T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:59:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so2952344edr.7
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J+I/sPsiAe8pwAU/XMKnP57lQQiWdAm7KX3gL17IkpQ=;
        b=j3K+30QOy1ipe6xd6JRjZ7FFcgmyEn4LlLmXyLFMv8XI5/z1qE8LYRTXZvXwh9GyZx
         /q5a+yBolHgkc28g0ce+PntPFux+b2AOJGOSeA3nBfqptABs6YKCjiPgSNxfx2S3Bxup
         mchvD55m+Nkta/q+3HTJgNNOoxaP7uyfmDaCb718gDMu8s3fM4yDB5hJDBU0giC8ezhs
         deQ0y81ks0EJp35mH90+1ITQE/XiTJh6Dj+9PaRkRIrtbNjCgay4W6X8n2vRAMR39RxL
         7s2VehNg7BpAPoK+l72nm+c09EEfFtOXdNaQP4EH51HXBp521335g6tMTJBeLvD1iRE8
         v5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J+I/sPsiAe8pwAU/XMKnP57lQQiWdAm7KX3gL17IkpQ=;
        b=Cv2bE0Su8P/ZUot2GPHHRUq91cRf3jkEkMa9BbUTxC681woTtCybiAVvUJnEDc2DdH
         NSy/ofV3P1J+UPM+xp31cWZUcrUFoBZElghfbxTnajaxY/+TYP1EJB1KmyHPcCacYEBR
         Y8IqxonR2ofjaQ11YIdd/pYJg+Tx1O/l73Xbr8E2XAgutMhEDWlw1K5nTsKt/lmwWDI7
         OyZFXTSoQo+Os2jMtwGUP2sj9yU4Z6W/l72Xg15QAZKojwlFCv1pWR0iqXL2ta50M3J0
         6zuksnryq/MR3JnbZBCwg1BCI6+sPKc+sMiO7fA3r5AciI7Gik0Mv4pAZ8QOoeGJPSBk
         7SZQ==
X-Gm-Message-State: AJcUukdYSAUz26p3bCDAMJZI0ga3TwcKw5R2q06Lo2UmT9dNYoIIbrss
        YAgXf+CQjPpNkkeF8i6c5O9FjP54
X-Google-Smtp-Source: ALg8bN7TTWUt8d6Z8IN2v5ovwm1V6oRY/LGiPszQCHNrWX6F0QikhR7magUJlB3CVBhxmOaTtdYuUw==
X-Received: by 2002:a17:906:a4d5:: with SMTP id cc21mr3794390ejb.12.1548280756860;
        Wed, 23 Jan 2019 13:59:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d56sm10757756ede.76.2019.01.23.13.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 13:59:16 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:59:16 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 21:59:09 GMT
Message-Id: <43a40d0c43a1402a047b8c329ae8448643bedcce.1548280753.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.git.gitgitgadget@gmail.com>
References: <pull.112.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/6] commit-graph: collapse parameters into flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() and write_commit_graph_reachable() methods
currently take two boolean parameters: 'append' and 'report_progress'.
We will soon expand the possible options to send to these methods, so
instead of complicating the parameter list, first simplify it.

Collapse these parameters into a 'flags' parameter, and adjust the
callers to provide flags as necessary.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 8 +++++---
 builtin/commit.c       | 2 +-
 builtin/gc.c           | 4 ++--
 commit-graph.c         | 9 +++++----
 commit-graph.h         | 8 +++++---
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index b12d46fdc8..0c92421f75 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -127,6 +127,7 @@ static int graph_write(int argc, const char **argv)
 	struct string_list *commit_hex = NULL;
 	struct string_list lines;
 	int result;
+	int flags = COMMIT_GRAPH_PROGRESS;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -151,11 +152,13 @@ static int graph_write(int argc, const char **argv)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
+	if (opts.append)
+		flags |= COMMIT_GRAPH_APPEND;
 
 	read_replace_refs = 0;
 
 	if (opts.reachable)
-		return write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
+		return write_commit_graph_reachable(opts.obj_dir, flags);
 
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
@@ -175,8 +178,7 @@ static int graph_write(int argc, const char **argv)
 	result = write_commit_graph(opts.obj_dir,
 				    pack_indexes,
 				    commit_hex,
-				    opts.append,
-				    1);
+				    flags);
 
 	UNLEAK(lines);
 	return result;
diff --git a/builtin/commit.c b/builtin/commit.c
index 04b0717b35..3228de4e3c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1668,7 +1668,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    write_commit_graph_reachable(get_object_directory(), 0, 0))
+	    write_commit_graph_reachable(get_object_directory(), 0))
 		return 1;
 
 	repo_rerere(the_repository, 0);
diff --git a/builtin/gc.c b/builtin/gc.c
index 9c6c9c9007..198872206b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -663,8 +663,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		clean_pack_garbage();
 
 	if (gc_write_commit_graph &&
-	    write_commit_graph_reachable(get_object_directory(), 0,
-					 !quiet && !daemonized))
+	    write_commit_graph_reachable(get_object_directory(),
+					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0))
 		return 1;
 
 	if (auto_gc && too_many_loose_objects())
diff --git a/commit-graph.c b/commit-graph.c
index 162b9f2a85..28fe2378be 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -755,15 +755,14 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-int write_commit_graph_reachable(const char *obj_dir, int append,
-				 int report_progress)
+int write_commit_graph_reachable(const char *obj_dir, int flags)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
 	for_each_ref(add_ref_to_list, &list);
 	result = write_commit_graph(obj_dir, NULL, &list,
-				    append, report_progress);
+				    flags);
 
 	string_list_clear(&list, 0);
 	return result;
@@ -772,7 +771,7 @@ int write_commit_graph_reachable(const char *obj_dir, int append,
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       int append, int report_progress)
+		       int flags)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -791,6 +790,8 @@ int write_commit_graph(const char *obj_dir,
 	struct strbuf progress_title = STRBUF_INIT;
 	unsigned long approx_nr_objects;
 	int res = 0;
+	int append = flags & COMMIT_GRAPH_APPEND;
+	int report_progress = flags & COMMIT_GRAPH_PROGRESS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
diff --git a/commit-graph.h b/commit-graph.h
index cd333a0cd0..83fa548138 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -60,12 +60,14 @@ struct commit_graph *load_commit_graph_one(const char *graph_file);
  */
 int generation_numbers_enabled(struct repository *r);
 
-int write_commit_graph_reachable(const char *obj_dir, int append,
-				  int report_progress);
+#define COMMIT_GRAPH_APPEND     (1 << 0)
+#define COMMIT_GRAPH_PROGRESS   (1 << 1)
+
+int write_commit_graph_reachable(const char *obj_dir, int flags);
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       int append, int report_progress);
+		       int flags);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
-- 
gitgitgadget

