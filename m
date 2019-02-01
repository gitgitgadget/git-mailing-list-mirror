Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62511F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfBAR7E (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34347 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730936AbfBAR7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so6197754ede.1
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6djYe7/03CUDTr2kWoKpxarC+toKY46tdt8i8EI49jQ=;
        b=aLMRCqnzRM92/ch0X2V97ddxiKXyBJJoura9GtyqD7kZ0MPTs23zsxz1rkjoCEJkDA
         ABonmSx/mTdYlxWY7YhohFdPNhsepuDNjbFZB+/dkTrpQpHiN2oefMAsuITOrIomPm4V
         Gcy+0PgdWIPkwG5kGcBVSaC9ak159Jge/+3TVH5v8qEWblltPUao2k2fSFDw9hU4W5aS
         YqVLJ50e7Eoohj7W0LAnAkU1j0snPfRgEt2kNzahaaTxKnR21EfFXciwNKq9f9h5HUTE
         00wCKgbZJDtP6RIErkjHWd2cehDw0ytb5EqGFGloiUN7X1b+cgP6PubPOV4FAzGMqcYG
         clAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6djYe7/03CUDTr2kWoKpxarC+toKY46tdt8i8EI49jQ=;
        b=Z7iqhPo6XkoxDTp2yXvLJnK24g6QbQeuY0ZEeirGQfuR2xfTr+PtqWtyEV4MlUZpJS
         3Am06fStTLZlcsaW1j5tvEFhE5QQYl/VU15qKBlmoqjfexEo0h3wysbUESjT4q06l07y
         5JuPWi3WjG4/O9ZV326+kbOnvyyJYZytpiDXzX6OKeprnQbH+ayWnFncMv5jzRJID/sm
         eFw1jXN8dApqGJjaL5oKLTb3mXQLAvIa80tr5PkJs6766ZBiKo5hdSlyeqyy2LxnL/V1
         oDv8HC/uXP05m4Zdba1MorQ13hzDHCcqzSAONTt+qCNNlWL99KYMb40NKMSxdo8e+dAN
         I+2g==
X-Gm-Message-State: AJcUukdspNYcuWMApi9cLNKKWD8kxXHHHroANVJeIcUh+YJvImc/ee2U
        ygoqUIgm1YWC/Et5X8UEcDI+gu+q
X-Google-Smtp-Source: ALg8bN7JVLXMPHpgw65GidbMTYZ5PekaIWVb1dL2dBHpb8USncYgY8bJamKlPbVD9QMpSRevNHxXJQ==
X-Received: by 2002:aa7:c0d0:: with SMTP id j16mr39143799edp.173.1549043941711;
        Fri, 01 Feb 2019 09:59:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm1336549ejm.11.2019.02.01.09.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:01 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:01 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:44 GMT
Message-Id: <7c987cde860b783782e4ee8e4f6ebd362c0df9a2.1549043936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 03/15] trace2: collect Windows-specific process information
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

Add platform-specific interface to log information about the current
process.

On Windows, this interface is used to indicate whether the git process
is running under a debugger and list names of the process ancestors.

Information for other platforms is left for a future effort.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 common-main.c                            |   1 +
 compat/win32/trace2_win32_process_info.c | 101 +++++++++++++++++++++++
 config.mak.uname                         |   2 +
 trace2.h                                 |  14 ++++
 4 files changed, 118 insertions(+)
 create mode 100644 compat/win32/trace2_win32_process_info.c

diff --git a/common-main.c b/common-main.c
index 6dbdc4adf2..d484aec209 100644
--- a/common-main.c
+++ b/common-main.c
@@ -37,6 +37,7 @@ int main(int argc, const char **argv)
 
 	trace2_initialize();
 	trace2_cmd_start(argv);
