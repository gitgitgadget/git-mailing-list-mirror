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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF511F731
	for <e@80x24.org>; Fri,  9 Aug 2019 15:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407256AbfHIPA6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 11:00:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40632 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHIPA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 11:00:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so98496363wrl.7
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DFKO2Y6RdYqqFC92luOo3NuQfAXk9PB9nYMaKON8O0M=;
        b=RmPw6VJDHGIlZv1vz0Ypkua2juxfYgzplZqhr1zLxc5NbGjyxFhaVQnavtfuXbDKU+
         mxNhATBPP0mI/HKxHcUEXvq1QcmF18UuYeKPaTO/HQPt7u3SLC4zAsS6fnKoWBxcTMif
         cWg1JlKjr2XEHPD3A8AewyhCEEqlNH+cca4fSjzhwiSe/Gh1A7iGLhVtcuG6xE0m/fYR
         H/HRBCMFdwjuHCCjkStR/aWNbYmr7iNPFHtydh3bdD0unT6IvD7ZtZ0Vt93IJ/L1VsEp
         0WPJYegNrsQUdxmuE/GT83i2/aFseqKBIRFfGamSbGzrDmJWzkfnOPehwOAA05zlICTj
         KU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DFKO2Y6RdYqqFC92luOo3NuQfAXk9PB9nYMaKON8O0M=;
        b=ESKjVNDgUOzEjdQ/5B5o8J99BvDx0KvAd02MW9VQ4eUNuQwIdsqGGVHNIqmUDSVqZm
         4BhFGt3sVKYcPZ2xg9Rr4HzBz1Li/aTzDI8cnwgALxXEyhcqry5yvqq+ldQLv/LGvMN6
         4kMLFZA3/eeQKDvhvTUJiAxf8QtYvDDSisGdA1q1hj88h/srnl6+OkKzRO/O7j+Awx1e
         aDeliVdWAQPVUXea0fyYQg4JHXSYl2tDHQ+BZ5SpLZ8Gnt/LlY9JpjQL7vIn5deooRuD
         u9XOP/Bq75W/odmQPm4eJyvhe/GnDUdffh5PewDMXOu5M5UW25VlsD1Dps36fW8LCs7h
         mP7w==
X-Gm-Message-State: APjAAAX7Jw2U+cbtdQllwYxPnz+zUNB7yOhAF9Fwss245rs6XgWB8qne
        F2W7AyQHWhnMX2ag20n6XVNANDnw
X-Google-Smtp-Source: APXvYqxpKkRel9GALB5COGh2ck9N68NRr8BZVfEep6GnbWKS33+08Y/dbE5SURYXtV0Bg63ebuE6mQ==
X-Received: by 2002:a5d:4e45:: with SMTP id r5mr25056936wrt.206.1565362855723;
        Fri, 09 Aug 2019 08:00:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm85475908wrr.43.2019.08.09.08.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:00:55 -0700 (PDT)
Date:   Fri, 09 Aug 2019 08:00:55 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Aug 2019 15:00:48 GMT
Message-Id: <d5b5a70c1b0012e1fca29cdcbefa9df2155bb34b.1565362851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v3.git.gitgitgadget@gmail.com>
References: <pull.298.v2.git.gitgitgadget@gmail.com>
        <pull.298.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/7] trace2: trim trailing whitespace in normal format
 error message
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

Avoid creating unnecessary trailing whitespace in normal
target format error messages when the message is omitted.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_normal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 47a1882557..213724d5cb 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -142,8 +142,11 @@ static void fn_error_va_fl(const char *file, int line, const char *fmt,
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addstr(&buf_payload, "error ");
-	maybe_append_string_va(&buf_payload, fmt, ap);
+	strbuf_addstr(&buf_payload, "error");
+	if (fmt && *fmt) {
+		strbuf_addch(&buf_payload, ' ');
+		maybe_append_string_va(&buf_payload, fmt, ap);
+	}
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
-- 
gitgitgadget

