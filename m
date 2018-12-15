Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0382B1F405
	for <e@80x24.org>; Sat, 15 Dec 2018 11:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeLOL2D (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 06:28:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41727 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeLOL2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 06:28:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so7087741ljc.8
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KDejZoiRCdJlgiIo/ecPVYc10vkx+EzY8xGSu8cn5y8=;
        b=UD6g0n93vyt/JzC1m/3HsIAcVHFtqxCq1a3w5ipS1+rFvkoATWn1eLUAbG6M57sefz
         CyhLdOrMuaChF16+gw/up6Ni1QpIwPdHWHhRYKnapgcE3Uv/H8MDwiFJJqh3ijM/Fmb5
         Vpm8Pt36heGhbNQcqcM2QfGuG9Mpnd4DQyxkG3+ke5PtIE3V6rVgDPdtOUo1kBplQ6ui
         zGQ5OwRLb5DYEbAA/2jAWK6iCc9u5ZQi1zZhkHVVZYXDDWvLJoYpnu18zjEnxQjAFoh+
         v7ZHNSUzlnH1Q6z7xAdVugqRvpbRYm6sMGnLBzi4JWQ1YmKOC9986EiLhwV2lPdjMLF3
         LB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDejZoiRCdJlgiIo/ecPVYc10vkx+EzY8xGSu8cn5y8=;
        b=PaSPi/ntXL7M782HF6VEWqEZP+7/pUaaI53eIy3MicDIh3ZMTWK9E1hhW4nUg6llHh
         ipRnthP7rMmdc6WpnQrhpgeZDfLMaDgQsqFXily/J8f6bkIdF5ftvnQp6tRCUkySAGTa
         4UAyBIB4aBHinTh/08hGublQf8ZRAYqmWKqgFtkAAi6ON3XyZR6BNGTMol/KOq4/Y17r
         uwLQhV26Rt+dXPrAPm2EbIwGA+7tFLaIYwUTAOf1ETuNltgBBxuySEaoGYXZXrM2iEpz
         L55QNGLPFfrPdnzymCVBZbxVlQQk7I15xd+Q79RKXE6qXd5i6mcCS2ItghpxUYFMAj+g
         lsiw==
X-Gm-Message-State: AA+aEWa45TnMK8S7mtKbAcFxzKgrCCg8NjGJPNq6DiJAAHLFcWHNpm9d
        JqhoEFzbXXBdNpX6uJx3QLzdgRno
X-Google-Smtp-Source: AFSGD/W1ct9+R3bDzeqXz+/+ZCVwSAGpG6v/98aaUZCu0kH1SXfa5ViIhL2XU1AtnryW74bFpeHXDg==
X-Received: by 2002:a2e:1551:: with SMTP id 17-v6mr3736554ljv.68.1544873279787;
        Sat, 15 Dec 2018 03:27:59 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id t18sm1439174lft.93.2018.12.15.03.27.58
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 03:27:59 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] git-column.txt: fix section header
Date:   Sat, 15 Dec 2018 12:27:39 +0100
Message-Id: <20181215112742.1475882-2-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181215112742.1475882-1-martin.agren@gmail.com>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have too few dashes under "Examples", which causes Asciidoctor to not
pick it up as a section header, but to instead just render the dashes
literally. This also seems to confuse Asciidoctor about dashes in
general around here. It misinterprets the listing blocks in this
section, again rendering the dashes literally.

Make sure we have as many dashes as we have characters in "Examples".
This fixes the section-issue and, somehow, makes the listing blocks
render correctly.

Asciidoc renders identically before and after this patch, both man-page
and html.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 See https://git-scm.com/docs/git-column

 Documentation/git-column.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 763afabb6d..f58e9c43e6 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -47,7 +47,7 @@ OPTIONS
 	The number of spaces between columns. One space by default.
 
 EXAMPLES
-------
+--------
 
 Format data by columns:
 ------------
-- 
2.20.1

