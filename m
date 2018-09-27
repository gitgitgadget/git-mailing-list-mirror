Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A671F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeI1Bcb (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:32:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46754 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbeI1Bc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:32:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so3456214ljj.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PM8NodNoCMgmmCjvNiZ+IdLKLyYyayNmC1YFlDwuJlM=;
        b=PdJ/L702XsBUmmlgp8yPOQPyF/js6ZHb3b8cMLE3Cv0y5e/zZdrSykmeavFaUXYwPl
         Ebed6AcXj40BcfIYuWRLZOXU5MqFumIyDaZZZJIMVNIWv9kIXVt9e3bDpdysOviopQUx
         ER3kmg9h4DTJAjQq70V8PpFVbpKTJO/GzcX0RLxLXnXDvieotVYRg8GA8sEnZFxgGAmu
         v+M22UHg3ixpHn/xUercBgm+kdJUCvjgQ95XZ7VoV4JAzdbt4Ukl8+s8oWkdFbFpCr1j
         jsJ1KdFHF5rGnbaJd1CWPXuLpF8AETzLnf3Rp90I/CRUinPL2mqQNS++o+04hrPeuU+u
         W8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PM8NodNoCMgmmCjvNiZ+IdLKLyYyayNmC1YFlDwuJlM=;
        b=LW4WKqe9TBsyq9kpyTO8wOmwTNXHm6l4kMoVj/ReK30fTu+FWn344hDV1q6RB1XWg3
         3Uj0SY0KYh1a9MPdP3AMq3UZKLXh9GYbxGSn5xm+9RQ0OgcfiVgFp2pN5iLV3x/epO/s
         eegaC093JcGYo9T3jZjxGcXf70cgC1yueyWGKndLbVxKfNN7BqE9mtO+K9J4kUmf5ziL
         lbYTZmHBGptRowEJQyrAv+nAJwu7guKDbkCJxev2599ZGVBu0vW2/0Uk7dMn9FteGmXg
         OkDVMYCssfcwq4Mu7WstStvSee3xAzg/Fj5N6IiAXX5vyC3CJsbySVa4WvUoBaJplRiU
         JdqQ==
X-Gm-Message-State: ABuFfoihNCff0WBNEt3dfAHhl7gVynsA/DH8AnaYKL1BHHAtxd6A+B3z
        0YJ+DhbjIL4UWqcUoTcO8OPRgXoh
X-Google-Smtp-Source: ACcGV63adyF5UAzWI3pamtsbMcLD0rXPkIB+NdOgvHfBeZ8lljT9tQCEgfZ5rJNyKWJ9ekjSYXCYcA==
X-Received: by 2002:a2e:44d0:: with SMTP id b77-v6mr6741246ljf.47.1538075562358;
        Thu, 27 Sep 2018 12:12:42 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id r79-v6sm561673ljb.84.2018.09.27.12.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 12:12:41 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 2/4] git-commit-graph.txt: typeset more in monospace
Date:   Thu, 27 Sep 2018 21:12:20 +0200
Message-Id: <9759a162ca95c3ff9478f0947da3bed9e0493dac.1538075326.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <cover.1538075326.git.martin.agren@gmail.com>
References: <6b1cb43e-a1a8-921f-cd66-3697609854e0@gmail.com> <cover.1538075326.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While we're here, fix an instance of "folder" to be "directory".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit-graph.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index f42f2a1481..6ac610f016 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -25,9 +25,9 @@ OPTIONS
 --object-dir::
 	Use given directory for the location of packfiles and commit graph
 	file. This parameter exists to specify the location of an alternate
-	that only has the objects directory, not a full .git directory. The
-	commit graph file is expected to be at <dir>/info/commit-graph and
-	the packfiles are expected to be in <dir>/pack.
+	that only has the objects directory, not a full `.git` directory. The
+	commit graph file is expected to be at `<dir>/info/commit-graph` and
+	the packfiles are expected to be in `<dir>/pack`.
 
 
 COMMANDS
@@ -66,14 +66,15 @@ database. Used to check for corrupted data.
 EXAMPLES
 --------
 
-* Write a commit graph file for the packed commits in your local .git folder.
+* Write a commit graph file for the packed commits in your local `.git`
+  directory.
 +
 ------------------------------------------------
 $ git commit-graph write
 ------------------------------------------------
 
 * Write a graph file, extending the current graph file using commits
-  in <pack-index>.
+  in `<pack-index>`.
 +
 ------------------------------------------------
 $ echo <pack-index> | git commit-graph write --stdin-packs
@@ -86,7 +87,7 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 ------------------------------------------------
 
 * Write a graph file containing all commits in the current
-  commit-graph file along with those reachable from HEAD.
+  commit-graph file along with those reachable from `HEAD`.
 +
 ------------------------------------------------
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
-- 
2.19.0.216.g2d3b1c576c

