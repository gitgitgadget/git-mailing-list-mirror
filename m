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
	by dcvr.yhbt.net (Postfix) with ESMTP id C69CB1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfFFOPs (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33341 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbfFFOPq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id h9so3603018edr.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qc0TRJmYZ6L/AS8DMp29l3GCV93B7PVoMqQyOyPfB9g=;
        b=rvR2dIXrw32lviA8kL9K0e5xs3SRNsTQJLPeCC3Ae2Y5J7ET3rKfOWvIykJxU3v2+T
         L7Q8KVv92M/1bCm22q7eFE/4SCf+IW7F42kvtSAtiipiJpb2fguhvNDbRrY74vGivWKs
         0u3swwBh3/6wN6Ry6M0s3P1tFwAANfxZGX/2i7Sjbw7GZ1MAOvsR19Aaj/suOoQ+9/9H
         OziW4mKkoRCUOsgfVb1xWvpHejfKgCqovtdzRUzXt39+oZkNo8nz31H92JF5hMAaVOS3
         Tb+IFrSy647xFnGBIcG9XK/e6IAY2Tpn2RSkrfDXcydJ/cWRPCVmmz+5O6ib9egq9/Hs
         SPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qc0TRJmYZ6L/AS8DMp29l3GCV93B7PVoMqQyOyPfB9g=;
        b=IWSwCGeET+X6Z8/mOWM6gCNMrybmpWJN+U144Rzh7MaWklJc450yCjnLoCgRJ7yiEf
         uVvGTRsV8YvrRLiFhn1IDbq7xWq2g6m9Bxy5fTUy8XJ0hbnrZU1ilv3c53JDSGRJNXTv
         Kn7Gqlj2xQHImjtJ6lhjCpLf5a7RlYWZ4wctwkMNgColK26vh23O1y60Dh5mfQ2Wemma
         syFebFa76CZyJJQyw8qEP/grzko0Ohqfw+uy6/wBE4mA2c/Oflq2EjbdGxtIlc8K7ACu
         vlWKTQwabw0JrRgd2CUaxFJ2YYYDPeV4RsWWdGxJWdlDIO2Oa0xBZZ0ZcrJnWzglamjp
         783A==
X-Gm-Message-State: APjAAAXfTPJWKztZaUcL5x2DwHdHXHsfJsMKQvPs5W1aAQWV2LXKbywc
        Va/R4zJImqEhL2X5/hzC0uL4ZHEh
X-Google-Smtp-Source: APXvYqxiyGmBdBOqoAqfM4wfHBrqv3dXFyToOYjmVOY6QnMhC85xF7KEraI78pOixfawTZP23PUGXg==
X-Received: by 2002:a50:f599:: with SMTP id u25mr17214180edm.195.1559830543470;
        Thu, 06 Jun 2019 07:15:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j27sm357463eja.91.2019.06.06.07.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:43 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:43 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:27 GMT
Message-Id: <6084bbd16496d6328e0a50e604a7d05594e17f5e.1559830527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 14/14] commit-graph: clean up chains after flattened write
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
index 07856959c1..affa969e79 100644
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
@@ -1838,10 +1844,10 @@ int write_commit_graph(const char *obj_dir,
 
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
index b2bc07d72c..bd2e90e512 100755
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
