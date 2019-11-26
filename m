Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A41C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 20:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB2620835
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 20:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jcAe8lnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKZU4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:56:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:45365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKZU4S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 15:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574801770;
        bh=waZtlIXCpqG5qOWt+9z/0EHEfuGrrosSuzSxIttnVfA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jcAe8lnR3q9g7zrshK5M+A1nKNtiVU/EXrhft/LykeGGXRkuNkZVfImDMAaud0zuU
         dmkvuBUK8JL+A7OheNtwd+Pu6oiLmuXPEfQCXsJZXH0GDccQVnJUhfNsezaq53xYAw
         91p+SxyGvI0VMAdB17Y3+KxOk/sKJ9mF8UbqtDB0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1hzpQi2KHe-00b5Ux; Tue, 26
 Nov 2019 21:56:10 +0100
Date:   Tue, 26 Nov 2019 21:55:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
In-Reply-To: <20191125143023.GF494@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1911262151590.31080@tvgsbejvaqbjf.bet>
References: <20191109020037.GB60198@google.com> <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet> <20191113011020.GB20431@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet> <20191114074117.GB17186@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet> <20191121105414.GA16238@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
 <20191125143023.GF494@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F6wypIF7zfv4z60g4+caMXntq/bQoVGC5H8YlTMKTaX7kXDEYSx
 AoH4cSlUeSf9DxNQVUX5SLWTgMQ+OTfvTdYcX8ap1SnXpxLNMp3yhqxWHEVC/PIZ0cppmnz
 vko9SCPQp3Kj8GacTSSCXlETAqQGYRFdCchhKivpMmuUatYFgvvZyeYPicSaY1JswNLRv8r
 yOF1w+a/WA7cepEBUnPhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+pyhEd+fW1w=:kMQT8a87N7JEN+PesuSFEk
 2I+bn3BCrgWfD8c28ZgRTRygHMyBufO8R14haJ4uWDXvLaIOGpmpJUmCQtcRuakeAX115mwJh
 MP+IVtLy90icHPxh8s8IKndtcG74ND7MvFCobq+JUBkzYXoe1tZvERWYogJoM9lc8BK5vQx+z
 B160r9+0EOu0uk+x8MpsztJQLJFXTvIyuXu5XIbK7k64NCgIdxOIn6SR++cTVEzRWDrEdVoOO
 O/S3mnlU2twcfoigQH7H2yDknXqy92AHlZhxscUOa+ii6/iDNcsB8/GWyWtmYKYfoYWqukrbZ
 A1e3eBCblXr8U9wkq+lHH16mRm4a8UpBWb1yOwZUW3aChmqQ6ZZG+kWLjZldrB+fQtMljJx3z
 Uje2vDlw5hGF+YSMSqQO1gLmAgdxqmGnSiM6fdw5dsN4YK8tU4+O09enmb4OYjaGW9HMODtGj
 4FqP/lz8M7gj3nTLEnM+nIZsaSU+HA02icni2aCKbISv6FctkJOxmogwaFut1nEv+2F8OVvYb
 S5wsw2UDH7KJiQuDxm1SNa6cD+QVukCb2j7xw2+RWDG8o1V9s0RIdrUT66bCnPJDatsjBmiAY
 NLHVXIUIBqxckVLKawBsU/OnzqHE6UlSWQLQQggueDTjK1cHSWXzOaGEPU8hdlsZpANqcNrW4
 3g808XRQtriy0LsBYDo4OB1KXpxqYBofuvK31NUqXhvzTm8gq1oyO5DSloGT80arvwF6mSd/1
 1XivSUIgZnrjgDy8a03hsanUjGBEmYJd96ezIjlPd/QrHdG+qMtuDaHJ/48Expe4/XKXZVL8I
 7zbCoDdvH6VNh49Lj17OCroKOaeYBhUAIZQggM7n6wGS7OpabTG0gUdOxxd2V9+0GVG69kkrV
 Ul0ioV6hs2QSdpPjYotLhp8U0OiMcPGEIAaxen4LAd7Gqsasgv6vI+M0x64n9CD/bzlWTF6cT
 GjlKdc066Evb2vavWB4jE2P8SwO8FSrx1IfDwb19iyXHJHdYIAUFm0fXy0ZdFBWG5MyolmJ+O
 +hqrDyIQBKpPcP5Gc42Scbnsc4WuAs/pB0RnzpKgmMhdvO8ZXbEpZumW0JkJSOrwR9RMWNLDn
 NG0N9L8zhlnEgQl8JbvsUjMd07z3AFwv3/fUraeJcaIGGS1GZJRY7cGaS9T9WmQfoYg1qlIyU
 to8HjgTWenz9vYMV+x/ddOuUIm3QMLD9mgkC7HMKrb3FQKOiGyYqMuHafiKKkTU2VQKR2L1Sq
 wMBjYmQHnxM7WwWECJrMZQRXVLjDzCMpNNus3yxqNwLtq43AGc4yhVbAzPRw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 25 Nov 2019, Jeff King wrote:

> On Fri, Nov 22, 2019 at 02:50:05PM +0100, Johannes Schindelin wrote:
>
> > > Wow, thanks for working on this! I don't know that I'd call my
> > > javascript skills even rudimentary, but I did give it a look. The re=
al
> > > challenge to me is not the individual lines of code, but understandi=
ng
> > > how the Azure Pipelines and GitHub App systems fit together. So I di=
dn't
> > > see anything wrong, but I also know very little about those systems.
> >
> > I actually spent some quality time with the wiki in the past days to
> > remedy that. You can adore the result in all its beauty here:
> >
> > https://github.com/gitgitgadget/gitgitgadget/wiki/GitGitGadget's-Azure=
-Function-and-Azure-Pipelines
>
> Thanks, this was very informative. I have a feeling that some of this
> could be done via the new Actions stuff that GitHub has been shipping,
> but I have no idea if it would make any of it easier (and certainly I'm
> not advocating dropping a working system to chase a new shiny toy).

It is tempting all right.

The biggest obstacle is that at least one of those Pipelines requires
access to a clone of public-inbox.org/git, and cloning that is rather
expensive. Even a shallow fetch would be super expensive, by virtue of
_all_ the mails being blobs reachable from the tip commit's tree.

Further, GitHub Actions' triggers are a bit too limited: I want this
Pipeline to trigger when public-inbox.org/git is updated, not when any
branch in gitgitgadget/git is updated.

So yes, while it is tempting, it is also not possible right now to use
GitHub Actions.

Ciao,
Dscho
