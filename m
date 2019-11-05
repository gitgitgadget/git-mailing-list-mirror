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
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6A31F454
	for <e@80x24.org>; Tue,  5 Nov 2019 16:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390143AbfKEQF7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 11:05:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52536 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390011AbfKEQF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 11:05:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id c17so14258484wmk.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iJaVE1048Fb32mvhzZjEe2BjDg/cYBTxeZGy6ZxEsVM=;
        b=PHuT0g3a4fUQ/39gLV2BV/Wzq+TN8eVd5EHaRoYKNxU1OPKSq/I66kjACjUHdS1TMt
         +M8xzZK1TYEFstChKqL31ZtvQ1GmQhwpfgKEEAEpTThyy9UcEMsj/vKLTp312vO/yobC
         DLfvj6PC2LxqvwrHCNbnjwaxi5yAx6vwgrDQMEj/yx2YDShz3/Jp8Jq3FVDj/zYP9z20
         2X7ZTQ9w27Dv1TqainpvIa75vMUNUYUGynaGvvVQIC0two00kp/qSB9yfjFBOQiJwYMd
         3smpfAO6B2C27IOztaKcVQlH7utgw3lbtAVOcrNLg/0W4cpUtIvcfbALS0wD0gEEDJ92
         Iw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iJaVE1048Fb32mvhzZjEe2BjDg/cYBTxeZGy6ZxEsVM=;
        b=s4o1eKaOVujSMgAT4MC7oGZfC0bkxZuchENFxnK923KYqgkJlIhReGyLGgBI7A5MzE
         7Ccha+CLPkmchRuJARLDFRpMc/OkToBHnsPuGDXvrTq1mr6cpZ3rf9op3GvJDk67eEws
         Q2QhFEA4CNVbZDrleIts+5+OOTGyQkiOYtLhLwZjM/KGfnVC+B9HmcKDMc58ckNvBfXD
         EYDhSBoytNlP4mUI5G6B5/a0lFNGVg/llW16hMYIYjnR1fTpBghYIc2p3ecEP/YcCzbu
         S3P23a8XxzPO4O9geGtT8PlGim4xnHK61rhTb3M5bEKAiLLM6f9g0rsjyv76cs2sUwF0
         iKVA==
X-Gm-Message-State: APjAAAWfuS67/TmK8RerRzHGCJYmUZGtwjC2O9eBRGxu6+TPx2ssVHoy
        lC87Q3M4kPtLWzcK2G0c1IQm8dW9
X-Google-Smtp-Source: APXvYqymIUuuxvQidMyw2b8XEFHQ0zI1rR9FlJBFROMa0/ZsXyAIR4iJz8KxSwSzbb+91X0xost/LA==
X-Received: by 2002:a1c:6386:: with SMTP id x128mr4813842wmb.41.1572969956867;
        Tue, 05 Nov 2019 08:05:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13sm26594394wrm.8.2019.11.05.08.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 08:05:56 -0800 (PST)
Message-Id: <174c05bf29bbd92342aa45132592c348f988cf0b.1572969955.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.git.1572969955.gitgitgadget@gmail.com>
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 16:05:55 +0000
Subject: [PATCH 1/1] commit-graph: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rynus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When writing a commit-graph, we show progress along several commit
walks. When we use start_delayed_progress(), the progress line will
only appear if that step takes a decent amount of time.

However, one place was missed: computing generation numbers. This is
normally a very fast operation as all commits have been parsed in a
previous step. But, this is showing up for all users no matter how few
commits are being added.

Reported-by: ryenus <ryenus@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0aea7b2ae5..071e1c6e9b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1103,7 +1103,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	struct commit_list *list = NULL;
 
 	if (ctx->report_progress)
-		ctx->progress = start_progress(
+		ctx->progress = start_delayed_progress(
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
-- 
gitgitgadget
