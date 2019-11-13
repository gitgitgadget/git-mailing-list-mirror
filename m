Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0CA91F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 10:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKMKSD (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 05:18:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:42937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfKMKSC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 05:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573640269;
        bh=2taAQ3+iK6AeMJ4Dm9cEE7UL9H5LSnXuRy9PnnnKnG0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DpKai4K8KOouiQZ3ZFAtlE2vxx+ME33mkhAPCu4UypPD1kNJM9KXpGdR0kxnTiq1a
         QK4IMPeZsPJUNg+5HKZ3gp5T7apkpkMPPlJNfBkpRGhYU+MAuSsb+2d9kwMNNRXXxg
         k5i4u+REo2IynJar085tpJwjt7gewMRWxNt94Vzw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDkm-1hg0M11fTs-00xa9j; Wed, 13
 Nov 2019 11:17:49 +0100
Date:   Wed, 13 Nov 2019 11:17:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     James Shubin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, James Shubin <james@shubin.ca>
Subject: Re: [PATCH 1/1] contrib: Add --recursive flag for bash completion
In-Reply-To: <xmqqlfskbfru.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911131116170.46@tvgsbejvaqbjf.bet>
References: <pull.461.git.1573606072.gitgitgadget@gmail.com>        <ac8cb233ecea69d46ba5a0af0e63bc7c03963cbf.1573606072.git.gitgitgadget@gmail.com> <xmqqlfskbfru.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mGmjIVDqyONZfV9EnkJSU+KIhu9xPptxvcimdw4EBtckSaaUl6a
 o9IFNs4mITsl75PBVqFGO2ZHKAZ0IaWNE3e/U3SJFCrZeh93ULM4eiXsTDKM7qItKVEVwlY
 vI/AP2Yhq1VW/DIeFOiufxeIuceY3UYqbCwFZmoWX3POVOWpZxZH/t0YLkjvO5Q9igpL7wA
 z204J6RT5uwqJ0gxL0dvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nW2w8cDFslY=:VhGrcRGkDO+ubdxuZ0b7JI
 OdCgLGJipdjHl08MHP2DNMFhXODtfgOZ6WbEk+K0ZohtXxJwTo/TYrP6GGEZwM+s/Hd8X8puX
 wFII2FsLZtRm0KX/P8KYEMzcjXibU6w0lLG7WLhi32uY+z8TEpNNbG9ecXvC1j3q5FPQ7DayS
 dfeOGmNcC0h6OHNOpSMrI9d8QILN13uLWGdOkhh+5D8F6JdlX1eZKvIIG5gE9nFzyF85HInu/
 jP7z6wgl/aO6YHLjgLVNQeNB94vyFwx8t7qd+ZZwTJPYcTDRWYEdoer+NLGILlp+5eqquKg+/
 YYHaUdbR3yf2/bakuE+J7oAKneHeYaofRX7NldbY/+U0YYO8xYy4YV+H2iWCdPP2ovNs0wmDh
 KH0FAlr5UNkkfqh5qoNjauncsHrEBJKIPU6+BqB3nkOG0aZuOSbVYew5y5HrjGjj4lJqv9Ikq
 NaWoHKiiXqw52Mea9czdlZ6dbXkfmb2mYvQNyKwaCgjA5t//iskz9vSUlgUkR55Yttc3w8fbn
 j37ijujCW32p4IhULKsUbToJNtuJm1n89vPoQCOyH9wOhCDy7vquk3AuyS0gvMoYS32q5z8RU
 k9G8wG8nF45kpfbPa3wqWr3KBIHX+Ju7ISlWrhylYDE6tpPboOoyez6EhLgcN13rJJsSl3rPn
 bw1FU88wKTCFwWB6L9yDysy7rAv9MwxGJ7+TFuK6jySfupyyoN/aPBhiYUHPACZYbR1uCp6jm
 L8ic1anjhtRKFiHmhyN7R5egLaybDnkusj2fiDNI68ew1BLiqyPZHkacLNo95DMYpyvFcP4pe
 Z/A68scbMEaYGDBcp6xOZggiBCoiZZcMpGtg5fzoNQOBQU7PFyWliG01MDu9eQLS62sissvcF
 tS0/h/NCekbxNZenqCfXembuZ5gN8KjZDsjLTq8p1K+RmCkeoOpnwv40nqEpGygTrGUIlU6rq
 zb4/Vkm8Ukk7YB8nCFmA8IFNkfGwyy8OehXMxXH48C4N7pTLVoujXVBkwpOWmb8Q3EAONAJ2T
 dmx3CZkIcb8xjcRkyLfzSxSkJb6oIjxlaLbPe/j7AQw6dLkrmAHTUGaeJi8Kodo1dnnGPmNUQ
 lFSOw2dhchPnAeAli2CIiC05Uw2nPs2FHQepiJXOCimF/V4agDEE46TgdUVVsHqY/sHlEt1Dh
 mqjzDgzT4Us6L7PW/WCVwFsknmbYyxouf4gMKo9qo9MuUMhHVlkL601QYSoqALMksADhgFvh/
 PX/exKYY1zJq0Jws8T2+D/uvwIeh1SJh++nL7b2lqr2D1JjGUx9jKfJFSkGA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 13 Nov 2019, Junio C Hamano wrote:

> "James Shubin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: James Shubin <james@shubin.ca>
> > Subject: Re: [PATCH 1/1] contrib: Add --recursive flag for bash comple=
tion
>
> The title must make it clear which git subcommand learned the
> "--recursive" (unless the patch adds it to everything, that is).
>
>     Subject: [PATCH] completion: tab-complete "git svn --recursive"
>
> By the way, it is pointless to send a cover letter for a single
> patch topic like this; you may want to tell GGG not to do so.

In this instance, I totally agree. But in this instance, it would also
have made sense to at least scrub the PR description template before
sending. Also, it would have made sense to listen to Emily who suggested
to have another go at the commit message before sending.

Thanks,
Johannes
