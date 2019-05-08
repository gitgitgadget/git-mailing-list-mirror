Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F0E91F45F
	for <e@80x24.org>; Wed,  8 May 2019 18:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfEHSns (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 14:43:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56289 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHSnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 14:43:47 -0400
Received: by mail-it1-f195.google.com with SMTP id q132so5763746itc.5
        for <git@vger.kernel.org>; Wed, 08 May 2019 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QK0V/FgrwGTQ67n3+UeqcnYyiEjX8dldQ9yMvWHbrzU=;
        b=eNcfPaHigu/VzDiTzSLMemCGPvNds3QpcZX0g6HVid7bSLbM07Cgbp9cpqxvVe4Rt7
         7mHjFySTPBRB0cNrUisccbG4sdI4ymf1Qxj++cI1OUq4wlktTqM0TXHR5U193b57KsHv
         G7Vwtdp4OiJ8Hso/vRgXuXUxPTvthDLppPbAUQe0zqahsnxFYJIIYzhqsQcSk7DP9F7q
         LtQAMeSAauc9Cu8RfVHGtPvJkcLUfZv+gMUK+yOLUna0JJ8mFpmWKJEH2pby/flN0ef1
         U9nNcBzCmh0tozp6xi4A5n9RHGMItLufhiy6WwrYs+xd9sh0R1YZLWKjv6X1n6yy4DqO
         3oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QK0V/FgrwGTQ67n3+UeqcnYyiEjX8dldQ9yMvWHbrzU=;
        b=gOUzHzB72QfqfMffAesMfbILKBUh2RobDT1VfyMG0aUMcjf+rj2F45QNMrQ04EP0xJ
         vQRtf5Fr9I0OGvOcC52BkBbB8wN1gJHFnu5h8ccn6R07NQlkjuVEgOljPdJmn4Ie6buc
         n7tZtZlQzPOz74XqctAKTRPd9l1BC1EeyOLR+OaoN7BHrc0Gn12smnKzuZAOvwwEohIe
         b0Y5kMnOfhAGjDOdeR2SIsWXkY62wjV2fCNHniFa5FbEnxLeI9Ejgt+YDNoJDvalXPwx
         y3aq0ST86caZNAQDVS2Ov7p4M2CU+k4tbAOHty1SMPCUxJxPCXRgMWZoH3FBvhgbjJpA
         wtew==
X-Gm-Message-State: APjAAAW1uXe2ATW4uL3DuFXG9ME6BS8J6xpTo4jZnVUttNshaRproOHR
        jYR6M5QaZveOP1qNGMbRnF6pBdQw
X-Google-Smtp-Source: APXvYqwes9YaVKRha7ibhpEBuu/+8n4TukDctPndEmKSqB5SWQDB2fO/OU6a3vMxIbHrILZoEQcNyg==
X-Received: by 2002:a24:93c2:: with SMTP id y185mr4591013itd.95.1557341026664;
        Wed, 08 May 2019 11:43:46 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id a11sm4850634iod.11.2019.05.08.11.43.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 11:43:45 -0700 (PDT)
Date:   Wed, 8 May 2019 14:43:43 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] Doc: add missing backticks to pull.rebase value
Message-ID: <0e185c7c4b7ecb20631e1d330ce70ecf78427621.1557340984.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the documentation for pull.rebase, all of the valid values are
surrounded with backticks except for "true". Surround "true" with these
missing backticks.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/pull.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index b87cab31b3..6cdb2f320d 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -9,7 +9,7 @@ pull.ff::
 	command line). This setting overrides `merge.ff` when pulling.
 
 pull.rebase::
-	When true, rebase branches on top of the fetched branch, instead
+	When `true`, rebase branches on top of the fetched branch, instead
 	of merging the default branch from the default remote when "git
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
-- 
2.21.0.1049.geb646f7864

