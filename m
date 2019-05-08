Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38B51F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfEHPx7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44123 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfEHPx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so22518951edm.11
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b8z93/FWqgWVwgTgqfbO0pDDEkvy23xDqCRgy86Cg5s=;
        b=fNOFkQB9YXDB69Je2Ozi1vfwCrVY8g+KrUr0kpOmrrKbWAEUM6WdR6tSQv7wFw5HK3
         xldgegCj9el+IKF9QMhpgged4Yfw3ekWYiy0vXL1DkOSGNVtayKYTcHGdmFPONXRtOvW
         r8SzdxRO7X5obl1EcV4Yz+Ev2vkAvVzAaVGx1WIwXpseJKtK+4UGm/VWEvT/I0nGTvLT
         QbgFsfeglCXmTqqNCHo84RNhtWUsIKU1cZc4SlXaKspCBa+tuZ6ToUqFPR3T1QJcxD/v
         ArMTz+836LBeQah1lUf5TGUiwK1oLCSDdVJg0c7NjrwG7ZZb4ppOXH0glS9/ktqaCdwl
         /s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b8z93/FWqgWVwgTgqfbO0pDDEkvy23xDqCRgy86Cg5s=;
        b=VKJlgB3uRtNsuR9LqOD9k18JXWzpLl9WkiWK33vesjgZsOfwQGTYiHOvY5zRXgUO+8
         ivbFzOXTPjMEtEoQeJA8HOyynowAheFVLeuaAZUo+8vHWRnAyhS4XvLJNDRGqJYpLn36
         vH7UNPrVknHFMVzcbk6F1QJR0GYQor5mWPX7QUMU8ZDfhxcwXIuTSTSXvNVLgTczPPiE
         MMcSTSIMCVPVluTYbAJSV+rouODwgHRtFdzmXe/M1EcGwZyLu1inwvP2T8v/LeTxXgge
         fyyyl7dwmFwhzuBtVb82xCFsfLpe/hS67qBAcAP/Q2a6rLXJw2T4OthTrWxoldarThJo
         ytOg==
X-Gm-Message-State: APjAAAWGMEnngiHzGJ89bj4QE0fWMEVTQm7Zzt9TB/az7ApioA5cHSCr
        HDAF09tu8U5+FZok9jX26W9tVEhus84=
X-Google-Smtp-Source: APXvYqxe7sZVEDLEFiTxEwdDmvjoksyp65Kp7GgEkDv1A5DFPzBZdbgbNZNyIKp8taw5XZMrnZjd1w==
X-Received: by 2002:a50:f5d0:: with SMTP id x16mr39179621edm.287.1557330835468;
        Wed, 08 May 2019 08:53:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t3sm2666388edd.49.2019.05.08.08.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:55 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:55 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:38 GMT
Message-Id: <9d434dc38c7f3762de94dee57185c0504cf2667e.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/17] commit-graph: extract count_distinct_commits()
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

Extract count_distinct_commits(), which sorts the oids list, then
iterates through to find duplicates.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 730d529815..f7419c919b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -963,6 +963,27 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
+{
+	uint32_t i, count_distinct = 1;
+
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+			_("Counting distinct commits in commit graph"),
+			ctx->oids.nr);
+	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
+	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
+
+	for (i = 1; i < ctx->oids.nr; i++) {
+		display_progress(ctx->progress, i + 1);
+		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
+			count_distinct++;
+	}
+	stop_progress(&ctx->progress);
+
+	return count_distinct;
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1024,19 +1045,7 @@ int write_commit_graph(const char *obj_dir,
 
 	close_reachable(ctx);
 
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-			_("Counting distinct commits in commit graph"),
-			ctx->oids.nr);
-	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
-	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
-	count_distinct = 1;
-	for (i = 1; i < ctx->oids.nr; i++) {
-		display_progress(ctx->progress, i + 1);
-		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
-			count_distinct++;
-	}
-	stop_progress(&ctx->progress);
+	count_distinct = count_distinct_commits(ctx);
 
 	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
 		error(_("the commit graph format cannot write %d commits"), count_distinct);
-- 
gitgitgadget

