Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A7A1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfFGSin (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44743 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbfFGSid (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so4322957edr.11
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZJHzgcvsa8/m8/lpT/Thkq8lqoakqrEeG+ako1xU4jg=;
        b=vTMwatX1Rx1xQS8n8JXM/smDUCpbuFuqdDMemIXEZWeiOJI17ymkF+an1eQNh6OYAZ
         8Ug48eJZ09ocxTzbWXfss6eDMxCGdV8QakWbD63dYdQdJF5CjyQboPmISuJ1WMqpWxWT
         Pkv4+XoeEmSbRat0C5C8V7idCyV1ixWHtH1BBf3UL3pvNI9N7pd7vuOGhU8CRpQnswZG
         ZaoSoXMynhZEHP+HKUT6wfNB2hQBl/j/cqxFbBgIbosEfsB0J5xIM8dzDqmNd83YLyEV
         E0EVEyHKFD3H264ngwYxzTuRXrmw+QVhc8t+iu48ZskRMyVIy+Q2Jkki5mGHUGzHZaiD
         IqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZJHzgcvsa8/m8/lpT/Thkq8lqoakqrEeG+ako1xU4jg=;
        b=TWGyuRt1W4bBZzHvZvpqAwa+h49HatMzSLi7GM3ioAwiirCOdtmtqJEpSOvKTom+D5
         pRQz62ep1Itbetny3JC+2PAo5WhpuCXRAZGaQeIP37DKOiOVa50Cpwh9UJaIgRBuM2Qh
         6neUkR5HgzcJEC0lAQeqY/8i1ibj7vdfLMWkG9xWjgzd9l6HjWB4P4sw3tQtSN4qaoAe
         uQMYIACP0KY+k5wtEVoId4RSIFsww1Zg23VPHuHK0b6TSJiyjN09eun0vVCy3QMI4K72
         rTVDneKZwnHT8mpwdCP2ZlzNv2Vimo6RL0ohlBS00pados4s6HwRNXKGHgrW+ypnMXRb
         PQFQ==
X-Gm-Message-State: APjAAAVtIHMcI0S4EMDO80624R4itihWf7RKAm4GRDaznGS8d6l6yJW4
        +fzM0YeGix5/gl7Blve9C9nbJbrT
X-Google-Smtp-Source: APXvYqzkJ4pqHw69A9c88Io8cPAHFChudfsYBV5AJpjOEYumOOCUf8Lx7HgquAUg8JkZA2VPyje45A==
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr6451648ejd.144.1559932711973;
        Fri, 07 Jun 2019 11:38:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21sm715462eds.31.2019.06.07.11.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:31 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:31 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:17 GMT
Message-Id: <795ea36ff41a5838b1dda781b48163f8e20993c1.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 14/16] commit-graph: clean up chains after flattened write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If we write a commit-graph file without the split option, then
we write to $OBJDIR/info/commit-graph and start to ignore
the chains in $OBJDIR/info/commit-graphs/.

Unlink the commit-graph-chain file and expire the graph-{hash}.graph
files in $OBJDIR/info/commit-graphs/ during every write.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c                | 12 +++++++++---
 t/t5324-split-commit-graph.sh | 12 ++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 431ad2cf1d..8842f93910 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1685,6 +1685,12 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 
 	if (ctx->split_opts && ctx->split_opts->expire_time)
 		expire_time -= ctx->split_opts->expire_time;
+	if (!ctx->split) {
+		char *chain_file_name = get_chain_filename(ctx->obj_dir);
+		unlink(chain_file_name);
+		free(chain_file_name);
+		ctx->num_commit_graphs_after = 0;
+	}
 
 	strbuf_addstr(&path, ctx->obj_dir);
 	strbuf_addstr(&path, "/info/commit-graphs");
@@ -1839,10 +1845,10 @@ int write_commit_graph(const char *obj_dir,
 
 	res = write_commit_graph_file(ctx);
 
-	if (ctx->split) {
+	if (ctx->split)
 		mark_commit_graphs(ctx);
-		expire_commit_graphs(ctx);
-	}
+
+	expire_commit_graphs(ctx);
 
 cleanup:
 	free(ctx->graph_name);
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 3df90ae58f..e8df35c30b 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -216,6 +216,18 @@ test_expect_success 'test merge stragety constants' '
 	)
 '
 
+test_expect_success 'remove commit-graph-chain file after flattening' '
+	git clone . flatten &&
+	(
+		cd flatten &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		git commit-graph write --reachable &&
+		test_path_is_missing $graphdir/commit-graph-chain &&
+		ls $graphdir >graph-files &&
+		test_line_count = 0 graph-files
+	)
+'
+
 corrupt_file() {
 	file=$1
 	pos=$2
-- 
gitgitgadget

