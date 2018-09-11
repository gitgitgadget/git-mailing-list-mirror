Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF851F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeILBG6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:06:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39687 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeILBG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so11818182plp.6
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Agjw7Y9zGnVQmRvQGkvEZo0zdVClO8jtCf/ymvKo1wM=;
        b=oQ49JCHjJElDiaxgmDl3UmbA/IgvxkEtTFNgu62vt9LuqdzF5jzFBR6HcC7bS1Y3a1
         8YfHL7f5Ix2vjLYpFUFhFJn+1j3zlIUA32LhoJ6pPLtdlpcuJe7dOQk4YkCLThkMry6z
         vVtUI6SkJdH1dlvJhuxLi5oLyWxr5aTCibxBzua0CHCp3dKdavk6nNfMUKn/XCvklSoW
         zwGEkcupxR+kNZQJcpvBLcHfqAohVRp6fxbhciXzN1jkNGJaj938jCMXvakbujzS+9AW
         G8fBd0PSyO2r+OAYz0WKN90UgZ9LRVDB4o0DSHaDbYSdLgk7D5MEzEUq8obFTrva06ts
         6jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Agjw7Y9zGnVQmRvQGkvEZo0zdVClO8jtCf/ymvKo1wM=;
        b=HGo3PmBIGFwWHjZCGLr6EPh8t/7b6JoRawPPuoEwpGMez6kSX7P/LrmH+R0JPR9HvC
         DPdi5x8LSkUaoXaL5IpUTqa9bLaTFR+yjnOUVtZH/abVO559Qvz9WpSAVyLmqgyfyujk
         QnIpw6aZAAWSE8lYPGPwMprifhZbGozoQlAPAcHQwVtGtDeuZyuEyZUbBxSwJFvjPHIK
         GELt5jLmIRib0qfJSUbFkNY51hDMqXk3F3k6nEKNmMh8zPRjIA1R57CLmAxqCjoyl3tn
         LdKcG8OFcgf7PwEmhKuHeqqt1LKZBhR+KSPGCydP/MHEM7i54jd6RNw/RHYRbhJ6bJwU
         8myw==
X-Gm-Message-State: APzg51DMq0ttoPQDuwzDTPl8Yrv+K58VFeXY1J/H798hlA03W+zfCkFK
        yWhAj3UjT1g1bTfCKyZh8fWCukxe
X-Google-Smtp-Source: ANB0VdYZuUnhi+aep0sZK9Ub5+QOL8ZGPSJuMaFBnpYL7kDYLmxhxYboXVBolW0+0dKR6FJ6iyfa7Q==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr28426771plb.176.1536696364009;
        Tue, 11 Sep 2018 13:06:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id t1-v6sm20788904pgp.32.2018.09.11.13.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 13:06:02 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:06:02 -0700 (PDT)
X-Google-Original-Date: Tue, 11 Sep 2018 20:05:57 GMT
Message-Id: <5592300ca526422ed3a5cf000e9e574cc97b252d.1536696358.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.35.v3.git.gitgitgadget@gmail.com>
References: <pull.35.v2.git.gitgitgadget@gmail.com>
        <pull.35.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/2] mingw: fix mingw_open_append to work with named pipes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/mingw.c                | 36 ++++++++++++++++++++++++++++++++---
 t/t0051-windows-named-pipe.sh |  2 +-
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 858ca14a57..18caf21969 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -341,6 +341,19 @@ int mingw_mkdir(const char *path, int mode)
 	return ret;
 }
 
+/*
+ * Calling CreateFile() using FILE_APPEND_DATA and without FILE_WRITE_DATA
+ * is documented in [1] as opening a writable file handle in append mode.
+ * (It is believed that) this is atomic since it is maintained by the
+ * kernel unlike the O_APPEND flag which is racily maintained by the CRT.
+ *
+ * [1] https://docs.microsoft.com/en-us/windows/desktop/fileio/file-access-rights-constants
+ *
+ * This trick does not appear to work for named pipes.  Instead it creates
+ * a named pipe client handle that cannot be written to.  Callers should
+ * just use the regular _wopen() for them.  (And since client handle gets
+ * bound to a unique server handle, it isn't really an issue.)
+ */
 static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 {
 	HANDLE handle;
@@ -360,10 +373,12 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 			NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
 	if (handle == INVALID_HANDLE_VALUE)
 		return errno = err_win_to_posix(GetLastError()), -1;
+
 	/*
 	 * No O_APPEND here, because the CRT uses it only to reset the
-	 * file pointer to EOF on write(); but that is not necessary
-	 * for a file created with FILE_APPEND_DATA.
+	 * file pointer to EOF before each write(); but that is not
+	 * necessary (and may lead to races) for a file created with
+	 * FILE_APPEND_DATA.
 	 */
 	fd = _open_osfhandle((intptr_t)handle, O_BINARY);
 	if (fd < 0)
@@ -371,6 +386,21 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	return fd;
 }
 
+/*
+ * Does the pathname map to the local named pipe filesystem?
+ * That is, does it have a "//./pipe/" prefix?
+ */
+static int is_local_named_pipe_path(const char *filename)
+{
+	return (is_dir_sep(filename[0]) &&
+		is_dir_sep(filename[1]) &&
+		filename[2] == '.'  &&
+		is_dir_sep(filename[3]) &&
+		!strncasecmp(filename+4, "pipe", 4) &&
+		is_dir_sep(filename[8]) &&
+		filename[9]);
+}
+
 int mingw_open (const char *filename, int oflags, ...)
 {
 	typedef int (*open_fn_t)(wchar_t const *wfilename, int oflags, ...);
@@ -387,7 +417,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	if (filename && !strcmp(filename, "/dev/null"))
 		filename = "nul";
 
-	if (oflags & O_APPEND)
+	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
 		open_fn = mingw_open_append;
 	else
 		open_fn = _wopen;
diff --git a/t/t0051-windows-named-pipe.sh b/t/t0051-windows-named-pipe.sh
index e3c36341a0..10ac92d225 100755
--- a/t/t0051-windows-named-pipe.sh
+++ b/t/t0051-windows-named-pipe.sh
@@ -4,7 +4,7 @@ test_description='Windows named pipes'
 
 . ./test-lib.sh
 
-test_expect_failure MINGW 'o_append write to named pipe' '
+test_expect_success MINGW 'o_append write to named pipe' '
 	GIT_TRACE="$(pwd)/expect" git status >/dev/null 2>&1 &&
 	{ test-tool windows-named-pipe t0051 >actual 2>&1 & } &&
 	pid=$! &&
-- 
gitgitgadget
