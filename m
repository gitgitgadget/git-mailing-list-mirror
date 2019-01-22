Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB48F1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfAVVWS (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:18 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35071 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfAVVWS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:18 -0500
Received: by mail-ed1-f42.google.com with SMTP id x30so19826edx.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j6V1XFQKpZOQw01j/9kYUfQznrNut0YJFynstafqWO8=;
        b=MHNe9GDHccqASSAAeoezswX9goBuFo5jGeI0Pfv47gEhX9fusdYGe3KhQrCR6Qn0sF
         VABbUs5fvouD4yIJZZqs9ffX6qBrRoXwvS5N4NEsuGHGnrkoXk/8XWXOIhURucR6FWpG
         RPeu+TJ2+O9VNs6KTQ0+rrysYuFXirsJO9yMB1L8O6KGSD7ncipLFlUma0yF6mmwTia3
         UEuHAHcI0+oN5E3K+fMcmpV62Cl9gFrxJWdmtkfn/5HyAPFjLtGrPMKTCT2A25G+dfQZ
         OeC7HW+PckrxzG16vlZGdvKewelweQMzZ3RUgQUrjVZSFKPLqG0lREpqxkT8g0NPTOP3
         4VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j6V1XFQKpZOQw01j/9kYUfQznrNut0YJFynstafqWO8=;
        b=Km2n+8Doi7UthfB3vNeaVsOa0gntnDFK6jgwEngK5i0YqQND8iepjMTxVCHFeWWtmd
         Kz6tg+7q973VF53elDAySrV68eUWEV6RNbn1TI+i+nNEj9ewl2HGlgIYEA9R5g8jvAKO
         QaLo99rTll+QWylpKQl/gE45WOcyYzbzjbsx82RcUXFf6ylymRnUq5Avq8g/Dz28QqMI
         4jiE4SInvo+io4oxO9AU/oqnZ5HOmowZhp9dRnr6fZIJcLnOcwGz3uikC05nDbsGmQ34
         TPMtFUdPJmv10inIfpCflssvDIVrgyH8CVOeFlfLE1A7KCCBb/biebdHixr+EiaD09y8
         Tt8w==
X-Gm-Message-State: AJcUukdcOC4bbOSUa4Rqno0hnArPsbN0Pist7+6xPa5CZIAjb4/qUzXA
        MrhfVpFJNOBQx4SUWi0Oc7hexJiU
X-Google-Smtp-Source: ALg8bN7F1mLuwRBEzNblCOCtnzomWzVg15kRG28XVauhWRXtddXvCprG81Aj048hxnujQiJhfTbx3Q==
X-Received: by 2002:a17:906:248c:: with SMTP id e12mr135884ejb.14.1548192133507;
        Tue, 22 Jan 2019 13:22:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-v6sm5404010ejh.74.2019.01.22.13.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:12 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:12 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:21:58 GMT
Message-Id: <1a90de9dab0dd836e54fee9e08ab9e2284e1027a.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/14] trace2: Documentation/technical/api-trace2.txt
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

