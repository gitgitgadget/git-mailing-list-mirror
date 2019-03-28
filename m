Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E615C20248
	for <e@80x24.org>; Thu, 28 Mar 2019 13:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfC1NbK (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 09:31:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41136 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC1NbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 09:31:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id a25so17219942edc.8
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZiXBtuFWKl1XVWq1iK1wO5AD52eXkLFZSWBZ1PYQEW4=;
        b=kpo38rGqjFKsRhVQuMEWBoL+nYMaQAhkFX9RqvlHdCCxeJ48u21aXwRBi2WKPKRlDT
         1HcTAtRZJd8ZzwUcs/jRRGtH+qTMeuZemdZJD7d+JyVvkW1qL2QbHJDrp1axt7Wx0XVS
         slQBaC3p6acmecVcaKQCBpiuxFGyI7OsA7BdTR/1i3m8sk/3vGucECw/QAPkELKrMDyC
         o1z98eusdNojxrQsWovNIVsuvYRa5hihw7UuwPXfIcpMnqCA6Zq/ZTuPH+B7o/pZ4Kk2
         K+kMjevhrjV97VcJUhtFNYK0R19iIaHPLayplqxrpU6xiLF/TdioL3A9bsqx71J2zAis
         sS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZiXBtuFWKl1XVWq1iK1wO5AD52eXkLFZSWBZ1PYQEW4=;
        b=SVECxqvVHZN1jGWTLh9Xqi/UgAQGhjOhnSG7Ql14Fjj3vdwLoHaoy4P233kem+ctXV
         nw56jYWCn+tcaWHmV/4RReOvl7dd+oC/AG6lHTHCbvK3uyCyYJZ8YAQuvsxCBp+CSvKQ
         5abDy/K93J1nTJfHOFHCldGx/Rk/aL0BtXE9kchpwd+yoUHsEguXpXdkbe4yI18MpYZl
         NZI0JHRpVeQTRi8P+K6gQGAXiZRf1tAT0IRaBkKt2aS6W3bMK0o/q3FJFj9/ucQvoGVi
         dOqezgSZyFq5M/dW6iuEBO/z4crKjcdHGFfmndq1hoSBIRmPwsq8Y4vlFzq90zCPP2Zv
         bqUg==
X-Gm-Message-State: APjAAAXT5XifoHFyyLHEyZmUVVcw2UVl0t648LdmX4fY/dnZ2g8k2/kt
        0Rv8XiWpYRdTG9/CUWbr/2zhFBPl
X-Google-Smtp-Source: APXvYqwQ6UWpE1WME9imU6pXZ+ZKso/Yl9+6Wg8/SggSoOszrPvB/iOoEwUI6CLfNI85hUcdYnwNUA==
X-Received: by 2002:a50:9956:: with SMTP id l22mr28310778edb.170.1553779864795;
        Thu, 28 Mar 2019 06:31:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm7002487eda.36.2019.03.28.06.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 06:31:04 -0700 (PDT)
Date:   Thu, 28 Mar 2019 06:31:04 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Mar 2019 13:30:51 GMT
Message-Id: <7e0d4e20fbb3abbc787bc216d2c4bd8c18860aed.1553779851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.git.gitgitgadget@gmail.com>
References: <pull.169.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/4] trace2: use system config for default trace2 settings
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

Teach git to read the system config (usually "/etc/gitconfig") for
default Trace2 settings.  This allows system-wide Trace2 settings to
be installed and inherited to make it easier to manage a collection of
systems.

The original GIT_TR2* environment variables are loaded afterwards and
can be used to override the system settings.

Only the system config file is used.  Trace2 config values are ignored
in local, global, and other config files.  Likewise, the "-c" command
line arguments are ignored for Trace2 values.  These limits are for
performance reasons.

(1) For users not using Trace2, there should be minimal overhead to
detect that Trace2 is not enabled.  In particular, Trace2 should not
allocate lots of otherwise unused data strucutres.

