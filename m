Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAC831F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403859AbfHHOTI (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:19:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33450 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403825AbfHHOTF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:19:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id p77so4093592wme.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zGh8KIuph3vSSw62JCpgp0Zk+YDdXpBALb4SPAp011k=;
        b=Pe6kHhvmmeRBApfLc3ZE5r0zZNuIuSvo1TfhCQ2Bo6G/VXcyMYOwiBg+d7wfPlBXdN
         98p9HjMTN4vn5FkSPkviSQ8ZWa4YgXAGNbm22WXaRpDrCZbcoLeX3jaa961bly5pUD8Z
         DT5PCnZy6xAvMHltu0dri5wbdHk6J05qEiwIT39VT6R6W3mKIUu/Aa+YTBEy9O4EJZSI
         M5FMt4xcN55OcXCVPWe9RSiI17oztoGH58dBWty7llD9l5jGMe0BcLioHzW5fY+JF8/J
         Isvxmo3uo0IqPXMG4d+hh85w0wzqw0tqbW9hbGtE1SPDDdOP1EWoWpYl7NtcNOtCvTvf
         4OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zGh8KIuph3vSSw62JCpgp0Zk+YDdXpBALb4SPAp011k=;
        b=IWzDV5wV2JDanR4Zf6xelLFcaJnuvMA49nPBcP6MMTNw6GJaetWwObwORTPcv3oL6j
         RYdsrg01IeiArfZn247Kq9SjEdnOlP6XNt6/Ja1xgE6RP2NYofNVclA/mlWu7mpD2eiI
         Jy5P5dYxC5rs4qU3jWLj0xqDCjNeYxDPzJg87SizAfbuooFFrT2lwXAQ7QPQ0vpPc6KF
         2IyHFBC0sR+fOisz+XEB8hlmhz2+kc5XkLyv5zo3Mos2GZcIXjcte+MP4vNBZhRzSt82
         R5piteJnhdd9Ex2dRSkSAQm7CO3Vz1l6jb/HDDqBSnlH4tzNYfkGJm7Pmb+N47iOvx/h
         01Tw==
X-Gm-Message-State: APjAAAUVtSYiNci9qI2z1NkxgjuiEt0MvH+Tra10VWFtRfjidfi/tUaQ
        KJKWEwCqeb1UWioH4e2mZonNIii7
X-Google-Smtp-Source: APXvYqxC2BDRZnxV5EyT/v8NACkwG3jJcZa8hHtpvfaII5ugI9aPhI8KK6T1KPKPeJDk0+JEnTTY6A==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr5011579wmf.0.1565273943299;
        Thu, 08 Aug 2019 07:19:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a81sm3384120wmh.3.2019.08.08.07.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:19:02 -0700 (PDT)
Date:   Thu, 08 Aug 2019 07:19:02 -0700 (PDT)
X-Google-Original-Date: Thu, 08 Aug 2019 14:18:56 GMT
Message-Id: <5059776248b6686faaff37c97aa63d0212579cd8.1565273938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v2.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
        <pull.298.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/7] quote: add sq_quote_argv_pretty_ltrim
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create version of sq_quote_argv_pretty() that does not
insert a leading space before argv[0].

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 quote.c | 11 +++++++++++
 quote.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/quote.c b/quote.c
index 7f2aa6faa4..7cad8798ac 100644
--- a/quote.c
+++ b/quote.c
@@ -94,6 +94,17 @@ void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
 	}
 }
 
+void sq_quote_argv_pretty_ltrim(struct strbuf *dst, const char **argv)
+{
+	int i;
+
+	for (i = 0; argv[i]; i++) {
+		if (i > 0)
+			strbuf_addch(dst, ' ');
+		sq_quote_buf_pretty(dst, argv[i]);
+	}
+}
+
 static char *sq_dequote_step(char *arg, char **next)
 {
 	char *dst = arg;
diff --git a/quote.h b/quote.h
index fb08dc085c..3b3d041a61 100644
--- a/quote.h
+++ b/quote.h
@@ -40,6 +40,7 @@ void sq_quotef(struct strbuf *, const char *fmt, ...);
  */
 void sq_quote_buf_pretty(struct strbuf *, const char *src);
 void sq_quote_argv_pretty(struct strbuf *, const char **argv);
+void sq_quote_argv_pretty_ltrim(struct strbuf *, const char **argv);
 
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
-- 
gitgitgadget

