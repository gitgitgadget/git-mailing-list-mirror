Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05141F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbeISWJa (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 18:09:30 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33054 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbeISWJa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 18:09:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id m26-v6so5722006lfb.0
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUrE/mMMyuFxYmZFu42KeQqVpzwkfCag2MqlTiQzdnw=;
        b=rLvdIK27gCRY7EI4SSomAuy99XzyX/Tsf3z3JYGTMm66r2aMgc6TLUONjsruURjR1m
         dY2BiZN7gG47OlMcANTW3V8/h63LZsw2sPM2VRzE7L9Roz/rEWgYTPbRL+Up0VedQz4w
         qNrSbtqPTsLTpDOxJOM8y7ry1vN0rsRQqY5MheUVjjkSaZQys2cxM2TyEkAFlrkp8bLW
         0oGNyX5OP4GCLbt3Y7bmf/lt1QwhJHDCadw3ZO0iNavx2WHuFe4GBAwzrlm7vpZijV1N
         dNs2AuI5QSB58kQI5+RySITaXTMYl2SadRbY5YvqtC/oJsx225qnpQ0vjLPxVnqKE6YS
         Q6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUrE/mMMyuFxYmZFu42KeQqVpzwkfCag2MqlTiQzdnw=;
        b=img9lqV65iP+HOukQ/wcJtFE3xu8oOGl+mXhwEfLfchwMgw4ZeN/fQWFuGVSKehhUI
         DvEXB4uAxGhWOxW6+ehkDdGRZRjGiWHoxE6IXbdBYfx8aMokntz+BjHpd/oJIZtPOFP5
         bQRNu/D+1JxkmIn+vIRCt6G/FWI290IKTE1jNtZwKvqWs9zlJOT+FsoZZZv1uSQcT6fL
         vZDQ4RBnMk8wAqXwJC41HVghhrhd2D10U5jHVqGL7P3Q9X1oVWV4AjSXZ486Z08J/gqZ
         rldbm8RQmqQx/MrASyeIJaOgiGgrTeuxdoZxbOGtdus6Bdpq+sRmH4Ajt7BQxlUAzWkw
         p45g==
X-Gm-Message-State: APzg51AZCe2se0uvZeG+LwzmlyWHNmQs8C5uZ060CQoaZATI/V4cVI79
        3Jj0B0hADvOSkZRYtB12X9cqllhJ
X-Google-Smtp-Source: ANB0VdajouM4yNAZAU+PpKuAvvxRcoH791VkwcoBkQK5hQi6qNdez5V0tWf/mruSr7nrNsnpmG2rNA==
X-Received: by 2002:a19:dd8a:: with SMTP id w10-v6mr9849397lfi.97.1537374647727;
        Wed, 19 Sep 2018 09:30:47 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x8-v6sm3903594lji.53.2018.09.19.09.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 09:30:46 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 1/4] git-commit-graph.txt: fix bullet lists
Date:   Wed, 19 Sep 2018 18:30:32 +0200
Message-Id: <222721870b74742fd2fd20816a8e351b28e788cc.1537374062.git.martin.agren@gmail.com>
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

We have a couple of bullet items which span multiple lines, and where we
have prefixed each line with a `*`. (This might be the result of a text
editor trying to help.) This results in each line being typeset as a
separate bullet item. Drop the extra `*`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit-graph.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index dececb79d7..f42f2a1481 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -73,7 +73,7 @@ $ git commit-graph write
 ------------------------------------------------
 
 * Write a graph file, extending the current graph file using commits
-* in <pack-index>.
+  in <pack-index>.
 +
 ------------------------------------------------
 $ echo <pack-index> | git commit-graph write --stdin-packs
@@ -86,7 +86,7 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 ------------------------------------------------
 
 * Write a graph file containing all commits in the current
-* commit-graph file along with those reachable from HEAD.
+  commit-graph file along with those reachable from HEAD.
 +
 ------------------------------------------------
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
-- 
2.19.0.216.g2d3b1c576c

