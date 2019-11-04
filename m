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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3A21F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfKDMPf (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51482 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKDMPf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so16395557wme.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 04:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SfmLn9REjipp/wD4CfiKk04OVkxMAOT+kBo/By0k19E=;
        b=lKiXWdy2s0cDh5OBy+Tsk8PyIoNCjGVkwudRzYXnXLYd9K2wDl2TL6q0Xp5Tlp1jQv
         DsBzVrsNghI9ny6nxyfCdZwCPr0qvmEW4RFX3PTv6rup7cq1drRaCYMp2Xa6JyQveRxi
         fMrwxZddzM0KMSDiGYwQPduzSgW7ED21HdikuJUH2PL5l//gJbHM64iIHX3f+1Wl7TCI
         Zr9MuQuo+L/o0zTU2fKNNcs/nxWXSic0MVeGmsSpsEJMGvK3RCOFtdQ0ktayCVeMiUZ7
         aWfW6PvvYWwltyFWNoshNLMr0tuMz/w11XcHnzTDntHnDPGLVYJ5tfNKw9oPiCK/sIAc
         o1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SfmLn9REjipp/wD4CfiKk04OVkxMAOT+kBo/By0k19E=;
        b=cdG81aUQfrv8otpH4zL4OGv5qi9ODI4WaNfACY00mkUeDGppfWphUQ7WpMvftzzjFa
         gqgzCIihnpvsww1zT6X6iJ14eOIEDZLcPExMXEgBH0OHWMmlTmoilr73Qh6Sx4kW0BQf
         Gv9OnX+/bUbMpUnDOidP4niDgVKrxj9y5yz/U5UKraHgPxXvS5fRGkAqHP1wC2ug0rCQ
         x3ef1DlPa+5T/kJl6xIVjdZ4Tdk4LR9omg2QTsANaI22GQaJrxeFJ4ii1kURUfcX4KEM
         Z9tgQ1Q9fvn2IlTC/vj87FEfTs4dTIeK/j5cAuNSqpq2UStp/GSgJRiWpPadyOPgczQG
         hYnA==
X-Gm-Message-State: APjAAAWYnrItMa7hmsO2z+4MTIbOMFqOWv3oSXGAKRbHjjMFAwlEUU0z
        LZyp/AkJuz4XhJLcskSrpBtIrsj6
X-Google-Smtp-Source: APXvYqyEZQDGGy09wgThlGQ3lRutCQ4wr6asQ3ZJc6whoiqqWlzs7My0joGAz6CDRlgI8Czu7CK2IQ==
X-Received: by 2002:a1c:410a:: with SMTP id o10mr22665679wma.117.1572869732571;
        Mon, 04 Nov 2019 04:15:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm6671690wrq.72.2019.11.04.04.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:15:32 -0800 (PST)
Message-Id: <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 12:15:21 +0000
Subject: [PATCH v5 1/9] Start to implement a built-in version of `git add
 --interactive`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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

