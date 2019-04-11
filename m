Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244D220248
	for <e@80x24.org>; Thu, 11 Apr 2019 15:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDKPS4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 11:18:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44144 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKPSs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id d11so5538025edp.11
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GpNcQPROlFMztWQ6Ohm6DPy0l4N5khRhDAnI5/KIR8A=;
        b=lf9HFTNgUUmLYTsPMeTJQCIJtrnVws+nFZqCoVsCEmx8AnbCo3giVWKPqTKAL9u2g0
         BzGTQsFsWwgbsQRYo6FZh99A/Dn1iXIIBrKltJVDkD+o+nTJ0tjqYe+SGh21OnAm8+rp
         PEuvm0zFYVR8/3pk44vUeM9skFF64U98eZ3ezB9KZNUOlWu9MlfMGHllw3lJXCA+eBIk
         Mj9kxejOuOo+tA2m1hFTk4rPq0/GNlcig95iN8JuIPRctlIO0s8ZQcXEuDJHq+qGHRkb
         O1LUzoEI0qFqI1zGvRZW/gJb4+f+0CPgWmn1PW4Ssv28iIBXV2wxrvBuLXV5j6bu9hCk
         U7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GpNcQPROlFMztWQ6Ohm6DPy0l4N5khRhDAnI5/KIR8A=;
        b=TnJg8bWJBpebpXv5HwLajoU1H7atd0copPgeof8xfeqD0wcmGjj+x0IY+lQ/gQJ3vy
         ZHwxT918POSCEesV4Y1e+aG6Yl0CbEU66exgDh6hijMme5ZsCtLVqfKJSwjqBNJlYYT5
         Dp9EvT19I2jCsGuYJktkC16ZnWQg/w9Rrmt/6xI12GGpUQvQoFlaES3gtMlQXXdxg70c
         PlbZ4ItrdJ0HVX95/Qn1XUz7E2m0nfZmKlzI+dk3zseSt1wPgPfdMWWzhxxKQ4PIhgab
         JnBW1OGr4PajGyQ5LjSYDyFyo4ofOO68pt7nfFf2HKD+niZ8bccqlhttGgrOzjcyjNM7
         a1pg==
X-Gm-Message-State: APjAAAVm2jObqWEooRDp50C51NElle/D25TcOi38O4Ir6OujIiTSk+Fc
        aXJAoB2OaGwQutTr71BmHB+2gVgY
X-Google-Smtp-Source: APXvYqzBz9tAAmuDJT/Q+CM7GnC0hud/8ngCH2dcot1SLAR0JR1DjPgwFSlNwUECGMEBMoyyK0t3yg==
X-Received: by 2002:a50:878f:: with SMTP id a15mr31435455eda.196.1554995926745;
        Thu, 11 Apr 2019 08:18:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm3170843edl.63.2019.04.11.08.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:18:45 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:18:45 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 15:18:36 GMT
Message-Id: <285beb2b2d740ce20fdd8af1becf371ab39703db.1554995916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v3.git.gitgitgadget@gmail.com>
References: <pull.169.v2.git.gitgitgadget@gmail.com>
        <pull.169.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 10/10] trace2: update docs to describe system/global config
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

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config.txt               |   2 +
 Documentation/config/trace2.txt        |  56 ++++++++++
 Documentation/technical/api-trace2.txt | 141 ++++++++++++++-----------
 Documentation/trace2-target-values.txt |  10 ++
 4 files changed, 147 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/config/trace2.txt
 create mode 100644 Documentation/trace2-target-values.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d87846faa6..7e2a6f61f5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -422,6 +422,8 @@ include::config/submodule.txt[]
 
 include::config/tag.txt[]
 
+include::config/trace2.txt[]
+
 include::config/transfer.txt[]
 
 include::config/uploadarchive.txt[]
diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
new file mode 100644
index 0000000000..a5f409c1c1
--- /dev/null
+++ b/Documentation/config/trace2.txt
@@ -0,0 +1,56 @@
+Trace2 config settings are only read from the system and global
+config files; repository local and worktree config files and `-c`
+command line arguments are not respected.
+
+trace2.normalTarget::
+	This variable controls the normal target destination.
+	It may be overridden by the `GIT_TR2` environment variable.
+	The following table shows possible values.
+
+trace2.perfTarget::
+	This variable controls the performance target destination.
+	It may be overridden by the `GIT_TR2_PERF` environment variable.
+	The following table shows possible values.
+
+trace2.eventTarget::
+	This variable controls the event target destination.
+	It may be overridden by the `GIT_TR2_EVENT` environment variable.
+	The following table shows possible values.
++
+include::../trace2-target-values.txt[]
+
+trace2.normalBrief::
+	Boolean.  When true `time`, `filename`, and `line` fields are
+	omitted from normal output.  May be overridden by the
+	`GIT_TR2_BRIEF` environment variable.  Defaults to false.
+
+trace2.perfBrief::
+	Boolean.  When true `time`, `filename`, and `line` fields are
+	omitted from PERF output.  May be overridden by the
+	`GIT_TR2_PERF_BRIEF` environment variable.  Defaults to false.
+
+trace2.eventBrief::
+	Boolean.  When true `time`, `filename`, and `line` fields are
+	omitted from event output.  May be overridden by the
+	`GIT_TR2_EVENT_BRIEF` environment variable.  Defaults to false.
+
+trace2.eventNesting::
+	Integer.  Specifies desired depth of nested regions in the
+	event output.  Regions deeper than this value will be
+	omitted.  May be overridden by the `GIT_TR2_EVENT_NESTING`
+	environment variable.  Defaults to 2.
+
+trace2.configParams::
+	A comma-separated list of patterns of "important" config
+	settings that should be recorded in the trace2 output.
+	For example, `core.*,remote.*.url` would cause the trace2
+	output to contain events listing each configured remote.
+	May be overridden by the `GIT_TR2_CONFIG_PARAMS` environment
+	variable.  Unset by default.
+
+trace2.destinationDebug::
+	Boolean.  When true Git will print error messages when a
+	trace target destination cannot be opened for writing.
+	By default, these errors are suppressed and tracing is
+	silently disabled.  May be overridden by the
+	`GIT_TR2_DST_DEBUG` environment variable.
diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 43adbf00eb..e8eee25226 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -22,21 +22,41 @@ Targets are defined using a VTable allowing easy extension to other
 formats in the future.  This might be used to define a binary format,
 for example.
 
+Trace2 is controlled using `trace2.*` config values in the system and
+global config files and `GIT_TR2*` environment variables.  Trace2 does
+not read from repo local or worktree config files or respect `-c`
+command line config settings.
+
 == Trace2 Targets
 
 Trace2 defines the following set of Trace2 Targets.
 Format details are given in a later section.
 
-`GIT_TR2` (NORMAL)::
+=== The Normal Format Target
+
+The normal format target is a tradition printf format and similar
+to GIT_TRACE format.  This format is enabled with the `GIT_TR`
+environment variable or the `trace2.normalTarget` system or global
+config setting.
+
+For example
 
-	a simple printf format like GIT_TRACE.
-+
 ------------
 $ export GIT_TR2=~/log.normal
 $ git version
 git version 2.20.1.155.g426c96fcdb
 ------------
-+
+
+or
+
+------------
+$ git config --global trace2.normalTarget ~/log.normal
+$ git version
+git version 2.20.1.155.g426c96fcdb
+------------
+
+yields
+
 ------------
 $ cat ~/log.normal
 12:28:42.620009 common-main.c:38                  version 2.20.1.155.g426c96fcdb
@@ -46,17 +66,32 @@ $ cat ~/log.normal
 12:28:42.621250 trace2/tr2_tgt_normal.c:124       atexit elapsed:0.001265 code:0
 ------------
 
