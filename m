Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4B5C432C3
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8399821774
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 10:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UfrnGBns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfK1KZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:25:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:40143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1KZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 05:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574936724;
        bh=uZzF/8q/LQDzm44wkBvDn7MCaVoZpc8EBPNtrHgFPG0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UfrnGBnsZId+L0xLH64zBSM2Ly57NtxbPPxL5R0hhQgtUhmxxsqc/dw4jBnUodHI5
         6uZZjDEyBxWRuMMDPGKr/T15T4xpSxquFv1982GXO1XOVvfTNwndAYR8XBbvPMszD2
         TfGN/Ja+iN9Of4uGcyeedDwgETcTHRZW19p5uQGg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1iFSLg32M8-00KwcG; Thu, 28
 Nov 2019 11:25:24 +0100
Date:   Thu, 28 Nov 2019 11:25:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: recommend lore.kernel.org over
 public-inbox.org
In-Reply-To: <20191127200421.GA27456@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1911281123100.31080@tvgsbejvaqbjf.bet>
References: <20191127125231.GH22221@sigill.intra.peff.net> <20191127125343.GA27983@sigill.intra.peff.net> <20191127125936.GA9877@dcvr> <nycvar.QRO.7.76.6.1911272059050.31080@tvgsbejvaqbjf.bet> <20191127200421.GA27456@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EUYOvYW6TtZIxZHzdO+6cPDQKtdyEuZzdPaPXrkdUdSVHcNHzHh
 fJ+JBwjHT3l+SUXGDnPkhZalsEHeUFfeL3lxvdFHhvTuHW1wXV9p23sAOIYo9Aet4fV1B2N
 oPLRccx8MQeVxV1TDGr65CNuxoCD40TUT7dYFVoOpIXtWpVcOjA1dx5h05Y6N4gdjmxO2Uo
 D0wYzxtHnrqPZTyNJ5e1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RurolSkEWwY=:0f1A6YDn18lIBWIwgVSFiQ
 rNolw3D0AAH6qkzhyJd7elaZ2WNYwdmsqEw+yrD8vUbEi51EFPuMI9GTmTj3WldHUhp75r1Hp
 FZvYtuFgVtWbgUA3L+R70qM5olEChTVsCi/d9ks/3FfcfYBRRHnX9wNzDx/9DwbLaCNB24JBo
 hSTODvflB0BcrL6siqtj6h/3g3eTwN4bbmHdn/RbuRSH4hGAVeBtqjfIUVxeK7IPnr5sfE41j
 6fvt389v43mBcotmZ+VIqHBryBcFEKYRsCJyB2pHEPEPHzRHplRLoLSPvOhv1kyGlvYPOob/l
 aw+7CC4Dc5Tq221yuZcD9vrVlpNuYJhayIIhSoTBwSPl1sk4y3OzrlTAOUyNFLWcMcryD8VKd
 PKaJdNpeKQqGIsfDw7eCgrZqHyUAVY0jIrrfhe2HflHFZWLWLKtFd4Tc65WR04dDbYnon4lb2
 E2vgn81hb31hXQLigF4SUToB2qd3vWa6ULL+xRsIQsCQ0PYwQhXZ5lV/yOQxBYX2l7UUhoUlO
 YWHEkr4Ur6pqirCY9anoyuO0pjEWw0scN8Td1Ap9usvH0AUT98yoLYNi7cZShy83nN1BYMEqC
 y6gSQxjgZCNkQuFQnLfEcQS2YDRP23SrzW7vxnd33RLk0plt4c4zydsY0pW+k0Y/RnZuHsOxI
 EUckROiuGFMDO1vTVVRxgKgu8RN/uaz7LpQ+gy/+4HBjXhgiT6bEh2qSPTaxrnUIvxCn+eZlx
 8X9J4zG3VSDmt7hOj/b20BgBwnwwvXrFa49vcHxFOTvBRCGHoHfL/f3zjWTx0IRw/kSu+yK1g
 UnTtA99t5V7df5GFOYbFNQv5DBW2oDg+WpbLnd2SsWr1Y2WQoTnFoG0vb5GluEQgkrGWxllJg
 H1xU+iN3i/EN3O3+eQtDfb9bd1kXsIXBSkIIcHYCvhn+kKti74O48MF/Uztwu7dar7jd3W+PN
 IWHXMveyTxhaZorVgZyLLqRauZWc6Vz50dkQ45d54diQphITh32t2tHastBbAtgYDj4Q+2+GV
 OhnO61q3QKF5rLGnYnT0kqMLSKIjygskBETo7p0JoRWzEUGEzIcHjB1IL1ljPM8Szy6AkENsn
 GbQ4+pUiSPv9bkHn8n/5zl0bmS7VKJ5rLJK/JLI+uegKxw+DbT4+Jtc9EyxL/pTJ2wZ628i3/
 zzztOvAl499NnkLRjymVMA7gU4pSNkGgePhMmnIT1/LUnk6P3uI9D2bK5ev1U9JjeXmyVQec8
 MWhbjR7BKRJEf9EBtVyCYt7jTDLqMu1y8vKENiDdujopHvno5WtcM4KnDvgM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 27 Nov 2019, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 27 Nov 2019, Eric Wong wrote:
> > > Jeff King <peff@peff.net> wrote:
> > > > Since lore.kernel.org now has the same archive as public-inbox.org=
 and
> > > > may have more longevity going forward[1], let's recommend people u=
se it
> > > > for finding or referencing messages.
> > > >
> > > > [1] https://public-inbox.org/git/20191120195556.GA25189@dcvr/
> > > >       or if you like:
> > > >     https://lore.kernel.org/git/20191120195556.GA25189@dcvr/
> >
> > One of the things I appreciate most about https://public-inbox.org/git=
 is
> > that you can clone it. I just tried this with
> > https://lore.kernel.org/git/...
> >
> > $ git clone https://lore.kernel.org/git/  lore-git
> > Cloning into 'lore-git'...
> > warning: You appear to have cloned an empty repository.
>
> Oops, that's a usability issue I hope to fix at some point.

That would be nice. As you can tell from my puzzlement, not everybody
scrolls down to the instruction (which I finally found after your
comment)...

:-D

> > Is this something other people also care about?
>
> Instructions are actually at the bottom:
>
>    git clone --mirror https://lore.kernel.org/git/0 git/git/0.git
>
> The "0" is the "epoch", and larger repos have multiple epochs,
> roughly 1GB each. https://lore.kernel.org/lkml/ has 0..7, right now.

Okay, so how does that work, is the idea that you should graft them
together using replacement objects if you want to have the full archive?

And: if I want to track the latest mails in GitGitGadget, what indication
will I have that I'll need to switch to `.../1`?

Thanks,
Dscho
