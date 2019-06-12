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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF621F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfFLN3t (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33795 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbfFLN3r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id c26so25799009edt.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tPaXiBtUx95N2dIHvvILIHCLcnhpXLVtJ8zNarsFOz0=;
        b=RD7o+pNKTm9/Sv3++88vfpB58bZ2+92Vw6g3pZ14AH00aAt23XC43GOmRwQMgiSvj9
         FbBxvYuRf4Zn+XXM15d+9rb921yhOruuupBDZLH0kmzdVvnJZoO7Er/3SR/BxIqMz4Ht
         +//5ywVEyiP+yDYU+jgUg+AFhsTmYQia0Cg6AOn2FtzE4NhqosOD4VNnpyWlwGwdR+tx
         eK4uaRk5SadmUmFpAI79p+KfxjSHG0wRGIy0zmIauPQ3kod1vlcD2AITgzMWiJmyF6v3
         zedCUdhC6nbhmB7w7g8zU5cArK33lIBUafKmnCfZ15FPjSBu/wNIY8Q2Z3ENy8DV5nxG
         r7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tPaXiBtUx95N2dIHvvILIHCLcnhpXLVtJ8zNarsFOz0=;
        b=BsZrBXSJ2+1lp0104rNe2QYKydZ9H/zavZ1LoBIkuIFoLY9E+FwYYVMo5Nn5wRRT4i
         Z1T6jUofofApjdtEziYc2BxdtEox6GVznaFDNh9X63hk+arhNIKsmm/aHddN93vbF0QJ
         5t9/gSQgALkyL2Tg4VqjyWmI0icJLO93KRgS4wyzLxzhtrieM5Evfk4RVrWtcsgiyfKn
         bgSnQQ+LPjzFU0eEqwQtGrnhcuo3TSZl0VL02pV/z6fH5Ln0+uCGca4UbXuEAHW2TNJS
         StGO2PmasxZc7s7YCU9+TNtZD05PHfPkQTk2Sk0G68DKhsoMoj6DhnRh5By1QTtKV84C
         d8PQ==
X-Gm-Message-State: APjAAAWO+NkiImOJbfAwY8Tt3idPGegyxdkDdXOcZWqt6KTwORUlHBmh
        wlNkNb8vuxR88nOigeGlzQDiiLsz
X-Google-Smtp-Source: APXvYqys9SldrMMBPx+teRWnTx06MvupCvfEEZ8SiHLLsIwvYZ6UHgu35UhUZi/nsqTr4CMYnVN3xQ==
X-Received: by 2002:a17:906:3e97:: with SMTP id a23mr57656228ejj.233.1560346185166;
        Wed, 12 Jun 2019 06:29:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm2468877eda.79.2019.06.12.06.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:44 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:44 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:32 GMT
Message-Id: <b403c01ef543360df3496f810a7e3988205bb18c.1560346174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 10/11] commit-graph: extract copy_oids_to_commits()
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
extracting helper functions one by one.

Extract copy_oids_to_commits(), which fills the commits list
with the distinct commits from the oids list. During this loop,
it also counts the number of "extra" edges from octopus merges.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 57 ++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1a0a875a7b..72f9c5c7e2 100644
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

