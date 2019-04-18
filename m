Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E79F20248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbfDRNQ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:16:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44345 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389008AbfDRNQz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:16:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id i13so1750053edf.11
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dQQIqMCqFqB9pCzCDY8X8PKZUN6YUHlx5gB/oimRTNo=;
        b=rrt5bj6aDpve9PJun0U/sXb+YfzYUcI91cO7BwXo57dr8sUocqy1XMHy1kTxY5cpAL
         XGbCE/qcWprysNXJLxL7LsEIKIPcU/+g72qqgTlKfIUBb3zX2FmmedXRsPbymXjaDWBY
         O2t4ft+XyKSr7XfynX/vH2gn7Hepq+0A2tQpXK2r0DDpXIln9WbXj0QSL//wUpCIA5/m
         63eQMv7MH6DFNEUlf0pHmvbPNFNd/1b+Tu2G+LZ5nDDlZnlnrUbtw6i/Cc8UD0wWwTHr
         wICe/QfXoTq0DK79/NM7Jt0Zw2Y3Kez5j2+uOOeQYYrYpUXbUI/XlRuaGPynVOD4mJxi
         4r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dQQIqMCqFqB9pCzCDY8X8PKZUN6YUHlx5gB/oimRTNo=;
        b=Io16Hq9iz2tCRNOWq11t4mloVz8bzCd4y9wg7ygmvG4Vk1aNPYshkwoJ8GYzw+7X1N
         FrNeocXJsSxkMbRt64yiEJ8yHsHsiu6weNsYHph6OeV1H143eOSbxzN9DlrnQajXeS5M
         YW6QZmYD6T9ziab7dSa5JD+57RsYxoLGD2w1ChNO2s1FHVkxLaFcKgYiXjVXiB+X1sjM
         NWLprt1ZxFpaDJxr1orb7BYnhII9LKpbzITzPpgBYgistcx7IRnQY+i6RWqMtG4lSLar
         8KCKK95jJCVO+vgp87SqPzA/JxykoE1pLfeXF3Vj1neuVnzZYxGCuSR/0V1ngN3ypze5
         MeeQ==
X-Gm-Message-State: APjAAAXOmf0kl+QXXDUJR2OReWd9ug5qbPnCh6ZC9l26s2BakwLoJaKN
        bq5ts/1YNe+XvhHt4Pj+fRX6AcTD
X-Google-Smtp-Source: APXvYqxcTM7tZoHhtmnXTDO3ZReICXzYxmXeGuGXnz3LLlZra+2G9Tm7r6w+eOusLbBs6G6njoAo+Q==
X-Received: by 2002:a17:906:1545:: with SMTP id c5mr52579852ejd.135.1555593412090;
        Thu, 18 Apr 2019 06:16:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm514449eda.26.2019.04.18.06.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:16:51 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:16:51 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Apr 2019 13:16:36 GMT
