Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C891FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 15:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936558AbdJQPj0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 11:39:26 -0400
Received: from mout.web.de ([212.227.15.3]:61553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936454AbdJQPjU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 11:39:20 -0400
Received: from [192.168.178.36] ([91.20.51.19]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lk8fS-1dX5De0RXW-00c7Dq; Tue, 17
 Oct 2017 17:39:12 +0200
Subject: [PATCH 2/2] ls-remote: use PARSE_OPT_NO_INTERNAL_HELP
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f66f3fc2-8f51-03f5-c242-cb6d776af585@web.de>
Date:   Tue, 17 Oct 2017 17:39:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:CKdfeSVrXVxUb40siWLz4qTcJDRRXgE0M/bA1pU/z6NdAGb76ld
 u/Di9vrU52HqaLZYpZGRKGHgAY3c+B2WFmS1nv7yr6p2KIfhYHcxw31ixWH/KBIRwOVAOI9
 47U7HhdIx2AbmCUAjvpthCRnhNmu401Vu2DveWQa2VCd9Dh7tmkki+oD0yM2iGDrGKdbFEq
 wIFSTDzcGWbPILE5b5GHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m1dOdOmJR5g=:ObogVY39BuKNqgcRuqfTrN
 HapT5F6O8KOEW+I03sZZiv1/RABvKJ1KbE01uTKW6U51jMtCAZv+6yOxpHx7ZLaiB4QCrftqW
 YA3gt1GNDUikpDllsPbpY5eTDN9dgywjA562hoIDMjDg/ypA43wbeP629Bo9Y33z9ry+jiarS
 Qy6QQjBkQpKuDny/PiOzjzL6KPnWCZ9NvGGjJsealwAVKsVO9znVCpTE+/ZoZ3L6Of6mjX4tt
 gM23zZ1sZv3Piv7HvD86vPBd6oXBuglzGmvxs7FRAS04L8kpBH75FFDM4QLnitctb8wKxX1o7
 8Dnsx5esrctEcu+jOMSizh1jyF6KMv6J+hTlnZJAo/nyq77J4Bv1vxLdSHfKY1oidi0yC7bqy
 HejfPZTdVateTvJIi0gzompktj1ei5zoCaYqtkknRjMh58xPwRz32MGQAoK+wc+/taILBfVhm
 UvFYaq0ladoJs7kihzgkR1v7xetkzQhWqi48rI5DvCEUdnwWpNuUydg+rcBLX8ccXSzu0qGIj
 6tFzLzPSJ/+9ANuZ5VkhnxYImA95LFCJ+fHTdpwtk6dGDKvYaKe5ZLSiZMmFqHSAbrFpg1kE2
 Dv2Y1ZHquwuYS4WJoi8sRJPD0J/h1LXvgbZWxtO3POeXIABPg+7J6z3lbhoUq0+NqyAX+kXax
 h+hQagPZJGPXXklqN4Qe9o0iuK8fo/mMwXEz0/Hmst+xgVcIuJHBeVUxMtJeXuU4KMRjDPduS
 d4D/gGtpRsk57YfeSn5/zRB+D9DDSvLV765XQ5DuipS41NuQugv4z9uYqek+AyV4BmtVjsV3L
 Cm8au2y6P42aOJWTthwui3G21zgzrWkUl6pikn2ZzAekvzSXUU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since ba5f28bf79 (ls-remote: use parse-options api) git ls-remote -h
without any other options has shown the short help text of the command
instead of acting as the short equivalent of --heads.  Fix this
regression by turning off internal handling of -h for repository setup,
and option parsing, as well as the corresponding test in t0012.

Reported-by: Thomas Rikl <trikl@online.de>
Analyzed-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/ls-remote.c  | 1 +
 git.c                | 2 +-
 t/t0012-help.sh      | 1 +
 t/t5512-ls-remote.sh | 6 ++++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index c4be98ab9e..5f27d252b4 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -68,6 +68,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
+			     PARSE_OPT_NO_INTERNAL_HELP |
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest = argv[0];
 
diff --git a/git.c b/git.c
index 9d1b8c4716..056a123506 100644
--- a/git.c
+++ b/git.c
@@ -421,7 +421,7 @@ static struct cmd_struct commands[] = {
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
-	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
+	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY | NO_INTERNAL_HELP },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 	{ "mailsplit", cmd_mailsplit },
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 74eeead168..05d8cf9b49 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -54,6 +54,7 @@ test_expect_success 'generate builtin list' '
 '
 
 cat >no_internal_help <<EOF
+ls-remote
 EOF
 
 test_expect_success 'generate builtin list with internal help' '
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 02106c9226..637e9a87f3 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -264,4 +264,10 @@ test_expect_success 'ls-remote works outside repository' '
 	nongit git ls-remote dst.git
 '
 
+test_expect_success 'ls-remote -h == ls-remote --heads' '
+	git ls-remote -h >short &&
+	git ls-remote --heads >long &&
+	test_cmp long short
+'
+
 test_done
-- 
2.14.2
