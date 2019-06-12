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
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EEF1F609
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfFLN3l (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44632 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfFLN3l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so25733352edr.11
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NxQpoBV2LpILPeLk5XMn+LWk/ydUOHZ1hBj9R1xv/AM=;
        b=cDLf6a2E85g4Rsh+bexoqVFAN5OqSLLo05Iyr1onMv4FWTytRlL8rN3/Qds/d0PpZY
         ErI3i8l91jqz2JH8NpUm4idzxiLV3fqX/tSMSZqmd6i0+26uh8eyB1kCkHUGoT87sDL2
         O4TRz3kv3wNwyywPhFWycCT0qEzalNx9BSHlibYIqzGw667BDqCaHdCnRxD1qIwLDqcp
         FFSvh93KNWwg4TigxdksM57jFIXNce5+Q8v1s0tZGPeSmYoi3UElSwgpk0n6hw+qag+j
         TpPmlxN/Vqit0IorPBvPWPFecoezccc0hMvmPDkXv+3ItA15U3lmDPdWYrxqxncV6AuV
         7DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NxQpoBV2LpILPeLk5XMn+LWk/ydUOHZ1hBj9R1xv/AM=;
        b=GCGDIsQ0o3yAIwHUzxTM90tXOXr+kl5BAFa6scYYY7mUfVX614D/bhqc7X+4J+aruA
         f6uVWR0kbtkcnekdAdQwK+AS0L1tze62uaBIllMlZttwSFTxoOHLjlaIb+CFcvVCCQkJ
         Yjc0qUdYuPqaLWYxkQGxcXLR22tJ4puRZNXsRIFNblCtPA8Zmuwxfhki8cAz940FpSH0
         MVs2xk583SmXXnv15rE6F1mKDft0tOYpKotZvGUL9KUWslI4KZo9XRNxw8YN2XODnjOj
         2D245tctFkgxva6Gfw64REZsFb2BNjKNj+vIcD9WE9aVmRpFmrshR0niai4r3rkvTq5m
         UIWQ==
X-Gm-Message-State: APjAAAU3zerKF53RT9Y5w/7sgg/a+KLV/jyQZo4k0zDO4/vBGHjDt3V+
        9hGeiOwm8oYKRSIn7Bwwq+f5KHbs
X-Google-Smtp-Source: APXvYqxlDg7hcP7FgxnDC4Yd/vWkYLiiAMK7yjSucSx9v+UsCmJr6iOBptEofFbH1AocquzLh4ouQQ==
X-Received: by 2002:a50:c102:: with SMTP id l2mr87484659edf.185.1560346178884;
        Wed, 12 Jun 2019 06:29:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm4588840edd.0.2019.06.12.06.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:38 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:38 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:25 GMT
Message-Id: <b4e3ae579a04670956f7a06c2aae762fa7fea4fb.1560346173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 03/11] commit-graph: collapse parameters into flags
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

The write_commit_graph() and write_commit_graph_reachable() methods
currently take two boolean parameters: 'append' and 'report_progress'.
As we update these methods, adding more parameters this way becomes
cluttered and hard to maintain.

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
index 2a1c4d701f..d8efa5bab2 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -142,6 +142,7 @@ static int graph_write(int argc, const char **argv)
 	struct string_list *commit_hex = NULL;
 	struct string_list lines;
 	int result = 0;
+	unsigned int flags = COMMIT_GRAPH_PROGRESS;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -166,11 +167,13 @@ static int graph_write(int argc, const char **argv)
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
@@ -190,8 +193,7 @@ static int graph_write(int argc, const char **argv)
 	if (write_commit_graph(opts.obj_dir,
 			       pack_indexes,
 			       commit_hex,
-			       opts.append,
-			       1))
+			       flags))
 		result = 1;
 
 	UNLEAK(lines);
diff --git a/builtin/commit.c b/builtin/commit.c
index b9ea7222fa..b001ef565d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1670,7 +1670,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    write_commit_graph_reachable(get_object_directory(), 0, 0))
+	    write_commit_graph_reachable(get_object_directory(), 0))
 		return 1;
 
 	repo_rerere(the_repository, 0);
diff --git a/builtin/gc.c b/builtin/gc.c
index 3984addf73..df2573f124 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -665,8 +665,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	}
 
 	if (gc_write_commit_graph &&
-	    write_commit_graph_reachable(get_object_directory(), 0,
-					 !quiet && !daemonized))
+	    write_commit_graph_reachable(get_object_directory(),
+					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0))
 		return 1;
 
 	if (auto_gc && too_many_loose_objects())
diff --git a/commit-graph.c b/commit-graph.c
index 1b58d1da14..fc40b531af 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -851,15 +851,14 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-int write_commit_graph_reachable(const char *obj_dir, int append,
-				 int report_progress)
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
 	for_each_ref(add_ref_to_list, &list);
 	result = write_commit_graph(obj_dir, NULL, &list,
-				    append, report_progress);
+				    flags);
 
 	string_list_clear(&list, 0);
 	return result;
@@ -868,7 +867,7 @@ int write_commit_graph_reachable(const char *obj_dir, int append,
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       int append, int report_progress)
+		       unsigned int flags)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -887,6 +886,8 @@ int write_commit_graph(const char *obj_dir,
 	struct strbuf progress_title = STRBUF_INIT;
 	unsigned long approx_nr_objects;
 	int res = 0;
+	int append = flags & COMMIT_GRAPH_APPEND;
+	int report_progress = flags & COMMIT_GRAPH_PROGRESS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
diff --git a/commit-graph.h b/commit-graph.h
index 869717ca19..01538b5cf5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -65,18 +65,20 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
  */
 int generation_numbers_enabled(struct repository *r);
 
+#define COMMIT_GRAPH_APPEND     (1 << 0)
+#define COMMIT_GRAPH_PROGRESS   (1 << 1)
+
 /*
  * The write_commit_graph* methods return zero on success
  * and a negative value on failure. Note that if the repository
  * is not compatible with the commit-graph feature, then the
  * methods will return 0 without writing a commit-graph.
  */
-int write_commit_graph_reachable(const char *obj_dir, int append,
-				  int report_progress);
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       int append, int report_progress);
+		       unsigned int flags);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
-- 
gitgitgadget

