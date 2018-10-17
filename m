Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F5F1F454
	for <e@80x24.org>; Wed, 17 Oct 2018 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJREak (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 00:30:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43342 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 00:30:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id 30-v6so13214727plb.10
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ymgvcj6OeStBGftGAb5tXW4kovZeRBFdVxnR92KagPg=;
        b=Gp3xv0teaYLOGgUYsacUR+5YfwisywVzZ0bDhLpNkeYT5T24lYfDOjIlGnCLR6BzER
         C1/aV/2jotqaFtoobaBSUCsruWrm2d1JWhfG3DAbDbp/ctYFd6D88l+DJU38ZYoKk0Ib
         36N0A26fXwbMbgmS+kKrOYGS4d3LoijPTGCw1vJ2Snhg4Hq4Yx4QCt1vxxm6ysiLusOi
         Y0duC40u5oO7QdPiRs2BCsSEy/YKEyK4cpxKViJGpQ0KwjWrI3Jlpl/Ficm/i29OuoU+
         +dRxn/FpxF8z0VglnQPrnWEKjitXxzgH+pHKns8zsyWpHX/dfrFXbQrJ+6vobzfwWjfY
         7U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ymgvcj6OeStBGftGAb5tXW4kovZeRBFdVxnR92KagPg=;
        b=pTw5A85nhVQRmegWyAHlxd6CtrCkKK5FeD3MmIQu220t/26aO4i+tAb1Tswpjo3o0S
         RDeHBwKEkNNzpUZtSkYQXPtUGkaLbPNhlMWfhjPyhKmOiusjTstQz9M/nz2xSmK5Z/mC
         PtXZuofaELTjRW0rEITIbdADt+4JLP3iMdWUZju+XLSLkfH/9HHi2uhrhBsqxdBFxA7m
         QTtfOSiZZLsCLvuV2KTKHHu5HrvZ5B+Y+OqXrAvNZoZQF5PdncduFe2yX8mCJ1NQtRAV
         v6Xxwd3iCGlXE08FGtQ4biUj1FodmOjWIqIUjUivEb7HMx6gBSYQht0cdKBuwydsZ0Wz
         MeEg==
X-Gm-Message-State: ABuFfog2D8/yfcb2r39oJuBQIE1cDYU3MS7Opf3yXU/cfgrBEg7U+C8x
        lV6mOgIWR9HUXnzNFypAnTvmRbSm
X-Google-Smtp-Source: ACcGV61288tddFfEZinH8WTqBCdhgZYxBvS/RQfwmDwqnx1GNA28kahnsYFTAUGJuJim0OvOq/wH+A==
X-Received: by 2002:a17:902:7285:: with SMTP id d5-v6mr22965827pll.145.1539808396112;
        Wed, 17 Oct 2018 13:33:16 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id u62-v6sm24170582pfu.69.2018.10.17.13.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 13:33:15 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:33:15 -0700 (PDT)
X-Google-Original-Date: Wed, 17 Oct 2018 20:33:08 GMT
Message-Id: <6f07487dcd6368982392613adb29438916c8738d.1539808389.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.50.git.gitgitgadget@gmail.com>
References: <pull.50.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] commit-graph: Use commit-graph by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The config setting "core.commitGraph" enables using the commit-graph
file to accelerate commit walks through parsing speed and generation
numbers. The setting "gc.writeCommitGraph" enables writing the
commit-graph file on every non-trivial 'git gc' operation. Together,
they help users automatically improve their performance.

By setting these config variables to true by default, we make the
commit-graph feature an "opt-out" feature instead of "opt-in".

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt | 4 ++--
 builtin/gc.c             | 2 +-
 commit-graph.c           | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f6f4c21a54..dc5ee7c145 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -923,7 +923,7 @@ the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
 core.commitGraph::
 	If true, then git will read the commit-graph file (if it exists)
-	to parse the graph structure of commits. Defaults to false. See
+	to parse the graph structure of commits. Defaults to true. See
 	linkgit:git-commit-graph[1] for more information.
 
 core.useReplaceRefs::
@@ -1639,7 +1639,7 @@ gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
 	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
 	'--auto' the commit-graph will be updated if housekeeping is
-	required. Default is false. See linkgit:git-commit-graph[1]
+	required. Default is true. See linkgit:git-commit-graph[1]
 	for details.
 
 gc.logExpiry::
diff --git a/builtin/gc.c b/builtin/gc.c
index 871a56f1c5..77e7413f94 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -41,7 +41,7 @@ static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
-static int gc_write_commit_graph;
+static int gc_write_commit_graph = 1;
 static int detach_auto = 1;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
diff --git a/commit-graph.c b/commit-graph.c
index a686758603..a459272466 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -232,15 +232,15 @@ static int prepare_commit_graph(struct repository *r)
 {
 	struct alternate_object_database *alt;
 	char *obj_dir;
-	int config_value;
+	int config_value = 1;
 
 	if (r->objects->commit_graph_attempted)
 		return !!r->objects->commit_graph;
 	r->objects->commit_graph_attempted = 1;
 
+	repo_config_get_bool(r, "core.commitgraph", &config_value);
 	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
-	    !config_value))
+	    !config_value)
 		/*
 		 * This repository is not configured to use commit graphs, so
 		 * do not load one. (But report commit_graph_attempted anyway
-- 
gitgitgadget
