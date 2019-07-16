Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4A31F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfGPO6l (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:58:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37604 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387943AbfGPO6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:58:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so19028302wme.2
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pLQdIAlPTGeJFKOpkVCELoHJWpFnDOwPQDBKkdcQHUc=;
        b=ZYTliWulV+6D3LKqEuA+v+CTDhLZEA08VBb/40FcS+xqf4DPW27Qjlsztd7h6PnOZl
         UAZfaOQfcRPu9a5uhQhx31hAnEXu8ivpP05N4WBNHEtZ7bm3CUvY7Y2fpIZQNxubbsNv
         /eIOJieJrjVWsVd/uAkHY7GXN4CDHmztmt59fW/GZIIIJhpL93DDvoaczS7axyGxbaAd
         17RQIc5v5kOhNIewNBaoj7rWDjiO5CVITtCH1BbbpdN98sAa0UIayTDTBdELTt2NcO57
         zZdF1znSzR02mp4+ecCHbfvh7t/JstO/J05nXqiqe0VSU5Woc280kM/Xut5p97LmZYfc
         DNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pLQdIAlPTGeJFKOpkVCELoHJWpFnDOwPQDBKkdcQHUc=;
        b=IU03bkx1h2pc1xyPkCi8MHgdR3ywpvvNZ7QhnDsQMoLsGlZfjZXSy+mH9Pc5rdO7s3
         v8zXQl/oSHH9OhzPtfWtSR+JSrnQkKnhEMXms4MZFFY6YVh9AvBSFMsnmiA+bojJLIqp
         /evXR8I0P23/YwlBtUw+LXUVJ/8gQvguM9jpFgUCOdHbyqK7aml7UR2iOhJ8dn8xtFJq
         8s2ujk5Hpe0g8KFcukiSUpKH5fVyIxRjgpjR1aL+A1yG+IEFSJEBDp/Ki07HS/9cNmWW
         wHcrb/7LWtcRbU+hzX8jfWEfGeT1IGk2J8t4wYJ64AXsh9fSpgBkqZfK1QrNovmPkzUE
         xFMQ==
X-Gm-Message-State: APjAAAVaNE1VbM5xQSZSwnUiBxENR540WYo5e+G1FbHQmryGueUE0RQo
        rvU2Wxu8XNcqyzxsWi//euWoELTz
X-Google-Smtp-Source: APXvYqwL+TheCZngEc28iknbGeFTkrz24ejXGDcp3bMDQFJlwLFlxPWXGHgcLraiqiTm2VVHHggRXQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr30156470wmb.32.1563289117897;
        Tue, 16 Jul 2019 07:58:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm25503138wmf.8.2019.07.16.07.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:58:37 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:58:37 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:58:25 GMT
Message-Id: <0a5ec9345d2f9cc6cd348231219d4af428a28e94.1563289115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v3.git.gitgitgadget@gmail.com>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 01/11] Start to implement a built-in version of `git add
 --interactive`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is hardly the first conversion of a Git command that is implemented
as a script to a built-in. So far, the most successful strategy for such
conversions has been to add a built-in helper and call that for more and
more functionality from the script, as more and more parts are
converted.

With the interactive add, we choose a different strategy. The sole
reason for this is that on Windows (where such a conversion has the most
benefits in terms of speed and robustness) we face the very specific
problem that a `system()` call in Perl seems to close `stdin` in the
parent process when the spawned process consumes even one character from
`stdin`. And that just does not work for us here, as it would stop the
main loop as soon as any interactive command was performed by the
helper. Which is almost all of the commands in `git add -i`.

It is almost as if Perl told us once again that it does not want us to
use it on Windows.

Instead, we follow the opposite route where we start with a bare-bones
version of the built-in interactive add, guarded by the new
`add.interactive.useBuiltin` config variable, and then add more and more
functionality to it, until it is feature complete.

At this point, the built-in version of `git add -i` only states that it
cannot do anything yet ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/add.txt |  5 +++++
 Makefile                     |  1 +
 add-interactive.c            |  7 +++++++
 add-interactive.h            |  8 ++++++++
 builtin/add.c                | 10 ++++++++++
 t/README                     |  4 ++++
 6 files changed, 35 insertions(+)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h

diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
index 4d753f006e..c9f748f81c 100644
--- a/Documentation/config/add.txt
+++ b/Documentation/config/add.txt
@@ -5,3 +5,8 @@ add.ignore-errors (deprecated)::
 	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
 	as it does not follow the usual naming convention for configuration
 	variables.
+
+add.interactive.useBuiltin::
+	[EXPERIMENTAL] Set to `true` to use the experimental built-in
+	implementation of the interactive version of linkgit:git-add[1]
+	instead of the Perl script version. Is `false` by default.
diff --git a/Makefile b/Makefile
index 98a0588416..0a47200f47 100644
--- a/Makefile
+++ b/Makefile
@@ -824,6 +824,7 @@ LIB_H := $(sort $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null
 	-name '*.h' -print))
 
 LIB_OBJS += abspath.o
+LIB_OBJS += add-interactive.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
diff --git a/add-interactive.c b/add-interactive.c
new file mode 100644
index 0000000000..482e458dc6
--- /dev/null
+++ b/add-interactive.c
@@ -0,0 +1,7 @@
+#include "cache.h"
+#include "add-interactive.h"
+
+int run_add_i(struct repository *r, const struct pathspec *ps)
+{
+	die(_("No commands are available in the built-in `git add -i` yet!"));
+}
diff --git a/add-interactive.h b/add-interactive.h
new file mode 100644
index 0000000000..7043b8741d
--- /dev/null
+++ b/add-interactive.h
@@ -0,0 +1,8 @@
+#ifndef ADD_INTERACTIVE_H
+#define ADD_INTERACTIVE_H
+
+struct repository;
+struct pathspec;
+int run_add_i(struct repository *r, const struct pathspec *ps);
+
+#endif
diff --git a/builtin/add.c b/builtin/add.c
index dd18e5c9b6..4f625691b5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -20,6 +20,7 @@
 #include "bulk-checkin.h"
 #include "argv-array.h"
 #include "submodule.h"
+#include "add-interactive.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -185,6 +186,14 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 {
 	int status, i;
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	int use_builtin_add_i =
+		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
+	if (use_builtin_add_i < 0)
+		git_config_get_bool("add.interactive.usebuiltin",
+				    &use_builtin_add_i);
+
+	if (use_builtin_add_i == 1 && !patch_mode)
+		return !!run_add_i(the_repository, pathspec);
 
 	argv_array_push(&argv, "add--interactive");
 	if (patch_mode)
@@ -319,6 +328,7 @@ static int add_config(const char *var, const char *value, void *cb)
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
+
 	return git_default_config(var, value, cb);
 }
 
diff --git a/t/README b/t/README
index 9747971d58..28999cebd3 100644
--- a/t/README
+++ b/t/README
@@ -397,6 +397,10 @@ GIT_TEST_STASH_USE_BUILTIN=<boolean>, when false, disables the
 built-in version of git-stash. See 'stash.useBuiltin' in
 git-config(1).
 
+GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
+builtin version of git add -i. See 'add.interactive.useBuiltin' in
+git-config(1).
+
 GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
 of the index for the whole test suite by bypassing the default number of
 cache entries and thread minimums. Setting this to 1 will make the
-- 
gitgitgadget

