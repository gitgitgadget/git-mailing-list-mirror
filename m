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
	by dcvr.yhbt.net (Postfix) with ESMTP id F22FE1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfFMP0K (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:26:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44679 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbfFMLts (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 07:49:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so30744668edr.11
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 04:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VNRv0hgUnC+qtQN/vThezjmRB9rOmTqItv2ejLWr2Dg=;
        b=ZQxIf0bf7U5PWJrLj0knLuRgl5plQlFkP/MD5OnaHzJZOyCin8wEC5T6ogG67Omcj1
         MsM4wV1IBeQl8hyQz5nPGjsfWkrFqcz+DqGc9yjeWaCMIlntxqv/UBX6yFOVuvgkqMLn
         ThtHaBp4RhqGpN7nlA5b4dcye1yTH9YJ9VgXNnZ17f1QFQ3SL4Qurm4tHQvWojdU1Q7b
         /nVok1Ghv2E9TIOkRwdIf4LD8Fm5x4oZI1eFKQMB2wMVXE3LF1CtLrVtPSmENKdnDAsJ
         ouJLmzeKKSkk/svsNIeN0nlsz7Wzb4em+JWB8+Lgy4vOpA6sAyKOI+ut646MuCG9hYBR
         gNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VNRv0hgUnC+qtQN/vThezjmRB9rOmTqItv2ejLWr2Dg=;
        b=e70vQAXWrKuyX/7eIP8Gl14PDZOwOUP5Y35X4r/hWNj3kwY1mlXKd7bQstEFUyiyWV
         vdR8hGukBtivbe0Yng+hDRDI17v0Gq3MyliUjoQvtjWPLTstkwi/kkHsg12zGre2JAho
         iRIiJynswajb8lywcI5xQoNVV1CxJZjMqqKiHTO7/sqDvWS2qj2rq09oW6zBnbrho42U
         2VyUEbSvbuN7deWyP6KgSpuTA+gG8VOlVW6d9kouj6pQhNW8DDmfwXF3K9J+w/E0D9EG
         7GZBa7SGcaWLOAmtbzdxA2kFnRL3iR+jyhE4lMz9//HnY6n6K4wJgUCaJdwn95jUHhEb
         6mKw==
X-Gm-Message-State: APjAAAWj/OhubdJ2wZ4mMLHUxdipc7L1zyNf+TPpk5Rw75YocSBzPsD3
        LJO2B2gYMvy7JAvh31Z+AJdz3DEj
X-Google-Smtp-Source: APXvYqwkJ5CRM+nIOavk7egF/vLNV+L7dqsO9gU6nnQllEFNxcPiCn3gZnaXuRopn1auxkzaYV4JAA==
X-Received: by 2002:a17:906:30c4:: with SMTP id b4mr12817142ejb.276.1560426586975;
        Thu, 13 Jun 2019 04:49:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm814987ede.2.2019.06.13.04.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 04:49:46 -0700 (PDT)
Date:   Thu, 13 Jun 2019 04:49:46 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Jun 2019 11:49:40 GMT
Message-Id: <d0ae652801c3ae343cc0c6b29c4444282d6c2d4a.1560426581.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.265.git.gitgitgadget@gmail.com>
References: <pull.265.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/4] winansi: simplify loading the GetCurrentConsoleFontEx()
 function
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

We introduced helper macros to simplify loading functions dynamically.
Might just as well use them.

This also side-steps a compiler warning when building with GCC v8.x: it
would complain about casting between incompatible function pointers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index f4f08237f9..a29d34ef44 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -7,6 +7,7 @@
 #include <wingdi.h>
 #include <winreg.h>
 #include "win32.h"
+#include "win32/lazyload.h"
 
 static int fd_is_interactive[3] = { 0, 0, 0 };
 #define FD_CONSOLE 0x1
@@ -41,26 +42,21 @@ typedef struct _CONSOLE_FONT_INFOEX {
 #endif
 #endif
 
-typedef BOOL (WINAPI *PGETCURRENTCONSOLEFONTEX)(HANDLE, BOOL,
-		PCONSOLE_FONT_INFOEX);
-
 static void warn_if_raster_font(void)
 {
 	DWORD fontFamily = 0;
-	PGETCURRENTCONSOLEFONTEX pGetCurrentConsoleFontEx;
+	DECLARE_PROC_ADDR(kernel32.dll, BOOL, GetCurrentConsoleFontEx,
+			HANDLE, BOOL, PCONSOLE_FONT_INFOEX);
 
 	/* don't bother if output was ascii only */
 	if (!non_ascii_used)
 		return;
 
 	/* GetCurrentConsoleFontEx is available since Vista */
-	pGetCurrentConsoleFontEx = (PGETCURRENTCONSOLEFONTEX) GetProcAddress(
-			GetModuleHandle("kernel32.dll"),
-			"GetCurrentConsoleFontEx");
-	if (pGetCurrentConsoleFontEx) {
+	if (INIT_PROC_ADDR(GetCurrentConsoleFontEx)) {
 		CONSOLE_FONT_INFOEX cfi;
 		cfi.cbSize = sizeof(cfi);
-		if (pGetCurrentConsoleFontEx(console, 0, &cfi))
+		if (GetCurrentConsoleFontEx(console, 0, &cfi))
 			fontFamily = cfi.FontFamily;
 	} else {
 		/* pre-Vista: check default console font in registry */
-- 
gitgitgadget

