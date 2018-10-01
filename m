Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F6C1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 19:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeJBCA0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 22:00:26 -0400
Received: from mout.web.de ([212.227.17.12]:33545 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeJBCA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 22:00:26 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GN8-1g0z7R1JrK-00Cerj; Mon, 01
 Oct 2018 21:15:59 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GN8-1g0z7R1JrK-00Cerj; Mon, 01
 Oct 2018 21:15:59 +0200
Subject: Re: [PATCH] grep: provide a noop --recursive option
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Christoph Berg <myon@debian.org>,
        Duy Nguyen <pclouds@gmail.com>
References: <20180929140132.GA31238@msg.df7cb.de>
 <20180929145527.23444-1-avarab@gmail.com>
 <xmqq8t3k9qjs.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ffc574a9-cf78-2dd5-084a-a6005547d363@web.de>
Date:   Mon, 1 Oct 2018 21:15:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq8t3k9qjs.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VQ04ixzkS3CaltVsNy/YtMJKDDjSxK3/kO+PP1PEw7Z1O1AhXpF
 oOHOzk9kvovVRHVFbqvBQhN4YRORrwSHLz/u9DPBPhQSHRy9dK20MY7ell3VgniL5BgJlZ1
 clQwAt9/Lbr3SuMTWRm6v0UaqDmsGUJuSheEJH2ZqJQHVJAtLQdXlWFuBG8IHgHhTf8+TdS
 tagIWLab58AtxN874ek2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pj9AzS5d2m8=:Opzm8+9fegS28prHFGnM2E
 y0ezF8Ayn+J9NdzWsLwTEO/nn8xIhhMcukIFgsw1aaSkiKs8fNqRFX0QBMl3oaKr5QviSut3P
 R8SiERD97PtAkDjhkynlR2i46Fh1jxuP8Qm8+jY0WLw+ysn9xkWfYlhiTY5AE+5ZTL1J2Rois
 jvBCv56jIAkb4Q5tqHCu2Uh59XyVR9Xkiz0MppKXp6y8UwPp2bru19Z2KYluj+Tn2WKAwXWbM
 TbYi12CKxeVWUlsPMyccACGkA4lRvhHL5VZ10HsFQiZSc+QEMYVJfCO7lpM4K7F2B0ZspEY68
 6m8pOgxDK+aQyO4lzUJIyVPOMCH6+FMsA+6xo2q2ZtkowNxKx57rvX9i2Zyc9zzecBeJAPgsn
 ze6VvcZwo8M2A8UNjY77TrpvPM43kNbotJXb40uPVfKnsWH0TW25t4BSJnXN4VcwadoQplilF
 3Eeq+soBWaXB2XLscVf2AZ7qffTQqso5MdqSY2DfTqE9vwNM3KT16BoFuXXYf5gNh2u6m5xc6
 Fkb4RAJUATE08GgVBKZMGAO1Lio7hWmbHCm2/MR31XTJ4I0LTjnVfmQI+Ap/1mso0j2T5iRlo
 EryYwvi0keoAqLiF3IOjxrVk4xErj7FYanURCcyJBeenS/j2tKMmfCFvBbhylH/R+OzH2RuWx
 CiES76AQ1HmJo99rzigic36X7WP0Q7lJfGxsM6LR5zUcgK6Dr7oul7DY1qQYNOqwpZnmQKb5W
 yGS3rAx/Uvz8lxK5xMDH+CWyS+N3SL7OHkLYL6cZtthzvdfoCMEhz0K2Bk/Ei48YstpTCbTBg
 xLtc9ulgxnNMzPPBAOxS21BebAg6bs1FCUedNAh1eMYXuuxSw4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.09.2018 um 19:11 schrieb Junio C Hamano:
> I however do not mind if we added "--recursive" with matching
> "--no-recursive", and
> 
>  - made "--recursive" the default (obviously)
> 
>  - made "--no-recursive" a synonym to setting the recursion limit
>    to "never recurse"
> 
>  - and made "--recursive" a synonym to setting the recursion limit
>    to "infinity".
> 
> That would be more work than this patch.  But if I see "--recursive"
> advertised as a feature, and the command by default goes recursive,
> I do expect to be able to tell it not to recurse.

-- >8 --
Subject: [PATCH] grep: add -r/--[no-]recursive

Recognize -r and --recursive as synonyms for --max-depth=-1 for
compatibility with GNU grep; it's still the default for git grep.

This also adds --no-recursive as synonym for --max-depth=0 for free,
which is welcome for completeness and consistency.

Fix the description for --max-depth, while we're at it -- negative
values other than -1 actually disable recursion, i.e. they are
equivalent to --max-depth=0.

Requested-by: Christoph Berg <myon@debian.org>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Initial-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/git-grep.txt | 11 +++++++++--
 builtin/grep.c             |  2 ++
 t/t7810-grep.sh            | 12 ++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a3049af1a3..84fe236a8e 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
 	   [ -o | --only-matching ] [-c | --count] [--all-match] [-q | --quiet]
-	   [--max-depth <depth>]
+	   [--max-depth <depth>] [--[no-]recursive]
 	   [--color[=<when>] | --no-color]
 	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
@@ -119,11 +119,18 @@ OPTIONS
 
 --max-depth <depth>::
 	For each <pathspec> given on command line, descend at most <depth>
-	levels of directories. A negative value means no limit.
+	levels of directories. A value of -1 means no limit.
 	This option is ignored if <pathspec> contains active wildcards.
 	In other words if "a*" matches a directory named "a*",
 	"*" is matched literally so --max-depth is still effective.
 
+-r::
+--recursive::
+	Same as `--max-depth=-1`; this is the default.
+
+--no-recursive::
+	Same as `--max-depth=0`.
+
 -w::
 --word-regexp::
 	Match the pattern only at word boundary (either begin at the
diff --git a/builtin/grep.c b/builtin/grep.c
index 601f801158..f6e127f0bc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -811,6 +811,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			GREP_BINARY_NOMATCH),
 		OPT_BOOL(0, "textconv", &opt.allow_textconv,
 			 N_("process binary files with textconv filters")),
+		OPT_SET_INT('r', "recursive", &opt.max_depth,
+			    N_("search in subdirectories (default)"), -1),
 		{ OPTION_INTEGER, 0, "max-depth", &opt.max_depth, N_("depth"),
 			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
 			NULL, 1 },
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index be5c1bd553..43aa4161cf 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -309,6 +309,8 @@ do
 			echo ${HC}v:1:vvv
 		} >expected &&
 		git grep --max-depth -1 -n -e vvv $H >actual &&
