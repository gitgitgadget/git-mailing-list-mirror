Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2897520248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfBVWZF (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43983 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVWZF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id m35so3072318ede.10
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6wM4AVCHFIe/1dtctvO0oWlgYpCXJdmmr94dTUrx/eA=;
        b=oY7Wm/QpqTYqaSIIWYh80q3Y8Kx8WOoQL/5OB7VpKFASj5n/LNzyeBG8WXG91eybE7
         ycBriBZkdcVbZ2iTRVUk4GYwD7hsczBStBSTE4oLb+s6/medgeKjF0WsMxcLoQAekq2E
         inHZzKamYLeKMQbbvmxDwZmHxhpWjyYCzLQg1NfyMHPz72IWuxKEhB3Qvxhc4rAnPK2E
         1hM5N+w5cyB9tyLTzKem8FZFkmWwNriVrJoFWPGKPv4rFo4JTGoP4DfjHR2Q1Bnn6nrE
         0mKH4s76X2JY/z9shpCHu/RB7sIxsJ8BOIm55UjG/lX9VK0j4X/ueK9PMciJddH4pXI7
         Timw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6wM4AVCHFIe/1dtctvO0oWlgYpCXJdmmr94dTUrx/eA=;
        b=miv5UjmHNdbnLOP0hZ+k1DFEKV+2Roc0XsPVC7hRbDYLl5qU9VjM7/abgIAivk944v
         yxTUo83U7zUeM1vs9gQiTdlYzo9Ej9Ub6OP2hXR1MRZeiNkqXi3B+TMRiJa3PuYhi/fB
         mW5OwXmPqZZuFcreMH30TFKx1Sx2LneGm15PlspixI77+h323Tc2G5+6Rfuz5YnkuXnD
         98oqHPgBj0kJS6+spPpzTptozF0qA2J21nuXFCwnVDnOFXwE08SlQHrGWTTzcGHrHmxk
         2FeDZvUV74kzkPjWvFhKbkfiv600+bZ+sJb2ZoricajXrN625NJOcqWwStsbWiquR4lU
         6fLw==
X-Gm-Message-State: AHQUAuadCLXZZqj7eJ2K5wXphVTFICg3yuy5tmEJVtyyzZuTCgfwEDW/
        QMcQwFbMSq3kU6mujpVFRcJzpmdF
X-Google-Smtp-Source: AHgI3IZaZJV3+a1OZej3v9AMhgZo6JQwj/KjJOOyCMUWHN/t4em1W1qIHkSQFjV5a8nLwAmBHb72GA==
X-Received: by 2002:a17:906:f0c1:: with SMTP id dk1mr4525283ejb.14.1550874302837;
        Fri, 22 Feb 2019 14:25:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p47sm696098eda.31.2019.02.22.14.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:02 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:02 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:46 GMT
Message-Id: <50f689dc956ea5ad7100475b6f91c918567647f4.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 03/15] trace2: collect Windows-specific process information
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
 compat/win32/trace2_win32_process_info.c | 147 +++++++++++++++++++++++
 config.mak.uname                         |   2 +
 trace2.h                                 |  14 +++
 4 files changed, 164 insertions(+)
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
index 0000000000..52bd62034b
--- /dev/null
+++ b/compat/win32/trace2_win32_process_info.c
@@ -0,0 +1,147 @@
+#include "../../cache.h"
+#include "../../json-writer.h"
+#include <Psapi.h>
+#include <tlHelp32.h>
+
+/*
+ * An arbitrarily chosen value to limit the size of the ancestor
+ * array built in git_processes().
+ */
+#define NR_PIDS_LIMIT 10
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
+ * Accumulate JSON array of our parent processes:
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
+ *
+ * Note: we compute the set of parent processes by walking the PPID
+ *       link in each visited PROCESSENTRY32 record.  This search
+ *       stops when an ancestor process is not found in the snapshot
+ *       (because it exited before the current or intermediate parent
+ *       process exited).
+ *
+ *       This search may compute an incorrect result if the PPID link
+ *       refers to the PID of an exited parent and that PID has been
+ *       recycled and given to a new unrelated process.
+ *
+ *       Worse, it is possible for a child or descendant of the
+ *       current process to be given the recycled PID and cause a
+ *       PPID-cycle.  This would cause an infinite loop building our
+ *       parent process array.
+ *
+ * Note: for completeness, the "System Idle" process has PID=0 and
+ *       PPID=0 and could cause another PPID-cycle.  We don't expect
+ *       Git to be a descendant of the idle process, but because of
+ *       PID recycling, it might be possible to get a PPID link value
+ *       of 0.  This too would cause an infinite loop.
+ *
+ * Therefore, we keep an array of the visited PPIDs to guard against
+ * cycles.
+ *
+ * We use a fixed-size array rather than ALLOC_GROW to keep things
+ * simple and avoid the alloc/realloc overhead.  It is OK if we
+ * truncate the search and return a partial answer.
+ */
+static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
+{
+	PROCESSENTRY32 pe32;
+	DWORD pid;
+	DWORD pid_list[NR_PIDS_LIMIT];
+	int k, nr_pids = 0;
+
+	pid = GetCurrentProcessId();
+	while (find_pid(pid, hSnapshot, &pe32)) {
+		/* Only report parents. Omit self from the JSON output. */
+		if (nr_pids)
+			jw_array_string(jw, pe32.szExeFile);
+
+		/* Check for cycle in snapshot. (Yes, it happened.) */
+		for (k = 0; k < nr_pids; k++)
+			if (pid == pid_list[k]) {
+				jw_array_string(jw, "(cycle)");
+				return;
+			}
+
+		if (nr_pids == NR_PIDS_LIMIT) {
+			jw_array_string(jw, "(truncated)");
+			return;
+		}
+
+		pid_list[nr_pids++] = pid;
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

