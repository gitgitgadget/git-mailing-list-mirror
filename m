Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6A41F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfEHPx6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38580 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfEHPx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so22544512edl.5
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=68iiDnJ65hUNnWIwGjDVkylpNqJV3qybbZTGBNgM03I=;
        b=haVr3k8I7JaTbrVTClJfB2GpqWUH1LG5K3IsbrFTeWOQjDJW2LVlN2e2i6PByKSSXd
         drY39M/OMwHreZrusEIhp1hRkcw5q1qedgULQk9YgV3/B1empc7EEAZCy2NDt0HjC4Wm
         ULo0FFt/RDpSYJVrV8HjrNG8sGy61sRl50JiaQKA7raNThOEITFHBcNbVJYrfyjSWuMt
         jEfXZkQD8EzHmfkbdbJoaP/JwyjlKsOMgw36LoC43RYhI5911ToKyJ0SDc+WhR/9O1l2
         AV1jFCyBQUhw7avCyoNlMWKv6Ol1cDJPkS1VV9PlVcTg6PIz+nkpSPxa65iAgVc14Bzt
         VW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=68iiDnJ65hUNnWIwGjDVkylpNqJV3qybbZTGBNgM03I=;
        b=JjWwEcRKEUbH5scvDGQF+pnAtPy4ZTuNJPEeK4v8z259rK05/Lpp5JFk4c5tYRG4FV
         r1AQg7I7pmsqfWCrNUxc3UIvR9jIFmxfv+bcoEFu43TF5O/X/wtDbRlBhz4g6i1+f3xD
         iCCZ3hGx19Mf1A+IINCIx882kMJeQrEhAGqCsRwfe/IwVsyhEJmgN5SgDqF8CqNaGEry
         rQEdpldKoBbF2gYr+gESL3/nYgS3a6F52j0XqMGBYQEhAJF5MsSySeBN6jw0xEHX+axk
         o+GbAUdobcd5jsYMkjVS0JYFyI4O1AmO1CZHFK4F1EhpTgvjRgDBXn+Sb0urohfichTf
         91ZQ==
X-Gm-Message-State: APjAAAUR/Yb4d8qkyzV2Wlz5qrB1G1EP+jxIt4Sk3lRdYvp9iZ58Ov55
        eF4KM2IknjiJLbVN/C7lEGVTkeDZS7E=
X-Google-Smtp-Source: APXvYqxCnL7i2E4YiAnZhoBp5HxSHQNefYHjRUXcgl6Qa80X2noB1nNDEFM90k1IyDL1E0W/QEXtPA==
X-Received: by 2002:a50:a55b:: with SMTP id z27mr39720198edb.68.1557330836254;
        Wed, 08 May 2019 08:53:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p60sm579292edp.0.2019.05.08.08.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:55 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:55 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:39 GMT
Message-Id: <ebd665468e1347752dabc0c963c890530ea0ea55.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/17] commit-graph: extract copy_oids_to_commits()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
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

