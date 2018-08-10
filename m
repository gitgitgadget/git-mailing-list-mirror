Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2950B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHKAq1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43633 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeHKAq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id a14-v6so4973405pgv.10
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rZ4GGVQAMoFtK7W4eaVOoB2E1a/1FvCOzVhE/wJlg9I=;
        b=bqhex//14plTHC1zuUtc/wVtfuqpgTesNkwqsF2lVS7poGvdZAcN4fhzwjk9/x9UFI
         j63vHgYZyzevCG3e4NZ2tASJZiqJKpViYZ0v4xzz7L/uejiXMpjv8RbMruw1Rb/1EiIm
         MeYudLqi/RJkQI9vbs1dEYb9qHX8FCEyYnDtvtfqtLKlnyGgkxxK8Mdy6LxS1oBSvszc
         YSDQghbaHqI2xf9/suQOou6esi/NctBllyLQsCWNfcmqMsKCG1hWOavAjO0bDJ0GZAHV
         ptI6C1ebvN+Jp0/B8E+AKxy7COQgllUY/IkRVHwjtr1KwZBWkZuxLaGNf2yutoHCr6Dn
         HX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rZ4GGVQAMoFtK7W4eaVOoB2E1a/1FvCOzVhE/wJlg9I=;
        b=ZnC1lFKLUMt6xGk5L81O5heh+iVOKzuIjg1OqdnW6kVAlYq54HdlSfJwh2sVjA3py3
         uRuJTgl9tn7LEfhN4n/iNjsLcR5jSN2kEGzfY0olqiw0kURYpIp8R3xO1vPmB+1r1dmm
         +KonRszGXBkE2Mo8bJhyPrGKHKbc9ZPm8h+iIzcJ7ZlIMy3w+OiE6pUpce3gM3RVlQw/
         h5p5TzH9Z4k+8YQXzOWPWgYWgvorfwhdBEFlzZr8T76QPwHdYU183Bhrzv4oUMIr9+gu
         DAX+wIPcUtCt+0iZSA1J0w4cJgttvtAZAetFJfctZOORaKtFgRbfLp8K2hSyR/i+5urv
         D/dg==
X-Gm-Message-State: AOUpUlGquyJN9MYzatbKvK0L6XaxYA82RJ0tzRKNpSLlajSstogIVNEB
        5qkkGahFBe5opnKn4fWmtaAqJVr3
X-Google-Smtp-Source: AA+uWPxHKDIS7Pp18N1wjNIOLMIaJzLNNv+WKCziRCQqgLTRrap2reSSSfm8fCCG2q7A63atRRF5NA==
X-Received: by 2002:a63:b91a:: with SMTP id z26-v6mr8121525pge.22.1533939280940;
        Fri, 10 Aug 2018 15:14:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id g2-v6sm17297440pfb.79.2018.08.10.15.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:40 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:40 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:12 GMT
Message-Id: <c296675eb0d0f825213e948655ac13dc9bf51ec9.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 10/21] range-diff: do not show "function names" in hunk
 headers
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

We are comparing complete, formatted commit messages with patches. There
are no function names here, so stop looking for them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/range-diff.c b/range-diff.c
index 23aa61af5..6d75563f4 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -9,6 +9,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "pretty.h"
+#include "userdiff.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -302,6 +303,10 @@ static void output_pair_header(struct strbuf *buf,
 	fwrite(buf->buf, buf->len, 1, stdout);
 }
 
+static struct userdiff_driver no_func_name = {
+	.funcname = { "$^", 0 }
+};
+
 static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
@@ -311,6 +316,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
 	spec->is_stdin = 1;
+	spec->driver = &no_func_name;
 
 	return spec;
 }
-- 
gitgitgadget

