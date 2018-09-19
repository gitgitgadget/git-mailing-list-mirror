Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E330F1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbeISWJc (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 18:09:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42426 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbeISWJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 18:09:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so1944962lfj.9
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PM8NodNoCMgmmCjvNiZ+IdLKLyYyayNmC1YFlDwuJlM=;
        b=AvGDArE7WDV9lenDzsHI+DWGm+OE6lHgHvbg1NZwMjMsJxV6mJy28Y7cq5AynrHeRW
         VVHYQ7/KwyJBadadvO4XAP4OE6yWuPgLZd7d8a/fj06RLEDe/Zl0vdFXpHSCHlBWAplC
         iIP5UndHgZjinRwuXZQ7B9DO6QLvmWToToT7h35oyl3LOR8k0UOECVIncnq1jPnrN18b
         Sn28mPZyhn2MeM3vbx7AdX9nAAknuSN2EUOGNJwvO3ruQCUpgVftnknRLpQaKT83TG0c
         Wz33Hb4Qw/ArFc8P+UU9L6N/qx17ju9E/X8D0Lwfefhc1//UzrEe7Yhm40WI1P8eQcr4
         gvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PM8NodNoCMgmmCjvNiZ+IdLKLyYyayNmC1YFlDwuJlM=;
        b=N6oyniLUCYMh4Gs8p5gQPntl0TwhHA6W0R0nO35dmJgzdE894+UyaLUcvjLw6YBpNr
         HXVTXGizufoRjvTtxaM3cf5oOaCOOJWTgFLC23WKgSDlsCyUBnkXzPjFZSOZ1lE/PheN
         lo3xVM1Rt5Sy/s2L7ulSNagBA07ba5jrucrSN0RhOR1xKfs5XVI8/MHQwsdm7Uchj5n5
         XIazgd6tOiMmGTSFGU6dPVf1JKp06tNs9VEdRNFK3pKb1W/H22BmzPdVDyFb3RIhB/WS
         1xmqZRAqqxRlMyfeSfoDT9JBy2GObMkI6ORXSbcAHSurZRiEGxNgQQUflqYQSQz7eXcm
         5xsA==
X-Gm-Message-State: APzg51DX4s676IrfbF9JQmpD2nKCUA4mxgu1FjOOkJS+B6Lz8yKB/EJV
        hHveVazq9d9xmRLlY41z+ofQQjXm
X-Google-Smtp-Source: ANB0VdZp7ehU63iq3IuO1pbNUbK0/bedkPFbFMtXpuDwVXxmE915v9gV90tErtePLFa2KnABCeVrXQ==
X-Received: by 2002:a19:3b0f:: with SMTP id i15-v6mr6239111lfa.56.1537374649933;
        Wed, 19 Sep 2018 09:30:49 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x8-v6sm3903594lji.53.2018.09.19.09.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 09:30:49 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 2/4] git-commit-graph.txt: typeset more in monospace
Date:   Wed, 19 Sep 2018 18:30:33 +0200
Message-Id: <acac5c3584b1cc7cf36ce4f7800738548eba8ccb.1537374062.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <cover.1537374062.git.martin.agren@gmail.com>
References: <cover.1537374062.git.martin.agren@gmail.com>
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

