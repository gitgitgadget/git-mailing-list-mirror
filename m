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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A48E1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfFYOtn (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46586 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731906AbfFYOtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so27489887edr.13
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=prTONMgonWGTswXILkRhCe6wGvUsumXO4PE5ug20+a0=;
        b=Dkg+Ye5Hzh/gVEP4OSu/KJNJLbxbR/bBQ00XL7HZzHyNttQAgKXlO8am0Mip757Rqx
         k+34mFaKSZ99xkqm2sZnuwHaViPnftw+PkyBtunEC8/JSLm56q+IpGc2epNBgCQ7P62G
         b3rV4vigOv2OI4Z5v76hAlMcwn3Rs7QP3n4jXIFfmcx1uGw58STvaXsePEaAIcPUDXrW
         J6tQ78Hsg1HvBSaZzj8eEKvpuINl93KO8DyP6PiIXPPyKysLVEJlwS21pOb0JQ9Nrm7e
         g0+HsAiPpoowclYEWhB5l9iKEIfZg4NO7lUHrJexQmHMcoRPlqk/lpP5jsIg7vL0yb7e
         QSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=prTONMgonWGTswXILkRhCe6wGvUsumXO4PE5ug20+a0=;
        b=WS997y4lJVSjtlUvwnWsAYyg9/O5IAEmRLEZS73xncSNXYe/RvKZ7TcntIjqkx1nKc
         FvCTHHjFrX6tGY+e5EOj1F2Jvseae+zUDts5cfqF0foYRmTcAmZlKcW4E3R7KlxhvBGU
         ChDaSP46ySdl9aF12sINOFFSzlimYqbJzhS9viqJvETv8cHd2UYUXTSWcBn5iFotyXcz
         E8kjvBQX+PEHFBHeQ//aty6XYjFlLXqQh1Vf7X1HTYvYhoQpJ+xiAo424QLSKzy/jLXi
         Qr4C5qFyeSx8/vCtAo6pAs6YMJ7n7TA8tBpEbi3nUP3N4jRUz7iwndCYL/mY7hRd1Tmj
         hdzQ==
X-Gm-Message-State: APjAAAW3nqsMI1zhGt1JylVn5EKBxXUB+aS9nJ2s5yK3iOOO1cQy7AKY
        58ZZDz3VHSfGdbBCIlvKix+RJLVM
X-Google-Smtp-Source: APXvYqwenBDU+AFd3L3G4eHheFxuXfYBPDvbPyyKQI9KEpk2lmuJimIor8wOc1UyxqnaHPP2CRg0qg==
X-Received: by 2002:a50:b803:: with SMTP id j3mr104390600ede.208.1561474180551;
        Tue, 25 Jun 2019 07:49:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm4581205eds.19.2019.06.25.07.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:40 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:40 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:22 GMT
Message-Id: <993b6bcd0a8cf47acd0cfa695ad6e34865b060d3.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 16/20] msvc: add a compile-time flag to allow detailed heap
 debugging
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

MS Visual C comes with a few neat features we can use to analyze the
heap consumption (i.e. leaks, max memory, etc).

With this patch, we introduce support via the build-time flag
`USE_MSVC_CRTDBG`.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c    | 6 ++++++
 config.mak.uname  | 4 ++++
 git-compat-util.h | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index c063ae62be..667285887a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2411,6 +2411,12 @@ int wmain(int argc, const wchar_t **wargv)
 
 	trace2_initialize_clock();
 
+#ifdef _MSC_VER
+#ifdef USE_MSVC_CRTDBG
+	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
+#endif
+#endif
+
 	maybe_redirect_std_handles();
 
 	/* determine size of argv and environ conversion buffer */
diff --git a/config.mak.uname b/config.mak.uname
index b8c52e49d2..3fde48c64d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -448,6 +448,10 @@ else
 endif
 	BASIC_CFLAGS += $(sdk_libs) $(msvc_libs)
 
+ifneq ($(USE_MSVC_CRTDBG),)
+	# Optionally enable memory leak reporting.
+	BASIC_CFLAGS += -DUSE_MSVC_CRTDBG
+endif
 	BASIC_CFLAGS += -DPROTECT_NTFS_DEFAULT=1
 	# Always give "-Zi" to the compiler and "-debug" to linker (even in
 	# release mode) to force a PDB to be generated (like RelWithDebInfo).
diff --git a/git-compat-util.h b/git-compat-util.h
index cc0e7e9733..83be89de0a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1,6 +1,15 @@
 #ifndef GIT_COMPAT_UTIL_H
 #define GIT_COMPAT_UTIL_H
 
+#ifdef USE_MSVC_CRTDBG
+/*
+ * For these to work they must appear very early in each
+ * file -- before most of the standard header files.
+ */
+#include <stdlib.h>
+#include <crtdbg.h>
+#endif
+
 #define _FILE_OFFSET_BITS 64
 
 
-- 
gitgitgadget

