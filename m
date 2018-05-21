Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953101F51C
	for <e@80x24.org>; Mon, 21 May 2018 13:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeEUNlU (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 09:41:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:35361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbeEUNlT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 09:41:19 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX16a-1fqdNB1pZs-00W0Nn; Mon, 21
 May 2018 15:41:17 +0200
Date:   Mon, 21 May 2018 15:41:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] merge-recursive: simplify handle_change_delete
In-Reply-To: <CABPp-BFjF7ZAjqi79aRbT+0M+stPnrcEXwYoV75qCHTb2oLiXg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805211540120.77@tvgsbejvaqbjf.bet>
References: <20180519020700.2241-1-newren@gmail.com> <20180519020700.2241-6-newren@gmail.com> <3b05f4b1-e236-989d-afe0-e85b28c2e278@kdbg.org> <CABPp-BFjF7ZAjqi79aRbT+0M+stPnrcEXwYoV75qCHTb2oLiXg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vLufn18Psd0l3YZaAyXWHCeE1745ttiXu7SSxVos6ymtUzU7LSJ
 HzoYpXnRFTfVaATLZ9GDiZi2Sp7DKDpJ1Ur32LNUVu2fGfO1jMCu3HDiigT7untwpfljlb6
 g4N5kLWVmhrPgpEs6eNxFUEsJVe35zCPzhVH+XfLZ7ZFxLNvxyCSvT2rS/2Sl5lGMARaYzm
 WVS2RIxAlAXzF7H0JKebg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ui4XXdvH1QE=:tzM2U8sMMC7ckWXtTmsktR
 vxxRuJpjTVzWX9LNixPxnaTwBf64CwCiepTOBgie/Ic7/FFQq+QR7ZvrzVUhjuE4yqJe18utB
 BlYk+ohJmD7u8lfA0Hdw4mTHU9sWGNZo3axd06rpCBQP9a9i7W4lZeinoI8GmNmOUSCwhexqo
 KBRxlBBHDyii4gxx4LkuDNirFH2qgCCHOptp3lbmmKFXSahUUK2wMGZeORzj+nqvfuPc7qdVa
 H6HDYYYHG9mEZyiO/oRMg8ZJwYmu2iL5Cw3G6m82K3VPuS1BOmxyDNQuy3YlofrIso8MEFaWM
 CHB4gMEF0xqlxOLbEg0YQstAPqB0NMaS+bnkgcUiLI1tOH/Cu0hLPamdQfO1PSs9h1zU82kpR
 AMmRGLdEZhY/tyX5abmDKhYV1yrLybsKdX8DDFH8Xby9zhiSNyXDGar2JVOY6H1MJkJzph4+q
 K7zrr5LPMWS/Lrx6MQQ61LsHYpOcSU8aL6y8hiuX/yi/7kYj7qA5CYMi5hPCurWQ41FiQI9P/
 L7+7BUhJ7YG7Af6Q9RZYAVXcr0EkhZWGQv7iLYp9VTEmpn4QQMnkzzwjQEnZGZ+9vpKiuO13k
 MuQd8hXRLefX7ql6f75A+SxbQdKTmqMeNkJPj3ThpeQehyi2NJeskV7H4NOt0S+ZQZzPj19V0
 tOC873XeT4Sver2GzYdJ+R4lc28MoShKw9jBDTkJfQEZ7eO5l9Gr2Usv8owb1UcR/ycXM07HS
 VPCwCfukqXCjKPvq0QwPW85QclOva8IVgrROhyFo9O7uxzHRhOpmOZd3Mfh7PRtRU8HlSJGAc
 4p2ZX5x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 19 May 2018, Elijah Newren wrote:

> On Sat, May 19, 2018 at 12:32 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> > Am 19.05.2018 um 04:07 schrieb Elijah Newren:
> >>
> >> There is really no need for four branches of nearly identical messages
> >> when we can store the differences into small variables before printing.
> >
> > Oh, there is a reason for the repeated message text: translations! Please do
> > not play sentence Lego with translated strings. The original code is
> > preferable.
> 
> Ah, translations; that makes sense now.  I'm still annoyed by the
> code, but I retract patch 5 then.

Maybe you can remove the temptation for others, too, my replacing your
patch 5 with one that adds the code comment "No sentence Lego! Think of
our poor translators and refrain from making their life miserable!" or
some more appropriate one?

Ciao,
Dscho
