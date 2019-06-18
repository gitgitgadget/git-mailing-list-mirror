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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1901F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfFRSOk (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35239 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730171AbfFRSOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so23078503edr.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HXSXdQ5Rz3aMBKbJoVmMTYz9pf/hTvjtFWy3MApxN+0=;
        b=Kl7A+uprHWd06/W7U0Sg+33VxdSxGDyxOG3SWap7j1OGKIPqlM310/kwFTtdPcNylX
         /IhzKYvwemCWzHjfOGPlDYfgdtiCxz6j9760GDsPAan7IBV6bMvZdyQNP7d8tX2XdJvF
         VtZsMfsICQqMvgvCx9xuTIYaHKuzRAgph207mSCq4igEyCNc3nnxGSH1oiYe6t2NP/V6
         SoqW7eJrdFmpajW+ftdZyLaZqhvlvXBKlGb0DPGE3eIoRZlY1iG211tKMgVYLN1+l+00
         1nkMNhUjEFBJHUqFzOFVQmlyPEqiQW+403Gy3u4qmj3HCf5Q+CUEgHKfJeVX8rVpDY7D
         +KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HXSXdQ5Rz3aMBKbJoVmMTYz9pf/hTvjtFWy3MApxN+0=;
        b=Pf0AtV2eszKx7uaBwRX1f/v66GrMfJ6hOOObR+WpAfJ2sX3KXCyHvKY32vGkDZj1Ji
         oX2ptEQWPXHDNFHEFR6lhQvUSaQGPDRnQWrLKScMcQLsehP6sh6s1JsTakvUfU7kS1M3
         8ieeiM8izEMlrgyQQcFTdc0TkBbnqButNyyD6z9oFD9xOIu9U6Huzm3pdrJd1Jwr/upz
         cyEnhReaHcFa5AgJyYK3S8mYxwS8WT9YkUGIwIYFfsKWu+P1BvkQU9WNyuZQzgptO4cV
         Gk+rVAsASSeePLCP+ux99BAfFl3IAURt+mIZzYuM7/tUbNZ8IlE/vhPsWw+GGhtQKTZZ
         5TUw==
X-Gm-Message-State: APjAAAUe/OBHeIQ9MSFn/7znFXL2cJ9DTnNY1i4DY5CzhEV7Lp7aPKPy
        XjEdcgyDSudUC8JD0QQh8SjzPxAf
X-Google-Smtp-Source: APXvYqww7XCm+Kg9CyR7zDRvJQX51S60Mkynz22WYzOqFVVKVx5eY7q++54l+h0g6TbxhcF3UVWL1w==
X-Received: by 2002:aa7:c486:: with SMTP id m6mr62483674edq.298.1560881674370;
        Tue, 18 Jun 2019 11:14:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3sm320564ejo.43.2019.06.18.11.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:33 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:33 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:16 GMT
Message-Id: <a4aa473c55e5df8a61f63742a2e27a2483ab6291.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 14/18] commit-graph: clean up chains after flattened write
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
index f33f4fe009..3599ae664d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1687,6 +1687,12 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 
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
@@ -1841,10 +1847,10 @@ int write_commit_graph(const char *obj_dir,
 
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

