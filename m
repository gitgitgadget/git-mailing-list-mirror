Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1F020248
	for <e@80x24.org>; Thu, 11 Apr 2019 15:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDKPSt (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 11:18:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33224 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDKPSq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id d55so4765841ede.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kd2Rbi1tXiZYWQUT3yNjrRoPlm/Ow8LpLPIgY82loQs=;
        b=BvB2a4Y6zPqzP/zz4Uw6UZBi3Rep63wK3p/aueB2gmyKNaG1xrmFn7W/Hu11gXHvh4
         RnHNvooZaJKIYGy3zUGQpX2doYkQdhoew2V4Yn60W6ODROg30e2E96CqcUZ/m3tP19Ix
         LiqW2o2vPPQbyM8SouFJ5uMivKq1Q7IcSAU0oVsQm9Fh2bhhdHzOoBvABtGHePcOqhiF
         vDpuSB/Grfs+HT/jzAKgVPmlTauk2LSlCZMAHNbdPRMcTk35nlmtK8MvrqVn5Nycc0lZ
         RiCPJogLUuap5d2V6OoPOs6CuiWA7rFGYI8kNo7ERi4wc8xCnl2frl8P67yPpo3DhoQ/
         XM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kd2Rbi1tXiZYWQUT3yNjrRoPlm/Ow8LpLPIgY82loQs=;
        b=sO92x34GnxH7u2Py2TFP8m/KjW7BXa3E+J9jrG5rxGcguG+EWFP377cX+XOt5/3Zf/
         Pgxef/IS9LQ4wCBgUh3GpuuZrQZX5EcpD7gdQjCo7M02XSxKZvtrWAO+GnMIyRYn1ygF
         M2OrVhDtSsTBr+neVf3+z/2HfmfDzPLN4IznMF5croFdNaU/k+e7PE1lVBgylV43qfAj
         NxVUuMWd6oQc2On4KGEwfgzB3ddtJl6fA/D/x4gTJIzUBjEOaaDd/lfRdNwRXGzJwdOO
         66vF8TwylDUQoktynW2KZHc+3q8UrbSDkKGkiginMDQLfeg0rNnV6kKDIgxvGWTx9kOf
         aXWw==
X-Gm-Message-State: APjAAAVDtmiMeO7/5vHeSqpnWQuPOQopVFiCMk1MZ6GIuZe3DbuOHZfX
        T7ahuo+h0PvsB+XaXcKcAmTMG22k
X-Google-Smtp-Source: APXvYqyPwd+9B2vng2er42Xi09jS4GLcdrj01Kf96O2SoXPdzO2aBviTa/IVF4cHxuQM61KfSCsS0g==
X-Received: by 2002:a17:906:bcd6:: with SMTP id lw22mr28116680ejb.110.1554995923979;
        Thu, 11 Apr 2019 08:18:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1sm5136624ejf.40.2019.04.11.08.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:18:43 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:18:43 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 15:18:33 GMT
Message-Id: <2a7a9338758f915d00f78671e50a3a7b618e94e5.1554995916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v3.git.gitgitgadget@gmail.com>
References: <pull.169.v2.git.gitgitgadget@gmail.com>
        <pull.169.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 07/10] trace2: report peak memory usage of the process
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
index 52bd62034b..2a514caed9 100644
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
+	DECLARE_PROC_ADDR(psapi.dll, BOOL, GetProcessMemoryInfo,
+			  HANDLE, PPROCESS_MEMORY_COUNTERS, DWORD);
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

