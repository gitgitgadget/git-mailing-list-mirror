Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FCA61F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEIOWn (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39198 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfEIOWl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id e24so2194467edq.6
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=68iiDnJ65hUNnWIwGjDVkylpNqJV3qybbZTGBNgM03I=;
        b=KBLwGBpQwbI4oTm8QnxiyMMJkzXahPu0vTkIqtfi3Rb8taxrBs5UGCBjUcuMCTDAuU
         zKLfTeBc2f1Y9HTN+l0euzcdCqWKjzJPbZiwJrMCfL0bmWdmCFCGOlrMTUJT+TFU8oHM
         eO6Q7DwLoucErbBmkV+pJutAco6Q8FZrruQgWz2RFeFshX9bqMvv8Fx8ORsdiCBZKdWc
         gkIpKoDb23JWRy7d+f0WvmUMgEunLxMH4tAahbb32hF0EHOouSUtoCcHZLm5h2zJ4OZu
         ZPy0EIk4X47P1wzdi14q+qQvWtBwBQLuUQ5uGZWdlPIQTdO2qxIl4oqJm2JERCG19pVk
         yqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=68iiDnJ65hUNnWIwGjDVkylpNqJV3qybbZTGBNgM03I=;
        b=s0K0JbprInYEAbHXG4OQ9109sHw/l20Z9VDcMtW2RvbZE+f1+GKq/t0+TmoN03Pm1b
         YcjDBRm0BaglSjI5qrEK0r93hup1UnWOmA6PCclR+XITFi+dprkkw/lkWsR64EipFhVl
         25/n/5DyL6dYdxnIPb0326rZ+B7s/Ycrzi5QhfJIWXZG2rS3mEGLaBoWCQZ8NudGsj4c
         /3ddWCZxl0aelOC+i6dnHXy1oHg/8NNsFzbmwYiRolBpHB2AdfkfLlNQpZbmTfCg7nep
         Z4Yw1+2sh/F9iTOXPhRmWZMZhy+M2IYwQY6ZRuRDpF9zhahBBTZzvmGWhlVVEDRMtTDa
         Aq6g==
X-Gm-Message-State: APjAAAVlwNUbcPuyyQOOanStBAuQu7C8JFhZyB3pRA1clZVO1rXOVpQZ
        MUA5Fo7l+Bfm0Rrc3yT33h+eNzVn
X-Google-Smtp-Source: APXvYqwb44OHAeaoGMXkGBIyKwnIHy5F5Yd7Ubyc9/F/GzOpNI+0WfI5ymvF6xeeZ4pIltLFLSajwA==
X-Received: by 2002:a17:906:58a:: with SMTP id 10mr3581325ejn.36.1557411759920;
        Thu, 09 May 2019 07:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm432679edc.75.2019.05.09.07.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:39 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:39 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:28 GMT
Message-Id: <57366ffdaae5f646a26e52f9494a80b28761356d.1557411749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 10/11] commit-graph: extract copy_oids_to_commits()
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

The write_commit_graph() method is too complex, so we are
extracting methods one by one.

Extract copy_oids_to_commits(), which fills the commits list
with the distinct commits from the oids list. During this loop,
it also counts the number of "extra" edges from octopus merges.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 57 ++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f7419c919b..16cdd7afb2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -984,6 +984,37 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 	return count_distinct;
 }
 
+static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
+{
+	uint32_t i;
+	struct commit_list *parent;
+
+	ctx->num_extra_edges = 0;
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+			_("Finding extra edges in commit graph"),
+			ctx->oids.nr);
+	for (i = 0; i < ctx->oids.nr; i++) {
+		int num_parents = 0;
+		display_progress(ctx->progress, i + 1);
+		if (i > 0 && oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
+			continue;
+
+		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.list[i]);
+		parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);
+
+		for (parent = ctx->commits.list[ctx->commits.nr]->parents;
+		     parent; parent = parent->next)
+			num_parents++;
+
+		if (num_parents > 2)
+			ctx->num_extra_edges += num_parents - 1;
+
+		ctx->commits.nr++;
+	}
+	stop_progress(&ctx->progress);
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -997,7 +1028,6 @@ int write_commit_graph(const char *obj_dir,
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
 	int num_chunks;
-	struct commit_list *parent;
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int res = 0;
@@ -1056,30 +1086,7 @@ int write_commit_graph(const char *obj_dir,
 	ctx->commits.alloc = count_distinct;
 	ALLOC_ARRAY(ctx->commits.list, ctx->commits.alloc);
 
-	ctx->num_extra_edges = 0;
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-			_("Finding extra edges in commit graph"),
-			ctx->oids.nr);
-	for (i = 0; i < ctx->oids.nr; i++) {
-		int num_parents = 0;
-		display_progress(ctx->progress, i + 1);
-		if (i > 0 && oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
-			continue;
-
-		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.list[i]);
-		parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);
-
-		for (parent = ctx->commits.list[ctx->commits.nr]->parents;
-		     parent; parent = parent->next)
-			num_parents++;
-
-		if (num_parents > 2)
-			ctx->num_extra_edges += num_parents - 1;
-
-		ctx->commits.nr++;
-	}
-	stop_progress(&ctx->progress);
+	copy_oids_to_commits(ctx);
 
 	if (ctx->commits.nr >= GRAPH_EDGE_LAST_MASK) {
 		error(_("too many commits to write graph"));
-- 
gitgitgadget

