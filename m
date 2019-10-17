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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7861F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440994AbfJQRq4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:46:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34492 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440979AbfJQRqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:46:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so3370134wrp.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XvBExzE+u7QNRZzVxUUWijr/F6gCfBkJ0YChQTTxoss=;
        b=rmaCjMAWIY+nG9UlIPTYqGz2nkxP99ZhDTmHSG63+ufwqSV+8X8DXAVEI3qAbrW1A0
         lFF2vFyw/CCAY7zevWCRDurPx5AikIeVJp9Dk65A9iHipBXlKSzVPp0AtpeVRkVdhXMg
         qje7cEq8aBQKsGLtABV24Lai8Uyilk1kRuFqp2vhHi22zC0d32BXU9X0bd3Vn3OR7VdN
         ZRj+PEnKMFZg765nVRPYEYL6NPItCGZIMikuNnxV5FKwPILFxzbpDI21onWrE340fg8K
         rrq14FkooGBFDBKgvrxfyKPebQukGd0i4oAOl+WQAHuMUgI7JCZ1S2NK29bHgNSOwsK4
         hmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XvBExzE+u7QNRZzVxUUWijr/F6gCfBkJ0YChQTTxoss=;
        b=D7ViXiymHS/zwHURFswwrD2t9oIcGlSbkyaTOLFe28Bs3KvQyz05WOFfYZnt1XLkdt
         URmevBfhQ7bNNJDNtZIeZ2cEgszl4wwOpOl45MBpcFXcLPVMOR4mx/JuJLNLNAU6eSdp
         cRbmdV0mcUqLr/wQOp+Q5DNAU5XBduyJfwPbVfJphMG1sdW2SP0reYk6ctJwxrQmU5tq
         jC3TgE6acquKp6HkEHYAatrfiEtpcPJZ85x0lb3edffmyQuSwSRGiQXjL4Jw2zoJ4drj
         YCPKnSsQwHR1By8AFQtA0VjG/5zfTaHrdZgR3U6xA8XU6+emNOiZihcUSWbbbU8OWMWZ
         AO3w==
X-Gm-Message-State: APjAAAX6J3tyJH5Kb/AmHwRvXTvywZvcOQ0DdfHB4/w3G+9+ijIjvvRD
        L1Rt1sT/Cyx2zBFYAVTb8U6heie4
X-Google-Smtp-Source: APXvYqwm6qsnsCub60VMc2QHEsSjE25CWC7wS3jg/Ad3FBjgVRS6EV0Gb/KbghD22eKwK9sQ8JE1rA==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr4013310wru.21.1571334413944;
        Thu, 17 Oct 2019 10:46:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t203sm3367756wmf.42.2019.10.17.10.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 10:46:53 -0700 (PDT)
Message-Id: <838478a185322572ed4747eb484b678a8e2d7ac6.1571334411.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.382.v2.git.1571334411.gitgitgadget@gmail.com>
References: <pull.382.git.1571250635.gitgitgadget@gmail.com>
        <pull.382.v2.git.1571334411.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Oct 2019 17:46:51 +0000
Subject: [PATCH v2 1/1] builtin/blame.c: constants into bit shift format
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
index e946ba6cd9..10185ccdc6 100644
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
+#define OUTPUT_ANNOTATE_COMPAT      (1U<<0)
+#define OUTPUT_LONG_OBJECT_NAME     (1U<<1)
+#define OUTPUT_RAW_TIMESTAMP        (1U<<2)
+#define OUTPUT_PORCELAIN            (1U<<3)
+#define OUTPUT_SHOW_NAME            (1U<<4)
+#define OUTPUT_SHOW_NUMBER          (1U<<5)
+#define OUTPUT_SHOW_SCORE           (1U<<6)
+#define OUTPUT_NO_AUTHOR            (1U<<7)
+#define OUTPUT_SHOW_EMAIL           (1U<<8)
+#define OUTPUT_LINE_PORCELAIN       (1U<<9)
+#define OUTPUT_COLOR_LINE           (1U<<10)
+#define OUTPUT_SHOW_AGE_WITH_COLOR  (1U<<11)
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
-- 
gitgitgadget
