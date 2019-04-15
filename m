Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDCC120248
	for <e@80x24.org>; Mon, 15 Apr 2019 20:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfDOUjx (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 16:39:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38869 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfDOUju (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 16:39:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id d13so15914284edr.5
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sokXBaj3+XNus2pDsxqrtM5BTxJnRQKzSOtAe0V/Rw8=;
        b=cjEMwzFU/jWHA0sgB93Yqq2cOKCki0PHC5tBFPc1F8QPtpeE+D4rFgMiVZ5A0G3STv
         Rek403lrKshQHbCRH9rGQHbX2ciw5x6UtxtZCDwKS9HcDhFcxqIssjYAZ0bemAPUcxVP
         2u6iX/WuqAsS1798oIyOReJ1fvKe0fcrMAYx0P2M8rC2CslUrVgmZMykWG5dMki19Iwb
         XX4H8DYiRuyNOGgxmBPkikY5WF9y8r6FjmlB+W5fu9YAjLCMGvbq6L1+HTlyio5gJaHx
         7YPOdnyGr1ToSpYpQjUxzmBOhgaJj7Km9wykFoD/c+mAGcAS8Aq8ahUE+U18tn242k5l
         9Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sokXBaj3+XNus2pDsxqrtM5BTxJnRQKzSOtAe0V/Rw8=;
        b=f0Gtw540PpFaxrfmb2IxgcmtAyXaQpni0W9SWN//ndA1Ey0ZIWlSzHE5wdY1I3EY6P
         6qFZAe1+uTniACS6HQj2sI6I9dxU4PKF2/w1lYcQj2Lq/qqDJy2gGv16nvUuCUtfxTjl
         uentGobLDPRSFOMQjF0O8/zNZtz59rgdalZi+w04ZLw4NAn8T1oILaru4UwyEFIOyRFj
         eu+iBLu6lA+VcAQKewe2soBygpOnnJVHturQM96j3Fw/Zb5I4wUCEHRiLAF+F8nyZ3pt
         2xelqF/jHC5NfAqctgWuujoH8dmZSzrkQiaNsEJ9AM6mlnbHdSbvEQrFPtKeRIyIgsbV
         oDQA==
X-Gm-Message-State: APjAAAWkAFTYs82BkYYL6AlMBOXJUAy115tMibxr4bYwPg8pMvxQSuMT
        ZTOeGHkt2OYOa6fU0m7zXpeJUHnz
X-Google-Smtp-Source: APXvYqx2OjR0BE9X6rIv1zwqGz4EKeEYEQwTDF0Sj1dgzlJ81PyO4CzJIwKvdQneDkFNykqUfewpwg==
X-Received: by 2002:a17:906:5013:: with SMTP id s19mr30077896ejj.203.1555360787859;
        Mon, 15 Apr 2019 13:39:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4sm5705632ejx.55.2019.04.15.13.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:39:47 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:39:47 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Apr 2019 20:39:36 GMT
Message-Id: <550cad618923c6e5aa1bd5f901f2968791d7566b.1555360780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v4.git.gitgitgadget@gmail.com>
References: <pull.169.v3.git.gitgitgadget@gmail.com>
        <pull.169.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 06/10] trace2: use system/global config for default trace2
 settings
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

Teach git to read the system and global config files for
default Trace2 settings.  This allows system-wide Trace2 settings to
be installed and inherited to make it easier to manage a collection of
systems.

The original GIT_TR2* environment variables are loaded afterwards and
can be used to override the system settings.

Only the system and global config files are used.  Repo and worktree
local config files are ignored.  Likewise, the "-c" command line
arguments are also ignored.  These limits are for performance reasons.

(1) For users not using Trace2, there should be minimal overhead to
detect that Trace2 is not enabled.  In particular, Trace2 should not
allocate lots of otherwise unused data strucutres.

(2) For accurate performance measurements, Trace2 should be initialized
as early in the git process as possible, and before most of the normal
git process initialization (which involves discovering the .git directory
and reading a hierarchy of config files).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                 |   1 +
 t/t0210-trace2-normal.sh |  49 +++++++++++++--
 t/t0211-trace2-perf.sh   |  31 ++++++++--
 t/t0212-trace2-event.sh  |  42 +++++++++++--
 trace2.c                 |   4 ++
 trace2.h                 |  12 ++--
 trace2/tr2_cfg.c         |   7 +--
 trace2/tr2_dst.c         |  26 ++++----
 trace2/tr2_dst.h         |   3 +-
 trace2/tr2_sysenv.c      | 127 +++++++++++++++++++++++++++++++++++++++
 trace2/tr2_sysenv.h      |  36 +++++++++++
 trace2/tr2_tgt_event.c   |  46 +++++++-------
 trace2/tr2_tgt_normal.c  |  16 ++---
 trace2/tr2_tgt_perf.c    |  16 ++---
 14 files changed, 340 insertions(+), 76 deletions(-)
 create mode 100644 trace2/tr2_sysenv.c
 create mode 100644 trace2/tr2_sysenv.h

diff --git a/Makefile b/Makefile
index 3e03290d8f..9ddfa3dfe7 100644
--- a/Makefile
+++ b/Makefile
@@ -1005,6 +1005,7 @@ LIB_OBJS += trace2/tr2_cfg.o
 LIB_OBJS += trace2/tr2_cmd_name.o
 LIB_OBJS += trace2/tr2_dst.o
 LIB_OBJS += trace2/tr2_sid.o
+LIB_OBJS += trace2/tr2_sysenv.o
 LIB_OBJS += trace2/tr2_tbuf.o
 LIB_OBJS += trace2/tr2_tgt_event.o
 LIB_OBJS += trace2/tr2_tgt_normal.o
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 03a0aedb1d..8d17e1e6f1 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -3,6 +3,11 @@
 test_description='test trace2 facility (normal target)'
 . ./test-lib.sh
 
+# Turn off any inherited trace2 settings for this test.
+sane_unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
+sane_unset GIT_TR2_BRIEF
+sane_unset GIT_TR2_CONFIG_PARAMS
+
 # Add t/helper directory to PATH so that we can use a relative
 # path to run nested instances of test-tool.exe (see 004child).
 # This helps with HEREDOC comparisons later.
@@ -15,11 +20,6 @@ PATH="$TTDIR:$PATH" && export PATH
 # Warning: So you may see extra lines in artifact files when
 # Warning: interactively debugging.
 
-# Turn off any inherited trace2 settings for this test.
-unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
-unset GIT_TR2_BRIEF
-unset GIT_TR2_CONFIG_PARAMS
-
 V=$(git version | sed -e 's/^git version //') && export V
 
 # There are multiple trace2 targets: normal, perf, and event.
@@ -132,4 +132,43 @@ test_expect_success 'normal stream, error event' '
 	test_cmp expect actual
 '
 
+sane_unset GIT_TR2_BRIEF
+
+# Now test without environment variables and get all Trace2 settings
+# from the global config.
+
+test_expect_success 'using global config, normal stream, return code 0' '
+	test_when_finished "rm trace.normal actual expect" &&
+	test_config_global trace2.normalBrief 1 &&
+	test_config_global trace2.normalTarget "$(pwd)/trace.normal" &&
+	test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 001return 0
+		cmd_name trace2 (trace2)
+		exit elapsed:_TIME_ code:0
+		atexit elapsed:_TIME_ code:0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'using global config with include' '
+	test_when_finished "rm trace.normal actual expect real.gitconfig" &&
+	test_config_global trace2.normalBrief 1 &&
+	test_config_global trace2.normalTarget "$(pwd)/trace.normal" &&
+	mv "$(pwd)/.gitconfig" "$(pwd)/real.gitconfig" &&
+	test_config_global include.path "$(pwd)/real.gitconfig" &&
+	test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 001return 0
+		cmd_name trace2 (trace2)
+		exit elapsed:_TIME_ code:0
+		atexit elapsed:_TIME_ code:0
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index c9694b29f7..b501e867af 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -3,6 +3,11 @@
 test_description='test trace2 facility (perf target)'
 . ./test-lib.sh
 
+# Turn off any inherited trace2 settings for this test.
+sane_unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
+sane_unset GIT_TR2_PERF_BRIEF
+sane_unset GIT_TR2_CONFIG_PARAMS
+
 # Add t/helper directory to PATH so that we can use a relative
 # path to run nested instances of test-tool.exe (see 004child).
 # This helps with HEREDOC comparisons later.
@@ -15,11 +20,6 @@ PATH="$TTDIR:$PATH" && export PATH
 # Warning: So you may see extra lines in artifact files when
 # Warning: interactively debugging.
 
-# Turn off any inherited trace2 settings for this test.
-unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
-unset GIT_TR2_PERF_BRIEF
-unset GIT_TR2_CONFIG_PARAMS
-
 V=$(git version | sed -e 's/^git version //') && export V
 
 # There are multiple trace2 targets: normal, perf, and event.
@@ -150,4 +150,25 @@ test_expect_success 'perf stream, child processes' '
 	test_cmp expect actual
 '
 
+sane_unset GIT_TR2_PERF_BRIEF
+
+# Now test without environment variables and get all Trace2 settings
+# from the global config.
+
+test_expect_success 'using global config, perf stream, return code 0' '
+	test_when_finished "rm trace.perf actual expect" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+	test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+	cat >expect <<-EOF &&
+		d0|main|version|||||$V
+		d0|main|start||_T_ABS_|||_EXE_ trace2 001return 0
+		d0|main|cmd_name|||||trace2 (trace2)
+		d0|main|exit||_T_ABS_|||code:0
+		d0|main|atexit||_T_ABS_|||code:0
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 028b6c5671..59adae8123 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -3,6 +3,11 @@
 test_description='test trace2 facility'
 . ./test-lib.sh
 
+# Turn off any inherited trace2 settings for this test.
+sane_unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
+sane_unset GIT_TR2_BARE
+sane_unset GIT_TR2_CONFIG_PARAMS
+
 perl -MJSON::PP -e 0 >/dev/null 2>&1 && test_set_prereq JSON_PP
 
 # Add t/helper directory to PATH so that we can use a relative
@@ -17,11 +22,6 @@ PATH="$TTDIR:$PATH" && export PATH
 # Warning: So you may see extra lines in artifact files when
 # Warning: interactively debugging.
 
-# Turn off any inherited trace2 settings for this test.
-unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
-unset GIT_TR2_BARE
-unset GIT_TR2_CONFIG_PARAMS
-
 V=$(git version | sed -e 's/^git version //') && export V
 
 # There are multiple trace2 targets: normal, perf, and event.
@@ -233,4 +233,36 @@ test_expect_success JSON_PP 'basic trace2_data' '
 	test_cmp expect actual
 '
 
+# Now test without environment variables and get all Trace2 settings
+# from the global config.
+
+test_expect_success JSON_PP 'using global config, event stream, error event' '
+	test_when_finished "rm trace.event actual expect" &&
+	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
+	test-tool trace2 003error "hello world" "this is a test" &&
+	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
+	sed -e "s/^|//" >expect <<-EOF &&
+	|VAR1 = {
+	|  "_SID0_":{
+	|    "argv":[
+	|      "_EXE_",
+	|      "trace2",
+	|      "003error",
+	|      "hello world",
+	|      "this is a test"
+	|    ],
+	|    "errors":[
+	|      "%s",
+	|      "%s"
+	|    ],
+	|    "exit_code":0,
+	|    "hierarchy":"trace2",
+	|    "name":"trace2",
+	|    "version":"$V"
+	|  }
+	|};
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/trace2.c b/trace2.c
index 1c180062dd..490b3f071e 100644
--- a/trace2.c
+++ b/trace2.c
@@ -10,6 +10,7 @@
 #include "trace2/tr2_cmd_name.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
+#include "trace2/tr2_sysenv.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
@@ -120,6 +121,7 @@ static void tr2main_atexit_handler(void)
 	tr2_sid_release();
 	tr2_cmd_name_release();
 	tr2_cfg_free_patterns();
+	tr2_sysenv_release();
 
 	trace2_enabled = 0;
 }
