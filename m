Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5831F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHJWSk (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:18:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39325 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeHJWSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:18:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id w14-v6so4448516plp.6
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1XOcOTuK9TSCFwdPwogil4+04wg2XRDo4Wn6E3KwjGY=;
        b=fUfaY+Vml0zs2B8SsjUlvifdYqN5Ylx/8uZsdCn8/w7erQun/NLMwx7C17zVIuYO+p
         FFbqmjT1KnIM2mirgBlWp23xkJTXChrxVi+tVePOYAqhEoPxTGknkAN7m2BFo0D2DXR0
         1dqoDtU4+kSAwARpoSCJHHes0cI1b+RP8Z3mPz6Pstv4D8ce9Ay7C+Vybejvyuj/n+LQ
         Nk9GjVPmI7Zo0j6CG6JiLt81D+RvWdrTQAEkFjEarykYVmaYp4i3R5eLkkOlmyAri0v5
         SUJ4OkR+gawKtUeS9oNYAbuC6TsPSG9b9XGUjNB7RN1OtswKJyHaBWIEZfw4sff8Zub7
         Gggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1XOcOTuK9TSCFwdPwogil4+04wg2XRDo4Wn6E3KwjGY=;
        b=gt5GxjBVgLSG8KwugHBfShbWQ5SdN5LYt7Rf8TIFCe/yU+PQPeSgK2ZcUMeVnWslpj
         CwzxyXiV95yoPEXat5SXNul9hK5J8EZygAPa3rY1yxbbkg6muPvROReztp36WJGT5TuH
         8J70ipYwH0JUj4/nz4PQXLc5eBncsybt/LVOCrIXYmLkdOq99T60yjS4LWa4CtM4ygHV
         FMYoJhR+tdInWSoHVw9BPG1IcW/+USw2BYeACM9L/L3Pwf+QQ6cqWIY4bWFsfOrl5t+F
         RRCkKHprN/ceHVxrsaaLPgd2YyKaPNIyNPzZ3fp3c0O9Kj2Wfx0sxg+n2jFw1yExZ9oM
         D1Iw==
X-Gm-Message-State: AOUpUlHoD/9oQItFghq4pVOCvaHRKcR58r59Bo1c9hoO+XRWl/sZpogK
        E3koIEwd0RxizjyWM0PFR3w1rhxl
X-Google-Smtp-Source: AA+uWPwdr7qOJZp+mTx8aBH1KWSMo74/xi6g3/U3t4XEEzmPUpwNZXvRM9wbXYD3e3rV1T5yUwnA/w==
X-Received: by 2002:a17:902:988a:: with SMTP id s10-v6mr7235308plp.200.1533930442770;
        Fri, 10 Aug 2018 12:47:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id e73-v6sm23461252pfb.153.2018.08.10.12.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:47:21 -0700 (PDT)
Date:   Fri, 10 Aug 2018 12:47:21 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 19:47:14 GMT
Message-Id: <fa0c282aab98cd857ea37afd5a00ce8600b77bb1.1533930437.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.17.v2.git.gitgitgadget@gmail.com>
References: <pull.17.git.gitgitgadget@gmail.com>
        <pull.17.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/4] mingw: implement lock_or_unlock_fd_for_appending()
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

For some reason, t/t5552-skipping-fetch-negotiator.sh fails particularly
often on Windows due to racy tracing where the `git upload-pack` and the
`git fetch` processes compete for the same file.

We just introduced a remedy that uses fcntl(), but Windows does not have
fcntl(). So let's implement an alternative.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 19 +++++++++++++++++++
 compat/mingw.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6ded1c859..6da9ce861 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -514,6 +514,25 @@ int mingw_chmod(const char *filename, int mode)
 	return _wchmod(wfilename, mode);
 }
 
+int mingw_lock_or_unlock_fd_for_appending(int fd, int lock_it)
+{
+	HANDLE handle = (HANDLE)_get_osfhandle(fd);
+	OVERLAPPED overlapped = { 0 };
+	DWORD err;
+
+	if (!lock_it && UnlockFileEx(handle, 0, -1, 0, &overlapped))
+		return 0;
+	if (lock_it &&
+	    LockFileEx(handle, LOCKFILE_EXCLUSIVE_LOCK, 0, -1, 0, &overlapped))
+		return 0;
+
+	err = GetLastError();
+	/* LockFileEx() cannot lock pipes */
+	errno = err == ERROR_INVALID_FUNCTION ?
+		EBADF : err_win_to_posix(GetLastError());
+	return -1;
+}
+
 /*
  * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
  * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
diff --git a/compat/mingw.h b/compat/mingw.h
index 571019d0b..0f76d89a9 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -397,6 +397,9 @@ HANDLE winansi_get_osfhandle(int fd);
  * git specific compatibility
  */
 
+int mingw_lock_or_unlock_fd_for_appending(int fd, int lock_it);
+#define lock_or_unlock_fd_for_appending mingw_lock_or_unlock_fd_for_appending
+
 #define has_dos_drive_prefix(path) \
 	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
 int mingw_skip_dos_drive_prefix(char **path);
-- 
gitgitgadget

