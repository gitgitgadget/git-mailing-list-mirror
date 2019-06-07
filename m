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
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B5B1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfFGSif (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34233 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbfFGSiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id c26so4365269edt.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jK1/p6qEQFMmjHfzPgJ0kPVOPDEBdL69dL0BgkKvxt8=;
        b=GfLjjOa7ucR4UhGzzaYQC0yFtQ9fbJFNJ3A0kJd+HKoh5o4hObq3kVZHS11fvKXnjz
         4GN+fBprfUNGQg7abcNrAYBsqa9OXvkKERSYoxiSB0vkdHEXTVIQesAf2Q10z5V8KDJQ
         iXtynsV6TABGgafk3dnHVXWhjSuqPSLBFd89Ki4WKcJCZkmoA5064STlriLhoJD3nO1r
         QYXscNhPX4BLxlPIT/J2VHSMH2lqiC0urPHQ/UmmAfwOzJcUQaTj3MKxdos28GmpDAIk
         W3zVZ7oZKZxroUZZL6nVGpCVAEkpQg9hRqSLj+LLCLj74TQd1tiNv2C4TBq8lrfM7KyC
         /Trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jK1/p6qEQFMmjHfzPgJ0kPVOPDEBdL69dL0BgkKvxt8=;
        b=jLecGMj33hokcAz0bV5UWRQxIekhVIg09thJo0dkxQnhGqtT8g/W5hYvengfnUlNMh
         OAK6a1JL1ojTla4qcuF0ixR74Jd/PeT0oXyrdtfe4nJ5bW26Z10tRmQ32pEi8WPrXq1l
         fcsQoWSi27uhQrGHpPu7macD6T+QVHiRYnzU7/nYUlKH+rLx8ET4Yibyo8wOKbCdFACx
         0Eb3v05DTNbdple4wrsBKJi5/QBcznoxAc+M9+ZSS14x/AlxBZ0CzAEJnSHTXr69qZv/
         7xBaIMwedlWO3JolOIGFFHGw0dFdEstjfKGqYNBoCbg9ShK59rRioEfYKf1JvlIgxyQX
         63cQ==
X-Gm-Message-State: APjAAAVno9tXMylB+5TByc2AKeimCVg0cFEARI2B9QNRkcYH3kUosEm7
        joGqAaHOUhvM/z8eXCf7fr8riFlt
X-Google-Smtp-Source: APXvYqxjWsHOsBbSrXRf8EF79YUnB+xulfpUHoE/HndV7z2NwY/egVcrnunkzduaQ8cheyIj8L279w==
X-Received: by 2002:a50:95ed:: with SMTP id x42mr14332799eda.279.1559932703460;
        Fri, 07 Jun 2019 11:38:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm664933edi.72.2019.06.07.11.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:23 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:23 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:06 GMT
Message-Id: <2470d2b5485439f49dc9ec5418cc3d10bcad0e0a.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 03/16] commit-graph: rename commit_compare to oid_compare
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

The helper function commit_compare() actually compares object_id
structs, not commits. A future change to commit-graph.c will need
to sort commit structs, so rename this function in advance.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8c3598037b..70d5889892 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -770,7 +770,7 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 	}
 }
 
-static int commit_compare(const void *_a, const void *_b)
+static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
 	const struct object_id *b = (const struct object_id *)_b;
@@ -1039,7 +1039,7 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 			_("Counting distinct commits in commit graph"),
 			ctx->oids.nr);
 	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
-	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
+	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
 
 	for (i = 1; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-- 
gitgitgadget

