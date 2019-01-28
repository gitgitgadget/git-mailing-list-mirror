Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C491F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfA1Vrq (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:47:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46133 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfA1Vrq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so14293747edt.13
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bNJ+Wkw3LUOXEXcei6RLhoMm7z15hycaqBM/ICAwDV4=;
        b=GMXm/tGXTg3lCrQMRsyogp7wuvoGv+8FYYH4LwhvRyMfYkWC03ycmkgES9/T05Qx87
         Ixn797PjkPRNXy/hvaixBE0A+T/B4pjeofqmzP6a8xfEnBu+Wonb/QX4K6F8klauKR/2
         /L8tejvy3l1dR+ws75vdznKKxVzG84Oi6NE3EKdp+QBCNLIHKqG89oX+0JITmP+fht0u
         DpVLvQnk57So68URSg1vMIKv6BcXkaLDIXy4esOoJ12ORQwbzUYBYVFY5RsCGvRadp9r
         LQDc8VWk1+ForY+scxdDxQTm8dcFk906D7GeRPRXtdHmZCz56JB2NZAX8Je170z9rHbZ
         lwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bNJ+Wkw3LUOXEXcei6RLhoMm7z15hycaqBM/ICAwDV4=;
        b=qycVBfg3EQ3hxzIQe/wTRKooMde7mwRs3RyQuP3Gj4CStZaaNTlYWkHKia5ybBrq8Z
         oPC4PcnER9aK44nxxPLq5cDZ82aCuS7cRsLhHkgtGTIR9r2rUyMrgJ8FsNoUiWeaU/ct
         xmamCISrMaKff8vKaAVVNVUAZpQzDgb9kCtN7Jjyrr50YsV7lebhXF94iw4zSQinFvSk
         hwRvnXikVQceYLl+5QjuKs820pP31clTnH5AmyjD969zIH5Kz4u8svF9myRYk7GjEFkB
         44DaEeloa/Pz+8QT0yQvvJt72nQ/kszeeqdhxiEGqVj6501wW2VNK1ayMHQs3tWodG+Z
         Hf+w==
X-Gm-Message-State: AJcUukfCp3VERvY10T+kgWHiT+nuq+XW/g+E/AUJ49O0WK5Zq4JqFL5k
        DdA7PRc9zVoMq1hp3uUZ4u1KLjnU
X-Google-Smtp-Source: ALg8bN7le0UuE6KarxpAumAxciHO1xxc/RO7DGTAjqpXXRVtZTNldGibXbYkYDkHTdWDt06s7lgTBg==
X-Received: by 2002:a50:e0cb:: with SMTP id j11mr23047780edl.195.1548712064187;
        Mon, 28 Jan 2019 13:47:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21sm13538731edr.67.2019.01.28.13.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:43 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:43 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:28 GMT
Message-Id: <5ac061e14a3a0e8cdd81fd0d56c3c70e6a22d171.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/14] trace2: collect platform-specific process
 information
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

Add optional platform-specific code to log information about
the current process.

On Windows, this includes whether git.exe is running under a
debugger and information about the ancestors of the process.

The purpose of this information is to help indicate if the
process was launched interactively or in the background by
an IDE, for example.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 common-main.c           |   1 +
 compat/win32/ancestry.c | 102 ++++++++++++++++++++++++++++++++++++++++
 config.mak.uname        |   2 +
 trace2.h                |  13 +++++
 4 files changed, 118 insertions(+)
 create mode 100644 compat/win32/ancestry.c

diff --git a/common-main.c b/common-main.c
index 6dbdc4adf2..d484aec209 100644
--- a/common-main.c
+++ b/common-main.c
@@ -37,6 +37,7 @@ int main(int argc, const char **argv)
 
 	trace2_initialize();
 	trace2_cmd_start(argv);
+	trace2_collect_process_info();
 
 	git_resolve_executable_dir(argv[0]);
 
diff --git a/compat/win32/ancestry.c b/compat/win32/ancestry.c
new file mode 100644
index 0000000000..629d8214b9
--- /dev/null
+++ b/compat/win32/ancestry.c
@@ -0,0 +1,102 @@
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
+
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
+		trace2_data_json("process", the_repository,
+				 "windows/ancestry", &jw);
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
+			   "windows/debugger_present", 1);
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
index e391431041..13d7c5410f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -391,6 +391,7 @@ ifeq ($(uname_S),Windows)
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
+		compat/win32/ancestry.o \
 		compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE
@@ -528,6 +529,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
+		compat/win32/ancestry.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
diff --git a/trace2.h b/trace2.h
index 7ab9f355f3..a4a075d060 100644
--- a/trace2.h
+++ b/trace2.h
@@ -387,4 +387,17 @@ __attribute__((format (printf, 1, 2)))
 void trace2_printf(const char *fmt, ...);
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
+	do {} while (0)
+#endif
+
 #endif /* TRACE2_H */
-- 
gitgitgadget

