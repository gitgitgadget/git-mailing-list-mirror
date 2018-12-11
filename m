Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D831A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 14:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeLKO6L (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 09:58:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44032 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKO6L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 09:58:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so7232956pfh.11
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 06:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RB4H0OhUUMImR1XoEM5gMdKxz9z1l2QRRdsZk6JkZXQ=;
        b=QGwSMikQPunvXXaekz8ulcUm4AHQ9qpeA/FhIaPkpD7EhRyjy+plau5dPdOAgRFdUA
         OaDoCuGkCGES3rc7HH4zWlJqb9iYeCLhyAxslRHBQFNC8g36aCUyAGJzEc810AuHMpNd
         pXpQjnD/K5qE06wkGdsqVfYr4Xt5/t/MrSF5xAPRvajKtw3b/tj8qL3AVdqncOGDK/jv
         H5HMKSPpYDRmgIWv7UKR59v7ZBBPr2PBV5Bx59m3tZ9SdXBmark9y7F+/IyoE4+uxNDj
         ac4OZyy9RuvvN4DUUSINYR6rE5MXupJVGmcCfA0vzCkEbKcXJ+3XTbUfB71XZyo3n39w
         jKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RB4H0OhUUMImR1XoEM5gMdKxz9z1l2QRRdsZk6JkZXQ=;
        b=k856kH4LvBu9tRwg739vyrLh5S8cVfdLLfCNyeTHza+OF1SRpRCsvy1RCjBydhoHwX
         GhTCSc0jubK2sOamEwKPfZsNZQHGCSaMsKJkamNvhsLgYCTOPYybKME+jHP8SiW4gxc4
         dxYOYjZxrmkaUJoOEDE6w4Eks5NyOCP/9U7h5Zo3Mf8LO1a1ALqp4MuxTBkw8f9XxQc1
         iGh8VbSnV6GzTs9N+NFjkhoARSqzhM34xhXogjbP18mNQ9gRn0DmQS65ByGBdidMEGsZ
         JgBXbJ+5KbVwPA2GBTNEBf5TN2UfwGl7+1++n4Qx5gxvmLBRENVuOyAIr3NxPqB6hnhz
         myDw==
X-Gm-Message-State: AA+aEWYKA5o9utyYdG59vQQfvy38rzkGhL1Ad8mvhxHYT8T75gZjU/yH
        ms6SE0Gu+70BUi7tdAvuaBCStdna
X-Google-Smtp-Source: AFSGD/X/t0zi9gPgYIfTv/IpGXBAp7wGaJ1UFBYX8P9sqAg1/f+JGkvwqtDNAt2qiZ2+LkUz3lD1ig==
X-Received: by 2002:a62:4851:: with SMTP id v78mr16771162pfa.97.1544540290563;
        Tue, 11 Dec 2018 06:58:10 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id l3sm24814128pga.92.2018.12.11.06.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:58:10 -0800 (PST)
Date:   Tue, 11 Dec 2018 06:58:10 -0800 (PST)
X-Google-Original-Date: Tue, 11 Dec 2018 14:58:05 GMT
Message-Id: <9dcaace5075fd83463d9c3d57bc51123fdd1568d.1544540287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.97.git.gitgitgadget@gmail.com>
References: <pull.97.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] help.h: fix coding style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We want a space after the `while` keyword.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 help.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.h b/help.h
index 9eab6a3f89..a141e209ae 100644
--- a/help.h
+++ b/help.h
@@ -15,7 +15,7 @@ struct cmdnames {
 
 static inline void mput_char(char c, unsigned int num)
 {
-	while(num--)
+	while (num--)
 		putchar(c);
 }
 
-- 
gitgitgadget

