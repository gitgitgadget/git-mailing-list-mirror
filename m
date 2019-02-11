Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00DC91F453
	for <e@80x24.org>; Mon, 11 Feb 2019 19:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfBKTMn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 14:12:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40336 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbfBKTMn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 14:12:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id 10so3646410eds.7
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M57iSBFNGcoetmNl+aGGDVczN0L+nKMy/xyyhanLHvI=;
        b=JEOJILUo61uLlddQLPI+tg1+2nmi7ey97oHb9ZVcO/KarfgwSJM2Iui/0dX7NOK1Rj
         6wDfs3N4QkGNyYeiAocvmp4VVM29tBW3GdxuL7OJwvBX+iEcS6zlU7Y+G25kx7g6YilB
         LvZfO1rbXiPQ6tDaSfknoZ5LM6O9CMNq0Rnk+ZNhOXvKWLQ5D839NRqk1kQJQM3yRbxc
         KyrN6eYM96e7uNXBXc0BJcvw7tPNDsuqFRYs2zmhto/RwOGpwujHBp1bLcBydmZ1Teq1
         +cmPhXBZso725XH4tY73uJ03FrBmjwaLDByVeCTGssvlfItQLIIjK3B6zMKTFMjpntRL
         sKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M57iSBFNGcoetmNl+aGGDVczN0L+nKMy/xyyhanLHvI=;
        b=ol+XVSM6lofKcBM7rv2oJVaAwskULzKVQoVtXg1iIjsyrMv7RwRHeyjuRbhmb8FlyE
         1L3/ijuMBKLaM69lvp1mjwqMK8FAePvkSbjWYm0ZWPWy8MWu61nLf1ZFEIlRucuW4G0c
         2wSX8uLbHR4FOuAIOLqCc+KIYr5VmXZuLtowdpJIoS32g/56GUbG9Tz2EPUF959GqW0m
         62LTphv7xUQe1c5J/7WHzhZyV1uR4f102v4DI0UvBhGDpRwa+CPwMc219QpibtUkiTzv
         mjRyFkSxjoWbBclJve+7GbkPQt1t8j45WH6qS0MYUIIW+5AFjXPrf/+EkoJUDHSt3lCN
         rxHQ==
X-Gm-Message-State: AHQUAuYWdP5PN0k5BqzkBDlGfuZB/x76YzxDaoXCDpexo1o5jSgWHD+g
        RwexjTc3+IYaG/FpVK1AQOs/Fkhh
X-Google-Smtp-Source: AHgI3IYa+mJIli+DchXdaV6t5CKk/VvuJhNxvpafQDfOhxTCNxrSmCD5JbeSrfRni7AY47UrfY57wQ==
X-Received: by 2002:a50:f284:: with SMTP id f4mr29987525edm.77.1549912360908;
        Mon, 11 Feb 2019 11:12:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm1526087ejr.15.2019.02.11.11.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:12:40 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:12:40 -0800 (PST)
X-Google-Original-Date: Mon, 11 Feb 2019 19:12:38 GMT
Message-Id: <6af9ad6fbbd9ebeb4077ad2167e4e60674b1df75.1549912358.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.123.git.gitgitgadget@gmail.com>
References: <pull.123.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] fixup! trace2: collect Windows-specific process
 information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     [jeffhost@microsoft.com]@vger.kernel.org (mailto:jeffhost@microsoft.com),
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Guard against infinite loop while computing the parent process hierarchy.

CreateToolhelp32Snapshot() is used to get a list of all processes on the
system.  Each process entry contains the process PID and PPID (alive at the
time of the snapshot).  We compute the set of ancestors of the current process
by repeated searches on this list.

Testing revealed that the snapshot can contain PPID cycles.  This causes an
infinite loop during the set construction and causes the git.exe command to
hang.

Testing found an instance where 3 processes were in a PPID cycle.  The
snapshot implied that each of these processes was its own great-grandparent.
This should not be possible unless a PID was recycled and just happened to
match up.

For full disclosure, the Windows "System Idle Process" has PID and PPID 0.
If it were to launch a Git command, it could cause a similar infinite loop.
Or more properly, if any ancestor of the current Git command has PPID 0, it
will appear to be a descendant of the idle process and trigger the problem.

This commit fixes both cases by maintaining a list of the PIDs seen during
the ancestor walk and stopping if a cycle is detected.

Additionally, code was added to truncate the search after a reasonable fixed
depth limit.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/win32/trace2_win32_process_info.c | 32 ++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index 253199f812..751b366470 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -3,6 +3,8 @@
 #include <Psapi.h>
 #include <tlHelp32.h>
 
+#define NR_PIDS_LIMIT 42
+
 /*
  * Find the process data for the given PID in the given snapshot
  * and update the PROCESSENTRY32 data.
@@ -21,13 +23,17 @@ static int find_pid(DWORD pid, HANDLE hSnapshot, PROCESSENTRY32 *pe32)
 }
 
 /*
- * Accumulate JSON array:
+ * Accumulate JSON array of our parent processes:
  *     [
  *         exe-name-parent,
  *         exe-name-grand-parent,
  *         ...
  *     ]
  *
+ * We artificially limit this to NR_PIDS_LIMIT to quickly guard against cycles
+ * in the parent PIDs without a lot of fuss and because we just want some
+ * context and don't need an absolute answer.
+ *
  * Note: we only report the filename of the process executable; the
  *       only way to get its full pathname is to use OpenProcess()
  *       and GetModuleFileNameEx() or QueryfullProcessImageName()
@@ -38,16 +44,28 @@ static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
 {
 	PROCESSENTRY32 pe32;
 	DWORD pid;
+	DWORD pid_list[NR_PIDS_LIMIT];
+	int k, nr_pids = 0;
 
 	pid = GetCurrentProcessId();
+	while (find_pid(pid, hSnapshot, &pe32)) {
+		/* Only report parents. Omit self from the JSON output. */
+		if (nr_pids)
+			jw_array_string(jw, pe32.szExeFile);
 
-	/* We only want parent processes, so skip self. */
-	if (!find_pid(pid, hSnapshot, &pe32))
-		return;
-	pid = pe32.th32ParentProcessID;
+		/* Check for cycle in snapshot. (Yes, it happened.) */
+		for (k = 0; k < nr_pids; k++)
+			if (pid == pid_list[k]) {
+				jw_array_string(jw, "(cycle)");
+				return;
+			}
 
-	while (find_pid(pid, hSnapshot, &pe32)) {
-		jw_array_string(jw, pe32.szExeFile);
+		if (nr_pids == NR_PIDS_LIMIT) {
+			jw_array_string(jw, "(truncated)");
+			return;
+		}
+
+		pid_list[nr_pids++] = pid;
 
 		pid = pe32.th32ParentProcessID;
 	}
-- 
gitgitgadget