Message-Id: <88a5ab23324d8dab58803b291ff6d7a03dc7a74e.1555593396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.v2.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
        <pull.168.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 8/8] Turn `git serve` into a test helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git serve` built-in was introduced in ed10cb952d31 (serve:
introduce git-serve, 2018-03-15) as a backend to serve Git protocol v2,
probably originally intended to be spawned by `git upload-pack`.

However, in the version that the protocol v2 patches made it into core
Git, `git upload-pack` calls the `serve()` function directly instead of
spawning `git serve`; The only reason in life for `git serve` to survive
as a built-in command is to provide a way to test the protocol v2
functionality.

Meaning that it does not even have to be a built-in that is installed
with end-user facing Git installations, but it can be a test helper
instead.

Let's make it so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                                    |  2 +-
 builtin.h                                   |  1 -
 git.c                                       |  1 -
 builtin/serve.c => t/helper/test-serve-v2.c |  7 +++--
 t/helper/test-tool.c                        |  1 +
 t/helper/test-tool.h                        |  1 +
 t/t5701-git-serve.sh                        | 32 ++++++++++++---------
 t/t5702-protocol-v2.sh                      |  5 ++--
 t/t5703-upload-pack-ref-in-want.sh          | 16 +++++------
 9 files changed, 36 insertions(+), 30 deletions(-)
 rename builtin/serve.c => t/helper/test-serve-v2.c (81%)

diff --git a/Makefile b/Makefile
index f5fc977ee8..9ce62fa295 100644
--- a/Makefile
+++ b/Makefile
@@ -758,6 +758,7 @@ TEST_BUILTINS_OBJS += test-repository.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
+TEST_BUILTINS_OBJS += test-serve-v2.o
 TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha256.o
@@ -1127,7 +1128,6 @@ BUILTIN_OBJS += builtin/rev-parse.o
 BUILTIN_OBJS += builtin/revert.o
 BUILTIN_OBJS += builtin/rm.o
 BUILTIN_OBJS += builtin/send-pack.o
-BUILTIN_OBJS += builtin/serve.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
diff --git a/builtin.h b/builtin.h
index 6538932e99..c48636e244 100644
--- a/builtin.h
+++ b/builtin.h
@@ -219,7 +219,6 @@ extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
-extern int cmd_serve(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 2dd588674f..c58b067771 100644
--- a/git.c
+++ b/git.c
@@ -548,7 +548,6 @@ static struct cmd_struct commands[] = {
 	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 	{ "rm", cmd_rm, RUN_SETUP },
 	{ "send-pack", cmd_send_pack, RUN_SETUP },
-	{ "serve", cmd_serve, RUN_SETUP },
 	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
diff --git a/builtin/serve.c b/t/helper/test-serve-v2.c
similarity index 81%
rename from builtin/serve.c
rename to t/helper/test-serve-v2.c
index d3fd240bb3..aee35e5aef 100644
--- a/builtin/serve.c
+++ b/t/helper/test-serve-v2.c
@@ -1,14 +1,14 @@
+#include "test-tool.h"
 #include "cache.h"
-#include "builtin.h"
 #include "parse-options.h"
 #include "serve.h"
 
 static char const * const serve_usage[] = {
-	N_("git serve [<options>]"),
+	N_("test-tool serve-v2 [<options>]"),
 	NULL
 };
 
-int cmd_serve(int argc, const char **argv, const char *prefix)
+int cmd__serve_v2(int argc, const char **argv)
 {
 	struct serve_options opts = SERVE_OPTIONS_INIT;
 
@@ -19,6 +19,7 @@ int cmd_serve(int argc, const char **argv, const char *prefix)
 			 N_("exit immediately after advertising capabilities")),
 		OPT_END()
 	};
+	const char *prefix = setup_git_directory();
 
 	/* ignore all unknown cmdline switches for now */
 	argc = parse_options(argc, argv, prefix, options, serve_usage,
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 2b21943f93..4bf3666b43 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -48,6 +48,7 @@ static struct test_cmd cmds[] = {
 	{ "revision-walking", cmd__revision_walking },
 	{ "run-command", cmd__run_command },
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
+	{ "serve-v2", cmd__serve_v2 },
 	{ "sha1", cmd__sha1 },
 	{ "sha1-array", cmd__sha1_array },
 	{ "sha256", cmd__sha256 },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 25abed1cf2..bc72370916 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -39,6 +39,7 @@ int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
 int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
+int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index fe45bf828d..ffb9613885 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test git-serve and server commands'
+test_description='test protocol v2 server commands'
 
 . ./test-lib.sh
 
@@ -14,7 +14,8 @@ test_expect_success 'test capability advertisement' '
 	0000
 	EOF
 
-	GIT_TEST_SIDEBAND_ALL=0 git serve --advertise-capabilities >out &&
+	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
+		--advertise-capabilities >out &&
 	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
@@ -24,11 +25,11 @@ test_expect_success 'stateless-rpc flag does not list capabilities' '
 	test-tool pkt-line pack >in <<-EOF &&
 	0000
 	EOF
-	git serve --stateless-rpc >out <in &&
+	test-tool serve-v2 --stateless-rpc >out <in &&
 	test_must_be_empty out &&
 
 	# EOF
-	git serve --stateless-rpc >out &&
+	test-tool serve-v2 --stateless-rpc >out &&
 	test_must_be_empty out
 '
 
@@ -37,7 +38,7 @@ test_expect_success 'request invalid capability' '
 	foobar
 	0000
 	EOF
-	test_must_fail git serve --stateless-rpc 2>err <in &&
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
 	test_i18ngrep "unknown capability" err
 '
 
@@ -46,7 +47,7 @@ test_expect_success 'request with no command' '
 	agent=git/test
 	0000
 	EOF
-	test_must_fail git serve --stateless-rpc 2>err <in &&
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
 	test_i18ngrep "no command requested" err
 '
 
@@ -56,7 +57,7 @@ test_expect_success 'request invalid command' '
 	agent=git/test
 	0000
 	EOF
-	test_must_fail git serve --stateless-rpc 2>err <in &&
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
 	test_i18ngrep "invalid command" err
 '
 
@@ -87,7 +88,7 @@ test_expect_success 'basics of ls-refs' '
 	0000
 	EOF
 
-	git serve --stateless-rpc <in >out &&
+	test-tool serve-v2 --stateless-rpc <in >out &&
 	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
@@ -107,7 +108,7 @@ test_expect_success 'basic ref-prefixes' '
 	0000
 	EOF
 
-	git serve --stateless-rpc <in >out &&
+	test-tool serve-v2 --stateless-rpc <in >out &&
 	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
@@ -127,7 +128,7 @@ test_expect_success 'refs/heads prefix' '
 	0000
 	EOF
 
-	git serve --stateless-rpc <in >out &&
+	test-tool serve-v2 --stateless-rpc <in >out &&
 	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
@@ -148,7 +149,7 @@ test_expect_success 'peel parameter' '
 	0000
 	EOF
 
-	git serve --stateless-rpc <in >out &&
+	test-tool serve-v2 --stateless-rpc <in >out &&
 	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
@@ -169,7 +170,7 @@ test_expect_success 'symrefs parameter' '
 	0000
 	EOF
 
-	git serve --stateless-rpc <in >out &&
+	test-tool serve-v2 --stateless-rpc <in >out &&
 	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
@@ -189,7 +190,7 @@ test_expect_success 'sending server-options' '
 	0000
 	EOF
 
-	git serve --stateless-rpc <in >out &&
+	test-tool serve-v2 --stateless-rpc <in >out &&
 	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
@@ -204,7 +205,10 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
 	0000
 	EOF
 
-	test_must_fail git -C server serve --stateless-rpc <in >/dev/null 2>err &&
+	(
+		cd server &&
+		test_must_fail test-tool serve-v2 --stateless-rpc
+	) <in >/dev/null 2>err &&
 	grep "unexpected line: .this-is-not-a-command." err
 '
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index db4ae09f2f..8691bfc52d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -359,12 +359,13 @@ test_expect_success 'even with handcrafted request, filter does not work if not
 	0000
 	EOF
 
-	test_must_fail git -C server serve --stateless-rpc <in >/dev/null 2>err &&
+	test_must_fail test-tool -C server serve-v2 --stateless-rpc \
+		<in >/dev/null 2>err &&
 	grep "unexpected line: .filter blob:none." err &&
 
 	# Exercise to ensure that if advertised, filter works
 	git -C server config uploadpack.allowfilter 1 &&
-	git -C server serve --stateless-rpc <in >/dev/null
+	test-tool -C server serve-v2 --stateless-rpc <in >/dev/null
 '
 
 test_expect_success 'default refspec is used to filter ref when fetchcing' '
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index f87b2f6df3..dd1cbd0dd6 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -48,15 +48,15 @@ test_expect_success 'setup repository' '
 '
 
 test_expect_success 'config controls ref-in-want advertisement' '
-	git serve --advertise-capabilities >out &&
+	test-tool serve-v2 --advertise-capabilities >out &&
 	! grep -a ref-in-want out &&
 
 	git config uploadpack.allowRefInWant false &&
-	git serve --advertise-capabilities >out &&
+	test-tool serve-v2 --advertise-capabilities >out &&
 	! grep -a ref-in-want out &&
 
 	git config uploadpack.allowRefInWant true &&
-	git serve --advertise-capabilities >out &&
+	test-tool serve-v2 --advertise-capabilities >out &&
 	grep -a ref-in-want out
 '
 
@@ -70,7 +70,7 @@ test_expect_success 'invalid want-ref line' '
 	0000
 	EOF
 
-	test_must_fail git serve --stateless-rpc 2>out <in &&
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>out <in &&
 	grep "unknown ref" out
 '
 
@@ -90,7 +90,7 @@ test_expect_success 'basic want-ref' '
 	0000
 	EOF
 
-	git serve --stateless-rpc >out <in &&
+	test-tool serve-v2 --stateless-rpc >out <in &&
 	check_output
 '
 
@@ -112,7 +112,7 @@ test_expect_success 'multiple want-ref lines' '
 	0000
 	EOF
 
-	git serve --stateless-rpc >out <in &&
+	test-tool serve-v2 --stateless-rpc >out <in &&
 	check_output
 '
 
@@ -133,7 +133,7 @@ test_expect_success 'mix want and want-ref' '
 	0000
 	EOF
 
-	git serve --stateless-rpc >out <in &&
+	test-tool serve-v2 --stateless-rpc >out <in &&
 	check_output
 '
 
@@ -153,7 +153,7 @@ test_expect_success 'want-ref with ref we already have commit for' '
 	0000
 	EOF
 
-	git serve --stateless-rpc >out <in &&
+	test-tool serve-v2 --stateless-rpc >out <in &&
 	check_output
 '
 
-- 
gitgitgadget