(2) For accurate performance measurements, Trace2 should be initialized
as early in the git process as possible, and before most of the normal
git process initialization (which involves discovering the .git directory
and reading a hierarchy of config files).

Added the GIT_TEST_TR2_SYSTEM_CONFIG environment variable for testing
purposes to specify the pathname of a fake "system" config or disable
use of the system config.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt |  31 ++++++
 Makefile                               |   1 +
 t/t0210-trace2-normal.sh               |  41 +++++++-
 t/t0211-trace2-perf.sh                 |  41 +++++++-
 t/t0212-trace2-event.sh                |  52 +++++++++-
 trace2.c                               |   4 +
 trace2.h                               |   7 +-
 trace2/tr2_cfg.c                       |   7 +-
 trace2/tr2_dst.c                       |  24 ++---
 trace2/tr2_dst.h                       |   3 +-
 trace2/tr2_sysenv.c                    | 125 +++++++++++++++++++++++++
 trace2/tr2_sysenv.h                    |  36 +++++++
 trace2/tr2_tgt_event.c                 |  19 ++--
 trace2/tr2_tgt_normal.c                |  10 +-
 trace2/tr2_tgt_perf.c                  |  10 +-
 15 files changed, 356 insertions(+), 55 deletions(-)
 create mode 100644 trace2/tr2_sysenv.c
 create mode 100644 trace2/tr2_sysenv.h

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index baaa1153bb..13ca595c69 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -117,6 +117,37 @@ values are recognized.
 Socket type can be either `stream` or `dgram`.  If the socket type is
 omitted, Git will try both.
 
+== Trace2 Settings in System Config
+
+Trace2 also reads configuration information from the system config.
+This is intended to help adminstrators to gather system-wide Git
+performance data.
+
+Trace2 only reads the system configuration, it does not read global,
+local, worktree, or `-c` config settings.
+
+Trace2 will try to load the following system configuration settings
+and then read the corresponding environment variables at startup.
+
+....
+---------------------------------------------------
+trace2.normalTarget          GIT_TR2
+trace2.normalBrief           GIT_TR2_BRIEF
+
+trace2.perfTarget            GIT_TR2_PERF
+trace2.perfBrief             GIT_TR2_PERF_BRIEF
+
+trace2.eventTarget           GIT_TR2_EVENT
+trace2.eventBrief            GIT_TR2_EVENT_BRIEF
+trace2.eventNesting          GIT_TR2_EVENT_NESTING
+
+trace2.configParams          GIT_TR2_CONFIG_PARAMS
+
+trace2.destinationDebug      GIT_TR2_DST_DEBUG
+---------------------------------------------------
+....
+
+
 == Trace2 API
 
 All public Trace2 functions and macros are defined in `trace2.h` and
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
index 03a0aedb1d..5d4c04ed30 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -1,5 +1,14 @@
 #!/bin/sh
 
+# Disable loading of Trace2 settings from the system config
+# (usually "/etc/gitconfig") to eliminate system dependencies.
+GIT_TEST_TR2_SYSTEM_CONFIG=0 && export GIT_TEST_TR2_SYSTEM_CONFIG
+
+# Turn off any inherited trace2 settings for this test.
+unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
+unset GIT_TR2_BRIEF
+unset GIT_TR2_CONFIG_PARAMS
+
 test_description='test trace2 facility (normal target)'
 . ./test-lib.sh
 
@@ -15,11 +24,6 @@ PATH="$TTDIR:$PATH" && export PATH
 # Warning: So you may see extra lines in artifact files when
 # Warning: interactively debugging.
 
-# Turn off any inherited trace2 settings for this test.
-unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
-unset GIT_TR2_BRIEF
-unset GIT_TR2_CONFIG_PARAMS
-
 V=$(git version | sed -e 's/^git version //') && export V
 
 # There are multiple trace2 targets: normal, perf, and event.
@@ -132,4 +136,31 @@ test_expect_success 'normal stream, error event' '
 	test_cmp expect actual
 '
 
