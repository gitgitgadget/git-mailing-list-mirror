Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17ECF20248
	for <e@80x24.org>; Fri, 29 Mar 2019 17:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfC2REd (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 13:04:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33085 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbfC2REc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 13:04:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id q3so2675153edg.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kd2Rbi1tXiZYWQUT3yNjrRoPlm/Ow8LpLPIgY82loQs=;
        b=sEuM2cQhrsoS/5AvdCmcsZ4C60q9BQj4NapjptMwQzm0v/8KEE9GAFBKnChiAVv7g8
         EZu2QF+YIOu8mo6QoYHWqqi0wFeWQqc6eo3IcS7AleTEhK9C1yD1vPmbdYNDqeoIFR4w
         6z+vD0dg47kSJiZxcdhur9jCfr7tnIFHnbKwRCRRGjcKCOhxjh/cOzdR6Dc0c+rlrtQF
         5SoP/ZoUxFJP+2ABC+Lm1GUPQLEgGmOclbbtTVrOHnN5SxM8pQavsxT7r3HcnolO9YCM
         HY59coBGIQCky4EuZZDOUO3CkMPNZNJ1QIQPke+2MVWt9GRleBMXtx+FraoYgeyb5/uB
         ZLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kd2Rbi1tXiZYWQUT3yNjrRoPlm/Ow8LpLPIgY82loQs=;
        b=pPnF7iGOCFJq6fjD/Z9iW7NzHv8M29lUC9DwTs68x8zVJcKW9VRHZXfX51r+aWcecj
         ndPSkCMXFQ1gD2rBSPUL5bnjrBixpXTMOel1kqOCWbRbbIfMfsXF1R9+R0jGzQvOY2xG
         tsuDeBS/47qG2ZSG+hzBLcrGDVk1ndh/FbjE5ekZQYABkfw+6GuSACkpz/2SHYktuo5a
         Pp7EySFVzh2urHa500CrPqwxxKLjODabh1o+jHeMlSpZNOmo5IN0I6GOvV2q+4VXgscL
         z0mu4R2vcAnZLFwy2TyxhGFJ3Mz0S+L1Uh3HrmJv2sVlkmtLrvTVE8bU1qy3adTaMBH7
         wXCg==
X-Gm-Message-State: APjAAAUBj2l1AUy/dADCykVHMRj3ivolDSBJuiWbcpQDoPSYqvACytzt
        EnJ/mB4iElfy6qNhePIsyQA7+Fqb
X-Google-Smtp-Source: APXvYqxqlAqaXordzUhqtlGAAy4T/lI/Yvv+epGO16VJLOxKSWYM9cv4mi/GSfmyFy/QPkSog6tZEg==
X-Received: by 2002:a17:906:1dd0:: with SMTP id v16mr28386696ejh.204.1553879069669;
        Fri, 29 Mar 2019 10:04:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm777560eds.27.2019.03.29.10.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:04:29 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:04:29 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Mar 2019 17:04:21 GMT
Message-Id: <86d8fe28cf2f51a494163f9cec3e3b0541288435.1553879063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v2.git.gitgitgadget@gmail.com>
References: <pull.169.git.gitgitgadget@gmail.com>
        <pull.169.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/7] trace2: report peak memory usage of the process
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

