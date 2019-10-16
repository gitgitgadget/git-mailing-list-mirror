Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFEEA1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 18:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394236AbfJPSak (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 14:30:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38611 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391082AbfJPSaj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 14:30:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so3844998wmi.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nQ8B3Sl0FQwDmOH63HhFurD2kBA6/qcJtuwkl2Zva+A=;
        b=rTD0aiEo1etluyAf69YzMBXaA2d8hRbv5zHpSdmY69mlCYr+ldU8eAZZT63NKQrUdR
         NQJma6W/s89vXtTcaHYIbjf0CUdNpdVWBWUopu8unTWmA2VeOd2oUREfBEGqf6xc08zJ
         yOCrD+dxofg6N8YL+wYYEyUcreSOmSVXcuoZzjGzYNLvar09Tp6LsPlpc5eF9HU3yLPP
         Cv+65UKdGK6mvWlPBRi485FhT3rZG+4JbV08thyoWp9QEqn2Gtx+8VM5dUn3Zq2JAuQQ
         bQ6p0V+wPKxdYZFWSuMRE5vB3xKhXg5McOnmrjIHDE2EEovar8eQbcS6pP0suBeVx55j
         7Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nQ8B3Sl0FQwDmOH63HhFurD2kBA6/qcJtuwkl2Zva+A=;
        b=KnYHo88Oz/vz1b7FyMWSAVqnQpzB1vURXr8VUL6GPSnNR7NaPz+mBGlsfhoFF40skj
         RvWkOzoKtkRtJOkMWnWc5hKYBoZyLPuKaj1rt71IspvAFlQSrcW2Y8ycJq7Fw7C62aiy
         cym+bURdyWlkViwNtENusz5Ckqa5O/hHLnS8MHTfSnJYoorjNWYPEE7ZgMxzysA/wS31
         ShUo+1fR0TzOtO7jOO4b3ycUUFWUSHWAVuvfJh2sabCxthm0CTHELU1UF2cwMF+nhgu8
         RfRpbObhQYLPYeo/4BlNu2id5oEPKI3LRMqjrMKXZUlqni+QaKdAkxpInGWSRHDS0F2P
         mQWg==
X-Gm-Message-State: APjAAAX1Nb8/7ajbR4qY52pfvUAh++zY41ONXV6uMSLdGMelHBU9AXfT
        VpBM44reDZzYH5bWno9N4CNOEuGB
X-Google-Smtp-Source: APXvYqxr5iKDcaU9qONeul7WaypsyNy50p2VkBReykik62G0mcVXB4zaUg1OuDEDwkTsSIJjrfyzdw==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr4636498wmk.30.1571250637694;
        Wed, 16 Oct 2019 11:30:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g185sm3776523wme.10.2019.10.16.11.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 11:30:37 -0700 (PDT)
Message-Id: <3b4b8e0353d705ea649c9fb608c021b35e6d8f5b.1571250635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.382.git.1571250635.gitgitgadget@gmail.com>
References: <pull.382.git.1571250635.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 18:30:35 +0000
Subject: [PATCH 1/1] builtin/blame.c: constants into bit shift format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

We are looking at bitfield constants, and elsewhere in the Git source
code, such cases are handled via bit shift operators rather than octal
numbers, which also makes it easier to spot holes in the range
(if, say, 1<<5 was missing, it is easier to spot it between 1<<4
and 1<<6 than it is to spot a missing 040 between a 020 and a 0100).

Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 builtin/blame.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e946ba6cd9..a57020acf9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -319,18 +319,18 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 	return time_buf.buf;
 }
 
-#define OUTPUT_ANNOTATE_COMPAT	001
-#define OUTPUT_LONG_OBJECT_NAME	002
-#define OUTPUT_RAW_TIMESTAMP	004
-#define OUTPUT_PORCELAIN	010
-#define OUTPUT_SHOW_NAME	020
-#define OUTPUT_SHOW_NUMBER	040
-#define OUTPUT_SHOW_SCORE	0100
-#define OUTPUT_NO_AUTHOR	0200
-#define OUTPUT_SHOW_EMAIL	0400
-#define OUTPUT_LINE_PORCELAIN	01000
-#define OUTPUT_COLOR_LINE	02000
-#define OUTPUT_SHOW_AGE_WITH_COLOR	04000
+#define OUTPUT_ANNOTATE_COMPAT      (1<<0)
+#define OUTPUT_LONG_OBJECT_NAME     (1<<1)
+#define OUTPUT_RAW_TIMESTAMP        (1<<2)
+#define OUTPUT_PORCELAIN            (1<<3)
+#define OUTPUT_SHOW_NAME            (1<<4)
+#define OUTPUT_SHOW_NUMBER          (1<<5)
+#define OUTPUT_SHOW_SCORE           (1<<6)
+#define OUTPUT_NO_AUTHOR            (1<<7)
+#define OUTPUT_SHOW_EMAIL           (1<<8)
+#define OUTPUT_LINE_PORCELAIN       (1<<9)
+#define OUTPUT_COLOR_LINE           (1<<10)
+#define OUTPUT_SHOW_AGE_WITH_COLOR  (1<<11)
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
-- 
gitgitgadget
