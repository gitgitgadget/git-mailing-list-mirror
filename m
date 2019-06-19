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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2341F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfFSVGL (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36365 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbfFSVGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so1315825edq.3
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=prTONMgonWGTswXILkRhCe6wGvUsumXO4PE5ug20+a0=;
        b=dViC17Ok1H3ZCA3tpDucQDm0Gl5qFnNTP6KwARv2tP95tiHeASICAt/Z/Oa5cDsuzB
         0E92Oq36pxS2leTvcGn6p+yMB3rkoYYTi4FPN1lAF8zuN2GtD8uaPVjGVmNw1Jvvcx1Y
         96Qfd1Wu5xdJP3T4R++M4XWque5A+fg9/zDnllTrq9DBEp8gUgUURljg4hMPCWJMYDTg
         XcOTY+4Qzn84gyhfDtg6VHeyaTSFB7vjTPudB361We6ZmhV94DOf7tnEKpvZ10ruWpMA
         9ejQWOEUX6vrKswzTVdJ99tJdJiDjxupgxnPEiIF4KWlwxUqt70qEP4imuTufRpevY7u
         HlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=prTONMgonWGTswXILkRhCe6wGvUsumXO4PE5ug20+a0=;
        b=egOgMap/2XNvgQg7bP8Ko2H6kHy5vBg4T8Bij0mog8VW6uGuxe1QqW2Her0cISAUeu
         kRv9gT+S4cqtGMtDxluQysr+AR8sNrssy8kHYMgK4hX/p2H/dzLtWcP/qmztJVk/Oych
         AeASXoKa+3HFeSoqtVdeIkETdp+uxxzxvzI4HNtuyj4W1PhgHBU1B7u0yUbI0mrHelO6
         lC9cvQHd44P8dUba9HXE8sdD8aATQUYJoEG7mFELCo5w0GpPIe8KrQNG1V9qULjFbTf4
         nfUiNPhGdSQqqv0Vq0GXnHrYZeUU3+eIa9RlE/ymQonl7A2Z/7l8gr0dcT9QELuibrZW
         8ZNw==
X-Gm-Message-State: APjAAAVDfkQkTjqJP0cr9PULv0ygkn9ilZ0yXBXNLwJ7YeDw+8nMMcjc
        ZJqTMvAtnGog2Q6WHI2rD1vlI/78
X-Google-Smtp-Source: APXvYqyBcj1z1DtCyA+LTHAbnuM8znzWed07l/HIn9w3wX+veA1PDVtrEb3NDoKnyqoewaCWGE340g==
X-Received: by 2002:a05:6402:397:: with SMTP id o23mr25329847edv.68.1560978368052;
        Wed, 19 Jun 2019 14:06:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v47sm1095475edc.80.2019.06.19.14.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:07 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:07 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:50 GMT
Message-Id: <e7888bedbd0cd861a7e84d687dc624d1518cc67d.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 16/20] msvc: add a compile-time flag to allow detailed heap
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

