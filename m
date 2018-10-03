Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4DBC1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJDCde (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:33:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40894 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbeJDCdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:33:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id n31-v6so2017745pgm.7
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xP8s7pZODrNTqCuygyKg4o8kzCijz1sOlFFcG6lhGQM=;
        b=De6kHP04zfh5xnXJ0veaEN0bR6L6i8eWQ00noaw72MnwtDETfQVtWZjut3c3cehIRM
         1g6XYepR6GladXXps5eQKdEItDC/jhmf9S4UcL2cny2bXOjLwKdaJ3i5JdP4FCI5neg7
         YTbjJZu+Y1vw6qi08b8CF/9X9dVCXIFvd/Tto6txBwBjW3+CU1RP3ulgNXtia8/q/p78
         VQfPmENF6SyryeNmFnquRApFCrhWM3LRZtUW9ttqNHGzZ6UmuaiDm7BtlMs/VxDEYcVa
         FM/h2SelEOaHk3DwsUWEYVGrvOw8YS/rXjfh8bksBt9MipieClSokJ+ewN4i2En6zJNp
         YGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xP8s7pZODrNTqCuygyKg4o8kzCijz1sOlFFcG6lhGQM=;
        b=lzh2wnVDn7shF26RNhQoqas3Ha5f5Qe3fGzB1mlj4s8uu1OttUzYGfXTx788LX3XCF
         /xjq3VvqQdZsd6Vk+WVt3ho7qDddOPftnpM9ClrrOTew18NMS6k41D4KnZJiVoBDOjCa
         WGxToMOwkTFNPH8TeYnUqZFT9yZHrIFDlzWoOpDHS2Qz70iHC0U/QDBaCm/wOOFUmiWk
         mtkVYwxMBsUVODs7ppSvw73X0k0jGjqnii0QhaIpKp5CZWypyYULJ+2qc5AVxnm2zjCJ
         dL4t0lEhq1ymJ3nLIZr9euxmUc+QuJwIBPqtt1nAJ/uS6pAoQnB+B8Bs6tkFL2grlQ/B
         ir4w==
X-Gm-Message-State: ABuFfojgB7jUTb1Fu430M+/W0Hq9VGcR1q6OLEcCQRiJBCcOFlAZxD4c
        b64fDkmFaErH49r/JbZdJLU9zg7Y
X-Google-Smtp-Source: ACcGV60f18OOz5iFxoPmD49YX9bABnvhNs0soORa610ydvtrEg9vMeapnD1MtxRX1KTOrhMf0D65eg==
X-Received: by 2002:a62:6786:: with SMTP id t6-v6mr3200634pfj.92.1538595825261;
        Wed, 03 Oct 2018 12:43:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id z7-v6sm3704788pff.146.2018.10.03.12.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:43:44 -0700 (PDT)
Date:   Wed, 03 Oct 2018 12:43:44 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 19:43:37 GMT
Message-Id: <2b127d9669aa7b73ced7611b6e77044f5efed11d.1538595818.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.44.git.gitgitgadget@gmail.com>
References: <pull.44.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] mingw: bump the minimum Windows version to Vista
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

Quite some time ago, a last plea to the XP users out there who want to
see Windows XP support in Git for Windows, asking them to get engaged
and help, vanished into the depths of the universe.

We tried for a long time to play nice with the last remaining XP users
who somehow manage to build Git from source, but a recent update of
mingw-w64 (7.0.0.5233.e0c09544 -> 7.0.0.5245.edf66197) finally dropped
the last sign of XP support, and Git for Windows' SDK is no longer able
to build core Git's `master` branch as a consequence. (Git for Windows'
`master` branch already bumped the minimum Windows version to Vista a
while ago, so it is fine.)

It is time to require Windows Vista or later to build Git from source.
This, incidentally, lets us use quite a few nice new APIs.

It also means that we no longer need the inet_pton() and inet_ntop()
emulation, which is nice.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname  | 4 ----
 git-compat-util.h | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index e47af72e01..8acdeb71fd 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -381,8 +381,6 @@ ifeq ($(uname_S),Windows)
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
 	ETAGS_TARGET = ETAGS
-	NO_INET_PTON = YesPlease
-	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
@@ -529,8 +527,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX = YesPlease
 	NO_PYTHON = YesPlease
 	ETAGS_TARGET = ETAGS
-	NO_INET_PTON = YesPlease
-	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
diff --git a/git-compat-util.h b/git-compat-util.h
index 3ba93d9c15..48c955541e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -147,7 +147,7 @@
 
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 # if !defined(_WIN32_WINNT)
-#  define _WIN32_WINNT 0x0502
+#  define _WIN32_WINNT 0x0600
 # endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
-- 
gitgitgadget
