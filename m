Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023AE1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeJWTPq (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 15:15:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43098 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWTPp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 15:15:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id q1-v6so457040pfh.10
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sBoE9U318lCcRAwWehlQz+MBIy5Z24ygcw2DXltBpXo=;
        b=bJHToyICDL2LL2lUE6uG2U0PYmZp5Ewr7Wj5eRzVDoCrf3gJuMQk8S9PKr8zSeQYb8
         a7wqIucBq5XZBMIova0UAsGrFinwnYKQTO0GrmKZ0D3eXQzT3X+5dobR1RSM6R3uxKgI
         CsUsnVpsa0qR3e1Y3GP+7hdtDIaBVVaT8FAj64gfSpf9SpvCAF+XcTJ/nlysJ5E7uCva
         DnhA/1xHF9EAsV/PEX0I5lL9OqISgE5s52pvT7n3R7EU8B24+bB6+7VBTcRAEEXZav+y
         Xap0e+OHFqnXV508t/I3l98LqUh8R+yMpFj9QF7po3e2SXyGAbwX2l3jPQbYOCKNPlwf
         5rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sBoE9U318lCcRAwWehlQz+MBIy5Z24ygcw2DXltBpXo=;
        b=I6XUlS8C3G8efFZcppKkdGSTn7aR1BU4EFY42He1wYYjbZn28muS2BZGwrkDOhBRxA
         111txofmWAm5wkNJNbs34iXQoX/B5cVq9BLpyHDaC4Ap1wUH9kWJSGqu1kI7jLyeaEbM
         Kqai0L3n+tnhtXjL2RtA41fM3pK4WE5BT/G0AIDGLQxmqPnNmlpdwvR5gpUlV2UdlW+6
         w38nYAocNxt68sdDskF6mAdgxLSHwruwHy/VH8z8uLeY53hDU4A3t/VWrskNtz5YGOo/
         sCejhpamMM4y+xmiPwAx0FQ47/tXcQCYl5uXPKqMY9+xa1q309zEVx9F6h5U6PerPaSd
         vShA==
X-Gm-Message-State: AGRZ1gJa6bPkgxQmaXrpq5OCzcIkfaMVO+nmioMH9Y4MYoVWy+7+evoD
        rcWo1zQ/z9J1xAdQXjP9kx1lEYhF
X-Google-Smtp-Source: AJdET5d3tbrz6PriVUzqWimLjq3Cx4beJ75FCg43SUdnVqZRkMg2mQqI8D+jj+nN5Qrocs6KLCpwhw==
X-Received: by 2002:a63:d849:: with SMTP id k9-v6mr9130410pgj.200.1540291970531;
        Tue, 23 Oct 2018 03:52:50 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id k132-v6sm1504217pga.28.2018.10.23.03.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:52:49 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:52:49 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 10:52:45 GMT
Message-Id: <3e3b1c3b1ff3363b216574f09d2c9cf22d25ad30.1540291965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.54.git.gitgitgadget@gmail.com>
References: <pull.54.git.gitgitgadget@gmail.com>
From:   "Anton Serbulov via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] mingw: fix getcwd when the parent directory cannot be
 queried
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anton Serbulov <aserbulov@plesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Anton Serbulov <aserbulov@plesk.com>

`GetLongPathName()` function may fail when it is unable to query
the parent directory of a path component to determine the long name
for that component. It happens, because of it uses `FindFirstFile()`
function for each next short part of path. The `FindFirstFile()`
requires `List Directory` and `Synchronize` desired access for a calling
process.

In case of lacking such permission for some part of path,
the `GetLongPathName()` returns 0 as result and `GetLastError()`
returns ERROR_ACCESS_DENIED.

`GetFinalPathNameByHandle()` function can help in such cases, because
it requires `Read Attributes` and `Synchronize` desired access to the
target path only.

The `GetFinalPathNameByHandle()` function was introduced on
`Windows Server 2008/Windows Vista`. So we need to load it dynamically.

`CreateFile()` parameters:
    `lpFileName` = path to the current directory
    `dwDesiredAccess` = 0 (it means `Read Attributes` and `Synchronize`)
    `dwShareMode` = FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE
                    (it prevents `Sharing Violation`)
    `lpSecurityAttributes` = NULL (default security attributes)
    `dwCreationDisposition` = OPEN_EXISTING
                              (required to obtain a directory handle)
    `dwFlagsAndAttributes` = FILE_FLAG_BACKUP_SEMANTICS
                             (required to obtain a directory handle)
    `hTemplateFile` = NULL (when opening an existing file or directory,
                            `CreateFile` ignores this parameter)

The string that is returned by `GetFinalPathNameByHandle()` function
uses the \\?\ syntax. To skip the prefix and convert backslashes
to slashes, the `normalize_ntpath()` mingw function will be used.

Note: `GetFinalPathNameByHandle()` function returns a final path.
It is the path that is returned when a path is fully resolved.
For example, for a symbolic link named "C:\tmp\mydir" that points to
"D:\yourdir", the final path would be "D:\yourdir".

Signed-off-by: Anton Serbulov <aserbulov@plesk.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2c3e27ce9..19addfa5d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -202,6 +202,31 @@ static int ask_yes_no_if_possible(const char *format, ...)
 	}
 }
 
+/* Normalizes NT paths as returned by some low-level APIs. */
+static wchar_t *normalize_ntpath(wchar_t *wbuf)
+{
+	int i;
+	/* fix absolute path prefixes */
+	if (wbuf[0] == '\\') {
+		/* strip NT namespace prefixes */
+		if (!wcsncmp(wbuf, L"\\??\\", 4) ||
+		    !wcsncmp(wbuf, L"\\\\?\\", 4))
+			wbuf += 4;
+		else if (!wcsnicmp(wbuf, L"\\DosDevices\\", 12))
+			wbuf += 12;
+		/* replace remaining '...UNC\' with '\\' */
+		if (!wcsnicmp(wbuf, L"UNC\\", 4)) {
+			wbuf += 2;
+			*wbuf = '\\';
+		}
+	}
+	/* convert backslashes to slashes */
+	for (i = 0; wbuf[i]; i++)
+		if (wbuf[i] == '\\')
+			wbuf[i] = '/';
+	return wbuf;
+}
+
 int mingw_unlink(const char *pathname)
 {
 	int ret, tries = 0;
@@ -925,6 +950,20 @@ char *mingw_getcwd(char *pointer, int len)
 		return NULL;
 	}
 	ret = GetLongPathNameW(cwd, wpointer, ARRAY_SIZE(wpointer));
+	if (!ret && GetLastError() == ERROR_ACCESS_DENIED) {
+		HANDLE hnd = CreateFileW(cwd, 0,
+			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+		if (hnd == INVALID_HANDLE_VALUE)
+			return NULL;
+		ret = GetFinalPathNameByHandleW(hnd, wpointer, ARRAY_SIZE(wpointer), 0);
+		CloseHandle(hnd);
+		if (!ret || ret >= ARRAY_SIZE(wpointer))
+			return NULL;
+		if (xwcstoutf(pointer, normalize_ntpath(wpointer), len) < 0)
+			return NULL;
+		return pointer;
+	}
 	if (!ret || ret >= ARRAY_SIZE(wpointer))
 		return NULL;
 	if (xwcstoutf(pointer, wpointer, len) < 0)
-- 
gitgitgadget
