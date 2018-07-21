Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4983D1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeGUW7Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45311 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeGUW7P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so9537903pgq.12
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sIRq3f1pOVAv2YM85b88JEkvjBprDbwuT4SBbWpus7A=;
        b=qISm2vEstckGv2dWRU92wI3tRc0Vt8CBsLZh8Bf92FERMMDbfRlBrR+Ua7BZxJJROW
         PtZ0Pwmf14q9/0K0lZoVGWHT78V3Li+FYFwN8k4aV3Rf8oKT22jtIDXZs6D0MCCNgkEE
         F8zeBpHYLuB87VkrRn44UHt7rtDnP5exvnexFKWLF6cCLSMHVQkJrRTbSKXVwrSAHW5/
         0HbyBxV/Q71dw5tcg4nit4MWibcxLvuEEoPBMzoC/uXMKHiDFDRuPqA4Mky/4wcAUv0m
         VBtTEY5Vo1iJu0UrjD8jzEhB68JiYgLPpmUySs1ryuxpzs1s/Va1FZPNHn+QiPx93H2L
         XzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sIRq3f1pOVAv2YM85b88JEkvjBprDbwuT4SBbWpus7A=;
        b=i0xpyQf/Qvi+tYgEWGsdpdfwjl1HWX4daXs0VPtSyeGtfGv4MMJfw7U5cMsHhvomVm
         sVpMBR1THI804uhaC4HG2KbyjLOpFrfA7ZLO8QPJl8xU2dLsbhsxYmQxum9WjV+DD1Ns
         /k++0j4CzSU3lLZmKO++sQwaWTwjJnbr0Fg9XYVQgG+8gn4gr5SmgqsVj0zOd/6SHTVN
         S9jjqKmPekR9oe/cgE6rH1hEjosYlUZkYlzKho+eeZsDsyYnO/7fp+8hITvajSYwKlD/
         klV6HDU6H2BR9LOA+EgolhLVsO2aIJh1Kclin4R8NlzE78cf+Ds/LUx4jYDWhJWYHEmx
         2VNg==
X-Gm-Message-State: AOUpUlGFkNfpH8VgsL8wC8ho3L0kcOmKyVs/nTHrRCY0z0lesl7O58Da
        eh7V9tFv3Pc6m4FOQ+deuhytvRDM
X-Google-Smtp-Source: AAOMgpdbYpBuv4743tfZLDudHld0Zs3T3DnRUbqqr8SDdD2GT7TNvjf4K1sBOo55kDyZwBOQClCUng==
X-Received: by 2002:a62:5cc1:: with SMTP id q184-v6mr7340922pfb.241.1532210699480;
        Sat, 21 Jul 2018 15:04:59 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y12-v6sm7005655pfe.139.2018.07.21.15.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:04:58 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:04:58 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:31 GMT
Message-Id: <0a52f887887cae039ee84b90cc05a6396242a744.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 10/21] range-diff: do not show "function names" in hunk
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
index 8329f52e7..3fc3a4018 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -9,6 +9,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "pretty.h"
+#include "userdiff.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -307,6 +308,10 @@ static void output_pair_header(struct strbuf *buf,
 	fwrite(buf->buf, buf->len, 1, stdout);
 }
 
+static struct userdiff_driver no_func_name = {
+	.funcname = { "$^", 0 }
+};
+
 static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
@@ -316,6 +321,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
 	spec->is_stdin = 1;
+	spec->driver = &no_func_name;
 
 	return spec;
 }
-- 
gitgitgadget

