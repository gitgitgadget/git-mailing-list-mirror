Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC78320248
	for <e@80x24.org>; Fri, 12 Apr 2019 11:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfDLLjq (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 07:39:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36196 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLLjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 07:39:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id u57so7412145edm.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bmLxfGOYFkRPzwOfAScQZAJO4Qb6uuc5fdvNBwHewN0=;
        b=r9TjTW7q1sLeka8dnljCaMmTKywPPXiZ2XLlb4a8HQ/qb9QEUeXhqwpN2WBL+nji9A
         z7g9g4kixuoqCqUD1qtJi13uRN7KTnIwmnFsq8COZoz6BuWxY9ml8uLJCHo2IaD8b2Kt
         4YoWRVO9a5uLMKKbkne4i9I2uaPO6GTnihbhipGaiiBhq9J+C/yBZALc+xNSaWmF3qMr
         XIvwbEPy3dak8+VQlVxKIJLVAk4VCK/Sa16AARpeD7oIdO/s+O5UpSw79eJaxhLb+i8y
         knZm+TXVz7CRLCF/Z0PZPAMXTgJE9Rix/7QnzcifQtvbtTXCiEJScnQiB42Yc1xgOHgS
         Xf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bmLxfGOYFkRPzwOfAScQZAJO4Qb6uuc5fdvNBwHewN0=;
        b=S8dDcLgifg9wUNrsqa9mYnJuB/jjTlC4lbA5tjHZ7RlNizBGTXUH8AlOXeZfdepGrO
         QAaVKtcGDHIh6qRrXeRD9Vsiiyx31zWkEt7TkjWZNh98nwKewhpzRw7w/6uUloubTFjt
         Yp5qfDg9NHUASdR8KXmma7L1tTXBTfRTivSUimEfEBnjcjCHKjsCCTLHfa5YcTJ8iObt
         T2V1uj7FM1TmqkdW/2ekx1g6usmkaLuw5fLaIdZXFIQ7ECYf6V3vKIw4HD9UmHxLCr3L
         HqItKss8yqZA1rVuv0yxVlwL/8x79Fp5GoWrHDn+QuIJA3uoiztnfsx163qSrnG8cZm2
         hDDA==
X-Gm-Message-State: APjAAAVSwbv32Itc5WVCj+Nz9JMOTVSYSpkzSctq0FP6aXM55MEBnd25
        SyGBNFrPrTFI0RmxVeL/aCP2Doiv
X-Google-Smtp-Source: APXvYqyTbjooNPuG/ZaTFivKFqCySin6Jm5cTc7nurhQJjMmS6PiMk9eK7gsiUUQkSKwQ/t/eOuItQ==
X-Received: by 2002:a17:906:4c4e:: with SMTP id d14mr22277550ejw.127.1555069184548;
        Fri, 12 Apr 2019 04:39:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm1487129eda.26.2019.04.12.04.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 04:39:44 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:39:44 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 11:39:41 GMT
Message-Id: <f006524f78a881b4f4e06cb15b877f8a226a9843.1555069181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.179.git.gitgitgadget@gmail.com>
References: <pull.179.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] macOS: make sure that gettext is found
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

Due to reasons (some XCode versions seem to include gettext, some
don't?), Homebrew does not expose the libraries and headers in
/usr/local/ by default anymore.

Let's help find them again.

Note: for some reason, this is a change of behavior caused by the
upgrade to Mojave, identified in our Azure Pipeline; it seems that
Homebrew used to add the /usr/local/ directories to the include and link
search path before, but now it no longer does.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 41e85fab1c..3605fead53 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -114,6 +114,8 @@ ifeq ($(uname_S),Darwin)
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
-- 
gitgitgadget