@@ -155,6 +157,8 @@ void trace2_initialize_fl(const char *file, int line)
 	if (trace2_enabled)
 		return;
 
+	tr2_sysenv_load();
+
 	if (!tr2_tgt_want_builtins())
 		return;
 	trace2_enabled = 1;
diff --git a/trace2.h b/trace2.h
index 8f89e70c44..894bfca7e0 100644
--- a/trace2.h
+++ b/trace2.h
@@ -38,7 +38,8 @@ void trace2_initialize_clock(void);
 
 /*
  * Initialize TRACE2 tracing facility if any of the builtin TRACE2
- * targets are enabled in the environment.  Emits a 'version' event.
+ * targets are enabled in the system config or the environment.
+ * Emits a 'version' event.
  *
  * Cleanup/Termination is handled automatically by a registered
  * atexit() routine.
@@ -125,10 +126,11 @@ void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
  * Emit one or more 'def_param' events for "interesting" configuration
  * settings.
  *
- * The environment variable "GIT_TR2_CONFIG_PARAMS" can be set to a
- * list of patterns considered important.  For example:
- *
- *    GIT_TR2_CONFIG_PARAMS="core.*,remote.*.url"
+ * Use the TR2_SYSENV_CFG_PARAM setting to register a comma-separated
+ * list of patterns configured important.  For example:
+ *     git config --system trace2.configParams 'core.*,remote.*.url'
+ * or:
+ *     GIT_TR2_CONFIG_PARAMS=core.*,remote.*.url"
  *
  * Note: this routine does a read-only iteration on the config data
  * (using read_early_config()), so it must not be called until enough
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index b329921ac5..caa7f06948 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -1,8 +1,7 @@
 #include "cache.h"
 #include "config.h"
-#include "tr2_cfg.h"
-
-#define TR2_ENVVAR_CFG_PARAM "GIT_TR2_CONFIG_PARAMS"
+#include "trace2/tr2_cfg.h"
+#include "trace2/tr2_sysenv.h"
 
 static struct strbuf **tr2_cfg_patterns;
 static int tr2_cfg_count_patterns;
@@ -21,7 +20,7 @@ static int tr2_cfg_load_patterns(void)
 		return tr2_cfg_count_patterns;
 	tr2_cfg_loaded = 1;
 
-	envvar = getenv(TR2_ENVVAR_CFG_PARAM);
+	envvar = tr2_sysenv_get(TR2_SYSENV_CFG_PARAM);
 	if (!envvar || !*envvar)
 		return tr2_cfg_count_patterns;
 
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index fd490a43ad..7d96f33420 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "trace2/tr2_dst.h"
+#include "trace2/tr2_sysenv.h"
 
 /*
  * If a Trace2 target cannot be opened for writing, we should issue a
@@ -7,17 +8,13 @@
  * or socket and beyond the user's control -- especially since every
  * git command (and sub-command) will print the message.  So we silently
  * eat these warnings and just discard the trace data.
- *
- * Enable the following environment variable to see these warnings.
  */
