Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6334D1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 21:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfD3Vqi (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 17:46:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:48373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfD3Vqi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 17:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556660796;
        bh=YFYiy768ZauP65xhRZ0z4JNJSOg096PBBv7ai68Q/1I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kjdejRDCIFGPcY4xBtoz/nzWWWeKRHoGWXV964JT+IZc9gK6AuSeceO/9Y2AxT/YI
         gyT7GEeF8mnZdAXP5GqZSW9uoSIy2U8SpQGg7nQMtDTCgie8jic20AfYr1H9SjWvJl
         Wes9+HINeMob62GsidspeIqFAy91+5wt3FFWUVTk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBFBB-1hVnqb0DKP-00AI4x; Tue, 30
 Apr 2019 23:46:36 +0200
Date:   Tue, 30 Apr 2019 17:46:34 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Nickolai Belakovski <nbelakovski@gmail.com>
cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v10 0/3]
In-Reply-To: <CAC05385Mc7pqiCd5mb+1c4WM+v7K=h=GMHuvkw9xizhRFJXXBA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904301740070.45@tvgsbejvaqbjf.bet>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com> <20190429051944.77164-1-nbelakovski@gmail.com> <nycvar.QRO.7.76.6.1904291656550.45@tvgsbejvaqbjf.bet> <CAC05385Mc7pqiCd5mb+1c4WM+v7K=h=GMHuvkw9xizhRFJXXBA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bhiAKMLSV+Wudee0irfMXGrQ6MXmBjv+2LDUSJeZ+nB8KOgrEY7
 5OVm2NLE70EMkb+yHC7d/Q9fwe2Dia6BY4XMR0WazpS73raCRyL4gSwsUra2Kbvf33rm8Wc
 xYOVpwCjmAt5oC2BfAEiV+W84QqRG8Z7IPRIxvC3AKIWUs0mvTx9J7Nb+cye7TK0UAbcSRJ
 jy0kVSZyGlU/2nE8NKhRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nvo8bGsHq1U=:4VA3B6Z6NFF4GELQ8C43uL
 4TnWRYoT1i8VI/QVDAOi6upgU64hl+dGFGroshGmJPebT8klvWsUN10A4JhPDT7nuNWiyxJBA
 JDlntiJX/8mc5jfWC1N4UQkECQ141Ro1Sj2q2/3WVgRAQ0XJ+jddQzel9bCD3FCO+DmMhgZyU
 e8vQum/0oDX0QxdjsQrtsGosEVAjlXUH+K0saEyRYdpujB8cjN7AXncZN11QTx4KYPNf/GKHQ
 L4LY0y/yBsLvo+USjYoIe4PrSJIA6zy8CG+627RLA6oC7M/ALqeP4ALdav5UPI4XD5a+mEC+J
 eqaxESJGsWetb8gyagiHdg4CYzTrppfKBKD3uyNFoe1Pj38wTIugfktJr1gbUjkOVbQpYH6UH
 ZqJgjCGkXC16qeV04LMbMIL8URs7HPl89/yDRg2pp4UxqZc/hrqiSN+ZdulV7TUKAA/UIX3YB
 aUfyG9+Sv74O5i47xuk480OH36/ikRKomAhIUGfM2jXxijjC3m8K85QwSL/6DvJP/JACDgvVH
 l6GsDxOefKLhrMwq8HhGJCmRaScI0UxtN4VVeiFMV6NEppJBNJ453JoZ3GDJIB96nvQxXAjWj
 Jvm4AgXB7eYBxAZ2HPdmbPboAOTVXr2JG0XN3YGKIBF548L1nhJVWsZiSAkDsvnDURqYnRsyh
 RIH2cXo00o45Y4WfLHIKjBSCbU9L1/J6rPjSyWpluy6J2dUEEpTrB2lMkypyIcc1Pmo5r8LHK
 RsJfsfYhCqLMd+2XcqCAsqegSrkhXbbPgnkr06PsLugs6rOEmm6M76Xm9AbC8Z/poZDTYUOLu
 PfDUjHeBjHUSC6GNJAMq+Htzu+WI2t04lfQO7sZRWt5mg7B5DnJMCo0I47U80ZweTYRbpXiUb
 2Qt3iSKFzm6JVAeosGHo5WlD9zd+j26G62kEpAmQ9IU7/ZCiqk1N+9IR/GftAg7e6ns4+fF/k
 1bg2T1qcNag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nickolai,

On Mon, 29 Apr 2019, Nickolai Belakovski wrote:

> Sorry, I'm not very accustomed to mailing list development. I had assumed
> that this was being threaded with the other messages in the series, hence
> leaving the subject blank and only putting new info in the body.

The openness of a mailing list-centric development is that everybody with
an email address can participate [*1*].

The downside is that *anybody* with *any* mail program can be a reader, so
you cannot assume *anything* about how people will read your mails. Some
will read it in a mail program that color-codes levels of quotation.
Others will not have any color whatsoever. Some thread. Some don't. In
most mail programs, you cannot even search for a Message-ID. Which can be
non-unique.

So the perceived benefits of this way to run a project come at a price.

> In the future I'll add in an appropriate subject and brief re-hash in the
> body. Thanks for bringing it up.

Thank you,
Johannes

Footnote *1*: Of course, it is not *all* that open. If you cannot convince
your mail program to send mails in plain text only, and to stop
reformatting mails e.g. to make them look better on cell phones (refusing
this is the price of requiring patches to be sent in whitespace-preserving
plain text emails), then you're not invited to the party. This is why I
sometimes say, not altogether without reason, that you can use *any*
mail program to participate in the Git project as long as it is `mutt`.
