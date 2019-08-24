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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA981F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfHXWi7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:38:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41285 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfHXWi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:38:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so11811262wrr.8
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rWhExOuj4Ccsq82VX0OGTPkRnHR6703iMWamSr+8H7w=;
        b=XkZBEOAX91hGC5AZq+iwVFrCWz5hgqWqISW35FvT2tAGPM8HfCYiEGvNDWZ+NTQwyg
         5nllMn3TQ5g8Uc9QMmBOFMtP5jplANkXVBC0IvOJqHsVG4RymI7z0nMS5SsBkheZOm7Q
         YADWvvjjawDebvUp9u5bu/yQ0dwHraK4ahHJLmOoTFzLGXrFG4AGWFPgURRBgC5t4YyH
         qrC6KBbM9oG1V1Cyvr0g9uSfmTt8N11+KgzdnCWeKecE2+gSoDBnPv4qAX4Fswdt8IOH
         AyJKZo6EOeQFI1HDczXlPpg9j6G8Ai7mcGRBXdb/2fjro2tEaLRec8xuQkD1I9wXTw4W
         DXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rWhExOuj4Ccsq82VX0OGTPkRnHR6703iMWamSr+8H7w=;
        b=O9m8Zsq+QHF+/bxaalILhMah3WuZPeBXr+g1krgx0yxDpeZOtHt/w82J07bVIxO5r3
         GibKF24FKTwlroQcmOW0rqdd/bA67Ho87Obta4MVjG+UdrdgRPsy82sGbK75Ij5yn3rW
         CIsgsnZj+vwqWiS+3o6ZPqdKT4NBDI9W2thH7f/O3AelKSpvUdFVJoeVmLWA3yhzS0pw
         3LCvrDHsDxlCFAz+XGLpCrnmECb2X9tSDIBhy3uK7QoRTBygwKWkp5LkyydTeW6p7aTt
         cknCEXpqgwurf7p6rLP1Y3cobh7BZADqrHcyb9pb0QHFgNuommqwPsDeUD/NiKzgbO9F
         jS5A==
X-Gm-Message-State: APjAAAWHLc6NyJUP85l+sYxjC1V9yBUSGHtC0BQuGmzL8wdgAVQ9ih1D
        cuR/rN60UC7ETAgPdEjOr47HsdSF
X-Google-Smtp-Source: APXvYqzJrmGxo2IcvMGkYRJLVqqlWEEnE05Wk0lq7EMGe2pQpjS+ADM2J5oDPDz5vCCToAzH+/TwhQ==
X-Received: by 2002:adf:cd08:: with SMTP id w8mr13641486wrm.147.1566686336807;
        Sat, 24 Aug 2019 15:38:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm6583006wrw.16.2019.08.24.15.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:38:56 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:38:56 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:38:55 GMT
Message-Id: <8f2d64a88518d05579701b7093ecbc197ebca2c7.1566686335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.135.git.gitgitgadget@gmail.com>
References: <pull.135.git.gitgitgadget@gmail.com>
From:   "Adam Roben via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: fix launching of externals from Unicode paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Adam Roben <adam@roben.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Roben <adam@roben.org>

If Git were installed in a path containing non-ASCII characters,
commands such as `git am` and `git submodule`, which are implemented as
externals, would fail to launch with the following error:

> fatal: 'am' appears to be a git command, but we were not
> able to execute it. Maybe git-am is broken?

This was due to lookup_prog not being Unicode-aware. It was somehow
missed in 85faec9d3a (Win32: Unicode file name support (except dirent),
2012-03-15).

Note that the only problem in this function was calling
`GetFileAttributes()` instead of `GetFileAttributesW()`. The calls to
`access()` were fine because `access()` is a macro which resolves to
`mingw_access()`, which already handles Unicode correctly. But
`lookup_prog()` was changed to use `_waccess()` directly so that we only
convert the path to UTF-16 once.

To make things work correctly, we have to maintain UTF-8 and UTF-16
versions in tandem in `lookup_prog()`.

Signed-off-by: Adam Roben <adam@roben.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8141f77189..9f02403ebf 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1161,14 +1161,21 @@ static char *lookup_prog(const char *dir, int dirlen, const char *cmd,
 			 int isexe, int exe_only)
 {
 	char path[MAX_PATH];
+	wchar_t wpath[MAX_PATH];
 	snprintf(path, sizeof(path), "%.*s\\%s.exe", dirlen, dir, cmd);
 
-	if (!isexe && access(path, F_OK) == 0)
+	if (xutftowcs_path(wpath, path) < 0)
+		return NULL;
+
+	if (!isexe && _waccess(wpath, F_OK) == 0)
 		return xstrdup(path);
-	path[strlen(path)-4] = '\0';
-	if ((!exe_only || isexe) && access(path, F_OK) == 0)
-		if (!(GetFileAttributes(path) & FILE_ATTRIBUTE_DIRECTORY))
+	wpath[wcslen(wpath)-4] = '\0';
+	if ((!exe_only || isexe) && _waccess(wpath, F_OK) == 0) {
+		if (!(GetFileAttributesW(wpath) & FILE_ATTRIBUTE_DIRECTORY)) {
+			path[strlen(path)-4] = '\0';
 			return xstrdup(path);
+		}
+	}
 	return NULL;
 }
 
-- 
gitgitgadget
