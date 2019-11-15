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
	by dcvr.yhbt.net (Postfix) with ESMTP id 709CC1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKOLL0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35016 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKOLL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id 8so9960391wmo.0
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 03:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u4xhHpMt7Wy2U1g1Q9DVtKrQQ8XntFr/yGlpj5Tcd4w=;
        b=a/QMkhErPJ9J8sAqh8amPBWOQeDDbQGVojPRdvAppibtnADdc0n6Z1bjGzh7D2+IBR
         URfNuPsHaM+Qbl8zVuA41yT5Nsm0DDziSoDeRms+e1dfUkResv9ONIaXCG158Buica9K
         ek/yAJqDzI2esdB4zB2hatfYLhvPDbZ7vnpSMWMaO8eCprlozqCMMsKEw/k7R9rmp8xN
         tw5KMR/ZzypgxLltW0oaAS7alkHfrTqwdB1eGNvyG/UPt+YdcFujLqlXe/ikhx/wrNrI
         hNrGQ/luEDfweqAEQEzyfPsDKb2fLYfVZy0pmszjhL9BoVPE+Mf/qxO7ZrU1gSttqrhn
         /4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u4xhHpMt7Wy2U1g1Q9DVtKrQQ8XntFr/yGlpj5Tcd4w=;
        b=pmOWhLR6w16/s5OT7BJcpt6woYhpklCA1QbRDPwMuTPuYAoPcTmU+WUDz4OeyxFutN
         L3zyFwHSI7nycH6uNR9y/AVT3Cb1hV8S1iumTIlTxv7gyMUQLD6rgSm8kA4pL6Ml/V4P
         hmo2CQgXAq8LnKZaDQ8CIEmSozzyinMazld1TarfC4QVGVIMgjqmpqaKSdDNzjlmM8OQ
         w+9roQrq3JA9QbjVh3VLAdA+fFnK+jNlGxU/AwFi5s2nbKxyj8xVM5WdDx/3vZLt3nks
         EA0ZABdiS+YekKgKDjfDNpuAYjecPeN/ZxZ4bL3IpUkBTCGwrTlTv+FHE3opykxU/6yO
         CdpQ==
X-Gm-Message-State: APjAAAUMFpj/sF77BBHVFDLmMgQEHzy0FWH99UUT56V4JSuXepVzNAFk
        U/4OhTHhWMwCA8pDzHOVmisK6L4I
X-Google-Smtp-Source: APXvYqyCtaTIwlwib5Qkomhpcq8gVvHWaC++pHIkvdoKNYOX9UlHrd9TFCed7KGFPyc/e5f9+UYEnA==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr13526353wmj.20.1573816282832;
        Fri, 15 Nov 2019 03:11:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5sm10499367wrv.56.2019.11.15.03.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:11:22 -0800 (PST)
Message-Id: <5d9962d4344fa182b37cd8d969da01bc603414be.1573816280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
References: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 11:11:12 +0000
Subject: [PATCH v7 1/9] Start to implement a built-in version of `git add
 --interactive`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Jeff Hostetler <git@jeffhostetler.com>, Jeff King" <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Unlike previous conversions to C, where we started with a built-in
helper, we start this conversion by adding an interception in the
`run_add_interactive()` function when the new opt-in
`add.interactive.useBuiltin` config knob is turned on (or the
corresponding environment variable `GIT_TEST_ADD_I_USE_BUILTIN`), and
calling the new internal API function `run_add_i()` that is implemented
directly in libgit.a.

At this point, the built-in version of `git add -i` only states that it
cannot do anything yet. In subsequent patches/patch series, the
`run_add_i()` function will gain more and more functionality, until it
is feature complete. The whole arc of the conversion can be found in the
PRs #170-175 at https://github.com/gitgitgadget/git.

The "--helper approach" can unfortunately not be used here: on Windows
we face the very specific problem that a `system()` call in
Perl seems to close `stdin` in the parent process when the spawned
process consumes even one character from `stdin`. Which prevents us from
implementing the main loop in C and still trying to hand off to the Perl
script.

The very real downside of the approach we have to take here is that the
test suite won't pass with `GIT_TEST_ADD_I_USE_BUILTIN=true` until the
conversion is complete (the `--helper` approach would have let it pass,
even at each of the incremental conversion steps).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/add.txt |  5 +++++
 Makefile                     |  1 +
 add-interactive.c            |  7 +++++++
 add-interactive.h            |  8 ++++++++
 builtin/add.c                | 12 ++++++++++++
 t/README                     |  4 ++++
 6 files changed, 37 insertions(+)
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
index 58b92af54b..6c4a1e0ee5 100644
--- a/Makefile
+++ b/Makefile
@@ -823,6 +823,7 @@ LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentat
 	-name '*.h' -print)))
 
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
index dd18e5c9b6..d4686d5218 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -20,6 +20,7 @@
 #include "bulk-checkin.h"
 #include "argv-array.h"
 #include "submodule.h"
+#include "add-interactive.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -185,6 +186,16 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 {
 	int status, i;
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	int use_builtin_add_i =
+		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
+
+	if (!patch_mode) {
+		if (use_builtin_add_i < 0)
+			git_config_get_bool("add.interactive.usebuiltin",
+					    &use_builtin_add_i);
+		if (use_builtin_add_i == 1)
+			return !!run_add_i(the_repository, pathspec);
+	}
 
 	argv_array_push(&argv, "add--interactive");
 	if (patch_mode)
@@ -319,6 +330,7 @@ static int add_config(const char *var, const char *value, void *cb)
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
+
 	return git_default_config(var, value, cb);
 }
 
diff --git a/t/README b/t/README
index 60d5b77bcc..5132ec83f8 100644
--- a/t/README
+++ b/t/README
@@ -397,6 +397,10 @@ GIT_TEST_STASH_USE_BUILTIN=<boolean>, when false, disables the
 built-in version of git-stash. See 'stash.useBuiltin' in
 git-config(1).
 
+GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
+built-in version of git add -i. See 'add.interactive.useBuiltin' in
+git-config(1).
+
 GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
 of the index for the whole test suite by bypassing the default number of
 cache entries and thread minimums. Setting this to 1 will make the
-- 
gitgitgadget

