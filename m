Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7171F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfKOJxx (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:53:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39795 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOJxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:53:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id l7so10253375wrp.6
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N+uolg5r0XDGuOmgPUa1kHx41h4qRZi4BmBjtiraTf8=;
        b=TFotuWWJoY2HpFj7OHlGjcy1d99z13Lh+uYe/sOxYdaFQgvQ6a9tLYDXvLoj14p4C1
         H8ZJplTLckkp07ZKGIxYYZmMSgyn+vTVnIa+dTy5pdbi/HFy7DjNodpy4aBQhi/Yw44u
         nMQR5frn01gG4idA7+vHZpdLaWnkIscVGu+zJsexoq9Z0rD9QGXJ5Pwu8zU5dZdPJolI
         QazGPREfWS9I4OtRfjLmON2kT+8GEmJ9IB4Y91HTDqWeSFJ9qTTdTgCXTBu5W/qTSTHq
         0ctPfcT7ywCMnY6lFZPwppRiJpneYEcZszi8yqxBfKv9nzSk3ZyX+j5LySIlzDm+2Dcq
         rJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N+uolg5r0XDGuOmgPUa1kHx41h4qRZi4BmBjtiraTf8=;
        b=rJqE0ZXgpIuJUXnS2YGJ0KnIt45MzhwHVjc1aYUeSyqR0vNUjwsSyZjc/aP+QAmzwB
         y3gERo0IAQBv0jHx264Q0mzLvQ7Ff2Dty0oO/IYTLOLAlYJ//NrhBJZEhMnH4HIsoHHN
         DasdlPpxAvghlNkZD1Erh/ZBE1vMZqygXcoDoOfwTtPvsvnPZ3sB8JNme9g4ert1UtwS
         pGX/gl3/QrGWpB8bdQK+bLlFgudKYq+N8ARWHJ72yA9A/VMYpY21qz1DtaOgICsuHR4+
         xKlaYv/QL0L9a9RQXmaOGCoEnEyQBkpQEpz9wmr+4tAUANSc6ibLIUZ+PyyeP5WvKtij
         bDuA==
X-Gm-Message-State: APjAAAWrixz6LzhrWXOodt2bhnCAhKbveqaGvTXqAdTpIAOmr46QWctb
        wh8cDoS4MrriLMhbLZz/7FKXMFkF
X-Google-Smtp-Source: APXvYqxKLn+htEfi7uF6LezwsUcwInBT3SFQWya3X+xhruz0wZ1uBLUEF/mDQ2XZheTnl6GC6GskTg==
X-Received: by 2002:a5d:4a85:: with SMTP id o5mr14780448wrq.109.1573811628873;
        Fri, 15 Nov 2019 01:53:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm10617437wrl.2.2019.11.15.01.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:53:48 -0800 (PST)
Message-Id: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 09:53:25 +0000
Subject: [PATCH v4 00/21] [Outreachy] Move doc to header files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the documentation from Documentation/technical/api-*.txt to the
corresponding header file, as it's easier for the developers to find the
usage information beside the code instead of looking for it in another doc
file.

Also documentation/technical/api-*.txt is removed because the information it
has is will be redundant and it'll be hard to keep it up to date and
synchronized with the documentation in the header files.

api-trace2.txt is not removed because it has lots of valuable information
that seems more appropriate to be in a separate doc file not in the trace2.h
although the functions documentation is moved to the trace2.h

api-error-handling.txt is not removed as well because no other file seemed
to be more suitable for the doc it contains. I'm open to suggestions though.

The ll-merge related doc was removed from api-merge.txt to ll-merge.h, while
the rest of the file is left as is.

Signed-off-by: Heba Waly heba.waly@gmail.com

Heba Waly (21):
  diff: move doc to diff.h and diffcore.h
  dir: move doc to dir.h
  graph: move doc to graph.h and graph.c
  merge: move doc to ll-merge.h
  sha1-array: move doc to sha1-array.h
  remote: move doc to remote.h and refspec.h
  refs: move doc to refs.h
  attr: move doc to attr.h
  revision: move doc to revision.h
  pathspec: move doc to pathspec.h
  sigchain: move doc to sigchain.h
  cache: move doc to cache.h
  argv-array: move doc to argv-array.h
  credential: move doc to credential.h
  parse-options: move doc to parse-options.h
  run-command: move doc to run-command.h
  trace: move doc to trace.h
  tree-walk: move doc to tree-walk.h
  submodule-config: move doc to submodule-config.h
  trace2: move doc to trace2.h
  api-index: remove api doc index files

 Documentation/Makefile                        |  11 +-
 Documentation/MyFirstContribution.txt         |   2 +-
 Documentation/MyFirstObjectWalk.txt           |   7 +-
 Documentation/git-credential.txt              |   3 +-
 Documentation/git.txt                         |   3 -
 Documentation/gitcredentials.txt              |   3 +-
 Documentation/technical/.gitignore            |   1 -
 .../technical/api-allocation-growing.txt      |  39 ---
 Documentation/technical/api-argv-array.txt    |  65 ----
 Documentation/technical/api-credentials.txt   | 271 ---------------
 Documentation/technical/api-diff.txt          | 174 ----------
 .../technical/api-directory-listing.txt       | 130 -------
 Documentation/technical/api-gitattributes.txt | 154 --------
 Documentation/technical/api-history-graph.txt | 173 ---------
 Documentation/technical/api-index-skel.txt    |  13 -
 Documentation/technical/api-index.sh          |  28 --
 Documentation/technical/api-merge.txt         |  72 +---
 Documentation/technical/api-oid-array.txt     |  90 -----
 Documentation/technical/api-parse-options.txt | 313 -----------------
 Documentation/technical/api-ref-iteration.txt |  78 -----
 Documentation/technical/api-remote.txt        | 127 -------
 .../technical/api-revision-walking.txt        |  72 ----
 Documentation/technical/api-run-command.txt   | 264 --------------
 Documentation/technical/api-setup.txt         |  47 ---
 Documentation/technical/api-sigchain.txt      |  41 ---
 .../technical/api-submodule-config.txt        |  66 ----
 Documentation/technical/api-trace.txt         | 140 --------
 Documentation/technical/api-trace2.txt        | 243 +------------
 Documentation/technical/api-tree-walking.txt  | 149 --------
 argv-array.h                                  |  62 ++++
 attr.c                                        |   3 +-
 attr.h                                        | 141 +++++++-
 cache.h                                       |  41 ++-
 credential.h                                  | 236 +++++++++++++
 diff.h                                        | 126 +++++++
 diffcore.h                                    |  32 ++
 dir.c                                         |   2 -
 dir.h                                         | 119 ++++++-
 graph.c                                       |   1 +
 graph.h                                       | 121 +++++++
 ll-merge.h                                    |  73 +++-
 parse-options.h                               | 328 ++++++++++++++++++
 pathspec.h                                    |  35 +-
 refs.h                                        |  51 +++
 refspec.h                                     |  16 +
 remote.h                                      |  57 ++-
 revision.h                                    |  59 ++++
 run-command.h                                 | 252 +++++++++++++-
 sha1-array.c                                  |   2 +-
 sha1-array.h                                  |  80 +++++
 sigchain.h                                    |  45 +++
 submodule-config.h                            |  38 +-
 trace.h                                       | 133 ++++++-
 trace2.h                                      | 124 +++++--
 tree-walk.h                                   | 122 ++++++-
 55 files changed, 2259 insertions(+), 2819 deletions(-)
 delete mode 100644 Documentation/technical/.gitignore
 delete mode 100644 Documentation/technical/api-allocation-growing.txt
 delete mode 100644 Documentation/technical/api-argv-array.txt
 delete mode 100644 Documentation/technical/api-credentials.txt
 delete mode 100644 Documentation/technical/api-diff.txt
 delete mode 100644 Documentation/technical/api-directory-listing.txt
 delete mode 100644 Documentation/technical/api-gitattributes.txt
 delete mode 100644 Documentation/technical/api-history-graph.txt
 delete mode 100644 Documentation/technical/api-index-skel.txt
 delete mode 100755 Documentation/technical/api-index.sh
 delete mode 100644 Documentation/technical/api-oid-array.txt
 delete mode 100644 Documentation/technical/api-parse-options.txt
 delete mode 100644 Documentation/technical/api-ref-iteration.txt
 delete mode 100644 Documentation/technical/api-remote.txt
 delete mode 100644 Documentation/technical/api-revision-walking.txt
 delete mode 100644 Documentation/technical/api-run-command.txt
 delete mode 100644 Documentation/technical/api-setup.txt
 delete mode 100644 Documentation/technical/api-sigchain.txt
 delete mode 100644 Documentation/technical/api-submodule-config.txt
 delete mode 100644 Documentation/technical/api-trace.txt
 delete mode 100644 Documentation/technical/api-tree-walking.txt


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-434%2FHebaWaly%2Fmove-doc-to-header-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-434/HebaWaly/move-doc-to-header-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/434

Range-diff vs v3:

  1:  60e80b545f !  1:  7f2f4c45a6 diff: move doc to diff.h and diffcore.h
     @@ -398,14 +398,6 @@
       	void (*set_default)(struct diff_options *);
       
       	FILE *file;
     -@@
     - void diff_emit_submodule_pipethrough(struct diff_options *o,
     - 				     const char *line, int len);
     - 
     -+/* Output should be colored. */
     - enum color_diff {
     - 	DIFF_RESET = 0,
     - 	DIFF_CONTEXT = 1,
      @@
       	DIFF_FILE_OLD_BOLD = 21,
       	DIFF_FILE_NEW_BOLD = 22,
  2:  7539f11bce =  2:  f87ca0228e dir: move doc to dir.h
  3:  370f42114e =  3:  495fe333bd graph: move doc to graph.h and graph.c
  4:  39f25de85f =  4:  90baf409ec merge: move doc to ll-merge.h
  5:  3a8f93de3d =  5:  a76a2e2244 sha1-array: move doc to sha1-array.h
  6:  52ba427514 =  6:  5719b8141c remote: move doc to remote.h and refspec.h
  7:  6a9a0f77b3 =  7:  f84c1338fa refs: move doc to refs.h
  8:  b1aedd025e =  8:  a007b50b9b attr: move doc to attr.h
  9:  6463c7565b =  9:  88553030f5 revision: move doc to revision.h
 10:  fa450e27a8 = 10:  0042d10223 pathspec: move doc to pathspec.h
 11:  0e1663c039 = 11:  240a4bcb32 sigchain: move doc to sigchain.h
 12:  1eca7099ef ! 12:  3e0d3f2415 cache: move doc to cache.h
     @@ -22,7 +22,7 @@
      -`alloc` is used by the `ALLOC_GROW` macro. Check
      -`Documentation/technical/api-allocation-growing.txt` - this variable is used to
      -track the allocated size of the list.
     -+`alloc` is used by the `ALLOC_GROW` macro. Check `cache.h` - this variable is 
     ++`alloc` is used by the `ALLOC_GROW` macro. Check `cache.h` - this variable is
      +used to track the allocated size of the list.
       
       Per entry, we find:
 13:  debc035d40 = 13:  4f805c8737 argv-array: move doc to argv-array.h
 14:  2e79afe7b8 = 14:  ea78cb4ae5 credential: move doc to credential.h
 15:  1dca77cd27 ! 15:  7097de91c3 parse-options: move doc to parse-options.h
     @@ -412,13 +412,10 @@
      + *   `static const char * const builtin_foo_usage[]` array
      + *   containing alternative usage strings
      + *
     -+ * - define `builtin_foo_options` array as described below
     -+ *   in section 'Data Structure'.
     ++ * - define `builtin_foo_options` array.
      + *
     -+ * - in `cmd_foo(int argc, const char **argv, const char *prefix)`
     -+ *   call
     -+ *
     -+ * 	argc = parse_options(argc, argv, prefix, builtin_foo_options, builtin_foo_usage, flags);
     ++ * - in `cmd_foo(int argc, const char **argv, const char *prefix)` call
     ++ *   argc = parse_options(argc, argv, prefix, builtin_foo_options, builtin_foo_usage, flags);
      + *
      + * `parse_options()` will filter out the processed options of `argv[]` and leave the
      + * non-option arguments in `argv[]`.
     @@ -430,6 +427,8 @@
      + * a limited parser for only a subset of the options that needs to be run
      + * before the full parser, which in turn shows the full help message.
      + *
     ++ * Flags are the bitwise-or of the members of parse_opt_flags.
     ++ *
      + * Sophisticated option parsing
      + * ----------------------------
      + *
 16:  1a9a6ca42d = 16:  03aa723fb7 run-command: move doc to run-command.h
 17:  f4df8e16ed = 17:  44a47075dc trace: move doc to trace.h
 18:  ee9b74018b = 18:  5b20c2794b tree-walk: move doc to tree-walk.h
 19:  9f34f3177d = 19:  251a08c1d8 submodule-config: move doc to submodule-config.h
 20:  a337f88a55 ! 20:  1f08493281 trace2: move doc to trace2.h
     @@ -20,15 +20,9 @@
       --- a/Documentation/technical/api-trace2.txt
       +++ b/Documentation/technical/api-trace2.txt
      @@
     - Trace2 Targets.  This section describes the set of available
     - messages.
     + === Basic Command Messages
       
     --It helps to divide these functions into groups for discussion
     --purposes.
     --
     --=== Basic Command Messages
     --
     --These are concerned with the lifetime of the overall git process.
     + These are concerned with the lifetime of the overall git process.
      -
      -`void trace2_initialize_clock()`::
      -
     @@ -73,11 +67,13 @@
      -
      -	Emits a "cmd_path" message with the full pathname of the
      -	current process.
     --
     --=== Command Detail Messages
     --
     --These are concerned with describing the specific Git command
     --after the command line, config, and environment are inspected.
     ++e.g: `void trace2_initialize_clock()`, `void trace2_initialize()`,
     ++`int trace2_is_enabled()`, `void trace2_cmd_start(int argc, const char **argv)`.
     + 
     + === Command Detail Messages
     + 
     + These are concerned with describing the specific Git command
     + after the command line, config, and environment are inspected.
      -
      -`void trace2_cmd_name(const char *name)`::
      -
     @@ -142,12 +138,14 @@
      -+
      -The repo-id field is in anticipation of future in-proc submodule
      -repositories.
     --
     --=== Child Process Messages
     --
     --These are concerned with the various spawned child processes,
     --including shell scripts, git commands, editors, pagers, and hooks.
     --
     ++e.g: `void trace2_cmd_name(const char *name)`,
     ++`void trace2_cmd_mode(const char *mode)`.
     + 
     + === Child Process Messages
     + 
     + These are concerned with the various spawned child processes,
     + including shell scripts, git commands, editors, pagers, and hooks.
     + 
      -`void trace2_child_start(struct child_process *cmd)`::
      -
      -	Emits a "child_start" message containing the "child-id",
     @@ -192,11 +190,12 @@
      -On Unix-based systems, `exec()` does not return if successful.
      -This message is used to indicate that the `exec()` failed and
      -that the current program is continuing.
     --
     --=== Git Thread Messages
     --
     --These messages are concerned with Git thread usage.
     --
     ++e.g: `void trace2_child_start(struct child_process *cmd)`.
     + 
     + === Git Thread Messages
     + 
     + These messages are concerned with Git thread usage.
     + 
      -`void trace2_thread_start(const char *thread_name)`::
      -
      -	Emits a "thread_start" message.
     @@ -220,10 +219,11 @@
      -This function must be called by the thread-proc before it returns
      -(so that the coorect TLS data is used and cleaned up.  It should
      -not be called by the caller of `pthread_join()`.
     --
     --=== Region and Data Messages
     --
     --These are concerned with recording performance data
     ++e.g: `void trace2_thread_start(const char *thread_name)`.
     + 
     + === Region and Data Messages
     + 
     + These are concerned with recording performance data
      -over regions or spans of code.
      -
      -`void trace2_region_enter(const char *category, const char *label, const struct repository *repo)`::
     @@ -282,9 +282,11 @@
      -`void trace2_printf(const char *fmt, ...)`::
      -
      -`void trace2_printf_va(const char *fmt, va_list ap)`::
     --
     ++over regions or spans of code. e.g:
     ++`void trace2_region_enter(const char *category, const char *label, const struct repository *repo)`.
     + 
      -	Emits a region- and thread-relative "printf" message.
     -+Refer to trace2.h for details about trace2 functions.
     ++Refer to trace2.h for details about all trace2 functions.
       
       == Trace2 Target Formats
       
     @@ -391,14 +393,6 @@
      -/*
      - * Emit a 'child_start' event prior to spawning a child process.
      +/**
     -+ * Child Process Messages
     -+ * ----------------------
     -+ *
     -+ * These are concerned with the various spawned child processes,
     -+ * including shell scripts, git commands, editors, pagers, and hooks.
     -+ */
     -+
     -+/**
      + * Emits a "child_start" message containing the "child-id",
      + * "child-argv", and "child-classification".
        *
     @@ -457,20 +451,6 @@
        * Emit an 'exec_result' when possible.  On Unix-derived systems,
        * this should be called after exec() returns (which only happens
        * when there is an error starting the new process).  On Windows,
     -@@
     - #define trace2_exec_result(id, code) \
     - 	trace2_exec_result_fl(__FILE__, __LINE__, (id), (code))
     - 
     -+
     -+/**
     -+ * Git Thread Messages
     -+ * -------------------
     -+ * These messages are concerned with Git thread usage.
     -+ */
     -+
     - /*
     -  * Emit a 'thread_start' event.  This must be called from inside the
     -  * thread-proc to set up the trace2 TLS data for the thread.
      @@
       #define trace2_thread_exit() trace2_thread_exit_fl(__FILE__, __LINE__)
       
     @@ -505,13 +485,6 @@
       #define trace2_def_repo(repo) trace2_def_repo_fl(__FILE__, __LINE__, repo)
       
      -/*
     -+/**
     -+ * Region and Data Messages
     -+ * ------------------------
     -+ * These are concerned with recording performance data over regions or spans
     -+ * of code.
     -+ */
     -+
      +/**
        * Emit a 'region_enter' event for <category>.<label> with optional
        * repo-id and printf message.
 21:  e187c61371 = 21:  5f21417393 api-index: remove api doc index files

-- 
gitgitgadget
