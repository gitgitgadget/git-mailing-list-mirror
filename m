Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090911F462
	for <e@80x24.org>; Fri, 31 May 2019 17:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfEaRPL (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 13:15:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:33003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfEaRPK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 13:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559322904;
        bh=D4VXJ+yVtgJS1yoHuQlv4CtsqjpKx5qutoJ7PLrDozY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=crdvkYvXDq9HsMGJMGi+l6U8U70EOBE9fghamt3ZabfCOud2crhwcTQD187QThpAL
         dM0iwWRmoZIsh8Cje4kEKRZa5vgJygLZtHNKcxroZGmn4UfkgN9FdCgNwQzEk8kfJK
         8hj80JYDctVe8Q4VQ+MFELLikwTDF9pGtMWp3U8o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaZrd-1hH1YM3wMb-00KCBQ; Fri, 31
 May 2019 19:15:04 +0200
Date:   Fri, 31 May 2019 19:14:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
In-Reply-To: <xmqqd0jywo97.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905311914240.44@tvgsbejvaqbjf.bet>
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905311337270.44@tvgsbejvaqbjf.bet> <xmqqd0jywo97.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qRUVuvycS7j4Vfcoxq3IHVCz5DZFA8P8XfZbILjOTgmWeo8d+cj
 RnJihxC4hpKzLUYCDmNuiuEeWy2JhG5fvIRfXaetz9iR99zYp2RIAhrmAkdI9fxO6TPBEbS
 RVQGBasLfIrYBZKgIw9mD1+z1G5WzDIVlCe3QVukOPpAfZuqkHsuahFWoOe+4T0AmTBg/ko
 040AWCHi5vuPFd8aEvOzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mu5092eAPPA=:Ei1L1t+4PV1aDR0zbCNVRT
 C3misZbK1bEKVx2lsjl8TYinbyAf+m69WnpgSc22pGT+A7nVPNayICXVha0X6wNxXrOrgT/zP
 Ko4GFLmoBn1gQ4d/o50q4chBT6ick/mmrlr7VygW0xWJ22lDizpQj0sz6oXBzYxCeGGE/vDYA
 fSDyDtcmQtscbNji0QLSe9B6TLQgkfqJqVVqsS60iJgJiqrljOeC2QGm7HzH30sQLvi1r3RGH
 HJTDPN8D290HFVq5Q6nC0wc/ZuHKVIFFl1PnMOsA3KfJDB3pMJFoos+9ymwplZYYptJLfiOvd
 Vw7mpQYwE5oBuNa9rZ8fYM97xAGnUiVxQqeK8tC7lvHgpGkbA46EOE6d2Ggsri+wpvdLc5Lm4
 uBmCRQi8pF+pfpKg5mvjkeDQBLpaqme0E5KTpg73YTm8fLeckRqtsHL5AVKTKyiIg8RSHOuA9
 4VaxAn8mZMIR6OovJuE01pbvEDsMwTcraegu9s+4lJHPpgqg6LBG8XPJ46OJ+3ny5xT278uI5
 1+VH3ATXEy8uOULoMxaRqt1ks0N20eAUNyX2t/hm87JUhqnLGTg3sF/tWnJgWpHqDSGdivRDj
 CX36Oeezh4DA7qwJDiJDvUQ+Ov+4/9TOckAxB80jnTd+cNJ3XLQPITHH3WGFmiyJvjwKrncHU
 MhjeGsTJXzjvOlZTET73rHsvRzm/TEeljeBYMXg3F9c02AK3WsRxqmeR9LLfT/qWkzJDbeRcA
 JYJ7+DexjxBck9QZTo+JDotemJXmpzCE2T8WKlz8ioSpOYVvVcLVAQvngREpcSZnTA2lj6i5i
 fitUx92yNKWY4PmEN5/xiuBvfD1dTLdwp+bxvB0t2UBP1CQ380ks4gZhsoicyXgM2ie6cCyTi
 RSOmvczqgrI5XjUsaj3y2pJlIi9urScuj6aRI8kTq118LlnF2igVsFa814gpn528iujE1wxVc
 p1li22yhdvOcChkt+BDX2xYIGCpzSFXQZpJO1DO0oZGeMBaWWHC7C
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 31 May 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> The second round of release candidate has been tagged, after slipping
> >> for several days to merge a handful of last-minute regression fixes.
> >
> > You hinted in an earlier "What's cooking" that you'd maybe go for an
> > -rc3. Is that still the case?
>
> That was back when I did not know exactly what shape the tip of 'master'
> was.  I agree with what you said in your announcement of the Windows
> port of the -rc2; it seems that the release candidates are in reasonably
> good shape so far, and perhaps we can do without another round, even
> though it may be prudent to slip the final for a few days to give enough
> space between -rc2 and the final.

Okay! I think we're on the same page.

Thanks,
Dscho