-#define TR2_ENVVAR_DST_DEBUG "GIT_TR2_DST_DEBUG"
-
 static int tr2_dst_want_warning(void)
 {
 	static int tr2env_dst_debug = -1;
 
 	if (tr2env_dst_debug == -1) {
-		const char *env_value = getenv(TR2_ENVVAR_DST_DEBUG);
+		const char *env_value = tr2_sysenv_get(TR2_SYSENV_DST_DEBUG);
 		if (!env_value || !*env_value)
 			tr2env_dst_debug = 0;
 		else
@@ -42,7 +39,9 @@ static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
 	if (fd == -1) {
 		if (tr2_dst_want_warning())
 			warning("trace2: could not open '%s' for '%s' tracing: %s",
-				tgt_value, dst->env_var_name, strerror(errno));
+				tgt_value,
+				tr2_sysenv_display_name(dst->sysenv_var),
+				strerror(errno));
 
 		tr2_dst_trace_disable(dst);
 		return 0;
@@ -116,7 +115,8 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	if (!path || !*path) {
 		if (tr2_dst_want_warning())
 			warning("trace2: invalid AF_UNIX value '%s' for '%s' tracing",
-				tgt_value, dst->env_var_name);
+				tgt_value,
+				tr2_sysenv_display_name(dst->sysenv_var));
 
 		tr2_dst_trace_disable(dst);
 		return 0;
@@ -126,7 +126,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	    strlen(path) >= sizeof(((struct sockaddr_un *)0)->sun_path)) {
 		if (tr2_dst_want_warning())
 			warning("trace2: invalid AF_UNIX path '%s' for '%s' tracing",
-				path, dst->env_var_name);
+				path, tr2_sysenv_display_name(dst->sysenv_var));
 
 		tr2_dst_trace_disable(dst);
 		return 0;
@@ -148,7 +148,8 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 error:
 	if (tr2_dst_want_warning())
 		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
-			path, dst->env_var_name, strerror(e));
+			path, tr2_sysenv_display_name(dst->sysenv_var),
+			strerror(e));
 
 	tr2_dst_trace_disable(dst);
 	return 0;