+# Now test using system config by using a mocked up config file
+# rather than inheriting "/etc/gitconfig".  Here we do not use
+# GIT_TR2* environment variables.
+
+unset GIT_TR2_BRIEF
+
+MOCK=./mock_system_config
+
+test_expect_success 'setup mocked /etc/gitconfig' '
+	git config --file $MOCK trace2.normalTarget "$(pwd)/trace.normal" &&
+	git config --file $MOCK trace2.normalBrief 1
+'
+
+test_expect_success 'using mock, normal stream, return code 0' '
+	test_when_finished "rm trace.normal actual expect" &&
+	GIT_TEST_TR2_SYSTEM_CONFIG="$MOCK" test-tool trace2 001return 0 &&
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
index c9694b29f7..abe35b2186 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -1,5 +1,14 @@
 #!/bin/sh
 
+# Disable loading of Trace2 settings from the system config
+# (usually "/etc/gitconfig") to eliminate system dependencies.
+GIT_TEST_TR2_SYSTEM_CONFIG=0 && export GIT_TEST_TR2_SYSTEM_CONFIG
+
+# Turn off any inherited trace2 settings for this test.
+unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
+unset GIT_TR2_PERF_BRIEF
+unset GIT_TR2_CONFIG_PARAMS
+
 test_description='test trace2 facility (perf target)'
 . ./test-lib.sh
 
@@ -15,11 +24,6 @@ PATH="$TTDIR:$PATH" && export PATH
 # Warning: So you may see extra lines in artifact files when
 # Warning: interactively debugging.
 
-# Turn off any inherited trace2 settings for this test.
-unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
-unset GIT_TR2_PERF_BRIEF
-unset GIT_TR2_CONFIG_PARAMS
-
 V=$(git version | sed -e 's/^git version //') && export V
 
 # There are multiple trace2 targets: normal, perf, and event.
@@ -150,4 +154,31 @@ test_expect_success 'perf stream, child processes' '
 	test_cmp expect actual
 '
 
+# Now test using system config by using a mocked up config file
+# rather than inheriting "/etc/gitconfig".  Here we do not use
+# GIT_TR2* environment variables.
+
+unset GIT_TR2_PERF_BRIEF
+
+MOCK=./mock_system_config
+
+test_expect_success 'setup mocked /etc/gitconfig' '
+	git config --file $MOCK trace2.perfTarget "$(pwd)/trace.perf" &&
+	git config --file $MOCK trace2.perfBrief 1
+'
+
+test_expect_success 'using mock, perf stream, return code 0' '
+	test_when_finished "rm trace.perf actual expect" &&
+	GIT_TEST_TR2_SYSTEM_CONFIG="$MOCK" test-tool trace2 001return 0 &&
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
index 028b6c5671..c535496261 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -1,5 +1,14 @@
 #!/bin/sh
 
+# Disable loading of Trace2 settings from the system config
+# (usually "/etc/gitconfig") to eliminate system dependencies.
+GIT_TEST_TR2_SYSTEM_CONFIG=0 && export GIT_TEST_TR2_SYSTEM_CONFIG
+
+# Turn off any inherited trace2 settings for this test.
+unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
+unset GIT_TR2_BARE
+unset GIT_TR2_CONFIG_PARAMS
+
 test_description='test trace2 facility'
 . ./test-lib.sh
 
@@ -17,11 +26,6 @@ PATH="$TTDIR:$PATH" && export PATH
 # Warning: So you may see extra lines in artifact files when
 # Warning: interactively debugging.
 
-# Turn off any inherited trace2 settings for this test.
-unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
-unset GIT_TR2_BARE
-unset GIT_TR2_CONFIG_PARAMS
-
 V=$(git version | sed -e 's/^git version //') && export V
 
 # There are multiple trace2 targets: normal, perf, and event.
@@ -233,4 +237,42 @@ test_expect_success JSON_PP 'basic trace2_data' '
 	test_cmp expect actual
 '
 
