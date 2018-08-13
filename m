Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B25B1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeHMOPJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:09 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38297 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOPI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id u11-v6so6776280plq.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rZ4GGVQAMoFtK7W4eaVOoB2E1a/1FvCOzVhE/wJlg9I=;
        b=XTYGh3yspFlMks76ymVa/F5JRYyVuqK2MiWIhQzsyLGM5RgMfiQ8c4+BPvay133CrW
         HAOv6G5a6OYKANqMNZ4VFucgid7zmhlo3mZ2CGVAdMYcqcYpbISZNa4v85TFNiFGvqn4
         TvyRTY2XzfPQAnrzPTDNK07hIvwpTo6KemjI2j8DA3enFMWJHuQ83LUZSB7d2gDvMzt8
         sTQLKZnf2fHQKezwzncVnXvwM0RB3fbzvzFnagMJgqJDVURFGJizeIRkHk9UmScfxfx/
         HpFX4CCJH4vP/x+v4UUN7GzOGU+PFPS8Og0BG2x3Nghp9M87YnvHXiXqmgkdiM1yGaYN
         2spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rZ4GGVQAMoFtK7W4eaVOoB2E1a/1FvCOzVhE/wJlg9I=;
        b=Dn1vAsgoiv57SLjP6kqXz9pOLGfrtnYWz71e0gc6IMlc+OY+rYhvDKfmoPoJODHCrk
         Chk7TjJ67H/rjMmR6SueS1oAyUVkxbSaVfp5EqNK7DWVSXVxVR0L9BNSP+LDhOiZ69P0
         /v3pRS0au2xSh2rgvVPcFJTWQmCX9hHcamhEmeek9yxp0vbLABXDNmOSvwgQ9r6Tr40F
         r5q5leS66fKGkbluLjFzSS3iHmPdxEE+cXtNGMWd/tQJ8plmmH0CRKUxA7KAvlglKyB8
         mRBTiCzFJNed1wXCAwTBYJyh+iksdrOLYuUgNrSDrqkBEETolJYqVkb26wRpq5JXhuwK
         O8Tg==
X-Gm-Message-State: AOUpUlGb3yC/OUV/BYsl/GSVou+ZJzFGzy1PYAMOMJRAceiiN+hwcdoC
        AsphBLHJTR94ij/Nveivp1W+xV+H
X-Google-Smtp-Source: AA+uWPzOtb8sUFGSNLRbNJU89t67lwFN5fdzWJEIdrDBp1L1OGYxG7RT5u99t+3kg7m07nR+t/zgoA==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr16211157plb.108.1534159995702;
        Mon, 13 Aug 2018 04:33:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id n22-v6sm37238359pfj.68.2018.08.13.04.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:14 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:14 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:45 GMT
Message-Id: <94b44dfe6859fd79803d682885a6a52ad800eedd.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 10/21] range-diff: do not show "function names" in hunk
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