Created design document for Trace2 feature.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 1158 ++++++++++++++++++++++++
 1 file changed, 1158 insertions(+)
 create mode 100644 Documentation/technical/api-trace2.txt

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
new file mode 100644
index 0000000000..501fd770f2
--- /dev/null
+++ b/Documentation/technical/api-trace2.txt
@@ -0,0 +1,1158 @@
+Trace2 API
+==========
+
+The Trace2 API can be used to print debug, performance, and telemetry
+information to stderr or a file.  The Trace2 feature is inactive unless
+explicitly enabled by setting one or more of the `GIT_TR2`, `GIT_TR2_PERF`,
+or `GIT_TR2_EVENT` environment variables.
+
+The Trace2 API is intended to replace the existing (Trace1)
+printf-style tracing provided by the existing `GIT_TRACE` and
+`GIT_TRACE_PERFORMANCE` facilities.  During initial implementation,
+Trace2 and Trace1 may operate in parallel.
+
+The Trace2 API defines a set of high-level events with known fields,
+such as (`start`: `argv`) and (`exit`: {`exit-code`, `elapsed-time`}).
+
+These high-level events are written to one or more Trace2 Targets
+in a target-specific format.  Each Trace2 Target defines a different
+purpose-specific view onto the event data stream.  In this mannor,
+a single set of Trace2 API event calls in the Git source can drive
+different types of analysis.
+
+Trace2 Targets
+--------------
+
+Trace2 defines the following set of Trace2 Targets.  These can be
+independently enabled and disabled.  Trace2 API events are sent to
+each enabled target.  Each enabled target writes an event message
+in a target-specific format (described later).
+
+`GIT_TR2` (NORMAL)::
+
+	a simple printf format like GIT_TRACE.
++
+------------
+$ export GIT_TR2=~/log.normal
+$ git version
+git version 2.20.1.155.g426c96fcdb
+------------
++
+------------
+$ cat ~/log.normal
+12:28:42.620009 common-main.c:38                  version 2.20.1.155.g426c96fcdb
+12:28:42.620989 common-main.c:39                  start git version
+12:28:42.621101 git.c:432                         cmd_verb version (version)
+12:28:42.621215 git.c:662                         exit elapsed:0.001227 code:0
+12:28:42.621250 trace2/tr2_tgt_normal.c:124       atexit elapsed:0.001265 code:0
+------------
+
+`GIT_TR2_PERF` (PERF)::
+
+	a column-based format to replace GIT_TRACE_PERFORMANCE suitable for
+	development and testing, possibly to complement tools like gprof.
++
+------------
+$ export GIT_TR2_PERF=~/log.perf
+$ git version
+git version 2.20.1.155.g426c96fcdb
+------------
++
+------------
+$ cat ~/log.perf
+12:28:42.620675 common-main.c:38                  | d0 | main                     | version      |     |           |           |            | 2.20.1.155.g426c96fcdb
+12:28:42.621001 common-main.c:39                  | d0 | main                     | start        |     |           |           |            | git version
+12:28:42.621111 git.c:432                         | d0 | main                     | cmd_verb     |     |           |           |            | version (version)
+12:28:42.621225 git.c:662                         | d0 | main                     | exit         |     |  0.001227 |           |            | code:0
+12:28:42.621259 trace2/tr2_tgt_perf.c:211         | d0 | main                     | atexit       |     |  0.001265 |           |            | code:0
+------------
+
+`GIT_TR2_EVENT` (EVENT)::
+
+	a JSON-based format of event data suitable for telemetry analysis.
++
+------------
+$ export GIT_TR2_EVENT=~/log.event
+$ git version
+git version 2.20.1.155.g426c96fcdb
+------------
++
+------------
+$ cat ~/log.event
+{"event":"version","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.620713","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
+{"event":"start","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621027","file":"common-main.c","line":39,"argv":["git","version"]}
+{"event":"cmd_verb","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621122","file":"git.c","line":432,"name":"version","hierarchy":"version"}
+{"event":"exit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621236","file":"git.c","line":662,"t_abs":0.001227,"code":0}
+{"event":"atexit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621268","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
+------------
+
+Trace2 API Definitions
+----------------------
+
+All public Trace2 functions and macros are defined in `trace2.h` and
+`trace2.c`.  These are documented in detail in `trace2.h`.  All
+public symbols are prefixed with `trace2_`.
+
+There are no public Trace2 data structures.
+
+The Trace2 code also defines a set of private functions and data types
+in the `trace2/` directory.  These symbols are prefixed with `tr2_`
+and should only be used by functions in `trace2.c`.
+
+The functions defined by the Trace2 API can be grouped into the
+following groups.
+
+Basic Command Events::
+
+	These are concerned with the lifetime of the overall git process.
++
+----------------
+trace2_initialize(...)
+
+trace2_cmd_start(...)
+trace2_cmd_exit(...)
+trace2_cmd_error(...)
+trace2_cmd_path(...)
+----------------
+
+Git Command Detail Events::
+
+	These are concerned with describing the specific Git command
+	after the command line, config, and environment are inspected.
++
+----------------
+trace2_cmd_verb(...)
+trace2_cmd_subverb(...)
+trace2_cmd_alias(...)
+
+trace2_cmd_list_config(...)
+trace2_cmd_set_config(...)
+
+trace2_def_param(...)
+trace2_def_repo(...)
+----------------
+
+Git Child Process Events::
+
+	These are concerned with the various spawned child processes,
+	including sub-git processes and hooks,
++
+----------------
+trace2_child_start(...)
+trace2_child_exit(...)
+
+trace2_exec(...)
+trace2_exec_result(...)
+----------------
+
+Git Thread Events::
+
+	These are concerned with Git thread usage.
++
+----------------
+trace2_thread_start(...)
+trace2_thread_exit(...)
+----------------
+
+Region and Data Events::
+
+	These are concerned with recording performance data
+	over regions or spans of code.
++
+----------------
+trace2_region_enter(...)
+trace2_region_enter_printf(...)
+trace2_region_leave(...)
+trace2_region_leave_printf(...)
+
+trace2_data_string(...)
+trace2_data_intmax(...)
+trace2_data_json(...)
+
+trace2_printf(...)
+----------------
+
+Trace2 API Usage
+----------------
+
+Here is a hypothetical usage of the Trace2 API showing the intended
+usage (without worrying about the actual Git details).
+
+Initialization::
+
+	Initialization happens in `main()`.  The initialization code
+	determines which, if any, Trace2 Targets should be enabled and
+	emits the `version`, `start`, and `exit` events.  It causes an
+	`atexit` function and `signal` handler to be registered that
+	will emit `atexit` and `signal` events.
++
+----------------
+int main(int argc, const char **argv)
+{
+	int exit_code;
+
+	trace2_initialize();
+	trace2_cmd_start(argv);
+
+	exit_code = cmd_main(argc, argv);
+
+	trace2_cmd_exit(exit_code);
+
+	return exit_code;
+}
+----------------
+
+Command Details::
+
+	After the basics are established, additional process
+	information can be sent to Trace2 as it is discovered, such as
+	the command verb, alias expansion, interesting config
+	settings, the repository worktree, error messages, and etc.
++
+----------------
+int cmd_checkout(int argc, const char **argv)
+{
+	// emit a single "def_param" event
+	trace2_def_param("core.editor", "emacs");
+
+	// emit def_params for any config setting matching a pattern
+	// in GIT_TR2_CONFIG_PARAMS.
+	trace2_cmd_list_config();
+
+	trace2_cmd_verb("checkout");
+	trace2_cmd_subverb("branch");
+	trace2_def_repo(the_repository);
+
+	if (do_something(...))
+	    trace2_cmd_error("Path '%s': cannot do something", path);
+
+	return 0;
+}
+----------------
+
+Child Processes::
+
+	Git typically spawns many sub-processes, such as sub-git
+	commands, shell scripts, editors, pagers, and hooks.
+	Trace2 child events record time spent waiting for child
+	processes and help track performance problems across
+	multiple layers of child processes.
++
+----------------
+void run_child(...)
+{
+	int child_exit_code;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	...
+
+	trace2_child_start(&cmd);
+	child_exit_code = ...();
+	trace2_child_exit(&cmd, child_exit_code);
+}
+----------------
++
+For example, the following fetch command spawned ssh, index-pack,
+rev-list, and gc.  This example also shows that fetch took
+5.199 seconds and of that 4.932 was in ssh.
++
+----------------
+$ export GIT_TR2_BRIEF=1
+$ export GIT_TR2=~/log.normal
+$ git fetch origin
+...
+
+$ cat ~/log.normal
+version 2.20.1.vfs.1.1.47.g534dbe1ad1
+start git fetch origin
+worktree /Users/jeffhost/work/gfw
+cmd_verb fetch (fetch)
+child_start[0] ssh git@github.com ...
+child_start[1] git index-pack ...
+... (Trace2 events from child processes omitted)
+child_exit[1] pid:14707 code:0 elapsed:0.076353
+child_exit[0] pid:14706 code:0 elapsed:4.931869
+child_start[2] git rev-list ...
+... (Trace2 events from child process omitted)
+child_exit[2] pid:14708 code:0 elapsed:0.110605
+child_start[3] git gc --auto
+... (Trace2 events from child process omitted)
+child_exit[3] pid:14709 code:0 elapsed:0.006240
+exit elapsed:5.198503 code:0
+atexit elapsed:5.198541 code:0
+----------------
++
+When a git process is a (direct or indirect) child of another
+git process, it inherits Trace2 context information.  This
+allows the child to print a verb hierarchy.  This example
+shows gc as child[3] of fetch.  When the gc process reports
+its verb as "gc", it also reports the hierarchy as "fetch/gc".
+(In this example, trace2 messages from the child process is
+indented for clarity.)
++
+----------------
+$ export GIT_TR2_BRIEF=1
+$ export GIT_TR2=~/log.normal
+$ git fetch origin
+...
+
+$ cat ~/log.normal
+version 2.20.1.160.g5676107ecd.dirty
+start git fetch official
+worktree /Users/jeffhost/work/gfw
+cmd_verb fetch (fetch)
+...
+child_start[3] git gc --auto
+    version 2.20.1.160.g5676107ecd.dirty
+    start /Users/jeffhost/work/gfw/git gc --auto
+    worktree /Users/jeffhost/work/gfw
+    cmd_verb gc (fetch/gc)
+    exit elapsed:0.001959 code:0
+    atexit elapsed:0.001997 code:0
+child_exit[3] pid:20303 code:0 elapsed:0.007564
+exit elapsed:3.868938 code:0
+atexit elapsed:3.868970 code:0
+----------------
+
+Region Events::
+
+	Trace2 defines a region as a timed span of code.
++
+----------------
+void wt_status_collect(struct wt_status *s)
+{
+	trace2_region_enter("status", "worktrees", s->repo);
+	wt_status_collect_changes_worktree(s);
+	trace2_region_leave("status", "worktrees", s->repo);
+
+	trace2_region_enter("status", "index", s->repo);
+	wt_status_collect_changes_index(s);
+	trace2_region_leave("status", "index", s->repo);
+
+	trace2_region_enter("status", "untracked", s->repo);
+	wt_status_collect_untracked(s);
+	trace2_region_leave("status", "untracked", s->repo);
+}
+
+void wt_status_print(struct wt_status *s)
+{
+	trace2_region_enter("status", "print", s->repo);
+	switch (s->status_format) {
+	    ...
+	}
+	trace2_region_leave("status", "print", s->repo);
+}
+----------------
++
+In this example, scanning for untracked files ran from +0.012568 to
++0.027149 (since the process started) and took 0.014581 seconds.
++
+----------------
+$ export GIT_TR2_PERF_BRIEF=1
+$ export GIT_TR2_PERF=~/log.perf
+$ git status
+...
+
+$ cat ~/log.perf
+d0 | main                     | version      |     |           |           |            | 2.20.1.160.g5676107ecd.dirty
+d0 | main                     | start        |     |           |           |            | git status
+d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
+d0 | main                     | cmd_verb     |     |           |           |            | status (status)
+...
+d0 | main                     | region_enter | r1  |  0.010988 |           | status     | label:worktrees
+d0 | main                     | region_leave | r1  |  0.011236 |  0.000248 | status     | label:worktrees
+d0 | main                     | region_enter | r1  |  0.011260 |           | status     | label:index
+d0 | main                     | region_leave | r1  |  0.012542 |  0.001282 | status     | label:index
+d0 | main                     | region_enter | r1  |  0.012568 |           | status     | label:untracked
+d0 | main                     | region_leave | r1  |  0.027149 |  0.014581 | status     | label:untracked
+d0 | main                     | region_enter | r1  |  0.027411 |           | status     | label:print
+d0 | main                     | region_leave | r1  |  0.028741 |  0.001330 | status     | label:print
+d0 | main                     | exit         |     |  0.028778 |           |            | code:0
+d0 | main                     | atexit       |     |  0.028809 |           |            | code:0
+----------------
++
+Regions may be nested.  This causes event messages to be indented.
+Elapsed times are relative to the start of the correpsonding nesting
+level as expected.  For example, if we add region events to:
++
+----------------
+static enum path_treatment read_directory_recursive(struct dir_struct *dir,
+	struct index_state *istate, const char *base, int baselen,
+	struct untracked_cache_dir *untracked, int check_only,
+	int stop_at_first_file, const struct pathspec *pathspec)
+{
+	enum path_treatment state, subdir_state, dir_state = path_none;
+
+	trace2_region_enter_printf("dir", "read_recursive", NULL, "%.*s", baselen, base);
+	...
+	trace2_region_leave_printf("dir", "read_recursive", NULL, "%.*s", baselen, base);
+	return dir_state;
+}
+----------------
++
+We can further investigate the time spent scanning for untracked files.
++
+----------------
+$ export GIT_TR2_PERF_BRIEF=1
+$ export GIT_TR2_PERF=~/log.perf
+$ git status
+...
+$ cat ~/log.perf
+d0 | main                     | version      |     |           |           |            | 2.20.1.162.gb4ccea44db.dirty
+d0 | main                     | start        |     |           |           |            | git status
+d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
+d0 | main                     | cmd_verb     |     |           |           |            | status (status)
+...
+d0 | main                     | region_enter | r1  |  0.015047 |           | status     | label:untracked
+d0 | main                     | region_enter |     |  0.015132 |           | dir        | ..label:read_recursive
+d0 | main                     | region_enter |     |  0.016341 |           | dir        | ....label:read_recursive vcs-svn/
+d0 | main                     | region_leave |     |  0.016422 |  0.000081 | dir        | ....label:read_recursive vcs-svn/
+d0 | main                     | region_enter |     |  0.016446 |           | dir        | ....label:read_recursive xdiff/
+d0 | main                     | region_leave |     |  0.016522 |  0.000076 | dir        | ....label:read_recursive xdiff/
+d0 | main                     | region_enter |     |  0.016612 |           | dir        | ....label:read_recursive git-gui/
+d0 | main                     | region_enter |     |  0.016698 |           | dir        | ......label:read_recursive git-gui/po/
+d0 | main                     | region_enter |     |  0.016810 |           | dir        | ........label:read_recursive git-gui/po/glossary/
+d0 | main                     | region_leave |     |  0.016863 |  0.000053 | dir        | ........label:read_recursive git-gui/po/glossary/
+...
+d0 | main                     | region_enter |     |  0.031876 |           | dir        | ....label:read_recursive builtin/
+d0 | main                     | region_leave |     |  0.032270 |  0.000394 | dir        | ....label:read_recursive builtin/
+d0 | main                     | region_leave |     |  0.032414 |  0.017282 | dir        | ..label:read_recursive
+d0 | main                     | region_leave | r1  |  0.032454 |  0.017407 | status     | label:untracked
+...
+d0 | main                     | exit         |     |  0.034279 |           |            | code:0
+d0 | main                     | atexit       |     |  0.034322 |           |            | code:0
+----------------
++
+Trace2 regions are similar to the existing trace_performance_enter()
+and trace_performance_leave() routines, but are thread safe and
+maintain per-thread stacks of timers.
+
+Data Events::
+
+	Trace2 defines a data event to report important variables.
+	These events contain the active thread and are indented
+	relative to the current thread's open region stack.
++
+----------------
+int read_index_from(struct index_state *istate, const char *path,
+	const char *gitdir)
+{
+	trace2_region_enter_printf("index", "do_read_index", the_repository, "%s", path);
+
+	...
+
+	trace2_data_intmax("index", the_repository, "read/version", istate->version);
+	trace2_data_intmax("index", the_repository, "read/cache_nr", istate->cache_nr);
+
+	trace2_region_leave_printf("index", "do_read_index", the_repository, "%s", path);
+}
+----------------
++
+----------------
+$ export GIT_TR2_PERF_BRIEF=1
+$ export GIT_TR2_PERF=~/log.perf
+$ git status
+...
+$ cat ~/log.perf
+d0 | main                     | version      |     |           |           |            | 2.20.1.156.gf9916ae094.dirty
+d0 | main                     | start        |     |           |           |            | git status
+d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
+d0 | main                     | cmd_verb     |     |           |           |            | status (status)
+d0 | main                     | region_enter | r1  |  0.001791 |           | index      | label:do_read_index .git/index
+d0 | main                     | data         | r1  |  0.002494 |  0.000703 | index      | ..read/version:2
+d0 | main                     | data         | r1  |  0.002520 |  0.000729 | index      | ..read/cache_nr:3552
+d0 | main                     | region_leave | r1  |  0.002539 |  0.000748 | index      | label:do_read_index .git/index
+...
+----------------
+
+Thread Events::
+
+	Trace2 defines events to mark the start and end of a thread.
+	A thread name constructed during the start event. This name is
+	added to subsequent thread-specific events.  The thread exit
+	event reports the elapsed time in the thread.
++
+For example, the multithreaded preload-index code can be
+instrumented with a region around the thread pool and then
+per-thread start and exit events within the threadproc.
++
+----------------
+static void *preload_thread(void *_data)
+{
+	trace2_thread_start("preload_thread");
+
+	trace2_data_intmax("index", the_repository, "offset", p->offset);
+	trace2_data_intmax("index", the_repository, "count", nr);
+
+	do {
+	    ...
+	} while (--nr > 0);
+	...
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+void preload_index(struct index_state *index,
+	const struct pathspec *pathspec,
+	unsigned int refresh_flags)
+{
+	trace2_region_enter("index", "preload", the_repository);
+
+	for (i = 0; i < threads; i++) {
+	    ... /* create thread */
+	}
+
+	for (i = 0; i < threads; i++) {
+	    ... /* join thread */
+	}
+
+	trace2_region_leave("index", "preload", the_repository);
+}
+----------------
++
+In this example preload_index() was executed by the `main` thread
+and started the `preload` region.  Seven threads, named
+`th01:preload_thread` through `th07:preload_thread`, were started.
+Events from each thread are atomically appended to the shared target
+stream as they occur so they may appear in random order with respect
+other threads. Finally, the main thread waits for the threads to
+finish and leaves the region.
++
+Data events are tagged with the active thread name.  They are used
+to report the per-thread parameters.
++
+----------------
+$ export GIT_TR2_PERF_BRIEF=1
+$ export GIT_TR2_PERF=~/log.perf
+$ git status
+...
+$ cat ~/log.perf
+d0 | main                     | version      |     |           |           |            | 2.20.1.156.gf9916ae094.dirty
+d0 | main                     | start        |     |           |           |            | git status
+d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
+d0 | main                     | cmd_verb     |     |           |           |            | status (status)
+...
+d0 | main                     | region_enter | r1  |  0.002595 |           | index      | label:preload
+d0 | th01:preload_thread      | thread_start |     |  0.002699 |           |            |
+d0 | th02:preload_thread      | thread_start |     |  0.002721 |           |            |
+d0 | th01:preload_thread      | data         | r1  |  0.002736 |  0.000037 | index      | offset:0
+d0 | th02:preload_thread      | data         | r1  |  0.002751 |  0.000030 | index      | offset:2032
+d0 | th03:preload_thread      | thread_start |     |  0.002711 |           |            |
+d0 | th06:preload_thread      | thread_start |     |  0.002739 |           |            |
+d0 | th01:preload_thread      | data         | r1  |  0.002766 |  0.000067 | index      | count:508
+d0 | th06:preload_thread      | data         | r1  |  0.002856 |  0.000117 | index      | offset:2540
+d0 | th03:preload_thread      | data         | r1  |  0.002824 |  0.000113 | index      | offset:1016
+d0 | th04:preload_thread      | thread_start |     |  0.002710 |           |            |
+d0 | th02:preload_thread      | data         | r1  |  0.002779 |  0.000058 | index      | count:508
+d0 | th06:preload_thread      | data         | r1  |  0.002966 |  0.000227 | index      | count:508
+d0 | th07:preload_thread      | thread_start |     |  0.002741 |           |            |
+d0 | th07:preload_thread      | data         | r1  |  0.003017 |  0.000276 | index      | offset:3048
+d0 | th05:preload_thread      | thread_start |     |  0.002712 |           |            |
+d0 | th05:preload_thread      | data         | r1  |  0.003067 |  0.000355 | index      | offset:1524
+d0 | th05:preload_thread      | data         | r1  |  0.003090 |  0.000378 | index      | count:508
+d0 | th07:preload_thread      | data         | r1  |  0.003037 |  0.000296 | index      | count:504
+d0 | th03:preload_thread      | data         | r1  |  0.002971 |  0.000260 | index      | count:508
+d0 | th04:preload_thread      | data         | r1  |  0.002983 |  0.000273 | index      | offset:508
+d0 | th04:preload_thread      | data         | r1  |  0.007311 |  0.004601 | index      | count:508
+d0 | th05:preload_thread      | thread_exit  |     |  0.008781 |  0.006069 |            |
+d0 | th01:preload_thread      | thread_exit  |     |  0.009561 |  0.006862 |            |
+d0 | th03:preload_thread      | thread_exit  |     |  0.009742 |  0.007031 |            |
+d0 | th06:preload_thread      | thread_exit  |     |  0.009820 |  0.007081 |            |
+d0 | th02:preload_thread      | thread_exit  |     |  0.010274 |  0.007553 |            |
+d0 | th07:preload_thread      | thread_exit  |     |  0.010477 |  0.007736 |            |
+d0 | th04:preload_thread      | thread_exit  |     |  0.011657 |  0.008947 |            |
+d0 | main                     | region_leave | r1  |  0.011717 |  0.009122 | index      | label:preload
+...
+d0 | main                     | exit         |     |  0.029996 |           |            | code:0
+d0 | main                     | atexit       |     |  0.030027 |           |            | code:0
+----------------
++
+In this example, the preload region took 0.009122 seconds.  The 7 threads
+took between 0.006069 and 0.008947 seconds to work on their portion of
+the index.  Thread "th01" worked on 508 items at offset 0.  Thread "th02"
+worked on 508 items at offset 2032.  Thread "th04" worked on 508 itemts
+at offset 508.
++
+This example also shows that thread names are assigned in a racy manner
+as each thread starts and allocates TLS storage.
+
+Printf Events::
+
+	Trace2 defines a printf interface to write arbitrary messages
+	to the targets.  These are convenient for development, but
+	may more difficult to post-process.
+
+Trace2 Target Formats
+---------------------
+
+NORMAL Target Format
+~~~~~~~~~~~~~~~~~~~~
+
+NORMAL format is enabled when the `GIT_TR2` environment variable
+is set to "1" or an absolute pathname.
+
+Events are written as lines of the form:
+
+------------
+[<time> SP <filename>:<line> SP+] <event-name> [[SP] <event-message>] LF
+------------
+
+`<event-name>`::
+
+	is the event name.
+`<event-message>`::
+	is a free-form printf message intended for human consumption.
++
+Note that this may contain embedded LF or CRLF characters that are
+not escaped, so the event may spill across multiple lines.
+
+If `GIT_TR2_BRIEF` is true, the time, filename, and line number fields
+are omitted.
+
+This target is intended to be more of a summary (like GIT_TRACE) and
+less detailed than the other targets, and therefore does not emit
+messages for some of the Trace2 API verbs.  For example, thread,
+region, and data events are omitted.
+
+PERF Target Format
+~~~~~~~~~~~~~~~~~~
+
+PERF format is enabled when the `GIT_TR2_PERF` environment variable
+is set to "1" or an absolute pathname.
+
+Events are written as lines of the form:
+
+------------
+[<time> SP <filename>:<line> SP+
+    BAR SP] d<depth> SP
+    BAR SP <thread-name> SP+
+    BAR SP <event-name> SP+
+    BAR SP [r<repo-id>] SP+
+    BAR SP [<t_abs>] SP+
+    BAR SP [<t_rel>] SP+
+    BAR SP [<category>] SP+
+    BAR SP DOTS* <perf-event-message>
+    LF
+------------
+
+`<depth>`::
+	is the git process depth.  This is the number of parent
+	git processes.  A top-level git command has depth value 0.
+	A child of it has depth value 1.
+
+`<thread-name>`::
+	is a unique name for the thread.  The primary thread
+	is called "main".  Other thread names are of the form "th%d:%s"
+	and include a unique number and the name of the thread-proc.
+
+`<event-name>`::
+	is the event name.
+
+`<repo-id>`::
+	when present, is a number indicating the repository
+	in use.  A `def_repo` event is emitted when a repository is
+	opened.  This defines the repo-id and associated worktree.
+	Subsequent repo-specific events will reference this repo-id.
++
+Currently, this is always "r1" for the main repository.
+This field is in anticipation of in-proc submodules in the future.
+
+`<t_abs>`::
+	when present, is the absolute time in seconds since the
+	program started.
+
+`<t_rel>`::
+	when present, is time in seconds relative to the start of
+	the current region.  For a thread-exit event, it is the elapsed
+	time of the thread.
+
+`<category>`::
+	is present on region and data events and is used to
+	indicate a broad category, such as "index" or "status".
++
+Currently, this is advisory.  This field is in anticipation
+of category-based filtering, similar to the `GIT_TRACE_<key>`
+facility in Trace1.
+
+`<perf-event-message>`::
+	is a free-form printf message intended for human consumption.
+
+If `GIT_TR2_PERF_BRIEF` is true, the time, filename, and line number
+fields are omitted.
+
+This target is intended for interactive performance analysis
+during development and is quite noisy.
+
+EVENT Target Format
+~~~~~~~~~~~~~~~~~~~
+
+EVENT format is enabled when the `GIT_TR2_EVENT` environment
+variable is set to "1" or an absolute pathname.
+
+Each event is a JSON-object containing multiple key/value pairs
+written as a single line and followed by a LF.
+
+------------
+'{' <key> ':' <value> [',' <key> ':' <value>]* '}' LF
+------------
+
+Some key/value pairs are common to all events and some are
+event-specific.
+
+Common Key/Value Pairs
+^^^^^^^^^^^^^^^^^^^^^^
+
+The following key/value pairs are common to all events:
+
+------------
+{
+	"event":"version",
+	"sid":"1547659722619736-11614",
+	"thread":"main",
+	"time":"2019-01-16 17:28:42.620713",
+	"file":"common-main.c",
+	"line":38,
+	...
+}
+------------
+
+`"event":<event>`::
+	is the event name.
+
+`"sid":<sid>`::
+	is the session-id.  This is a unique string to identify the
+	process instance to allow all events emitted by a process to
+	be identified.  A session-id is used instead of a PID because
+	PIDs are recycled by the OS.  For child git processes, the
+	session-id is prepended with the session-id of the parent git
+	process to allow parent-child relationships to be identified
+	during post-processing.
+
+`"thread":<thread>`::
+	is the thread name.
+
+`"time":<time>`::
+	is the UTC time of the event.
+
+`"file":<filename>`::
+	is source file generating the event.
+
+`"line":<line-number>`::
+	is the integer source line number generating the event.
+
+`"repo":<repo-id>`::
+	when present, is the integer repo-id as described previously.
+
+If `GIT_TR2_EVENT_BRIEF` is true, the file and line fields are omitted
+from all events and the time field is only present on the `start` and
+`atexit` events.
+
+Event-Specific Key/Value Pairs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+`version`::
+	This event gives the version of the executable and the EVENT format.
++
+------------
+{
+	"event":"version",
+	...
+	"evt":"1",		       # EVENT format version
+	"exe":"2.20.1.155.g426c96fcdb" # git version
+}
+------------
+
+`start`::
+	This event contains the complete argv received by main().
++
+------------
+{
+	"event":"start",
+	...
+	"argv":["git","version"]
+}
+------------
+
+`exit`::
+	This event is emitted when git calls `exit()`.
++
+------------
+{
+	"event":"exit",
+	...
+	"t_abs":0.001227, # elapsed time in seconds
+	"code":0	  # exit code
+}
+------------
+
+`atexit`::
+	This event is emitted by the Trace2 `atexit` routine during
+	final shutdown.  It should be the last event emitted by the
+	process.  (The elapsed time reported here is greater than the
+	time reported in the `exit` event because it runs after all
+	other atexit tasks have completed.)
++
+------------
+{
+	"event":"atexit",
+	...
+	"t_abs":0.001227,
+	"code":0
+}
+------------
+
+`signal`::
+	This event is emitted when the program is terminated by a user
+	signal.  Depending on the platform, the signal event may
+	prevent the `atexit` event from being generated.
++
+------------
+{
+	"event":"signal",
+	...
+	"t_abs":0.001227,
+	"signal":13
+}
+------------
+
+`error`::
+	This event is emitted when one of the `error()`, `die()`,
+	or `usage()` functions are called.
++
+------------
+{
+	"event":"error",
+	...
+	"msg":"invalid option: --cahced", # formatted error message
+	"fmt":"invalid option: %s"	  # error format string
+}
+------------
++
+The error event may be emitted more than once.  The format string
+allows post-processors to group errors by type without worrying
+about specific error arguments.
+
+`cmd_path`::
+	This event contains the discovered full path of the git
+	executable (on platforms that are configured to resolve it).
++
+------------
+{
+	"event":"cmd_path",
+	...
+	"path":"C:/work/gfw/git.exe"
+}
+------------
+
+`cmd_verb`::
+	This event contains the primary verb for this command
+	and the hierarchy of command verbs.
++
+------------
+{
+	"event":"cmd_verb",
+	...
+	"name":"pack-objects",
+	"hierarchy":"push/pack-objects"
+}
+------------
++
+Normally, the `name` field contains the canonical name of the
+command.  When a canonical command verb is not available, one of
+these special values are used:
++
+------------
+"_query_"            # "git --html-path"
+"_run_dashed_"       # when "git foo" tries to run "git-foo"
+"_run_shell_alias_"  # alias expansion to a shell command
+"_run_git_alias_"    # alias expansion to a git command
+"_usage_"            # usage error
+------------
+
+`cmd_subverb`::
+	This event, when present, describes the variant of the main
+	command verb.  This event may be emitted more than once.
++
+------------
+{
+	"event":"cmd_subverb",
+	...
+	"name":"branch"
+}
+------------
++
+The `name` field is an arbitrary string that makes sense in the
+context of the primary verb. For example, checkout can checkout a
+branch or an individual file.  And these variations typically have
+different performance characteristics that are not comparable.
+
+`alias`::
+	This event is present when an alias is expanded.
++
+------------
+{
+	"event":"alias",
+	...
+	"alias":"l",		 # registered alias
+	"argv":["log","--graph"] # alias expansion
+}
+------------
+
+`child_start`::
+	This event describes a child process that is about to be
+	spawned.
++
+------------
+{
+	"event":"child_start",
+	...
+	"child_id":2,
+	"child_class":"?",
+	"use_shell":false,
+	"argv":["git","rev-list","--objects","--stdin","--not","--all","--quiet"]
+
+	"hook_name":"<hook_name>"  # present when child_class is "hook"
+	"cd":"<path>"		   # present when cd is required
+}
+------------
++
+The `child_id` field can be used to match this child_start with the
+corresponding child_exit event.
++
+The `child_class` field is a rough classification, such as "editor",
+"pager", "transport/*", and "hook".  Unclassified children are classified
+with "?".
+
+`child_exit`::
+	This event is generated after the git process has returned
+	from the waitpid() and collected the exit information from the
+	child.
++
+------------
+{
+	"event":"child_exit",
+	...
+	"child_id":2,
+	"pid":14708,	 # child PID
+	"code":0,	 # child exit-code
+	"t_rel":0.110605 # observed run-time of child process
+}
+------------
++
+Note that the session-id of the child process is not available to
+the current/spawning process, so the child's PID is reported here as
+a hint for post-processing.  (But it is only a hint because the child
+proces may be a shell script which doesn't have a session-id.)
++
+Note that the `t_rel` field contains the observed run time in seconds
+for the child process (starting before the fork/exec/spawn and
+stopping after the waitpid() and includes OS process creation overhead).
+So this time will be slightly larger than the atexit time reported by
+the child process itself.
+
+`exec`::
+	This event is generated before git attempts to `exec()`
+	another command rather than starting a child process.
++
+------------
+{
+	"event":"exec",
+	...
+	"exec_id":0,
+	"exe":"git",
+	"argv":["foo", "bar"]
+}
+------------
++
+Since `exec()` does not return if successful, this will be the last
+event generated for the current git command before the new git commit
+starts.
++
+The `exec_id` field is a command-unique id and is only useful if the
+`exec()` fails and a corresponding exec_result event is generated.
+
+`exec_result`::
+	This event is generated if the `exec()` fails and control
+	returns to the current git command.
++
+------------
+{
+	"event":"exec_result",
+	...
+	"exec_id":0,
+	"code":1      # error code (errno) from exec()
+}
+------------
+
+`thread_start`::
+	This event is generated when a thread is started.  It is
+	generated from *within* the new thread's thread-proc (for TLS
+	reasons).
++
+------------
+{
+	"event":"thread_start",
+	...
+	"thread":"th02:preload_thread"
+}
+------------
+
+`thread_exit`::
+	This event is generated when a thread exits.  It is generated
+	from *within* the thread's thread-proc (for TLS reasons).
++
+------------
+{
+	"event":"thread_exit",
+	...
+	"thread":"th02:preload_thread",
+	"t_rel":0.007328                # thread elapsed time
+}
+------------
+
+`def_param`::
+	This event is generated to log a global key/value pair for the
+	current command.
++
+------------
+{
+	"event":"def_param",
+	...
+	"param":"core.editor",
+	"value":"emacs"
+}
+------------
++
+This is intended to log "values of interest" for post-processing.  For
+example, this might be configuration settings known to affect
+performance or the remote URL so that different repos can be grouped
+differently.  For thread- or region-specific key/values pairs, see the
+`data` and `data_json` events.
+
+`def_repo`::
+	This event defines a repo-id and associates it with the root
+	of the worktree.  Subsequent repo-relative events will refer
+	to this repo-id.  Repo-id number 1 refers to the main
+	repository.
++
+------------
+{
+	"event":"def_repo",
+	...
+	"repo":1,
+	"worktree":"/Users/jeffhost/work/gfw"
+}
+------------
++
+As stated earlier, the repo-id is currently always 1, so there will
+only be one def_repo event.  Later, if in-proc submodules are
+supported, a def_repo event should be emitted for each submodule
+visited.
+
+`region_enter`::
+	This event is generated when entering a region.
+	It serves as a marker in the event stream.  It starts an activity timer
+	for the region.  And it pushes a frame on the region stack for the
+	current thread.
++
+------------
+{
+	"event":"region_enter",
+	...
+	"repo":1,
+	"nesting":1,		 # current region stack depth
+	"category":"index",	 # optional
+	"label":"do_read_index", # optional
+	"msg":".git/index"	 # optional
+}
+------------
++
+The `category` field may be used in a future enhancement to
+do category-based filtering.
++
+The `GIT_TR2_EVENT_NESTING` environment variable can be used to
+filter deeply nested regions and data events.  It defaults to "2".
+
+`region_leave`::
+	This event is generated when leaving a region.  It serves as a
+	marker in the event stream and reports the elapsed time spent
+	in the region.  It pops a frame off of the region stack for
+	the current thread.
++
+------------
+{
+	"event":"region_leave",
+	...
+	"repo":1,
+	"t_rel":0.002876,	 # time spent in region in seconds
+	"nesting":1,		 # region stack depth
+	"category":"index",	 # optional
+	"label":"do_read_index", # optional
+	"msg":".git/index"	 # optional
+}
+------------
++
+The examples in this document have generally shown the region_enter
+and region_leave events with the same category and label fields.  This
+is not a requirement, but makes it easier to understand the logs.
+
+`data`::
+	This event is generated to log a thread- and region-local
+	key/value pair.  For example, during a recursive treewalk,
+	logging the relative path and the number of entries in the
+	tree.
++
+------------
+{
+	"event":"data",
+	...
+	"repo":1,              # optional
+	"t_abs":0.024107,      # absolute elapsed time
+	"t_rel":0.001031,      # elapsed time in region/thread
+	"nesting":2,
+	"category":"index",
+	"key":"read/cache_nr",
+	"value":"3552"}
+}
+------------
++
+The `value` field may be an integer or a string.
+
+`data-json`::
+	This event is generated to log a pre-formatted JSON string
+	containing structured data.
++
+------------
+{
+	"event":"data_json",
+	...
+	"repo":1,              # optional
+	"t_abs":0.015905,
+	"t_rel":0.015905,
+	"nesting":1,
+	"category":"process",
+	"key":"windows/ancestry",
+	"value":["bash.exe","bash.exe"]
+}
+------------
+
+Appendix: Relationship to the Existing Trace Api (api-trace.txt)
+----------------------------------------------------------------
+
+Eventually, I would like Trace2 to replace the existing Trace1 API.
+
+Trace2 is a superset of Trace1 and the existing Trace1 API calls could
+be converted to Trace2, but that work has not yet been attempted.
+
+There are a few issues here:
+
+* Updating existing tests that assume GIT_TRACE format messages.
+
+* How to best handle custom GIT_TRACE_<key> messages?
+
+** The GIT_TRACE_<key> mechanism allows each <key> to write to a
+different file (in addition to just stderr).
+
+** Do we want to maintain that ability or simply write to the existing
+Trace2 targets (and convert <key> to a "category").
+
-- 
gitgitgadget

