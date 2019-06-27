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
	by dcvr.yhbt.net (Postfix) with ESMTP id E39A31F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfF0JhX (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:37:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36646 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0JhV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:37:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so6436562edq.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1CDfdhP570sImu/DzEwADEdEZiPT3stXLqJRWefM8gc=;
        b=nAXEIofSn1Xx6qsu6i8DgLc6C8yJsVUUpca6fjW52Xwt4GcGmhu1powH/PFA6vJJ/0
         sdsg7Xw6f4OPR3trEcd3GlC3Xx6tKZu1dUhVXJtDYjy6NnjqsJruzjiXcRJaVUpT2tdo
         pb0HecPOjkLhjtkmuc60yECZd9Y8ibAJgHhhF4gjCyRFucBlV41x3NXnEw3udygKjKzY
         u6xUmgl0Gu62WivhM8cRRVr5jdbvSEVP0DDK/qoRB3XtI5aSl3SS9e9dqWU3fSS7reOz
         pR71Hjizm0iZUmA5omWvyz1JhB6EpsRkavHR72y9Ol6vRntOzMpLiXAtsiJ/Jne+GSWN
         qHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1CDfdhP570sImu/DzEwADEdEZiPT3stXLqJRWefM8gc=;
        b=Y46vnq+aqOYTo1DvEk0/FxCbNcA/S4rEr+TjoJ2YEWbV2jRjM8aFgAyMPqxwgbO6AI
         7oxZ7hbWm8TlHwSjQAVm3RtXQxVRNkkhm/D+wQj1t7WV8Uv0h7a7ho7l7hLoDd2Rf27P
         9gk+JTenAezCC6Aw6wBSx4Y6L24z2WxsmTqBgPIgAQcnnjsp2rZ9PBlIClDhgMOn+Nlz
         K7teTaYqFmcawzWZzBsD3Vl/zXYspblooHtDypP/Y2XtFdaE2I0Ev+ZeagzSAhcpnYL8
         Sq6Oy0acy/W0FUaeWXVoJx2KbYxy5x69l1gHueOJaLZJtkxMBjKKqK2D0EqPXKdPjXwY
         kZKw==
X-Gm-Message-State: APjAAAXT+Um3QCB8DAdC0+pc+bdUO1vR0EVRJ0iEXkmjki+ZN5uCgZI1
        jul/nHFnkFcRsFDPiQrS/udLjsLT
X-Google-Smtp-Source: APXvYqyw63ESujrw5cwf8ltDzaX7+YyVvil4xrSbMT0D8TraY3utnQO+vINEMSenidqip84MEopGQQ==
X-Received: by 2002:a17:906:1f43:: with SMTP id d3mr2100613ejk.169.1561628239691;
        Thu, 27 Jun 2019 02:37:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm322801ejm.68.2019.06.27.02.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:37:19 -0700 (PDT)
Date:   Thu, 27 Jun 2019 02:37:19 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 09:37:16 GMT
Message-Id: <0c9d2aead5f729942968314679c5a1ca2e0370d0.1561628237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.147.git.gitgitgadget@gmail.com>
References: <pull.147.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] mingw: use Unicode functions explicitly
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

Many Win32 API functions actually exist in two variants: one with
the `A` suffix that takes ANSI parameters (`char *` or `const char *`)
and one with the `W` suffix that takes Unicode parameters (`wchar_t *`
or `const wchar_t *`).

The ANSI variant assumes that the strings are encoded according to
whatever is the current locale. This is not what Git wants to use on
Windows: we assume that `char *` variables point to strings encoded in
UTF-8.

There is a pseudo UTF-8 locale on Windows, but it does not work
as one might expect. In addition, if we overrode the user's locale, that
would modify the behavior of programs spawned by Git (such as editors,
difftools, etc), therefore we cannot use that pseudo locale.

Further, it is actually highly encouraged to use the Unicode versions
instead of the ANSI versions, so let's do precisely that.

Note: when calling the Win32 API functions _without_ any suffix, it
depends whether the `UNICODE` constant is defined before the relevant
headers are #include'd. Without that constant, the ANSI variants are
used. Let's be explicit and avoid that ambiguity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c     |  2 +-
 compat/poll/poll.c |  2 +-
 compat/winansi.c   | 10 ++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8526876262..b8a62bf914 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1407,7 +1407,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	do_unset_environment_variables();
 
 	/* Determine whether or not we are associated to a console */
-	cons = CreateFile("CONOUT$", GENERIC_WRITE,
+	cons = CreateFileW(L"CONOUT$", GENERIC_WRITE,
 			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
 			FILE_ATTRIBUTE_NORMAL, NULL);
 	if (cons == INVALID_HANDLE_VALUE) {
diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 4459408c7d..8f24b80252 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -150,7 +150,7 @@ win32_compute_revents (HANDLE h, int *p_sought)
       if (!once_only)
 	{
 	  NtQueryInformationFile = (PNtQueryInformationFile)
-	    GetProcAddress (GetModuleHandle ("ntdll.dll"),
+	    GetProcAddress (GetModuleHandleW (L"ntdll.dll"),
 			    "NtQueryInformationFile");
 	  once_only = TRUE;
 	}
diff --git a/compat/winansi.c b/compat/winansi.c
index f4f08237f9..cd947e048e 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -599,7 +599,7 @@ int winansi_isatty(int fd)
 void winansi_init(void)
 {
 	int con1, con2;
-	char name[32];
+	wchar_t name[32];
 
 	/* check if either stdout or stderr is a console output screen buffer */
 	con1 = is_console(1);
@@ -619,13 +619,15 @@ void winansi_init(void)
 	}
 
 	/* create a named pipe to communicate with the console thread */
-	xsnprintf(name, sizeof(name), "\\\\.\\pipe\\winansi%lu", GetCurrentProcessId());
-	hwrite = CreateNamedPipe(name, PIPE_ACCESS_OUTBOUND,
+	if (swprintf(name, ARRAY_SIZE(name) - 1, L"\\\\.\\pipe\\winansi%lu",
+		     GetCurrentProcessId()) < 0)
+		die("Could not initialize winansi pipe name");
+	hwrite = CreateNamedPipeW(name, PIPE_ACCESS_OUTBOUND,
 		PIPE_TYPE_BYTE | PIPE_WAIT, 1, BUFFER_SIZE, 0, 0, NULL);
 	if (hwrite == INVALID_HANDLE_VALUE)
 		die_lasterr("CreateNamedPipe failed");
 
-	hread = CreateFile(name, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);
+	hread = CreateFileW(name, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);
 	if (hread == INVALID_HANDLE_VALUE)
 		die_lasterr("CreateFile for named pipe failed");
 
-- 
gitgitgadget
