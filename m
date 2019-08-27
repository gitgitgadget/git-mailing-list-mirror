Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 514F11F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 12:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfH0M55 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:57:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51066 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfH0M55 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:57:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so3002741wml.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EFvS5Gi28L2eRTcVRAJTam+GnToN6Ad2o0dwQ+Wr1D8=;
        b=SW/nCPrBKo1+FjvJGXmd9SnHgQBfFI2YAiSW+gje4RYdG5gif9VBbWqc3oNx8lmPok
         VKdzHgTSRnwII7gQ/hmOFP5Ya9CCoJIO5JCNJhIY/eBdtDitLTYGPx0+vzNakJxN6Zw2
         H+8bqqji5uz2QavvPJVd6Ug5uAHWoe2qaE6NDKxohL+FB20qv8jm6YJtcIwJ8ICUfilJ
         QQfCe0mP2RvIjq3pSdk6TF9AEzPY2Y+6DRfNlTjIJqIv+pQJtyN2Hzy2bnteC5jqG94r
         3f6bjQk8LK08g8UWefyEmn1uG2RTKOZvYvJAvGWYpDNMP63EIafeBXtHoTM+tnuSKLcL
         m/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EFvS5Gi28L2eRTcVRAJTam+GnToN6Ad2o0dwQ+Wr1D8=;
        b=uO419Add7fDxx75EZn+XeMFsU2qij5puaDVTTxIwHCF9NGKOqba5Ok/5lNApSCI0y3
         RmmtKx8BxP28On5JKkdQ2jeIItISX+n1grQjtFd87wAo5/gsVD2Ib2JnOVdnEERCT3WC
         2/5wy5Acy6l+1ViKs8aYuUfCccag/qkIreHRSq24tptcQ4OmtGgY/BDynM7OlU2Nn5KD
         thoHHsdJgER4dBc7PisY1lWHCE9Dr4DSDUIv9KKZeP3ujlMOF9asHQZqdxUookLAs5zT
         AVEijlcdoAA26I9ilPNjIw89iokwxTcidTpJk9j1R5fCAsMUZRfi7vZQM448yisoDxOA
         Y2MQ==
X-Gm-Message-State: APjAAAWqry5ODD2OBAbm1Y61R02VhLlIFs4wqkCpjlNPTzV7+qvJFQXx
        1vsLl8kn8k1YndoMCje20UwS/45fQt0=
X-Google-Smtp-Source: APXvYqyEtA5mmXBZVJvv63whGELcXa4BOGBi/nNrHVTZogS09N9NGtG7dLYnOY+E7KYwsHlD0U3C/g==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr28030602wmg.15.1566910674927;
        Tue, 27 Aug 2019 05:57:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 39sm44504356wrc.45.2019.08.27.05.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:57:54 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:57:54 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:42 GMT
Message-Id: <ad8752eca717218a2bb667273550ac07ce0760d8.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 01/11] Start to implement a built-in version of `git add
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
index f9255344ae..d04daf9fd8 100644
--- a/Makefile
+++ b/Makefile
@@ -826,6 +826,7 @@ LIB_H := $(sort $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null
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
index 60d5b77bcc..bda93fe603 100644
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

