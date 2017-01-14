Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED63120798
	for <e@80x24.org>; Sat, 14 Jan 2017 18:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbdANSEx (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 13:04:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:64411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbdANSEw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 13:04:52 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MB2G8-1cKjRi39fg-009x5U; Sat, 14
 Jan 2017 19:04:30 +0100
Date:   Sat, 14 Jan 2017 19:04:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/38] Teach the sequencer to act as rebase -i's
 backend
In-Reply-To: <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701141857270.3469@virtualbox>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de> <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R7rIHbHf4AhJ2FacewLvKdBsllYQ7QSGNMNTk+HOV8GtBNA0U2/
 zlj/LUbEHSZmiX3wEDLBFiUYQZRSf6GXNLGeZRqda5joe8t1I12WTcrA3pNwGhbv4K/gCju
 M2O5Fl1gMLr2xFezGS1Z9nrRQyWbjVGuccs4R46sbt/90iDRm8eubn5mM3+v7VWw0D4tOwS
 AFPHON2pwlZl4DSoF/aVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CjBOSmty+5w=:g0x3u8Q7o33wBXjK7fX+dl
 yB+tIV2KTPO6PFd7Li2f8Dabr3SShKkfTtVWxvddVt8BpTpnnzCNs7ZsQjFQsAAn0oN/bAIku
 SJiwKMxg9Skx84gem0n7vQ+uTtAqOnfskfxrARNZ6QkwMP9i3weqXnsx4KSkV4RpXMMU7mPfw
 kM0ByAsUMaZNN4exyHaQ3kCf+pk7w7AtJ8+jiWoXi24V6qljlc9tmlKDLtvh3fF4uMk2ZPhJ4
 uBF5oytY87NQCq1JYA52oVJq3kVXi0cmm7kD7NJlX6LbrPuiF9el6cbX7YCVK83Vb/uwdbI8q
 V2kyley73ixPswGbH8Pd+e2Bu6UeuOFajaS4C5uGWQy+mh10PcSeN77d/CQWXdExeSUMRKx9W
 t+tMJkaNc/bemaUW6iUuszvUAtHw9QorP488VQJDauZLaqgGaYbqs1leodTuMX4Qukz2pUHJF
 iO2vwLKleuHIkJBDhQEF2puSidwlDDpjwmadz+zeoHq4jf2wlINeFEX3heCEOsvNKAKMsKwhi
 PujSKmLjKjV2DfSB5Ame2iElvFMj7vto4EqWApinS7hx+Shy6d3J54wuF2RkL7Xe3fhWEGjUP
 zQF9JLfY/yeAiQDKssBIup3plsxQEgBlQnIeySB9ife3cDLzKv7nEZzQo2FluqJ7fknUi8QQ9
 ed91cDEeaZPHBN6YOjX4/Vo+myOQ4wJyP47YWjga+o2Y+bPDoLKUOoMbazczr2iOVIpumNywm
 zYR+QexoX6Wy6JjYHIw8puT5G24BA7fYzuzEdEgoOxdkAc1C/4HPZljJg5N7MtzweHPxyMYA+
 /bq2gXd2SfuJNXXmyEbNE0yIsHLVyiE4/AU7BfJCkTDhs3k3S4pwBGJaLWafGkvSsxoCM470S
 79DpbnycjTwKB8t+GTwFBsiBsHED9fFnxVWP/TK1jatPEEJZ7MNP2mNaaoWOC9OlpgTyxj3NA
 I6r9Wx+yqFXeMfVc8UUcxi5X7AvGRgz0e/o1NNE0/TOxu7/eeJw4+z6a6HFnHGzTB7WtDNGqz
 6yC3ekjBaGAk8AuPqSfb0V1q29ab2kYe0fzg7G2YfNaBv4lv0svDyz0Tm8ll7G7dMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Changes since v2:
> >
> > - fixed a TRANSLATORS: comment
> > ...
> > - replaced a spawned `diff-tree` command by code using the diff functions
> >   directly
> 
> I just finished skimming the interdiff (the difference between the
> result of merging the v2 into 'master' and the result of applying
> this series on 'master').

I wish you would not have skimmed it, but provided a thorough review.
There was a rather serious bug in this (not the first problem introduced
into one of my patch series *because of* code review, unhidden-git and
mmap-regexec are also very recent examples, I really should learn to
resist the prodding to replace well-tested code with code of unknown
correctness).

The problem in this instance was that the authorship is no longer retained
when continuing after resolving a conflict. Let me stress again that this
has not been a problem with v1 of sequencer-i, nor with v2. The regression
was caused by changes required by the code review.

In case you wonder: Yes, I am upset by this.

The required fixup patch is:

-- snipsnap --
Subject: [PATCH] fixup! sequencer: make reading author-script more elegant

An unfortunate regression of formerly battle-tested code sadly crept
into Git for Windows v2.11.0(2): authorship was not retained in case of
conflicts during picks.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 73b2ec6894..8ecab02291 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -612,7 +612,7 @@ static int read_env_script(struct argv_array *env)
 			count++;
 		}
 
-	for (i = 0; i < count; i++) {
+	for (i = 0, p = script.buf; i < count; i++) {
 		argv_array_push(env, p);
 		p += strlen(p) + 1;
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 71b9c8ef8b..61113be08a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -237,6 +237,22 @@ test_expect_success 'retain authorship' '
 	git show HEAD | grep "^Author: Twerp Snog"
 '
 
+test_expect_success 'retain authorship w/ conflicts' '
+	git reset --hard twerp &&
+	test_commit a conflict a conflict-a &&
+	git reset --hard twerp &&
+	GIT_AUTHOR_NAME=AttributeMe \
+	test_commit b conflict b conflict-b &&
+	set_fake_editor &&
+	test_must_fail git rebase -i conflict-a &&
+	echo resolved >conflict &&
+	git add conflict &&
+	git rebase --continue &&
+	test $(git rev-parse conflict-a^0) = $(git rev-parse HEAD^) &&
+	git show >out &&
+	grep AttributeMe out
+'
+
 test_expect_success 'squash' '
 	git reset --hard twerp &&
 	echo B > file7 &&
-- 
2.11.0.windows.3

