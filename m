Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0ACB1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeJWSqN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:46:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42369 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeJWSqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:46:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so370793plo.9
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wXl6MONf/mI5sF+41xCeeB5rAGu7b9Huy/dBxnNqZww=;
        b=kAMZ3oTA/uW2KVmnZXrFZ75ZhJZOodfhR0Kgss83X1ScQKanL90r2XbxRAvRIrKsuU
         0VCbHI1JdZyYxaSlyIqusaRFGJUsAqVH+hUGGns7kcOUUdTAndF7OggqqZWqe+gQRaYr
         /Mox2h+p3Y5jf38V4oQ+JTIQetfWn/ALZWOgKTYNw7Z/6GAUojPoG1OOEHnB8+ugJYuS
         6SCKHsWy+RpnSkglMiF7D7ebN7TBmaOdBrYsuzjjxTepzkFgw/sZ0NW/B1GXZ+kFgMQs
         fLCeZoKZFlP5RWu9ZzyLvsEi47arGrEbHgp6Wv68/UUvF2jnds/UMnDXrOmU+X5uLX8w
         VoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wXl6MONf/mI5sF+41xCeeB5rAGu7b9Huy/dBxnNqZww=;
        b=MjjXw6oNGRarRcQDvd7jGGNT3YnRZCqXTLX12edu1wL86Z0vS2cTEvLGeZyGESpNmF
         cVYl/Hp9UncN0iTwNDivGYZfMi8z+br9lB6s0eYT/02JLCZsfZH+9G2kWTal62vgPMXt
         GZGh104oDofdfkuOZdLH2CCYjLYyX25oRRtMsv5kmInAxvIbQmcYJGsao+RI1qNaNv6z
         /SNmzZBaz/ezJ5l3hux/zbaDryhQe16JFuKAM2mBXK6p3bR1PKe0mctgJkHtub4K5SnV
         ua942pGc9cJ+Hdga39L5WQNS2xUaDz7CDQ7s4dbOHNtspgWO7cwOFjrub7OhT8FXaQVN
         rkfg==
X-Gm-Message-State: ABuFfohMYRyUieuoegtOpL8uJleP1TGuc0ijgtN6g8MZ+OxFYYJdT4hB
        LG4TOGOWeNa0iffX0t5xNsERRBoq
X-Google-Smtp-Source: ACcGV63paiYkmijLKa2NMVpjf4Y691voMmjCCpAfkrRD8+n7OoWxvGB8gJEZwEv4GXDg4Hpkh1BERQ==
X-Received: by 2002:a17:902:760b:: with SMTP id k11-v6mr48441695pll.103.1540290203761;
        Tue, 23 Oct 2018 03:23:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1164248pgq.35.2018.10.23.03.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:23:22 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:23:22 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 10:23:16 GMT
Message-Id: <1974831d2ebfd040fca574673bb7afcb9c0b15ef.1540290197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.53.git.gitgitgadget@gmail.com>
References: <pull.53.git.gitgitgadget@gmail.com>
From:   "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] mingw: implement nanosecond-precision file times
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Karsten Blees <blees@dcon.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karsten Blees <blees@dcon.de>

We no longer use any of MSVCRT's stat-functions, so there's no need to
stick to a CRT-compatible 'struct stat' either.

Define and use our own POSIX-2013-compatible 'struct stat' with nanosecond-
precision file times.

Note: This can cause performance issues when using Git variants with
different file time resolutions, as the timestamps are stored in the Git
index: after updating the index with a Git variant that uses
second-precision file times, a nanosecond-aware Git will think that
pretty much every single file listed in the index is out of date.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c   | 18 ++++++++++--------
 compat/mingw.h   | 36 ++++++++++++++++++++++++++----------
 config.mak.uname |  2 --
 3 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 07fc0b79a..26016d02e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -592,9 +592,11 @@ static inline long long filetime_to_hnsec(const FILETIME *ft)
 	return winTime - 116444736000000000LL;
 }
 
-static inline time_t filetime_to_time_t(const FILETIME *ft)
+static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
 {
-	return (time_t)(filetime_to_hnsec(ft) / 10000000);
+	long long hnsec = filetime_to_hnsec(ft);
+	ts->tv_sec = (time_t)(hnsec / 10000000);
+	ts->tv_nsec = (hnsec % 10000000) * 100;
 }
 
 /**
@@ -653,9 +655,9 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 		buf->st_size = fdata.nFileSizeLow |
 			(((off_t)fdata.nFileSizeHigh)<<32);
 		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
-		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
-		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
-		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
+		filetime_to_timespec(&(fdata.ftLastAccessTime), &(buf->st_atim));
+		filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
+		filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
 		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
 			WIN32_FIND_DATAW findbuf;
 			HANDLE handle = FindFirstFileW(wfilename, &findbuf);
@@ -753,9 +755,9 @@ static int get_file_info_by_handle(HANDLE hnd, struct stat *buf)
 	buf->st_size = fdata.nFileSizeLow |
 		(((off_t)fdata.nFileSizeHigh)<<32);
 	buf->st_dev = buf->st_rdev = 0; /* not used by Git */
-	buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
-	buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
-	buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
+	filetime_to_timespec(&(fdata.ftLastAccessTime), &(buf->st_atim));
+	filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
+	filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
 	return 0;
 }
 
diff --git a/compat/mingw.h b/compat/mingw.h
index 571019d0b..9419b27e1 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -327,18 +327,41 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
 }
 
 /*
- * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
+ * Use mingw specific stat()/lstat()/fstat() implementations on Windows,
+ * including our own struct stat with 64 bit st_size and nanosecond-precision
+ * file times.
  */
 #ifndef __MINGW64_VERSION_MAJOR
 #define off_t off64_t
 #define lseek _lseeki64
+struct timespec {
+	time_t tv_sec;
+	long tv_nsec;
+};
 #endif
 
-/* use struct stat with 64 bit st_size */
+struct mingw_stat {
+    _dev_t st_dev;
+    _ino_t st_ino;
+    _mode_t st_mode;
+    short st_nlink;
+    short st_uid;
+    short st_gid;
+    _dev_t st_rdev;
+    off64_t st_size;
+    struct timespec st_atim;
+    struct timespec st_mtim;
+    struct timespec st_ctim;
+};
+
+#define st_atime st_atim.tv_sec
+#define st_mtime st_mtim.tv_sec
+#define st_ctime st_ctim.tv_sec
+
 #ifdef stat
 #undef stat
 #endif
-#define stat _stati64
+#define stat mingw_stat
 int mingw_lstat(const char *file_name, struct stat *buf);
 int mingw_stat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
@@ -351,13 +374,6 @@ int mingw_fstat(int fd, struct stat *buf);
 #endif
 #define lstat mingw_lstat
 
-#ifndef _stati64
-# define _stati64(x,y) mingw_stat(x,y)
-#elif defined (_USE_32BIT_TIME_T)
-# define _stat32i64(x,y) mingw_stat(x,y)
-#else
-# define _stat64(x,y) mingw_stat(x,y)
-#endif
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
diff --git a/config.mak.uname b/config.mak.uname
index 8acdeb71f..f179d7a1d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -370,7 +370,6 @@ ifeq ($(uname_S),Windows)
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
 	# USE_NED_ALLOCATOR = YesPlease
@@ -518,7 +517,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
 	USE_NED_ALLOCATOR = YesPlease
-- 
gitgitgadget
