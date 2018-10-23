Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E1E1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeJWSqI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:46:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46581 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeJWSqI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:46:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id r64-v6so415334pfb.13
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iq77terXrxcEpQveHm98O2N7uMN26N1Wz/b4yXQNVSk=;
        b=KCRNjP6pWKTZ937O6d/d458DBv3dQWGNNl4P8JLXe+KKX4ht8R8oj7jGgTjk7tdlR1
         rVugZGn/xK9X+8F4/d4pFJM8hzvvsIVeMdF21v9Qp3fF+X6xg5+cLvjgLPhFdvnqmkIq
         vr04+WnZIbEKFL5uOUripqJyXHchbRuDwOeauawRybkBI2+vWGFp36govTnbL4bdhrOb
         I891Dg6KS4x+AeYwrOiqtblH0YxQx9+QMeRc1+DPkoAGGFLWdkEyF2+ppowNKZWkFIPx
         h5KetN5oSxDVfLuVpsaEjKI0wulUC4mRyKJOn5wsHUUY3huh74cZUlQYqAwedaovzayz
         DuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iq77terXrxcEpQveHm98O2N7uMN26N1Wz/b4yXQNVSk=;
        b=OlrGkTfXi60TLOGacDKnk0D3BKd5x0bGzca0M5aHXXD2mgdlok9nWSLITLrO4J4CuG
         YJLUdI1We3zPknSl9KCJxPtmOY/s4lmZTxzIyzkQDkTjYQaVfOhGGbtWYhS1F1Uj5PHf
         TTxWiN+o/vEh1mEUvyf95OU2bAuh/h7UtMRv2NF7N3of8+CeFWXa4THOFzDsNevE+d6Y
         auZPaFoE3mLIjMd3/YSYMkz4EKtq3fz25cFddxoso+GEmThPBj/ikHa1f0/OgVnJCGnB
         BSryhvvPKlzXxRq29uXUvJqpjBY0plAur4pnSYhIWnwmzhU1eU9/nyP3NK10fzuaDSUW
         p+dg==
X-Gm-Message-State: AGRZ1gL7B/HNrP0CHXedhaV/p/SB7VNe8NjpPU9IXB9azPDXEtvMG3T/
        ZNP6ExC9O/a1ocRnD9qT71bxrSAH
X-Google-Smtp-Source: AJdET5dSRxvdE3noYLwFhjiNVEvhv3Ophh3QWkPQ5d4S/DWrFod8f5acbkW484VXYUdhiaJz17KpRw==
X-Received: by 2002:a63:3f44:: with SMTP id m65mr7016399pga.115.1540290200735;
        Tue, 23 Oct 2018 03:23:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id o131-v6sm1442801pgo.53.2018.10.23.03.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:23:19 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:23:19 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 10:23:14 GMT
Message-Id: <85485598a8c391262612929ad4b98e79517e01a4.1540290197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.53.git.gitgitgadget@gmail.com>
References: <pull.53.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] mingw: factor out code to set stat() data
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

In our fstat() emulation, we convert the file metadata from Win32 data
structures to an emulated POSIX structure.

To structure the code better, let's factor that part out into its own
function.

Note: it would be tempting to try to unify this code with the part of
do_lstat() that does the same thing, but they operate on different data
structures: BY_HANDLE_FILE_INFORMATION vs WIN32_FILE_ATTRIBUTE_DATA. So
unfortunately, they cannot be unified.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 18caf2196..d2e7d86db 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -736,6 +736,29 @@ static int do_stat_internal(int follow, const char *file_name, struct stat *buf)
 	return do_lstat(follow, alt_name, buf);
 }
 
+static int get_file_info_by_handle(HANDLE hnd, struct stat *buf)
+{
+	BY_HANDLE_FILE_INFORMATION fdata;
+
+	if (!GetFileInformationByHandle(hnd, &fdata)) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+
+	buf->st_ino = 0;
+	buf->st_gid = 0;
+	buf->st_uid = 0;
+	buf->st_nlink = 1;
+	buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
+	buf->st_size = fdata.nFileSizeLow |
+		(((off_t)fdata.nFileSizeHigh)<<32);
+	buf->st_dev = buf->st_rdev = 0; /* not used by Git */
+	buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
+	buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
+	buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
+	return 0;
+}
+
 int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	return do_stat_internal(0, file_name, buf);
@@ -748,7 +771,6 @@ int mingw_stat(const char *file_name, struct stat *buf)
 int mingw_fstat(int fd, struct stat *buf)
 {
 	HANDLE fh = (HANDLE)_get_osfhandle(fd);
-	BY_HANDLE_FILE_INFORMATION fdata;
 
 	if (fh == INVALID_HANDLE_VALUE) {
 		errno = EBADF;
@@ -758,20 +780,9 @@ int mingw_fstat(int fd, struct stat *buf)
 	if (GetFileType(fh) != FILE_TYPE_DISK)
 		return _fstati64(fd, buf);
 
-	if (GetFileInformationByHandle(fh, &fdata)) {
-		buf->st_ino = 0;
-		buf->st_gid = 0;
-		buf->st_uid = 0;
-		buf->st_nlink = 1;
-		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
-		buf->st_size = fdata.nFileSizeLow |
-			(((off_t)fdata.nFileSizeHigh)<<32);
-		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
-		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
-		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
-		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
+	if (!get_file_info_by_handle(fh, buf))
 		return 0;
-	}
+
 	errno = EBADF;
 	return -1;
 }
-- 
gitgitgadget

