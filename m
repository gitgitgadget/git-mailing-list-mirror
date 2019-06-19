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
	by dcvr.yhbt.net (Postfix) with ESMTP id 764CD1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfFSVGK (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41664 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFSVGH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so1263581eds.8
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DSglU3HprV3qOQP85ARxY9TDB5rasZXGc/9TjR3K0J8=;
        b=DyD1Rmh3PJhy2DWcxCjgehDzwXwZYT+yI6WePFb2in7cAztEH6yLbyqTZd1KyYtFlG
         i2TlutDljof3+szF3ZBUoTcaeR1mFZXgjYPC3pW0IVMr18ZgGLO26PRbsDHLp2xjHefU
         CS5Mor+HWnnOVOHoPIYErc6gXkH4HaGdAtQQTdTqPrVXWRAMqP3STqU9WmhAMHzOZ6rr
         Ada/M+v43DHnybHlwbM6yYkvqmmHD+Z0kOaY9KGlN7I8JONmoD93WIJYWXwi4Yjxdzlb
         nFh5UnoK/gZfnEP2tduCIKjR5/WM6d1On4PiPNORuJQbKF/N4BOzN/yhPeKaFLspjDaI
         TFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DSglU3HprV3qOQP85ARxY9TDB5rasZXGc/9TjR3K0J8=;
        b=qVQEBSGyJsVrxABJKFHkbIMJgFPvTlKt/LeC6mivMqE7EIZ4ZEPRL8VY8/fICG92IZ
         ecKfnOYZs/s1dHoG/rWpAuW/pArnt/3LtgfzC2CWLpBlxYb7C8cY9bccs7kkUDyTig2c
         7AixENfnzPSg+ApILAbiYckBvetfTwjWZhjggSLpCQcC6EnAEdm5jkAVcLMkfSiaf4ck
         +c1eOWgo0dI1er7db+ili+vKuMP4eTbDqRWhl6HbRrcQXNrVXMVWiKeiwGOONYl3GClq
         jRloRuzSMhC2iva3xFJtyNExTQbX8D0gEacVMeel8LgLdCfU3EaAoX7iP9dM/zS0tH4K
         l5Ow==
X-Gm-Message-State: APjAAAU6su7YVxIYjppVSSGRwZ8K8gZNmPH/SUy14I/WqTrj/PXDYkZQ
        4RDPGoCu47Hr8U3ycLUimmbOZdbM
X-Google-Smtp-Source: APXvYqxg6+i1aZA9DAzRoUu9AeEEYJqM9TyEXsAF2bWPzqt4OgjnTA9RX0U/rafCaeSynb0HXWF1dw==
X-Received: by 2002:a50:a56d:: with SMTP id z42mr115395271edb.241.1560978365835;
        Wed, 19 Jun 2019 14:06:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm6168662eda.85.2019.06.19.14.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:05 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:05 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:47 GMT
Message-Id: <f528883d97011128d77061c4976655b80a7e7b14.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 13/20] msvc: fix detect_msys_tty()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

The ntstatus.h header is only available in MINGW.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index f4f08237f9..11cd9b82cc 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -544,7 +544,20 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 #ifdef DETECT_MSYS_TTY
 
 #include <winternl.h>
+
+#if defined(_MSC_VER)
+
+typedef struct _OBJECT_NAME_INFORMATION
+{
+	UNICODE_STRING Name;
+	WCHAR NameBuffer[0];
+} OBJECT_NAME_INFORMATION, *POBJECT_NAME_INFORMATION;
+
+#define ObjectNameInformation 1
+
+#else
 #include <ntstatus.h>
+#endif
 
 static void detect_msys_tty(int fd)
 {
-- 
gitgitgadget

