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
	by dcvr.yhbt.net (Postfix) with ESMTP id B248F1F462
	for <e@80x24.org>; Wed, 22 May 2019 19:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbfEVTx2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:53:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40672 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbfEVTx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:53:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id j12so5486860eds.7
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4faLu+g9wtPICy/5uD1vKG4JFOLJBq0Bv9eyQsCQb1U=;
        b=gvBQkseIugDGLZkTHp+ZMiZJfRzBuvgaDO/0zU/oClB+Es03AUL3Pd52NfPPcY2zrf
         UryUTnCMgEqPNNoZbBL6LcAaGVHFAFYcHNVPtyww5J3jTlN3J/qQuksephwDFMCMScv0
         EpgSAaQ1av52mJ3RU8bxhx+GbjcUsDYGR7Mb+Xm9WqL8hlgn3g0eF6CkbouQjb/UNiq2
         gyoHglAnTOjlXhyy118lYfr8++W+Yc/RY+jkNjeYUlX7G+1HcXjxcRUaslRmtrrg8a+n
         aaYOEI4Wg2+xYmKknpfrkf9RNg70fGYOnAaVG32Z5s4Ad+bUOTwpIv7jKH3xp/dwalIw
         QVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4faLu+g9wtPICy/5uD1vKG4JFOLJBq0Bv9eyQsCQb1U=;
        b=R7Eo2NPFKhwcEGaWDHrJNXK0YrRXEe3FJHvZTT4cjs63m6QvtDFYfa83jNqecMAE5j
         4Taj86CkFafbbwU4Du1QsZzcMJPiurepSWakunlNTd9uuaBAmevuQfgc8mEaxjrUTdU7
         LcWziXou5v3RF5Zo9cXR0h6S4FOHj3WoN2UI6YIV1tZ/LNzn3F7dIg30NQVdFyYXKPCS
         TrRZKCpMT8sPRNhnCFGuy/TqDcbWL34RlSzAEabW047xpttPdOPdYS+j37ghtZo2DsPu
         pXmtTdMFO34juqNH3M0HkBVrBWLIdAUpqX84Pk0pmnXa0khPf80qSioNvJeQHkmFZPQz
         ISmA==
X-Gm-Message-State: APjAAAVGekAHuT4A1A+llpRE2yn8ZRzsnuIKduIZDGqKYxIqGD3613Uf
        koIK/JIDN41Ao6BvIj04vQYCrEgl
X-Google-Smtp-Source: APXvYqwg5UH4JmZvk0oToL6dm2QmAQrCzB2MN01CjxgXpvMSZZ+qlgdxB5x4s4O0ur5s4qDE74jgUA==
X-Received: by 2002:aa7:c645:: with SMTP id z5mr56847018edr.43.1558554804790;
        Wed, 22 May 2019 12:53:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g30sm7311426edg.57.2019.05.22.12.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:53:24 -0700 (PDT)
Date:   Wed, 22 May 2019 12:53:24 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 19:53:12 GMT
Message-Id: <809fa7ad804834fa7250958ac328d3716e5fcf80.1558554800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v2.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
        <pull.184.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/11] commit-graph: rename commit_compare to oid_compare
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