@@ -168,7 +169,7 @@ static void tr2_dst_malformed_warning(struct tr2_dst *dst,
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "trace2: unknown value for '%s': '%s'",
-		    dst->env_var_name, tgt_value);
+		    tr2_sysenv_display_name(dst->sysenv_var), tgt_value);
 	warning("%s", buf.buf);
 
 	strbuf_release(&buf);
@@ -184,7 +185,7 @@ int tr2_dst_get_trace_fd(struct tr2_dst *dst)
 
 	dst->initialized = 1;
 
-	tgt_value = getenv(dst->env_var_name);
+	tgt_value = tr2_sysenv_get(dst->sysenv_var);
 
 	if (!tgt_value || !strcmp(tgt_value, "") || !strcmp(tgt_value, "0") ||
 	    !strcasecmp(tgt_value, "false")) {
@@ -246,7 +247,8 @@ void tr2_dst_write_line(struct tr2_dst *dst, struct strbuf *buf_line)
 		return;
 
 	if (tr2_dst_want_warning())
-		warning("unable to write trace to '%s': %s", dst->env_var_name,
+		warning("unable to write trace to '%s': %s",
+			tr2_sysenv_display_name(dst->sysenv_var),
 			strerror(errno));
 	tr2_dst_trace_disable(dst);
 }
diff --git a/trace2/tr2_dst.h b/trace2/tr2_dst.h
index 9a64f05b02..3adf3bac13 100644
--- a/trace2/tr2_dst.h
+++ b/trace2/tr2_dst.h
@@ -2,9 +2,10 @@
 #define TR2_DST_H
 
 struct strbuf;
+#include "trace2/tr2_sysenv.h"
 
 struct tr2_dst {
-	const char *const env_var_name;
+	enum tr2_sysenv_variable sysenv_var;
 	int fd;
 	unsigned int initialized : 1;
 	unsigned int need_close : 1;
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
new file mode 100644
index 0000000000..9025b86303
--- /dev/null
+++ b/trace2/tr2_sysenv.c
@@ -0,0 +1,127 @@
+#include "cache.h"
+#include "config.h"
+#include "dir.h"
+#include "tr2_sysenv.h"
+
+/*
+ * Each entry represents a trace2 setting.
+ * See Documentation/technical/api-trace2.txt
+ */
+struct tr2_sysenv_entry {
+	const char *env_var_name;
+	const char *git_config_name;
+
+	char *value;
+	unsigned int getenv_called : 1;
+};
+
+/*
+ * This table must match "enum tr2_sysenv_variable" in tr2_sysenv.h.
+ *
+ * The strings in this table are constant and must match the published
+ * config and environment variable names as described in the documentation.
+ *
+ * We do not define entries for the GIT_TR2_PARENT_* environment
+ * variables because they are transient and used to pass information
+ * from parent to child git processes, rather than settings.
+ */
+/* clang-format off */
+static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
+	[TR2_SYSENV_CFG_PARAM]     = { "GIT_TR2_CONFIG_PARAMS",
+				       "trace2.configparams" },
+
+	[TR2_SYSENV_DST_DEBUG]     = { "GIT_TR2_DST_DEBUG",
+				       "trace2.destinationdebug" },
+
+	[TR2_SYSENV_NORMAL]        = { "GIT_TR2",
+				       "trace2.normaltarget" },
+	[TR2_SYSENV_NORMAL_BRIEF]  = { "GIT_TR2_BRIEF",
+				       "trace2.normalbrief" },
+
+	[TR2_SYSENV_EVENT]         = { "GIT_TR2_EVENT",
+				       "trace2.eventtarget" },
+	[TR2_SYSENV_EVENT_BRIEF]   = { "GIT_TR2_EVENT_BRIEF",
+				       "trace2.eventbrief" },
+	[TR2_SYSENV_EVENT_NESTING] = { "GIT_TR2_EVENT_NESTING",
+				       "trace2.eventnesting" },
+
+	[TR2_SYSENV_PERF]          = { "GIT_TR2_PERF",
+				       "trace2.perftarget" },
+	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TR2_PERF_BRIEF",
+				       "trace2.perfbrief" },
+};
+/* clang-format on */
+
+static int tr2_sysenv_cb(const char *key, const char *value, void *d)
+{
+	int k;
+
+	if (!starts_with(key, "trace2."))
+		return 0;
+
+	for (k = 0; k < ARRAY_SIZE(tr2_sysenv_settings); k++) {
+		if (!strcmp(key, tr2_sysenv_settings[k].git_config_name)) {
+			free(tr2_sysenv_settings[k].value);
+			tr2_sysenv_settings[k].value = xstrdup(value);
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Load Trace2 settings from the system config (usually "/etc/gitconfig"
+ * unless we were built with a runtime-prefix).  These are intended to
+ * define the default values for Trace2 as requested by the administrator.
+ *
+ * Then override with the Trace2 settings from the global config.
+ */
+void tr2_sysenv_load(void)
+{
+	if (ARRAY_SIZE(tr2_sysenv_settings) != TR2_SYSENV_MUST_BE_LAST)
+		BUG("tr2_sysenv_settings size is wrong");
+
+	read_very_early_config(tr2_sysenv_cb, NULL);
+}
+
+/*
+ * Return the value for the requested Trace2 setting from these sources:
+ * the system config, the global config, and the environment.
+ */
+const char *tr2_sysenv_get(enum tr2_sysenv_variable var)
+{
+	if (var >= TR2_SYSENV_MUST_BE_LAST)
+		BUG("tr2_sysenv_get invalid var '%d'", var);
+
+	if (!tr2_sysenv_settings[var].getenv_called) {
+		const char *v = getenv(tr2_sysenv_settings[var].env_var_name);
+		if (v && *v) {
+			free(tr2_sysenv_settings[var].value);
+			tr2_sysenv_settings[var].value = xstrdup(v);
+		}
+		tr2_sysenv_settings[var].getenv_called = 1;
+	}
+
+	return tr2_sysenv_settings[var].value;
+}
+
+/*
+ * Return a friendly name for this setting that is suitable for printing
+ * in an error messages.
+ */
+const char *tr2_sysenv_display_name(enum tr2_sysenv_variable var)
+{
+	if (var >= TR2_SYSENV_MUST_BE_LAST)
+		BUG("tr2_sysenv_get invalid var '%d'", var);
+
+	return tr2_sysenv_settings[var].env_var_name;
+}
+
+void tr2_sysenv_release(void)
+{
+	int k;
+
+	for (k = 0; k < ARRAY_SIZE(tr2_sysenv_settings); k++)
+		free(tr2_sysenv_settings[k].value);
+}
diff --git a/trace2/tr2_sysenv.h b/trace2/tr2_sysenv.h
new file mode 100644
index 0000000000..369b20bd87
--- /dev/null
+++ b/trace2/tr2_sysenv.h
@@ -0,0 +1,36 @@
+#ifndef TR2_SYSENV_H
+#define TR2_SYSENV_H
+
+/*
+ * The Trace2 settings that can be loaded from /etc/gitconfig
+ * and/or user environment variables.
+ *
+ * Note that this set does not contain any of the transient
+ * environment variables used to pass information from parent
+ * to child git processes, such "GIT_TR2_PARENT_SID".
+ */
+enum tr2_sysenv_variable {
+	TR2_SYSENV_CFG_PARAM = 0,
+
+	TR2_SYSENV_DST_DEBUG,
+
+	TR2_SYSENV_NORMAL,
+	TR2_SYSENV_NORMAL_BRIEF,
+
+	TR2_SYSENV_EVENT,
+	TR2_SYSENV_EVENT_BRIEF,
+	TR2_SYSENV_EVENT_NESTING,
+
+	TR2_SYSENV_PERF,
+	TR2_SYSENV_PERF_BRIEF,
+
+	TR2_SYSENV_MUST_BE_LAST
+};
+
+void tr2_sysenv_load(void);
+
+const char *tr2_sysenv_get(enum tr2_sysenv_variable);
+const char *tr2_sysenv_display_name(enum tr2_sysenv_variable var);
+void tr2_sysenv_release(void);
+
+#endif /* TR2_SYSENV_H */
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 89a4d3ae9a..48d9193b2c 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -6,10 +6,11 @@
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
+#include "trace2/tr2_sysenv.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_event = { "GIT_TR2_EVENT", 0, 0, 0 };
+static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0 };
 
 /*
  * The version number of the JSON data generated by the EVENT target
@@ -28,37 +29,36 @@ static struct tr2_dst tr2dst_event = { "GIT_TR2_EVENT", 0, 0, 0 };
  * are primarily intended for the performance target during debugging.
  *
  * Some of the outer-most messages, however, may be of interest to the
- * event target.  Set this environment variable to a larger integer for
- * more detail in the event target.
+ * event target.  Use the TR2_SYSENV_EVENT_NESTING setting to increase
+ * region details in the event target.
  */
-#define TR2_ENVVAR_EVENT_NESTING "GIT_TR2_EVENT_NESTING"
-static int tr2env_event_nesting_wanted = 2;
+static int tr2env_event_max_nesting_levels = 2;
 
 /*
- * Set this environment variable to true to omit the <time>, <file>, and
+ * Use the TR2_SYSENV_EVENT_BRIEF to omit the <time>, <file>, and
  * <line> fields from most events.
  */
-#define TR2_ENVVAR_EVENT_BRIEF "GIT_TR2_EVENT_BRIEF"
-static int tr2env_event_brief;
+static int tr2env_event_be_brief;
 
 static int fn_init(void)
 {
 	int want = tr2_dst_trace_want(&tr2dst_event);
-	int want_nesting;
+	int max_nesting;
 	int want_brief;
-	char *nesting;
-	char *brief;
+	const char *nesting;
+	const char *brief;
 
 	if (!want)
 		return want;
 
-	nesting = getenv(TR2_ENVVAR_EVENT_NESTING);
-	if (nesting && ((want_nesting = atoi(nesting)) > 0))
-		tr2env_event_nesting_wanted = want_nesting;
+	nesting = tr2_sysenv_get(TR2_SYSENV_EVENT_NESTING);
+	if (nesting && *nesting && ((max_nesting = atoi(nesting)) > 0))
+		tr2env_event_max_nesting_levels = max_nesting;
 
-	brief = getenv(TR2_ENVVAR_EVENT_BRIEF);
-	if (brief && ((want_brief = atoi(brief)) > 0))
-		tr2env_event_brief = want_brief;
+	brief = tr2_sysenv_get(TR2_SYSENV_EVENT_BRIEF);
+	if (brief && *brief &&
+	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
+		tr2env_event_be_brief = want_brief;
 
 	return want;
 }
@@ -92,13 +92,13 @@ static void event_fmt_prepare(const char *event_name, const char *file,
 	/*
 	 * In brief mode, only emit <time> on these 2 event types.
 	 */
-	if (!tr2env_event_brief || !strcmp(event_name, "version") ||
+	if (!tr2env_event_be_brief || !strcmp(event_name, "version") ||
 	    !strcmp(event_name, "atexit")) {
 		tr2_tbuf_utc_time(&tb_now);
 		jw_object_string(jw, "time", tb_now.buf);
 	}
 
-	if (!tr2env_event_brief && file && *file) {
+	if (!tr2env_event_be_brief && file && *file) {
 		jw_object_string(jw, "file", file);
 		jw_object_intmax(jw, "line", line);
 	}
@@ -459,7 +459,7 @@ static void fn_region_enter_printf_va_fl(const char *file, int line,
 {
 	const char *event_name = "region_enter";
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
+	if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
 		struct json_writer jw = JSON_WRITER_INIT;
 
 		jw_object_begin(&jw, 0);
@@ -484,7 +484,7 @@ static void fn_region_leave_printf_va_fl(
 {
 	const char *event_name = "region_leave";
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
+	if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
 		struct json_writer jw = JSON_WRITER_INIT;
 		double t_rel = (double)us_elapsed_region / 1000000.0;
 
@@ -511,7 +511,7 @@ static void fn_data_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 {
 	const char *event_name = "data";
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
+	if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
 		struct json_writer jw = JSON_WRITER_INIT;
 		double t_abs = (double)us_elapsed_absolute / 1000000.0;
 		double t_rel = (double)us_elapsed_region / 1000000.0;
@@ -539,7 +539,7 @@ static void fn_data_json_fl(const char *file, int line,
 {
 	const char *event_name = "data_json";
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
+	if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
 		struct json_writer jw = JSON_WRITER_INIT;
 		double t_abs = (double)us_elapsed_absolute / 1000000.0;
 		double t_rel = (double)us_elapsed_region / 1000000.0;
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 57f3e18f5b..1ce6f97863 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -4,20 +4,20 @@
 #include "quote.h"
 #include "version.h"
 #include "trace2/tr2_dst.h"
+#include "trace2/tr2_sysenv.h"
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_normal = { "GIT_TR2", 0, 0, 0 };
+static struct tr2_dst tr2dst_normal = { TR2_SYSENV_NORMAL, 0, 0, 0 };
 
 /*
- * Set this environment variable to true to omit the "<time> <file>:<line>"
+ * Use the TR2_SYSENV_NORMAL_BRIEF setting to omit the "<time> <file>:<line>"
  * fields from each line written to the builtin normal target.
  *
  * Unit tests may want to use this to help with testing.
  */
-#define TR2_ENVVAR_NORMAL_BRIEF "GIT_TR2_BRIEF"
-static int tr2env_normal_brief;
+static int tr2env_normal_be_brief;
 
 #define TR2FMT_NORMAL_FL_WIDTH (50)
 
@@ -25,15 +25,15 @@ static int fn_init(void)
 {
 	int want = tr2_dst_trace_want(&tr2dst_normal);
 	int want_brief;
-	char *brief;
+	const char *brief;
 
 	if (!want)
 		return want;
 
-	brief = getenv(TR2_ENVVAR_NORMAL_BRIEF);
+	brief = tr2_sysenv_get(TR2_SYSENV_NORMAL_BRIEF);
 	if (brief && *brief &&
 	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
-		tr2env_normal_brief = want_brief;
+		tr2env_normal_be_brief = want_brief;
 
 	return want;
 }
@@ -47,7 +47,7 @@ static void normal_fmt_prepare(const char *file, int line, struct strbuf *buf)
 {
 	strbuf_setlen(buf, 0);
 
-	if (!tr2env_normal_brief) {
+	if (!tr2env_normal_be_brief) {
 		struct tr2_tbuf tb_now;
 
 		tr2_tbuf_local_time(&tb_now);
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 9c3b4d8a0f..328d2234bd 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -6,20 +6,20 @@
 #include "json-writer.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
+#include "trace2/tr2_sysenv.h"
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_perf = { "GIT_TR2_PERF", 0, 0, 0 };
+static struct tr2_dst tr2dst_perf = { TR2_SYSENV_PERF, 0, 0, 0 };
 
 /*
- * Set this environment variable to true to omit the "<time> <file>:<line>"
+ * Use TR2_SYSENV_PERF_BRIEF to omit the "<time> <file>:<line>"
  * fields from each line written to the builtin performance target.
  *
  * Unit tests may want to use this to help with testing.
  */
-#define TR2_ENVVAR_PERF_BRIEF "GIT_TR2_PERF_BRIEF"
-static int tr2env_perf_brief;
+static int tr2env_perf_be_brief;
 
 #define TR2FMT_PERF_FL_WIDTH (50)
 #define TR2FMT_PERF_MAX_EVENT_NAME (12)
@@ -36,17 +36,17 @@ static int fn_init(void)
 {
 	int want = tr2_dst_trace_want(&tr2dst_perf);
 	int want_brief;
-	char *brief;
+	const char *brief;
 
 	if (!want)
 		return want;
 
 	strbuf_addchars(&dots, '.', TR2_DOTS_BUFFER_SIZE);
 
-	brief = getenv(TR2_ENVVAR_PERF_BRIEF);
+	brief = tr2_sysenv_get(TR2_SYSENV_PERF_BRIEF);
 	if (brief && *brief &&
 	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
-		tr2env_perf_brief = want_brief;
+		tr2env_perf_be_brief = want_brief;
 
 	return want;
 }
@@ -77,7 +77,7 @@ static void perf_fmt_prepare(const char *event_name,
 
 	strbuf_setlen(buf, 0);
 
-	if (!tr2env_perf_brief) {
+	if (!tr2env_perf_be_brief) {
 		struct tr2_tbuf tb_now;
 
 		tr2_tbuf_local_time(&tb_now);
-- 
gitgitgadget

