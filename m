Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F109C1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeIJWA0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 18:00:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46775 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 18:00:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id t19-v6so10019476ply.13
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uaaCPyujHx/G847/ERRvieUkKT3T50xow363oBxFmpc=;
        b=eC20yPSL2jcvyVyTkm9Hyk3kQnIzacRAWd0yRMlr+OoVjOfngxXkX7GZPBNntY2brj
         glTMpTaBFOlwK9VMf1rzm3layBJoGEwvvdDybOtLTmOAZengcMh5ciyXYyOg+1ZKLyVo
         2Y1Mg23qL+Gjl3ex0FU3+r+3UVGLtu+9o+I/3swRI/adXFL8Dnv8EHpnYEALFY6dFZjM
         iWsEbvjrBCwukoTWHt5kTONdaQ4k7Gk574YuRmzAEgdFd43XXuHWEG6Io9OpXVM01b0X
         AWgCTEpP1r8kK0KpHr/1g0ca21tHHapgkqnxZ20xlgXXd7LuZn7NQpPWn2TN4pnsifZZ
         uVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uaaCPyujHx/G847/ERRvieUkKT3T50xow363oBxFmpc=;
        b=cGk6vMRJA0WNS5jLnaX4JN7dmv/ubDitzys3ii5dF43O+ufYtDYJG3dOdGXrfXQUD+
         MSHB1lpoO7SpgIRr3XFy5GdnFkQVhfE4N/XZcLj/cbQYuppnGoAecN6QEXPuxASr2RrA
         Kefn4a5Ah2wuszFPko0Sz1r+0NBZw0QIiEQuO0y6gUzfExCgIv6M0vMAG1pNfVWMiNKP
         CNbXqm1QSY5vFchiLPuYzPXrXNTEG99YrO6t6WdMZ8mFl7dzRUMxeQ2xKpvaairMt5Gu
         pKj+9nIzy1QQY4TnylAGC6s9fjVz3Ahs5un5AiCQuRZyJ5TmEzCY0z+9nvomu/esCZkd
         JW0g==
X-Gm-Message-State: APzg51CcOd1Pm3B5Xj60URzb2FLE4rOV8LGbcIx3BZiT2wAa3Ig5sDay
        DraL/4oJbS+Wb6sxDYICE7bOpS80
X-Google-Smtp-Source: ANB0VdZF8P+RY3xzK3qmxpgN0m58cYqLmeyktnF4uDPYdTOvIdsgjyj1oTquO4O+g5H/2orj0aiyvA==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3-v6mr22760973plr.242.1536599123718;
        Mon, 10 Sep 2018 10:05:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id h85-v6sm31439536pfk.71.2018.09.10.10.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 10:05:22 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:05:22 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Sep 2018 17:05:17 GMT
Message-Id: <f0361dd306d19fa741c813885d240e041dc09a7a.1536599118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.35.v2.git.gitgitgadget@gmail.com>
References: <pull.35.git.gitgitgadget@gmail.com>
        <pull.35.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] mingw: fix mingw_open_append to work with named pipes
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
 compat/mingw.c                | 38 ++++++++++++++++++++++++++++++++---
 t/t0051-windows-named-pipe.sh |  2 +-
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 858ca14a57..f87376b26a 100644
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
@@ -371,6 +386,23 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	return fd;
 }
 
+#define IS_SBS(ch) (((ch) == '/') || ((ch) == '\\'))
+/*
+ * Does the pathname map to the local named pipe filesystem?
+ * That is, does it have a "//./pipe/" prefix?
+ */
+static int mingw_is_local_named_pipe_path(const char *filename)
+{
+	return (IS_SBS(filename[0]) &&
+		IS_SBS(filename[1]) &&
+		filename[2] == '.'  &&
+		IS_SBS(filename[3]) &&
+		!strncasecmp(filename+4, "pipe", 4) &&
+		IS_SBS(filename[8]) &&
+		filename[9]);
+}
+#undef IS_SBS
+
 int mingw_open (const char *filename, int oflags, ...)
 {
 	typedef int (*open_fn_t)(wchar_t const *wfilename, int oflags, ...);
@@ -387,7 +419,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	if (filename && !strcmp(filename, "/dev/null"))
 		filename = "nul";
 
-	if (oflags & O_APPEND)
+	if ((oflags & O_APPEND) && !mingw_is_local_named_pipe_path(filename))
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
