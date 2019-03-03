Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C743020248
	for <e@80x24.org>; Sun,  3 Mar 2019 14:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfCCO4o (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 09:56:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:34939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfCCO4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 09:56:44 -0500
Received: from [10.49.202.116] ([95.208.58.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MK3bN-1h1Ht62qY9-001Re3; Sun, 03
 Mar 2019 15:56:33 +0100
Date:   Sun, 3 Mar 2019 15:56:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
In-Reply-To: <xmqq8sxw69d5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903031551540.45@tvgsbejvaqbjf.bet>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com> <20180814223246.GA2379@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1902081024550.41@tvgsbejvaqbjf.bet>
 <20190208195459.GA32556@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903011557430.41@tvgsbejvaqbjf.bet> <20190301190042.GF30847@sigill.intra.peff.net> <xmqq8sxw69d5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1mfLtpqgHA9EUFhwL6vCGzH9rqtZ9KCk4XsZ/rOyz0VAOmTWD+J
 TKq/TX25KwqVV8NgEHxqM90woaYRIoVxqqkZYRPmi8l7neJ7M9e/lKbDKHD93mWZICE9drV
 Egn/ioTXQHzK/oPSdIMqGAjrf257NyPBX4Y2bjIRaD6BvVZMfzKvww2wJ0Hq39k2s6BGgCJ
 AzuYEh6LpllsE6Lp4RAVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BiQWNjwWtHQ=:l2SxzGZz8zIiWaxw1gAI5s
 7s+AAkIzOvBUg7fvhtms6u597sie0APuOKRHbj8xOG9ThAkOVAqAm8AU0UiDpxqS8rFT7S/4r
 epuLy6Y62hbd0kqBasfnlGm7kSXbN0tiwhqt3IGdJz/fe8p4J7o5pIIeyPr6w58bgPdO/oVEt
 OZYcZq3NNwvN7ZJDyTEozaBClPFQwf/7oOtS4xXvfnZtVfrRBRgU+6xaqUY/uMps41bJfG30t
 3Y+Ylh5yShNtv6F3tMfLXsuiYIETaIG9B4G+s2AAXGwQ5fhAZMWCniEj6IxVwsNqdzML9PL++
 DZQz9Sw4tNdPk0TgTz4aR8/w76eNfX6S3WbTjHm0oDrVEkY+Yew1Oq2EkX8xA/hFvnJNUUuBr
 cyaWLpsmnRLLZiHmFVwVYfBWExIuOFhDcQ5/7cb9YnMLzQOlzoacUXV6NnKdoGkbgZVkoRwCV
 e01RHtflpQbUuo6uTZP2++n7NcWYk/CIuB0ysRlH2a0/rPngLE6iV4W4sdcKdOdJQEAUBGXly
 gxshipZpstjyuarXLROELrJyn+3Vy90h1myGggA2T50EyT5FDEsaMvXTNo56G/S/WAnTcLpG6
 FynzorGB+whJoytdGikzTRrnkvZUm2IBOuaA84Ec8x766cCX8nu6iq5cBy2IhvaJqEzWaM+7R
 nWDDE9bWk24vob/dJKrEkdDv11S7wpVXQrd52IBSVD+0OwqSo/h0aZYT4FjwtROWX36nxzH+h
 15QeJJwaserdVH7SKqnVJcYnktQzbtWRjAg3P04EC8waoFrVl7tIImgs1I+TnbE8YgnXzftVG
 Q4dbX7KzFKVWEL8XUvlvLzLIeVUMFNYYQ7uQD+4aTkuJxCtcXUMxy7AuZmsWrWwluZ8inF8TL
 8gIV+TArf5k5QZHxXXp5u38c4rNOW5Hv8JVoJmRveLRm98sOYUY4Im5IeYxuE+qG9iiy05M7f
 ols1oForG+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 3 Mar 2019, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But for git-fetch, our primary purpose is receiving data and writing it
> > to disk. We should be checking all of our write()s already, and SIGPIPE
> > is just confusing.
> 
> Yup, sounds like a very sensible argument.
> 
> > So I'd actually be fine with just declaring that certain commands (like
> > fetch) just ignore SIGPIPE entirely.
> 
> Me too (to me, "actually be fine with" would mean "that's a larger
> hammer alternative, which is OK, while the base solution is fine,
> too").

So do I understand that you'd like something like this?

-- snipsnap --
t a/git.c b/git.c
index 2f604a41ea..c4122cc699 100644
--- a/git.c
+++ b/git.c
@@ -4,6 +4,7 @@
 #include "help.h"
 #include "run-command.h"
 #include "alias.h"
+#include "sigchain.h"
 
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
@@ -16,6 +17,7 @@
 #define SUPPORT_SUPER_PREFIX	(1<<4)
 #define DELAY_PAGER_CONFIG	(1<<5)
 #define NO_PARSEOPT		(1<<6) /* parse-options is not used */
+#define IGNORE_SIGPIPE		(1<<7)
 
 struct cmd_struct {
 	const char *cmd;
@@ -388,6 +390,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	prefix = NULL;
 	help = argc == 2 && !strcmp(argv[1], "-h");
 	if (!help) {
+		if (p->option & IGNORE_SIGPIPE)
+			sigchain_push(SIGPIPE, SIG_IGN);
 		if (p->option & RUN_SETUP)
 			prefix = setup_git_directory();
 		else if (p->option & RUN_SETUP_GENTLY) {
@@ -477,7 +481,7 @@ static struct cmd_struct commands[] = {
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
-	{ "fetch", cmd_fetch, RUN_SETUP },
+	{ "fetch", cmd_fetch, RUN_SETUP | IGNORE_SIGPIPE },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },

