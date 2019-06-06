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
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9401F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfFFOPf (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46165 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFFOPe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id h10so3520141edi.13
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4faLu+g9wtPICy/5uD1vKG4JFOLJBq0Bv9eyQsCQb1U=;
        b=RcxR7/YoLob5pzx+WS5v88rU1R1/7zvlruZUv7vyuaHOsvmfnKPc+wDJY3KkaBbSYu
         K2WjDpHxQNsneYn17Y87eSfc1hEDw9YPppZzBboX28fjbpYUkKDWnwBlIPlj//M2ndkc
         DEE05g/s1L3Fa5VFcaWr4lUCKd1BLVkJ0iI/wi29LXLXYUwwMkvK7OVPxcpAIVkBm9Dl
         yw7LzWDYwPrCLyYBbvKW9LbSfV1jmk9Weph1aoCxSt17e6QieY2T9FHubdYUWdrQrQtC
         wsFC6CgMfKjBYHUkt3d0HE94KKG5OmhQ61tAZqMXs2YzlpeP/EApxBtMmLHsgfUGHl16
         JfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4faLu+g9wtPICy/5uD1vKG4JFOLJBq0Bv9eyQsCQb1U=;
        b=rpxLZDHTsMaOUHXaIUl34B62lIyZi2e0U7KNo8B8+1MqPJtkdS9j6SJOWaXCkY0ewt
         OJ4HI1OBb0rt/CCan2X52IHEIkpgUsE3WpiuiObMfTwwLDtzLy7OQWNAk48pknwVggQM
         4l+4Szrmsn45sDPQUIg4M3xLYrJJXB4plAeS0TTQlsbQ9A1qZ0RFa6VKCtAZZXpgPa0/
         G3MKa1+MEk/G3TnLeZ5nJOtm1WasBwtvU/OwwlAUCCLgqqi1NINPfUt5UWBp3PVQJryB
         yGdoeJCSLYNLKccgc4LB7gbLjc4A16vmYPkLC3qVuHg4/qNP+++6FLBVQ7FhCpoScTKk
         aA2w==
X-Gm-Message-State: APjAAAUsrwxoZRem84UYE2/OO82p6r+plrOzjHK9gwHXhJPxs6QqrHga
        +Aatzz00usd4IbB1LHlz34IR92fW
X-Google-Smtp-Source: APXvYqwDxY8q5eDxYwNR72f6zo/UMn4KK0M4ESsfBNCNUCQ16dTAiiwrZUPRUuPAYw0ieuTGbK8zXg==
X-Received: by 2002:a17:906:700a:: with SMTP id n10mr3617130ejj.29.1559830531957;
        Thu, 06 Jun 2019 07:15:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20sm347757ejr.69.2019.06.06.07.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:31 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:31 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:16 GMT
Message-Id: <f35b04224abf188c265ed0395cd3dfcf6eb6ac5b.1559830527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 03/14] commit-graph: rename commit_compare to oid_compare
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
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

