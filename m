Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B941F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437969AbeKWCic (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:38:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39832 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391889AbeKWCib (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:38:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so9602978wmc.4;
        Thu, 22 Nov 2018 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KxXVsiTwhT+Sl2mN0fwtbcSfNM4w1wCbGd/a/zne9n8=;
        b=DALXly6rwcjqQH5b50tFZf8gxOLN8RvlWjO2Tiz8RBQyGdd8AXAMsxQMlJsV1BCSWZ
         61teEMfNSKGWMOSF06Qx/y5Lb7YZBvOBHYHhOQjFD4Ge/mPNYeGQ0aBfuManZf3pWD1H
         nmshGK26EEj+OH5ubKZV/t1WF65pIMY+4fZZIpOjxj5ak0DeP3EENhRav5hC61uYkc3H
         gKDKrFiq+pQFCYN2ooHIg5XJ4bppelwg8rVyX929cJSXkezhJI8VKKkWjVGQertvvwSo
         ZSk3PLcErbgdj0RjuDYOOdmuOrCZ4nbHobs84LfUgyHKmvB3klXXwhLqfkmhTBGi1sD9
         J3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KxXVsiTwhT+Sl2mN0fwtbcSfNM4w1wCbGd/a/zne9n8=;
        b=Js+p9AxzWgghnAnfnBGyCCkEWmtvBa6+UJA+z/8CQm2NYQAm4mv+7qlhqw2yugXUf/
         2DFbG8JBzI127yEmPnTEFtQlWJM/Pg3tABngzNA653nStgGdWOLzlr438SdX+GzEzrG7
         fLAsFmQEOOTz/yqvn8KP3INTBmlpC59N5uRgBUnFXO2hIeBCeMHcUPPwctj5EJQJI6Em
         lLq3UnyCu4s6MBs9nq4MOyrm4PcYicd+kl9yVW/K8LcLTXpdenL11eBUvqREiv3qeR65
         1M6wDUzD+SEewV5AUKVwZCqH6eutMNgeqc1jYGLyG/wXIc2os9Eig7mJm5fYBJvv/2er
         EOOw==
X-Gm-Message-State: AA+aEWbNyv40BJ++ibDWNR4ASaketAIxyKeYK0O6SSWCA5+Dq7sflx/l
        au5pApTupM5BbSYVndr5o97JgzoaQ9g=
X-Google-Smtp-Source: AFSGD/U0KATFdzC9jp/w4jAwNoX7X7vV3gdG54z3UkU26v2U2A/LPM4ocbvXc35G8Zq6AQqWU5xAiw==
X-Received: by 2002:a1c:c7cd:: with SMTP id x196mr1998245wmf.12.1542902312798;
        Thu, 22 Nov 2018 07:58:32 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id e8-v6sm3383226wmf.22.2018.11.22.07.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 07:58:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 22 Nov 2018 16:58:31 +0100
Message-ID: <87ftvt14uw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 21 2018, Junio C Hamano wrote:

>  * The "--no-patch" option, which can be used to get a high-level
>    overview without the actual line-by-line patch difference shown, of
>    the "range-diff" command was earlier broken, which has been
>    corrected.

There's a regression related to this that I wanted to send a headsup
for, but don't have time to fix today. Now range-diff in format-patch
includes --stat output. See e.g. my
https://public-inbox.org/git/20181122132823.9883-1-avarab@gmail.com/

Preliminary patch:

 builtin/log.c         | 3 +++
 t/t3206-range-diff.sh | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 0fe6f9ba1e..fdaba480d2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1094,9 +1094,12 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	}

 	if (rev->rdiff1) {
+		const int oldfmt = rev->diffopt.output_format;
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
+		rev->diffopt.output_format &= ~(DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
 				rev->creation_factor, 1, &rev->diffopt);
+		rev->diffopt.output_format = oldfmt;
 	}
 }

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e497c1358f..2e913542f3 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -248,8 +248,10 @@ test_expect_success 'dual-coloring' '
 for prev in topic master..topic
 do
 	test_expect_success "format-patch --range-diff=$prev" '
+		cat actual &&
 		git format-patch --stdout --cover-letter --range-diff=$prev \
 			master..unmodified >actual &&
+		! grep "a => b" actual &&
 		grep "= 1: .* s/5/A" actual &&
 		grep "= 2: .* s/4/A" actual &&
 		grep "= 3: .* s/11/B" actual &&