+		test_cmp expected actual &&
+		git grep --recursive -n -e vvv $H >actual &&
 		test_cmp expected actual
 	'
 
@@ -317,6 +319,8 @@ do
 			echo ${HC}v:1:vvv
 		} >expected &&
 		git grep --max-depth 0 -n -e vvv $H >actual &&
+		test_cmp expected actual &&
+		git grep --no-recursive -n -e vvv $H >actual &&
 		test_cmp expected actual
 	'
 
@@ -327,6 +331,8 @@ do
 			echo ${HC}v:1:vvv
 		} >expected &&
 		git grep --max-depth 0 -n -e vvv $H -- "*" >actual &&
+		test_cmp expected actual &&
+		git grep --no-recursive -n -e vvv $H -- "*" >actual &&
 		test_cmp expected actual
 	'
 
@@ -344,6 +350,8 @@ do
 			echo ${HC}t/v:1:vvv
 		} >expected &&
 		git grep --max-depth 0 -n -e vvv $H -- t >actual &&
+		test_cmp expected actual &&
+		git grep --no-recursive -n -e vvv $H -- t >actual &&
 		test_cmp expected actual
 	'
 
@@ -353,6 +361,8 @@ do
 			echo ${HC}v:1:vvv
 		} >expected &&
 		git grep --max-depth 0 -n -e vvv $H -- . t >actual &&
+		test_cmp expected actual &&
+		git grep --no-recursive -n -e vvv $H -- . t >actual &&
 		test_cmp expected actual
 	'
 
@@ -362,6 +372,8 @@ do
 			echo ${HC}v:1:vvv
 		} >expected &&
 		git grep --max-depth 0 -n -e vvv $H -- t . >actual &&
+		test_cmp expected actual &&
+		git grep --no-recursive -n -e vvv $H -- t . >actual &&
 		test_cmp expected actual
 	'
 	test_expect_success "grep $L with grep.extendedRegexp=false" '
-- 
2.19.0

