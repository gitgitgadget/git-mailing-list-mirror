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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9439D1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 08:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442789AbfIYIgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 04:36:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442770AbfIYIgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 04:36:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id i18so5517124wru.11
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5JljvxkHEF9YIZUfXwvIYy6RlaCqVYDJyiKSjoBJRWk=;
        b=IpeNd88QAKXjclING8hWoge740+35RoegpmUnOFRrr1Al/F4mRzHDnMVDbjRy4aPG8
         xlmz8mOlPINkGIluBnfLXNxMbha4HQ33JrjrI9XRQF6Yq3IodZ5oKNw1YwPIjWtNF2Sc
         45M/zwoWouiFMmCe3+9+D6L+eXBqjncnNBOV3QAPCZo+et4muv+ZcsuhFO+ZYnwI7xzS
         Hm928KjHlJ+Uu7s+QIgJnsPHZFiyfHMWrN+EOZznMGdgV3epEq6DNvoQw+MlYS0su6Hl
         PJJdpdVRjAsxdPXvFau8IXbQ978THjliJ5mJ4O0HXUFTwhtwZFFDryV+XcQKZtP9Uvz8
         qQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5JljvxkHEF9YIZUfXwvIYy6RlaCqVYDJyiKSjoBJRWk=;
        b=FR+zzn4LmAuK0AJbSlFz3WzxnsuZ2/F9E/txkr1nkMVyfqBqzSZjV0S5LWB/YoMdzE
         XvjBm/WPDFlkglxBjBiPcZVeyaaq8PeJfrbdYAdgR1iC0svsm8oXzIHWNJdsWiOiFBtP
         HZ55yB+r3IBhd0gSfS+tuQjJ1hN4bY1kC0fP3E2Z3IT8FJ9YVrQAYDhxqmScxBpK/Ba/
         9IKsRxezE6bE1QrKt9w6yi8LXtVy5/9QedYnuE0qXK7JuZDTq7ylFD3i7Ud433iymHmH
         2el4i06zwLO4vAdl6qYzbVrRyItWrdKiUDS7J24SrKeTs8M8L1c0EN4lnaIOU4WDHe+Y
         TDpg==
X-Gm-Message-State: APjAAAV0QxRdrPGlOzPjC17Xfbr8Pp0Wch22FgOFUkHU5ispfvndJNLz
        c2L3F637C3/aKI/ZHM5+nG9WCPug
X-Google-Smtp-Source: APXvYqx2Z5PHDjci7c6mcRe7mTfXAom37ytV+OdIVjX/a6xfWB4g5bo1GcToNQh1mo41CGdJurryRQ==
X-Received: by 2002:adf:f547:: with SMTP id j7mr8264972wrp.119.1569400561207;
        Wed, 25 Sep 2019 01:36:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm6472421wmg.2.2019.09.25.01.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 01:36:00 -0700 (PDT)
Date:   Wed, 25 Sep 2019 01:36:00 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Sep 2019 08:35:57 GMT
Message-Id: <1202809db71a7b0d06efd5e50716861ecff186de.1569400558.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.352.git.gitgitgadget@gmail.com>
References: <pull.352.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] Move git_sort(), a stable sort, into into libgit.a
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

The `qsort()` function is not guaranteed to be stable, i.e. it does not
promise to maintain the order of items it is told to consider equal. In
contrast, the `git_sort()` function we carry in `compat/qsort.c` _is_
stable, by virtue of implementing a merge sort algorithm.

In preparation for using a stable sort in Git's rename detection, move
the stable sort into `libgit.a` so that it is compiled in
unconditionally.

Note: this also makes the hack obsolete that was introduced in
fe21c6b285d (mingw: reencode environment variables on the fly (UTF-16
<-> UTF-8), 2018-10-30), where we included `compat/qsort.c` directly in
`compat/mingw.c` to use the stable sort.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                  | 2 +-
 compat/mingw.c            | 5 -----
 git-compat-util.h         | 4 +++-
 compat/qsort.c => qsort.c | 2 +-
 4 files changed, 5 insertions(+), 8 deletions(-)
 rename compat/qsort.c => qsort.c (97%)

diff --git a/Makefile b/Makefile
index f9255344ae..1e144598e4 100644
--- a/Makefile
+++ b/Makefile
@@ -950,6 +950,7 @@ LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
+LIB_OBJS += qsort.o
 LIB_OBJS += quote.o
 LIB_OBJS += range-diff.o
 LIB_OBJS += reachable.o
@@ -1714,7 +1715,6 @@ ifdef NO_GETPAGESIZE
 endif
 ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
-	COMPAT_OBJS += compat/qsort.o
 endif
 ifdef HAVE_ISO_QSORT_S
 	COMPAT_CFLAGS += -DHAVE_ISO_QSORT_S
diff --git a/compat/mingw.c b/compat/mingw.c
index 738f0a826a..77d4ef4d19 100644
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
diff --git a/git-compat-util.h b/git-compat-util.h
index 83be89de0a..2d46162897 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1094,9 +1094,9 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
-#ifdef INTERNAL_QSORT
 void git_qsort(void *base, size_t nmemb, size_t size,
 	       int(*compar)(const void *, const void *));
+#ifdef INTERNAL_QSORT
 #define qsort git_qsort
 #endif
 
@@ -1108,6 +1108,8 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
 		qsort(base, nmemb, size, compar);
 }
 
+#define QSORT_STABLE(base, n, compar) git_qsort((base), (n), sizeof(*(base)), compar)
+
 #ifndef HAVE_ISO_QSORT_S
 int git_qsort_s(void *base, size_t nmemb, size_t size,
 		int (*compar)(const void *, const void *, void *), void *ctx);
diff --git a/compat/qsort.c b/qsort.c
similarity index 97%
rename from compat/qsort.c
rename to qsort.c
index 7d071afb70..08f80eea09 100644
--- a/compat/qsort.c
+++ b/qsort.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 /*
  * A merge sort implementation, simplified from the qsort implementation
-- 
gitgitgadget