+# Now test using system config by using a mocked up config file
+# rather than inheriting "/etc/gitconfig".  Here we do not use
+# GIT_TR2* environment variables.
+
+MOCK=./mock_system_config
+
+test_expect_success 'setup mocked /etc/gitconfig' '
+	git config --file $MOCK trace2.eventTarget "$(pwd)/trace.event"
+'
+
+test_expect_success JSON_PP 'using mock, event stream, error event' '
+	test_when_finished "rm trace.event actual expect" &&
+	GIT_TEST_TR2_SYSTEM_CONFIG="$MOCK" test-tool trace2 003error "hello world" "this is a test" &&
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
index 8f89e70c44..cda8349058 100644
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
@@ -125,8 +126,8 @@ void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
  * Emit one or more 'def_param' events for "interesting" configuration
  * settings.
  *
- * The environment variable "GIT_TR2_CONFIG_PARAMS" can be set to a
- * list of patterns considered important.  For example:
+ * Use the TR2_SYSENV_CFG_PARAM setting to register a list of patterns
+ * configured important.  For example:
  *
  *    GIT_TR2_CONFIG_PARAMS="core.*,remote.*.url"
  *
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
index fd490a43ad..575cd69aa9 100644
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
@@ -116,7 +115,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	if (!path || !*path) {
 		if (tr2_dst_want_warning())
 			warning("trace2: invalid AF_UNIX value '%s' for '%s' tracing",
-				tgt_value, dst->env_var_name);
+				tgt_value, tr2_sysenv_display_name(dst->sysenv_var));
 
 		tr2_dst_trace_disable(dst);
 		return 0;
@@ -126,7 +125,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	    strlen(path) >= sizeof(((struct sockaddr_un *)0)->sun_path)) {
 		if (tr2_dst_want_warning())
 			warning("trace2: invalid AF_UNIX path '%s' for '%s' tracing",
-				path, dst->env_var_name);
+				path, tr2_sysenv_display_name(dst->sysenv_var));
 
 		tr2_dst_trace_disable(dst);
 		return 0;
@@ -148,7 +147,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 error:
 	if (tr2_dst_want_warning())
 		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
-			path, dst->env_var_name, strerror(e));
+			path, tr2_sysenv_display_name(dst->sysenv_var), strerror(e));
 
 	tr2_dst_trace_disable(dst);
 	return 0;
@@ -168,7 +167,7 @@ static void tr2_dst_malformed_warning(struct tr2_dst *dst,
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "trace2: unknown value for '%s': '%s'",
-		    dst->env_var_name, tgt_value);
+		    tr2_sysenv_display_name(dst->sysenv_var), tgt_value);
 	warning("%s", buf.buf);
 
 	strbuf_release(&buf);
@@ -184,7 +183,7 @@ int tr2_dst_get_trace_fd(struct tr2_dst *dst)
 
 	dst->initialized = 1;
 
