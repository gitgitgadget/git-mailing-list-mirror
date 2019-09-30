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
	by dcvr.yhbt.net (Postfix) with ESMTP id 584B41F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfI3Jzq (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33903 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfI3Jzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so13715229wmc.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1WrFUOjNOCYQ9G5fl078OoTy2uTYYjpRxw5Us+PnBoc=;
        b=jTNncJW2gkGVGMoPYFzNNHj2C9SDs72pOsyLwWpowtOcDzpPzBm+45YiZ2Q2o3uEzv
         Ot3FLXFST3e57ZIhGXIqaysaQwumgRUGurZrDgvCo6TDcl6JocCLHpVAa9CkqfnMJphG
         7mxXOQ/F+kI3f8tLa+j0cpvWRQK9YhghLCd7x3+RwpnbLMT/Be2kS+CazDYxam2uM1su
         k+QdnVRadvUdy9d+DQPbtmElzKsAvBvhF9Q+wl4XCUcY0gHppX1TH90IQ8GDeS2foMZK
         DzeRQ+BFejBvAghqY8C0k/mvyMS7kWkxvLR36PgyTKgD2TPJ69LYt/8Sl9su+PmGtERt
         oDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1WrFUOjNOCYQ9G5fl078OoTy2uTYYjpRxw5Us+PnBoc=;
        b=HQcnb3XAjJbc/EJn0hpxOxWFfFVZfnbzXckQ+0sniLGwiD5N9cmJrZIBUE45bwC7E8
         3OxahYYs2g0HA+h53XUy1AHRNpAbwGsRfBmNx/YGq2M07Fzd4VRsSjzOoyDd1t/ytGfZ
         y22cr9/XzkUkNJ2LVrX1NIMhUtG/Fp32beCeYPeSTUapYI36L586W+nwvveYEObxMbKb
         9xlsjcL+JSWVPWTtHLExpHX6nOkrx2c9nbajEwgHkfaSGU/yfb6CNWV3RShqZH/a/Yr0
         zhK9NPgOg3FqGKDgZDLMgEivu5mckh5iE1ydpqpMlBpRK4t7nyqB2uUvoz4HDnmjj64Y
         QawA==
X-Gm-Message-State: APjAAAUyUO1uVXt+Nf17hYZClrDFvrwwTfB1KHOZBpTWLL4eSInnBAKG
        STT9ciOlF8KiiW5I2V4rQQ8hhL0b
X-Google-Smtp-Source: APXvYqzcfZA6yMbimJzBZybNjzGsTG6TWQ1HcOLoU6kQBQyBs+u8yDH2Zh+FBV1OJSDRGJ4JDGh+Uw==
X-Received: by 2002:a1c:3904:: with SMTP id g4mr17233470wma.116.1569837339551;
        Mon, 30 Sep 2019 02:55:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17sm9679574wrl.15.2019.09.30.02.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:39 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:39 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:28 GMT
Message-Id: <bde1e8ef658c3978a85b58c3f2c4ffbd49a562f0.1569837330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 12/13] ci: really use shallow clones on Azure Pipelines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This was a left-over from the previous YAML schema, and it no longer
works. The problem was noticed while editing `azure-pipelines.yml` in VS
Code with the very helpful "Azure Pipelines" extension (syntax
highlighting and intellisense for `azure-pipelines.yml`...).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index c329b7218b..55ee23ad0f 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -1,6 +1,5 @@
-resources:
-- repo: self
-  fetchDepth: 1
+variables:
+  Agent.Source.Git.ShallowFetchDepth: 1
 
 jobs:
 - job: windows_build
-- 
gitgitgadget

