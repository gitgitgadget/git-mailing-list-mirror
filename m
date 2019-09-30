Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46CD61F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfI3VEx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:04:53 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43534 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3VEx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:04:53 -0400
Received: by mail-wr1-f41.google.com with SMTP id q17so12903189wrx.10
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ecxc5cwooZEFniAB8z3B6VDCZd1uUk8vubofhh1je3E=;
        b=h6osJqAqY7Q8G8r7Haly+y7k/805qbQPGGa3jsDpEsyvwTyhoZVomkip4Ko3lCS0WJ
         L6e6atpXf5BEmCVBIzmPu5LhbZf5yTsmfReY9oG/dSUMdNEUuKNP04CGDs/q5mwcn+3c
         oyny4wQR8nHTsiDHL5lNgBPU//t0aMW295wNVS71RTGQ/vp0fM2CRiD22UQT6LPvTLHe
         undfzYcV7Jbznv0N3kelPvEFBh+FJ64NIE/MRPUVPuLrv3kj2MRoW/ln52kk2kUq4epi
         F/gjvUWJbZH45BZKq7prdiWeBQYwSYyakIERn6KxLpXK4vDs+WTiVAe5NTBapSc2ANXU
         krJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ecxc5cwooZEFniAB8z3B6VDCZd1uUk8vubofhh1je3E=;
        b=RxtQL5t+KMajDkKLUPp7RyBLnXquVn0wyJ181zMkrQIB8zQKNG2r0Nm41M1IYfmYQ1
         mK8ZVUA/dGKUD7t9gJuAZmJ2r8l29PwfgtUP2J8n0vPemCxjoxC3/A4nUCb0KMcHZtnO
         P0i1aFlGT/RwYfTnf8R8m4+Fk/HynVv7TQm7UZ7CfQ9qHoD2pHbTqCX/+84ptDSN5Ntg
         j7rDpPO+wTf2qzbbuYOYoNItjkrKJPbZeipIRQ1mkvnhmcHTRai2RGrD6ajpgOqXU4Q/
         IeYeq90t/iC2Z95mcJ3owhLv6qSVNCDtgs5tpUdI9c0WVNS74+OBfpkNG+PQI4vFwySZ
         zbGQ==
X-Gm-Message-State: APjAAAW3u0VxZqnT5CRpCAikzB0FiGjrmpjDjvQATMf9BprcviSfroW4
        RWj5hzC8xrSs41SoCUQpupqkGFW0
X-Google-Smtp-Source: APXvYqxWuhcbbqcsCZzU/f1UWk4AIA/Wtm//BynZQP7j5Whp7aICCTE6wivZqnkP3Q5IroO4yU6kjQ==
X-Received: by 2002:adf:904f:: with SMTP id h73mr14239702wrh.128.1569864115347;
        Mon, 30 Sep 2019 10:21:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q124sm308885wma.5.2019.09.30.10.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 10:21:54 -0700 (PDT)
Date:   Mon, 30 Sep 2019 10:21:54 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 17:21:51 GMT
Message-Id: <8a99008a64eb1aa13aae8969e9c9963be898b31a.1569864113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.352.v2.git.gitgitgadget@gmail.com>
References: <pull.352.git.gitgitgadget@gmail.com>
        <pull.352.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] Move git_sort(), a stable sort, into into libgit.a
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `qsort()` function is not guaranteed to be stable, i.e. it does not
promise to maintain the order of items it is told to consider equal. In
contrast, the `git_sort()` function we carry in `compat/qsort.c` _is_
stable, by virtue of implementing a merge sort algorithm.

In preparation for using a stable sort in Git's rename detection, move
the stable sort into `libgit.a` so that it is compiled in
unconditionally, and rename it to `git_stable_qsort()`.

Note: this also makes the hack obsolete that was introduced in
fe21c6b285d (mingw: reencode environment variables on the fly (UTF-16
<-> UTF-8), 2018-10-30), where we included `compat/qsort.c` directly in
`compat/mingw.c` to use the stable sort.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                         |  2 +-
 compat/mingw.c                   | 11 +++--------
 git-compat-util.h                |  9 ++++++---
 compat/qsort.c => stable-qsort.c |  6 +++---
 4 files changed, 13 insertions(+), 15 deletions(-)
 rename compat/qsort.c => stable-qsort.c (89%)

