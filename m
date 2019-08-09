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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E56C1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 15:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436546AbfHIPBE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 11:01:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41751 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407249AbfHIPA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 11:00:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so95305786wrm.8
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qltHrhut4079hJXpE4qG7+O8t9VtgqAQ1eyQeghReLw=;
        b=VZ2yI9HEwPPURw5z4LcE+CQ1nMiGIF+sjPw2VNKuicVh9i6ZdnH/84uzwUB0aSV2V5
         6ipteYLAaNzJBWgfgHFDf+XAxRBGZC9MYeVvff67P2E/WViJQPfXFenDf7UrUQMEgGRR
         TNRDekHWxTsZAc1BdHh/EeJLE+fwRQYZcRcRCAL6GybF3IYct+cSSRON2UkGmi/c6xQb
         0uejPlOQlMrUq64gl/m2avuFcZ1V9/QEBULWTqT6xi0FG08Bpp0dYjwfEMeD9cqqKzKb
         Fp3fC6uc9DwAJd+xAlu8xYBwYuJbCquRNesQW9BAv6wQGMFpkXz5CTY0FNy3LuG4FsFd
         xv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qltHrhut4079hJXpE4qG7+O8t9VtgqAQ1eyQeghReLw=;
        b=WF5k268YD1VbUX+bcTYK2Xn3PR0XA5BrGIxBvvhT6kPL1lc9b17sZpMiMIerkYXwbi
         C+SBwGhTkBvusHmzvNcssY/ymloM/1MUsa/gPcJfJwThejphIAsQvFTAvb6oFCYMaolk
         7DtFJ2nVMsF1WF1ZvtrBi9sBBLGhHMDZBAlnwdgocjfGG9rhx2LBpNijrMKv2frI8Snr
         rj4WUhewds6+mXKZzmQyoP0UP+dKgtbaB73F3KcO/i583hBM2ufiP1FA3JK60qJNIgQ9
         uiS9kiVfH6xngoCqngyqCr2jFu9OhK5a5n3JxUB2LaA7diSBZbaMakCWyJIEDNf+TaKP
         Nk6g==
X-Gm-Message-State: APjAAAUYxfRiNs7jH7pM6v2O/czH6H5xTZnQ4ESgvLxCilCvYlWhN9gO
        IlI0E9C+b9QjzI4HJeG8FxLtUxoN
X-Google-Smtp-Source: APXvYqzuxlq3Dg3qtYzo74oOcJm3uEoso2DPOurNmw0Xva5AAbXEkbEUKKYzx7cZ8apK/X9KRk8Gjg==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5mr23152391wrt.278.1565362856319;
        Fri, 09 Aug 2019 08:00:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm103295356wrj.68.2019.08.09.08.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:00:55 -0700 (PDT)
Date:   Fri, 09 Aug 2019 08:00:55 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Aug 2019 15:00:49 GMT
Message-Id: <2002108a30246824f8017da1dea344c1a96f7de2.1565362851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v3.git.gitgitgadget@gmail.com>
References: <pull.298.v2.git.gitgitgadget@gmail.com>
        <pull.298.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 5/7] quote: add sq_append_quote_argv_pretty()
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

sq_quote_argv_pretty() builds a "pretty" string from the given argv.
It inserts whitespace before each value, rather than just between
them, so the resulting string always has a leading space.  Lets give
callers an option to not have the leading space or have to ltrim()
it later.

Create sq_append_quote_argv_pretty() to convert an argv into a
pretty, quoted if necessary, string with space delimiters and
without a leading space.

Convert the existing sq_quote_argv_pretty() to use this new routine
while preserving the leading space behavior.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 quote.c | 18 +++++++++++++++++-
 quote.h |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/quote.c b/quote.c
index 7f2aa6faa4..c8ba6b397a 100644
--- a/quote.c
+++ b/quote.c
@@ -84,12 +84,28 @@ void sq_quote_argv(struct strbuf *dst, const char **argv)
 	}
 }
 
+/*
+ * Legacy function to append each argv value, quoted as necessasry,
+ * with whitespace before each value.  This results in a leading
+ * space in the result.
+ */
 void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
+{
+	if (argv[0])
+		strbuf_addch(dst, ' ');
+	sq_append_quote_argv_pretty(dst, argv);
+}
+
+/*
+ * Append each argv value, quoted as necessary, with whitespace between them.
+ */
+void sq_append_quote_argv_pretty(struct strbuf *dst, const char **argv)
 {
 	int i;
 
 	for (i = 0; argv[i]; i++) {
-		strbuf_addch(dst, ' ');
+		if (i > 0)
+			strbuf_addch(dst, ' ');
 		sq_quote_buf_pretty(dst, argv[i]);
 	}
 }
diff --git a/quote.h b/quote.h
index fb08dc085c..ca8ee3144a 100644
--- a/quote.h
+++ b/quote.h
@@ -40,6 +40,7 @@ void sq_quotef(struct strbuf *, const char *fmt, ...);
  */
 void sq_quote_buf_pretty(struct strbuf *, const char *src);
 void sq_quote_argv_pretty(struct strbuf *, const char **argv);
+void sq_append_quote_argv_pretty(struct strbuf *dst, const char **argv);
 
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
-- 
gitgitgadget

