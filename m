Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C571F453
	for <e@80x24.org>; Mon, 29 Apr 2019 20:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfD2UOX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 16:14:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34908 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbfD2UOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 16:14:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id y67so10331087ede.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z8o12GckREM/bEMCMjMoq1w0AFX+e70lYNfbmVkvf6U=;
        b=HqOqcfHPC1cQJlT/l+NGLrhsZe4RI1H2odFSeK40y9e239WnPwDZLgfx6ovBAHr3ST
         PXOYnmTAhe8nq2xTJu0CL5ODHUuqwYsOO/yyhTQ1NH1Ri0ckU3DXubYICc92XlsoTwf6
         c6w2ChL7dzg7B2Z19inh6WtfJ+Roagt9yHx6UsfQU+IKrdAr5n4XdDwnPYr1Z0KqvqqK
         v7Md013dUIZDuKYIVoC7tBuTkGF+f1UXsxYgA9Ap1ZYU1f8juoXkCJ9sPA3khwb55OZe
         YNCKMnqA1Z/RpZCEEByBVJSIHl9n6Jgl9CH65fhxlcbpgrZNMloE8AarskxdXPLu8i49
         zs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z8o12GckREM/bEMCMjMoq1w0AFX+e70lYNfbmVkvf6U=;
        b=bltTpl4T2rhxNtiIBq5s5AM8nqWvvT6J6+BJ7EEW19G8ar94zbCMcpn3S6rN3K/Hi8
         Szf8RvZas25uIymclsXkazi18DMemFz8nF/vn/6PsTOc6cg600vSk+mhMGdokfjZm7ko
         HZ1j9sKYUwh4xanKta/KKsUJK7TeuaFgRE4B/z/7oCP9GQHzm/kBEWeFC0ZAJJKkZm6U
         EFb2n7SKFyOozrgPVv3lftwudomHiNP/YzEjUMTOCsANiwoBqdvJPgx1awn/IDtySThX
         7+sk5DyYZLQE7RiuPak5QTw5pSAfhZyTQ510VxnLBdxL8OrP/X31wtDqhek2e51uwCrG
         9YrQ==
X-Gm-Message-State: APjAAAUl9I+BS6lSgJzja6lC0/V0gwOHHFG4cxeqYMd7K06hJ2YynjrU
        bE3OCciAV+5KzSVHwXTeuJlclqwn
X-Google-Smtp-Source: APXvYqyoZVMbMs2InJkQ0eGwPgtgE8Zw3L60CCDGtNO465D1TGw3GZQRdAweih188whdiVTxnfqeSw==
X-Received: by 2002:a50:9143:: with SMTP id f3mr9738735eda.255.1556568859800;
        Mon, 29 Apr 2019 13:14:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i35sm9651924eda.55.2019.04.29.13.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:14:19 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:14:19 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 20:14:07 GMT
Message-Id: <56d8ce3fd60acc3808a5c8c1e5e1e6ba87fa1d5a.1556568852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v5.git.gitgitgadget@gmail.com>
References: <pull.169.v4.git.gitgitgadget@gmail.com>
        <pull.169.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 07/11] trace2: report peak memory usage of the process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Windows version of git to report peak memory usage
during exit() processing.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 common-main.c                            |  2 +-
 compat/win32/trace2_win32_process_info.c | 50 ++++++++++++++++++++++--
 trace2.c                                 |  2 +
 trace2.h                                 | 14 +++++--
 4 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/common-main.c b/common-main.c
index 299ca62a72..582a7b1886 100644
--- a/common-main.c
+++ b/common-main.c
@@ -41,7 +41,7 @@ int main(int argc, const char **argv)
 
 	trace2_initialize();
 	trace2_cmd_start(argv);
-	trace2_collect_process_info();
+	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
 
 	git_setup_gettext();
 
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index 52bd62034b..8ccbd1c2c6 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -1,5 +1,6 @@
 #include "../../cache.h"
 #include "../../json-writer.h"
+#include "lazyload.h"
 #include <Psapi.h>
 #include <tlHelp32.h>
 
@@ -137,11 +138,54 @@ static void get_is_being_debugged(void)
 				   "windows/debugger_present", 1);
 }
 
-void trace2_collect_process_info(void)
+/*
+ * Emit JSON data with the peak memory usage of the current process.
+ */
+static void get_peak_memory_info(void)
+{
+	DECLARE_PROC_ADDR(psapi.dll, BOOL, GetProcessMemoryInfo, HANDLE,
+			  PPROCESS_MEMORY_COUNTERS, DWORD);
+
+	if (INIT_PROC_ADDR(GetProcessMemoryInfo)) {
+		PROCESS_MEMORY_COUNTERS pmc;
+
+		if (GetProcessMemoryInfo(GetCurrentProcess(), &pmc,
+					 sizeof(pmc))) {
+			struct json_writer jw = JSON_WRITER_INIT;
+
+			jw_object_begin(&jw, 0);
+
+#define KV(kv) #kv, (intmax_t)pmc.kv
+
+			jw_object_intmax(&jw, KV(PageFaultCount));
+			jw_object_intmax(&jw, KV(PeakWorkingSetSize));
+			jw_object_intmax(&jw, KV(PeakPagefileUsage));
+
+			jw_end(&jw);
+
+			trace2_data_json("process", the_repository,
+					 "windows/memory", &jw);
+			jw_release(&jw);
+		}
+	}
+}
+
+void trace2_collect_process_info(enum trace2_process_info_reason reason)
 {
 	if (!trace2_is_enabled())
 		return;
 
-	get_is_being_debugged();
-	get_ancestry();
+	switch (reason) {
+	case TRACE2_PROCESS_INFO_STARTUP:
+		get_is_being_debugged();
+		get_ancestry();
+		return;
+
+	case TRACE2_PROCESS_INFO_EXIT:
+		get_peak_memory_info();
+		return;
+
+	default:
+		BUG("trace2_collect_process_info: unknown reason '%d'", reason);
+	}
 }
diff --git a/trace2.c b/trace2.c
index 490b3f071e..6baa65cdf9 100644
--- a/trace2.c
+++ b/trace2.c
@@ -213,6 +213,8 @@ int trace2_cmd_exit_fl(const char *file, int line, int code)
 	if (!trace2_enabled)
 		return code;
 
+	trace2_collect_process_info(TRACE2_PROCESS_INFO_EXIT);
+
 	tr2main_exit_code = code;
 
 	us_now = getnanotime() / 1000;
diff --git a/trace2.h b/trace2.h
index 894bfca7e0..888531eb08 100644
--- a/trace2.h
+++ b/trace2.h
@@ -391,13 +391,19 @@ void trace2_printf(const char *fmt, ...);
  * Optional platform-specific code to dump information about the
  * current and any parent process(es).  This is intended to allow
  * post-processors to know who spawned this git instance and anything
- * else the platform may be able to tell us about the current process.
+ * else that the platform may be able to tell us about the current process.
  */
+
+enum trace2_process_info_reason {
+	TRACE2_PROCESS_INFO_STARTUP,
+	TRACE2_PROCESS_INFO_EXIT,
+};
+
 #if defined(GIT_WINDOWS_NATIVE)
-void trace2_collect_process_info(void);
+void trace2_collect_process_info(enum trace2_process_info_reason reason);
 #else
-#define trace2_collect_process_info() \
-	do {                          \
+#define trace2_collect_process_info(reason) \
+	do {                                \
 	} while (0)
 #endif
 
-- 
gitgitgadget