-`GIT_TR2_PERF` (PERF)::
+=== The Performance Format Target
+
+The performance format target (PERF) is a column-based format to
+replace GIT_TRACE_PERFORMANCE and is suitable for development and
+testing, possibly to complement tools like gprof.  This format is
+enabled with the `GIT_TR2_PERF` environment variable or the
+`trace2.perfTarget` system or global config setting.
+
+For example
 
-	a column-based format to replace GIT_TRACE_PERFORMANCE suitable for
-	development and testing, possibly to complement tools like gprof.
-+
 ------------
 $ export GIT_TR2_PERF=~/log.perf
 $ git version
 git version 2.20.1.155.g426c96fcdb
 ------------
-+
+
+or
+
+------------
+$ git config --global trace2.perfTarget ~/log.perf
+$ git version
+git version 2.20.1.155.g426c96fcdb
+------------
+
+yields
+
 ------------
 $ cat ~/log.perf
 12:28:42.620675 common-main.c:38                  | d0 | main                     | version      |     |           |           |            | 2.20.1.155.g426c96fcdb
@@ -66,16 +101,31 @@ $ cat ~/log.perf
 12:28:42.621259 trace2/tr2_tgt_perf.c:211         | d0 | main                     | atexit       |     |  0.001265 |           |            | code:0
 ------------
 
-`GIT_TR2_EVENT` (EVENT)::
+=== The Event Format Target
+
+The event format target is a JSON-based format of event data suitable
+for telemetry analysis.  This format is enabled with the `GIT_TR2_EVENT`
+environment variable or the `trace2.eventTarget` system or global config
+setting.
+
+For example
 
-	a JSON-based format of event data suitable for telemetry analysis.
-+
 ------------
 $ export GIT_TR2_EVENT=~/log.event
 $ git version
 git version 2.20.1.155.g426c96fcdb
 ------------
