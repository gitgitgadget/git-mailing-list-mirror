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
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A521F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfFCQEG (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:04:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54299 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbfFCQEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:04:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so8603663wme.4
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZIvE548TU8dWlPp/oHb2TXffYWRZVBIzipxEtua75hQ=;
        b=VF1Bd91UyZFhfdIKNJGpJ57E1o9/BGZlwdAoVX+rB7X7zWrwvWF76J3bixk9Jdvv0C
         +z3VsBr3Fl2HUZCw/y2s3vgLPM7QOjcmWyxlZW1L4cmiCB0BCcyBZ9QnPejq4IeqU0j8
         Vsld/cgaTVmrWUWqqegq7omgmsYrcDHUHi8IYBcClNvj5q3Gr6AlEJeLPIpQcQ6j+Flp
         bcBt6poJ/LUbV+H7wxrhd7N9yTLSC9DESYH/GWjswe+bsiEXDI9iRQmL/jMSwnXroYF7
         uN5rs8zl4yDmiUuMF8gMWbzhd9V0016stClJjm3qwRRmqIz96uSDMpBmmkr9AwcIv/p3
         NfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZIvE548TU8dWlPp/oHb2TXffYWRZVBIzipxEtua75hQ=;
        b=kg2t5o5hsXCz3gxpju239WBHNNlWPp7kvX3xiw7/srbU1R2HxPeE2CD9jueA1YRlwr
         xO85DBy1l9dKUd+Yk3QSx3Ho6i+Jrp58Ogxx18OA+4P2KhQ4BLJuhrx9u8L2lVJGoELZ
         VInznfQ6JCyE9L9Dn/vp6FMfuRLBnquUHHnsCQKWDxUcpTy9yakIDPOCrOMWJ5twTg7s
         UWfUgkXfOVlW+4JA/JkpbNzHll8hEB9ChgCrgerDyfmRy9PQzByajs02+/4IAfgHR7qA
         xsESZzw+NAwXV4I8rkEoqhJU1f23vHFjK+sVfTJSRtuauvq2hnXQLzMTuyZ2ITjRbsCj
         9otQ==
X-Gm-Message-State: APjAAAWymlZ5u+tPyN6kTZbHoqPEkwoBJINUzcFK2XeSp2xzSDeh/hS/
        Qog4GB4gS0Q9ogCjH+VyiMgJB1ki
X-Google-Smtp-Source: APXvYqykwh+oDgz0Vp7iXkiRdOP+bLSECeML9hyOYD+Cwq25wA3h1hONxc3OoVHAsS5sf1VvEh7NzQ==
X-Received: by 2002:a1c:407:: with SMTP id 7mr3130144wme.113.1559577842286;
        Mon, 03 Jun 2019 09:04:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10sm7889824wmk.14.2019.06.03.09.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:04:01 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:04:01 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:46 GMT
Message-Id: <ca41bf08d0f8a0db6067f09d18fdc48f94a3a68d.1559577826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 14/14] commit-graph: clean up chains after flattened write
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

If we write a commit-graph file without the split option, then
we write to $OBJDIR/info/commit-graph and start to ignore
the chains in $OBJDIR/info/commit-graphs/.

Unlink the commit-graph-chain file and expire the graph-{hash}.graph
files in $OBJDIR/info/commit-graphs/ during every write.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c                | 12 +++++++++---
 t/t5323-split-commit-graph.sh | 12 ++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f7459d40f2..291a3c60ee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1672,6 +1672,12 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 
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
@@ -1826,10 +1832,10 @@ int write_commit_graph(const char *obj_dir,
 
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
diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
index b70dc90706..9a19de9e80 100755
--- a/t/t5323-split-commit-graph.sh
+++ b/t/t5323-split-commit-graph.sh
@@ -204,6 +204,18 @@ test_expect_success 'test merge stragety constants' '
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
