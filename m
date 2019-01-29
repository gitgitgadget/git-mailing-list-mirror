Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B731F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfA2OXz (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:23:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:57353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfA2OXy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:23:54 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M86jp-1h22uF13qr-00virI; Tue, 29
 Jan 2019 15:23:50 +0100
Date:   Tue, 29 Jan 2019 15:23:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ps/stash-in-c, was Re: What's cooking in git.git (Jan 2019, #04;
 Mon, 28)
In-Reply-To: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901291523060.41@tvgsbejvaqbjf.bet>
References: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sy6N9HmdzcUuEZja77yGrrHu4GGoNp2Msb9H/g7LPBotJVP4oa/
 Ma0Vc5FqS8E5zhiTj5QuGPw+5ZtaGKt42weYIq6EAvmp/vqNe18dc85/jeHoOPben5EvBge
 CrjkkJsvwOJsILUxL1DpoGGH1Vc5jh7WXQraMB+H7zaNUQ2CH/+JeX3cEAUYikBg13NbLgv
 qybIjWk6trDocMKGGPTdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U4XSOz+HJ88=:ckdiMOExq8Biht68bnAFOK
 RjboA0Yf3eJjyMfj4g34ic2oIILweO9tca0Bb4dOjlkbsLVevdd7RERgWfOP+tQCKyfqCnbxU
 //7l64D2qMp9op15JU/H5RChbl9xItPvjXGTugX6WKB8NRm+KjAJukusg38C7/1XasVjPyed3
 bku53AEaQ/MEWqj/G70bkJBI+74EYIuCg0zROivy1PYxbcLJroOdd9xbwHdXgvpvz9l+A/u2r
 pXWjyc2T2L+vXiPyS3UEEFa/eghLBizuFZKC38x6TOrDa/dgE6S31XULjqf4TC8pp/dysg5Dz
 oK6gOcz2034k2d8YWdzMBN1bxWM3WjzrOsyS9BbYl3UZPx7lk26PfP5d1MqbQArEDiLplIJng
 0N72jCC67pm2YurxEPtMoysLDzw9aejf9Wi2djujF3wtsGDeJHAeqvz+VFMR2Ijy1SHEFUpSt
 GsDA4WDklt5/nwX8higXNop1wae8YnKUeYH/5uyS+zhodeGOXMHPG7pRz03ZNAXQ7lY2kDrAj
 1+gaNfLGD8k7FN1hkPLha01m1XEmXtXUJ2s9g8jMmK5puZSqITkYS0+Nc5gTuyAAZPRuG5+Uw
 XSwN/zbyiofJY7cT5oYw4jmcMv7t2WAyI0pr11xau076IFODw9WSVaqoHlyjzRifsESkrmZR+
 JFbg6smGTWfOgBVsc9HtaUYD7coX0hJhVOVaPOaTxymJYIGF5VMSz94jD/5NzFTT2eQVwSpMA
 48eKnXCJDkIe+NfndjcJuuGJZrEtzLoBxgaxQDvMQ9gYxp0S6Ciu3wW7junlmx/tCROGRquhk
 P+EA5Bevjvot7S9ps3PcUIxIlSNOXQFYJ7u29a6P973aTSa+9i0V+omYRDABc1mqBHOwbpBTK
 qB9OU382DTXwZgvaJC7R/FUvoEEVOd4TupVjLt9LBVo/sDRn0ZtzlLqcksHcXd/oM/ygD/8wJ
 Nuz6sRuSS5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Junio C Hamano wrote:

> * ps/stash-in-c (2019-01-18) 28 commits
>  - stash: fix segmentation fault when files were added with intent
>  - tests: add a special setup where stash.useBuiltin is off
>  - stash: optionally use the scripted version again
>  - stash: add back the original, scripted `git stash`
>  - stash: convert `stash--helper.c` into `stash.c`
>  - stash: replace all `write-tree` child processes with API calls
>  - stash: optimize `get_untracked_files()` and `check_changes()`
>  - stash: convert save to builtin
>  - stash: make push -q quiet
>  - stash: convert push to builtin
>  - stash: convert create to builtin
>  - stash: convert store to builtin
>  - stash: convert show to builtin
>  - stash: convert list to builtin
>  - stash: convert pop to builtin
>  - stash: convert branch to builtin
>  - stash: convert drop and clear to builtin
>  - stash: convert apply to builtin
>  - stash: mention options in `show` synopsis
>  - stash: add tests for `git stash show` config
>  - stash: rename test cases to be more descriptive
>  - t3903: modernize style
>  - stash: improve option parsing test coverage
>  - ident: add the ability to provide a "fallback identity"
>  - strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
>  - strbuf.c: add `strbuf_join_argv()`
>  - sha1-name.c: add `get_oidf()` which acts like `get_oid()`
>  - Merge branch 'sd/stash-wo-user-name'
> 
>  "git stash" rewritten in C.
> 
>  Will merge to 'next'.

Yesssss! Thank you so much!

Ciao,
Dscho