-	tgt_value = getenv(dst->env_var_name);
+	tgt_value = tr2_sysenv_get(dst->sysenv_var);
 
 	if (!tgt_value || !strcmp(tgt_value, "") || !strcmp(tgt_value, "0") ||
 	    !strcasecmp(tgt_value, "false")) {
@@ -246,7 +245,8 @@ void tr2_dst_write_line(struct tr2_dst *dst, struct strbuf *buf_line)
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
index 0000000000..656613e371
--- /dev/null
+++ b/trace2/tr2_sysenv.c
@@ -0,0 +1,125 @@
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
+ * These strings are constant and must match the published names as
+ * described in the documentation.
+ *
+ * We do not define entries for the GIT_TR2_PARENT_* environment
+ * variables because they are transient and used to pass information
+ * from parent to child git processes, rather than settings.
+ */
+/* clang-format off */
+static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
+	{ "GIT_TR2_CONFIG_PARAMS",   "trace2.configparams"     },
+
+	{ "GIT_TR2_DST_DEBUG",       "trace2.destinationdebug" },
+
+	{ "GIT_TR2",                 "trace2.normaltarget"     },
+	{ "GIT_TR2_BRIEF",           "trace2.normalbrief"      },
+
+	{ "GIT_TR2_EVENT",           "trace2.eventtarget"      },
+	{ "GIT_TR2_EVENT_BRIEF",     "trace2.eventbrief"       },
+	{ "GIT_TR2_EVENT_NESTING",   "trace2.eventnesting"     },
+
+	{ "GIT_TR2_PERF",            "trace2.perftarget"       },
+	{ "GIT_TR2_PERF_BRIEF",      "trace2.perfbrief"        },
+};
+/* clang-format on */
+
+static int tr2_sysenv_cb(const char *key, const char *value, void *d)
+{
+	int k;
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
+ */
+void tr2_sysenv_load(void)
+{
+	const char *system_config_pathname;
+	const char *test_pathname;
+
+	system_config_pathname = git_etc_gitconfig();
+
+	test_pathname = getenv("GIT_TEST_TR2_SYSTEM_CONFIG");
+	if (test_pathname) {
+		if (!*test_pathname || !strcmp(test_pathname, "0"))
+			return; /* disable use of system config */
+
+		/* mock it with given test file */
+		system_config_pathname = test_pathname;
+	}
+
+	if (file_exists(system_config_pathname))
+		git_config_from_file(tr2_sysenv_cb, system_config_pathname,
+				     NULL);
+}
+
+/*
+ * Return the value for the requested setting.  Start with the /etc/gitconfig
+ * value and allow the corresponding environment variable to override it.
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
index 89a4d3ae9a..bb6e323953 100644
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
@@ -28,17 +29,15 @@ static struct tr2_dst tr2dst_event = { "GIT_TR2_EVENT", 0, 0, 0 };
  * are primarily intended for the performance target during debugging.
  *
  * Some of the outer-most messages, however, may be of interest to the
- * event target.  Set this environment variable to a larger integer for
- * more detail in the event target.
+ * event target.  Use the TR2_SYSENV_EVENT_NESTING setting to increase
+ * region details in the event target.
  */
-#define TR2_ENVVAR_EVENT_NESTING "GIT_TR2_EVENT_NESTING"
 static int tr2env_event_nesting_wanted = 2;
 
 /*
- * Set this environment variable to true to omit the <time>, <file>, and
+ * Use the TR2_SYSENV_EVENT_BRIEF to omit the <time>, <file>, and
  * <line> fields from most events.
  */
-#define TR2_ENVVAR_EVENT_BRIEF "GIT_TR2_EVENT_BRIEF"
 static int tr2env_event_brief;
 
 static int fn_init(void)
@@ -46,17 +45,17 @@ static int fn_init(void)
 	int want = tr2_dst_trace_want(&tr2dst_event);
 	int want_nesting;
 	int want_brief;
-	char *nesting;
-	char *brief;
+	const char *nesting;
+	const char *brief;
 
 	if (!want)
 		return want;
 
-	nesting = getenv(TR2_ENVVAR_EVENT_NESTING);
+	nesting = tr2_sysenv_get(TR2_SYSENV_EVENT_NESTING);
 	if (nesting && ((want_nesting = atoi(nesting)) > 0))
 		tr2env_event_nesting_wanted = want_nesting;
 
-	brief = getenv(TR2_ENVVAR_EVENT_BRIEF);
+	brief = tr2_sysenv_get(TR2_SYSENV_EVENT_BRIEF);
 	if (brief && ((want_brief = atoi(brief)) > 0))
 		tr2env_event_brief = want_brief;
 
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 57f3e18f5b..3364223805 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -4,19 +4,19 @@
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
 static int tr2env_normal_brief;
 
 #define TR2FMT_NORMAL_FL_WIDTH (50)
@@ -25,12 +25,12 @@ static int fn_init(void)
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
 		tr2env_normal_brief = want_brief;
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 9c3b4d8a0f..1ad781c32e 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -6,19 +6,19 @@
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
 static int tr2env_perf_brief;
 
 #define TR2FMT_PERF_FL_WIDTH (50)
@@ -36,14 +36,14 @@ static int fn_init(void)
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
 		tr2env_perf_brief = want_brief;
-- 
gitgitgadget