+	trace2_collect_process_info();
 
 	git_resolve_executable_dir(argv[0]);
 
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
new file mode 100644
index 0000000000..253199f812
--- /dev/null
+++ b/compat/win32/trace2_win32_process_info.c
@@ -0,0 +1,101 @@
+#include "../../cache.h"
+#include "../../json-writer.h"
+#include <Psapi.h>
+#include <tlHelp32.h>
+
+/*
+ * Find the process data for the given PID in the given snapshot
+ * and update the PROCESSENTRY32 data.
+ */
+static int find_pid(DWORD pid, HANDLE hSnapshot, PROCESSENTRY32 *pe32)
+{
+	pe32->dwSize = sizeof(PROCESSENTRY32);
+
+	if (Process32First(hSnapshot, pe32)) {
+		do {
+			if (pe32->th32ProcessID == pid)
+				return 1;
+		} while (Process32Next(hSnapshot, pe32));
+	}
+	return 0;
+}
+
+/*
+ * Accumulate JSON array:
+ *     [
+ *         exe-name-parent,
+ *         exe-name-grand-parent,
+ *         ...
+ *     ]
+ *
+ * Note: we only report the filename of the process executable; the
+ *       only way to get its full pathname is to use OpenProcess()
+ *       and GetModuleFileNameEx() or QueryfullProcessImageName()
+ *       and that seems rather expensive (on top of the cost of
+ *       getting the snapshot).
+ */
+static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
+{
+	PROCESSENTRY32 pe32;
+	DWORD pid;
+
+	pid = GetCurrentProcessId();
+
+	/* We only want parent processes, so skip self. */
+	if (!find_pid(pid, hSnapshot, &pe32))
+		return;
+	pid = pe32.th32ParentProcessID;
+
+	while (find_pid(pid, hSnapshot, &pe32)) {
+		jw_array_string(jw, pe32.szExeFile);
+
+		pid = pe32.th32ParentProcessID;
+	}
+}
+
+/*
+ * Emit JSON data for the current and parent processes.  Individual
+ * trace2 targets can decide how to actually print it.
+ */
+static void get_ancestry(void)
+{
+	HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
+
+	if (hSnapshot != INVALID_HANDLE_VALUE) {
+		struct json_writer jw = JSON_WRITER_INIT;
+
+		jw_array_begin(&jw, 0);
+		get_processes(&jw, hSnapshot);
+		jw_end(&jw);
+
+		trace2_data_json("process", the_repository, "windows/ancestry",
+				 &jw);
+
+		jw_release(&jw);
+		CloseHandle(hSnapshot);
+	}
+}
+
+/*
+ * Is a debugger attached to the current process?
+ *
+ * This will catch debug runs (where the debugger started the process).
+ * This is the normal case.  Since this code is called during our startup,
+ * it will not report instances where a debugger is attached dynamically
+ * to a running git process, but that is relatively rare.
+ */
+static void get_is_being_debugged(void)
+{
+	if (IsDebuggerPresent())
+		trace2_data_intmax("process", the_repository,
+				   "windows/debugger_present", 1);
+}
+
+void trace2_collect_process_info(void)
+{
+	if (!trace2_is_enabled())
+		return;
+
+	get_is_being_debugged();
+	get_ancestry();
+}
diff --git a/config.mak.uname b/config.mak.uname
index 7b36a1dfe7..a3c03ce2ae 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -391,6 +391,7 @@ ifeq ($(uname_S),Windows)
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
+		compat/win32/trace2_win32_process_info.o \
 		compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE
@@ -545,6 +546,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
+		compat/win32/trace2_win32_process_info.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
diff --git a/trace2.h b/trace2.h
index fce9891f53..ae5020d0e6 100644
--- a/trace2.h
+++ b/trace2.h
@@ -368,4 +368,18 @@ void trace2_printf(const char *fmt, ...);
 /* clang-format on */
 #endif
 
+/*
+ * Optional platform-specific code to dump information about the
+ * current and any parent process(es).  This is intended to allow
+ * post-processors to know who spawned this git instance and anything
+ * else the platform may be able to tell us about the current process.
+ */
+#if defined(GIT_WINDOWS_NATIVE)
+void trace2_collect_process_info(void);
+#else
+#define trace2_collect_process_info() \
+	do {                          \
+	} while (0)
+#endif
+
 #endif /* TRACE2_H */
-- 
gitgitgadget

