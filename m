Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD1A1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeJXRrD (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:47:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44809 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbeJXRrC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:47:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so2104349pff.11
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8k1iWuS/cXgQSIF0g3LIEpex3f6e9Y/06yNirx6pA+Y=;
        b=ZWr1fgeBiq/psFMxFHXLmONFhv4ePBu9DH4Bx9jOZvuIBV3MgncmkQArpauvjSe8ks
         4s/rfUzoy+9yvyeTOtlopa2rPjbAB5aKoFythOzZfLbr62UVDUPlMhToqhqaZ8dCptnT
         8xZkk4mfipLQz0kxfFxTuBLHOGKicE4KXgZTZwITnQwhoEaHA64OYWrf2dD6NatyR5Cx
         QGp0Dr8WZ4dDN4MJBn8OZ+CfFNveJAA69yVR4wqhEe2poGlO1iXaYRWLJtTZAby11Cim
         9X56KcevC/pl+fEFjTj08o7b6sri2Ga/zP72WldlHn4jYkW4/gVlx5aJN7rq5DfJUW4m
         DjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8k1iWuS/cXgQSIF0g3LIEpex3f6e9Y/06yNirx6pA+Y=;
        b=DVTS0nh1KPYcJqCPrYXPTVLzf3CfPNbm5jaKDuqLQmmiyCWHQIUHAkzwcvY/lyEueb
         Rkw+8WtoHhqzHqfG9cRzBWLgmNV1AQsmpRbfmM5vt4WWqrS1fkODm9NOQIYOs0l1OMIS
         O8w0dBZMMeNSSBEAgrLOhLmi4DJqsH3wlTS6qUxR4FaC9aeVVtwotoliMgyDtz01ly6+
         muOq7dBBxzu70FBnR/COCiu0h1aR5qKp2OPBUpM8A7Qav0ASBvo18AWhMv7gIQyjxx/q
         SWLBSQvTvVSsmibinLSC4qlkvuLvOR4P5F+ZXBgwF5YTWTKPxAqI34ELoE5P4vf5BBaH
         Ekug==
X-Gm-Message-State: AGRZ1gIRcaiyXgB/ovnM9ax9szYostWe6wqguMjCq0bhXpEbyIaK7hbF
        4/+GKwzgS2jbYby7k/pRH2b3uRTi
X-Google-Smtp-Source: AJdET5eP89eppgqqUu04r9azntp7m49azRExqOmIQYjscGfcs2V/UcuPc/mn4dGxAdfsAjij5EKaeQ==
X-Received: by 2002:a62:12c9:: with SMTP id 70-v6mr1912596pfs.140.1540372782979;
        Wed, 24 Oct 2018 02:19:42 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id a64-v6sm5380414pfe.32.2018.10.24.02.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 02:19:42 -0700 (PDT)
Date:   Wed, 24 Oct 2018 02:19:42 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Oct 2018 09:19:37 GMT
Message-Id: <87ef9ac6349fff6afc4d5cfc513f682f335a28f4.1540372778.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.54.v2.git.gitgitgadget@gmail.com>
References: <pull.54.git.gitgitgadget@gmail.com>
        <pull.54.v2.git.gitgitgadget@gmail.com>
From:   "Anton Serbulov via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] mingw: fix getcwd when the parent directory cannot be
 queried
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stephen Smith <ischis2@cox.net>,
        Junio C Hamano <gitster@pobox.com>,
        Anton Serbulov <aserbulov@plesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Anton Serbulov <aserbulov@plesk.com>

`GetLongPathName()` function may fail when it is unable to query
the parent directory of a path component to determine the long name
for that component. It happens, because it uses `FindFirstFile()`
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