-+
+
+or
+
+------------
+$ git config --global trace2.eventTarget ~/log.event
+$ git version
+git version 2.20.1.155.g426c96fcdb
+------------
+
+yields
+
 ------------
 $ cat ~/log.event
 {"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
@@ -85,37 +135,12 @@ $ cat ~/log.event
 {"event":"atexit","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
 ------------
 
-== Enabling a Target
-
-A Trace2 Target is enabled when the corresponding environment variable
-(`GIT_TR2`, `GIT_TR2_PERF`, or `GIT_TR2_EVENT`) is set.  The following
-values are recognized.
+=== Enabling a Target
 
-`0`::
-`false`::
+To enable a target, set the corresponding environment variable or
+system or global config value to one of the following:
 
-	Disables the target.
-
-`1`::
-`true`::
-
-	Enables the target and writes stream to `STDERR`.
-
-`[2-9]`::
-
-	Enables the target and writes to the already opened file descriptor.
-
-`<absolute-pathname>`::
-
-	Enables the target, opens and writes to the file in append mode.
-
-`af_unix:[<socket_type>:]<absolute-pathname>`::
-
-	Enables the target, opens and writes to a Unix Domain Socket
-	(on platforms that support them).
-+
-Socket type can be either `stream` or `dgram`.  If the socket type is
-omitted, Git will try both.
+include::../trace2-target-values.txt[]
 
 == Trace2 API
 
@@ -243,15 +268,16 @@ significantly affects program performance or behavior, such as
 	Emits a "def_param" messages for "important" configuration
 	settings.
 +
-The environment variable `GIT_TR2_CONFIG_PARAMS` can be set to a
+The environment variable `GIT_TR2_CONFIG_PARAMS` or the `trace2.configParams`
+config value can be set to a
 list of patterns of important configuration settings, for example:
 `core.*,remote.*.url`.  This function will iterate over all config
 settings and emit a "def_param" message for each match.
 
 `void trace2_cmd_set_config(const char *key, const char *value)`::
 
-	Emits a "def_param" message for a specific configuration
-	setting IFF it matches the `GIT_TR2_CONFIG_PARAMS` pattern.
+	Emits a "def_param" message for a new or updated key/value
+	pair IF `key` is considered important.
 +
 This is used to hook into `git_config_set()` and catch any
 configuration changes and update a value previously reported by
@@ -418,9 +444,6 @@ recursive tree walk.
 
 === NORMAL Format
 
-NORMAL format is enabled when the `GIT_TR2` environment variable is
-set.
-
 Events are written as lines of the form:
 
 ------------
@@ -437,8 +460,8 @@ Events are written as lines of the form:
 Note that this may contain embedded LF or CRLF characters that are
 not escaped, so the event may spill across multiple lines.
 
-If `GIT_TR2_BRIEF` is true, the `time`, `filename`, and `line` fields
-are omitted.
+If `GIT_TR2_BRIEF` or `trace2.normalBrief` is true, the `time`, `filename`,
+and `line` fields are omitted.
 
 This target is intended to be more of a summary (like GIT_TRACE) and
 less detailed than the other targets.  It ignores thread, region, and
@@ -446,9 +469,6 @@ data messages, for example.
 
 === PERF Format
 
-PERF format is enabled when the `GIT_TR2_PERF` environment variable
-is set.
-
 Events are written as lines of the form:
 
 ------------
@@ -508,8 +528,8 @@ This field is in anticipation of in-proc submodules in the future.
 15:33:33.532712 wt-status.c:2331                  | d0 | main                     | region_leave | r1  |  0.127568 |  0.001504 | status     | label:print
 ------------
 
-If `GIT_TR2_PERF_BRIEF` is true, the `time`, `file`, and `line`
-fields are omitted.
+If `GIT_TR2_PERF_BRIEF` or `trace2.perfBrief` is true, the `time`, `file`,
+and `line` fields are omitted.
 
 ------------
 d0 | main                     | region_leave | r1  |  0.011717 |  0.009122 | index      | label:preload
@@ -520,9 +540,6 @@ during development and is quite noisy.
 
 === EVENT Format
 
-EVENT format is enabled when the `GIT_TR2_EVENT` environment
-variable is set.
-
 Each event is a JSON-object containing multiple key/value pairs
 written as a single line and followed by a LF.
 
@@ -576,9 +593,9 @@ The following key/value pairs are common to all events:
 `"repo":<repo-id>`::
 	when present, is the integer repo-id as described previously.
 
-If `GIT_TR2_EVENT_BRIEF` is true, the `file` and `line` fields are omitted
-from all events and the `time` field is only present on the "start" and
-"atexit" events.
+If `GIT_TR2_EVENT_BRIEF` or `trace2.eventBrief` is true, the `file`
+and `line` fields are omitted from all events and the `time` field is
+only present on the "start" and "atexit" events.
 
 ==== Event-Specific Key/Value Pairs
 
@@ -889,7 +906,7 @@ visited.
 The `category` field may be used in a future enhancement to
 do category-based filtering.
 +
-The `GIT_TR2_EVENT_NESTING` environment variable can be used to
+`GIT_TR2_EVENT_NESTING` or `trace2.eventNesting` can be used to
 filter deeply nested regions and data events.  It defaults to "2".
 
 `"region_leave"`::
diff --git a/Documentation/trace2-target-values.txt b/Documentation/trace2-target-values.txt
new file mode 100644
index 0000000000..27d3c64e66
--- /dev/null
+++ b/Documentation/trace2-target-values.txt
@@ -0,0 +1,10 @@
+--
+* `0` or `false` - Disables the target.
+* `1` or `true` - Writes to `STDERR`.
+* `[2-9]` - Writes to the already opened file descriptor.
+* `<absolute-pathname>` - Writes to the file in append mode.
+* `af_unix:[<socket_type>:]<absolute-pathname>` - Write to a
+Unix DomainSocket (on platforms that support them).  Socket
+type can be either `stream` or `dgram`; if omitted Git will
+try both.
+--
-- 
gitgitgadget
