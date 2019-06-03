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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE96F1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfFCQD5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:03:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34165 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfFCQDz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:03:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id e16so4426499wrn.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4faLu+g9wtPICy/5uD1vKG4JFOLJBq0Bv9eyQsCQb1U=;
        b=Rmwl3oG3Vpy7EV/iyzbAhAuKFqHl3YaBxG4mZLCZRE3dvJy6QW7J3emOa4muHmTJs3
         O+v9zwn4ldNFeMXyw3WdSv+IopxTxIkNX4YzgIf4ehkp4EzTnoVb0Jeawt6/1SR3Wcq0
         hMyLA7pO02zclgPQEbMCH2H+6IXSVyMg1vl9BzI4kITdu7g5MUQASNWwyr16mwaSatUT
         ar3b+Xt2I1II93xFenKdJBgsE90Urm5gnWAxy7aCf5RHzuzXvWuzzLqeXAL24xeunM/m
         Hx+RFEEXPkbyQahrMsk/mDljywTUyXIRQ9LuxBo7AnP4yRD0iFMuWXjxJoOrQUx60ySp
         Xizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4faLu+g9wtPICy/5uD1vKG4JFOLJBq0Bv9eyQsCQb1U=;
        b=je+kneUo3SVVI3KPAzWfAdvoexfK/8G7xkcPvuhxs2Dqqtu/7KYT6u1U3c+x0w+U7A
         dgj6ksfzYeogR51u7zfOktbk3nMx8uGANUTe+YWYw9BVga08I1T0AVraQTdUNW4VTJbc
         senuKMuMmNptdudWRhJyOdWcZb8btYJlATmgkwGyT8SjxWUc/8mmcQ6DldWMcF2PmOsB
         IxlJKG53wO0oqk4zxPLYRo/Ea86xv/rghvqt3DTfuX+Z5p6NVijE3SZ0wqMXmDg7wB4z
         fkZuxI6bSk04B5T2jO7r6cANwMeReJMakrkfBBVUGIqpp0PqvhpROB1g0Sc01mOnKBI1
         h+8w==
X-Gm-Message-State: APjAAAWvCSUtCOZgCxDb2jhLal7RvETSN/cOlLVEmLakOGXpW7VNDGGN
        YkqBuWNgqt/KkflfejapiccT6SCL
X-Google-Smtp-Source: APXvYqyLaKkuEG96+zmZZirHWrb8aOySJdh/zSmObT9jNarH3mtP2l8GHR6+yXjEwNMx8d50IXBkjw==
X-Received: by 2002:adf:f70f:: with SMTP id r15mr16546550wrp.325.1559577833119;
        Mon, 03 Jun 2019 09:03:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm16997219wrr.33.2019.06.03.09.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:03:52 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:03:52 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:35 GMT
Message-Id: <f35b04224abf188c265ed0395cd3dfcf6eb6ac5b.1559577826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 03/14] commit-graph: rename commit_compare to oid_compare
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

The helper function commit_compare() actually compares object_id
structs, not commits. A future change to commit-graph.c will need
to sort commit structs, so rename this function in advance.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3afedcd7f5..e2f438f6a3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -761,7 +761,7 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 	}
 }
 
-static int commit_compare(const void *_a, const void *_b)
+static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
 	const struct object_id *b = (const struct object_id *)_b;
@@ -1030,7 +1030,7 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 			_("Counting distinct commits in commit graph"),
 			ctx->oids.nr);
 	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
-	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
+	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
 
 	for (i = 1; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-- 
gitgitgadget