diff --git a/Makefile b/Makefile
index f9255344ae..60c809e580 100644
--- a/Makefile
+++ b/Makefile
@@ -983,6 +983,7 @@ LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
 LIB_OBJS += split-index.o
+LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
@@ -1714,7 +1715,6 @@ ifdef NO_GETPAGESIZE
 endif
 ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
-	COMPAT_OBJS += compat/qsort.o
 endif
 ifdef HAVE_ISO_QSORT_S
 	COMPAT_CFLAGS += -DHAVE_ISO_QSORT_S
diff --git a/compat/mingw.c b/compat/mingw.c
index 738f0a826a..50af33b2b3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1229,11 +1229,6 @@ static int wenvcmp(const void *a, const void *b)
 	return _wcsnicmp(p, q, p_len);
 }
 
-/* We need a stable sort to convert the environment between UTF-16 <-> UTF-8 */
-#ifndef INTERNAL_QSORT
-#include "qsort.c"
-#endif
-
 /*
  * Build an environment block combining the inherited environment
  * merged with the given list of settings.
@@ -1272,8 +1267,8 @@ static wchar_t *make_environment_block(char **deltaenv)
 
 	/*
 	 * If there is a deltaenv, let's accumulate all keys into `array`,
-	 * sort them using the stable git_qsort() and then copy, skipping
-	 * duplicate keys
+	 * sort them using the stable git_stable_qsort() and then copy,
+	 * skipping duplicate keys
 	 */
 	for (p = wenv; p && *p; ) {
 		ALLOC_GROW(array, nr + 1, alloc);
@@ -1296,7 +1291,7 @@ static wchar_t *make_environment_block(char **deltaenv)
 		p += wlen + 1;
 	}
 
-	git_qsort(array, nr, sizeof(*array), wenvcmp);
+	git_stable_qsort(array, nr, sizeof(*array), wenvcmp);
 	ALLOC_ARRAY(result, size + delta_size);
 
 	for (p = result, i = 0; i < nr; i++) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 83be89de0a..7ec2c8fe31 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1094,10 +1094,10 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+void git_stable_qsort(void *base, size_t nmemb, size_t size,
+		      int(*compar)(const void *, const void *));
 #ifdef INTERNAL_QSORT
-void git_qsort(void *base, size_t nmemb, size_t size,
-	       int(*compar)(const void *, const void *));
-#define qsort git_qsort
+#define qsort git_stable_qsort
 #endif
 
 #define QSORT(base, n, compar) sane_qsort((base), (n), sizeof(*(base)), compar)
@@ -1108,6 +1108,9 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
 		qsort(base, nmemb, size, compar);
 }
 
+#define STABLE_QSORT(base, n, compar) \
+	git_stable_qsort((base), (n), sizeof(*(base)), compar)
+
 #ifndef HAVE_ISO_QSORT_S
 int git_qsort_s(void *base, size_t nmemb, size_t size,
 		int (*compar)(const void *, const void *, void *), void *ctx);
diff --git a/compat/qsort.c b/stable-qsort.c
similarity index 89%
rename from compat/qsort.c
rename to stable-qsort.c
index 7d071afb70..6cbaf39f7b 100644
--- a/compat/qsort.c
+++ b/stable-qsort.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 /*
  * A merge sort implementation, simplified from the qsort implementation
@@ -44,8 +44,8 @@ static void msort_with_tmp(void *b, size_t n, size_t s,
 	memcpy(b, t, (n - n2) * s);
 }
 
-void git_qsort(void *b, size_t n, size_t s,
-	       int (*cmp)(const void *, const void *))
+void git_stable_qsort(void *b, size_t n, size_t s,
+		      int (*cmp)(const void *, const void *))
 {
 	const size_t size = st_mult(n, s);
 	char buf[1024];
-- 
gitgitgadget

