Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A9A1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJXRrD (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:47:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41321 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:47:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5-v6so1962580plq.8
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J7BH/QTwkI9bmnE2nubon2dQyP2VBA1SynJTWbqdaoY=;
        b=LMTjZ5T5HqkCj5sFFLvX9D9BSWBhwVePugcM16JHL5AHEPxarrpqQX45MUPlFyL07q
         LZLZL5YQ/I3BkfwcixD05ZiCRXW3V4xFeBVgqh7hQeMVc/nmqrm7WxcQp3SWVXsd7Ctc
         KmEizpUCjvOeex8VANwfHiDsyh2BTMPaZ1/tB6ygnuIIQ68m7oeeNl5wVVQ3FRBHHy3H
         3MFI3s/NW6t22HIAUsa/F1JcsGhlvBqkRmPH//mP3NREmMMo5vUqNmwdlOXfEhF90zrD
         I52pkkRwGZeJKXi1FN2NxbMS8sa3NWNr6V3d0QZ3qqbTcxYu3g8Vg07l/0vLC5HbUMxc
         akuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J7BH/QTwkI9bmnE2nubon2dQyP2VBA1SynJTWbqdaoY=;
        b=Q/qqwTc1PszviYo2U3b0EuHGHjsU7fbIUdFcnMnUYcHJyFsnuPkb4oyubPIQoZfwJx
         ERxSy4l4CPWGFr8rk99hpw1nQdmAgWQj7j315cy860h3GhIYdjhZkUvAxRBcgjgbvW1Q
         t56JU9YMSoCokjQm1Gt+qbJHO4pHdcBLlHqExoUI+rQa/CajD5AStcWLu8AiM5ZRNSvI
         8rslZnAwGDYSGBm7XfalUdUlHpn9YGOR19CTAPCS+KN3Xsx3wimd68U3sBT3CfJn+6sw
         uiPTBnSmKk+yde7y8oXV58jOoL/tTwHemPA2E71oD/8O0RqGa0+oqPQ8lNEBGpJDHpnH
         z2qw==
X-Gm-Message-State: AGRZ1gKq9P3iSVbpFuU2tEJs62hxBDy1SIHLx9QumYcaPmoy1hRxYpGv
        llB0vpykDVyI5HccLF/Zvm8x/bll
X-Google-Smtp-Source: AJdET5cgrFIJCvODYKzbrM/qtruPOX1I+yb/oX2ML/MHjR9DurC9BgPUjFYvgzWNn8a5CRle05Mv0w==
X-Received: by 2002:a17:902:3283:: with SMTP id z3-v6mr1792983plb.308.1540372781567;
        Wed, 24 Oct 2018 02:19:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id j187-v6sm8032849pfc.39.2018.10.24.02.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 02:19:40 -0700 (PDT)
Date:   Wed, 24 Oct 2018 02:19:40 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Oct 2018 09:19:36 GMT
Message-Id: <e13ae233822c8e4a4504e3294adf3e0de38a1990.1540372778.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.54.v2.git.gitgitgadget@gmail.com>
References: <pull.54.git.gitgitgadget@gmail.com>
        <pull.54.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] mingw: ensure `getcwd()` reports the correct case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stephen Smith <ischis2@cox.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When switching the current working directory, say, in PowerShell, it is
quite possible to use a different capitalization than the one that is
recorded on disk. While doing the same in `cmd.exe` adjusts the
capitalization magically, that does not happen in PowerShell so that
`getcwd()` returns the current directory in a different way than is
recorded on disk.

Typically this creates no problems except when you call

	git log .

in a subdirectory called, say, "GIT/" but you switched to "Git/" and
your `getcwd()` reports the latter, then Git won't understand that you
wanted to see the history as per the `GIT/` subdirectory but it thinks you
wanted to see the history of some directory that may have existed in the
past (but actually never did).

So let's be extra careful to adjust the capitalization of the current
directory before working with it.

Reported by a few PowerShell power users ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 18caf2196..2c3e27ce9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -917,8 +917,15 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
 
 char *mingw_getcwd(char *pointer, int len)
 {
-	wchar_t wpointer[MAX_PATH];
-	if (!_wgetcwd(wpointer, ARRAY_SIZE(wpointer)))
+	wchar_t cwd[MAX_PATH], wpointer[MAX_PATH];
+	DWORD ret = GetCurrentDirectoryW(ARRAY_SIZE(cwd), cwd);
+
+	if (!ret || ret >= ARRAY_SIZE(cwd)) {
+		errno = ret ? ENAMETOOLONG : err_win_to_posix(GetLastError());
+		return NULL;
+	}
+	ret = GetLongPathNameW(cwd, wpointer, ARRAY_SIZE(wpointer));
+	if (!ret || ret >= ARRAY_SIZE(wpointer))
 		return NULL;
 	if (xwcstoutf(pointer, wpointer, len) < 0)
 		return NULL;
-- 
gitgitgadget

