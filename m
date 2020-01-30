Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A499C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9B920678
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NyZpHyMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgA3PNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:13:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:46973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgA3PNV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580397200;
        bh=7C5kWwzsAKaChKv225NRUnutT1hDhmqF2kTFoJet6Tk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NyZpHyMM4Khi6I3qSKQ4JkT5zx/KOWdIkZ7G9mA5ai1+odn5bymTW1AEWHAX3+XZl
         REmbwwLSifTddXT/74L1iwdE2wKOy4VB8dJAdQG4MAHOP00fGzzg6dFuSZn+r6tXdG
         IctPZ8Ba4K6FSYA6BaFv6UUSs0vGNs3IPUV46cJg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1jKeMc0PUI-00pJTB; Thu, 30
 Jan 2020 16:13:20 +0100
Date:   Thu, 30 Jan 2020 16:13:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Miriam R." <mirucam@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [Outreachy][PATCH 00/29] Finish converting git bisect to C part
 1
In-Reply-To: <CAN7CjDC-UrD0sTE=jjNm8=tYsS5-X8p_u_8LYuvRix=_QvnxfA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301612460.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2001202237140.46@tvgsbejvaqbjf.bet> <CAN7CjDC-UrD0sTE=jjNm8=tYsS5-X8p_u_8LYuvRix=_QvnxfA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-589323230-1580397201=:46"
X-Provags-ID: V03:K1:QGvVrGw0BEyHTfPBEnJMnM+wNGfyrdl1ycLOX6I0Q3HMxl+gx6/
 UT7PXpL3OnNAZvk4QKX3qz+eTNi++9NVqEJZKcvtyfbktm+Bf3rmjH7GJaY6oQNKx2cSHPL
 Kky+FQUihy2Lr6Eaxoz5DA4kILOtJIrIX/ctsyM89VYxT0Us8yNptDgdBbTePXd8t504HHz
 25yRrzqzdilxyegDIpXHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ulQabsBDbA=:XwLNhfRYStWGDU/W+DiG36
 Q3DpJJkp0RfJKNOF1YMQNCHIVhsHHu9tVuUVwJbmO0HdIrKKKE12jiLY6pokEfgru4tbvZFca
 n+Zj5ox5tBbg9s23N1PFc48tbmUuvJqTSaINV9DOyMx6Sg6zxHiqAd8kbF7Aca8dvDDdWagEz
 lk9jjckmlWxELnbAFOKWzb9J0cjcf4Q2MdBbw7DV0yhmXX7oUy5iPsWTGGov/7KSYSpEbs2Q1
 Ha7ITL5R6/TByfWaUTGv/PiFEPV0KA/8XnqpWHTO0xDWm0EP9y8yFieilGdG1jSWYyBOhnEo6
 OeLWRB7ui0cJ0i7sEoq0QlaYWCUyz1dewTxrFKH4clgP9MxK1ecxbKw9uH5JOF9C03ii5iMyk
 4VBGCoSzAayMn0tjL/uFL6bZfoRWgZlCFebsVXuZjqnK/IdlwHpvG0I7DtZFvvzE1XzwSFKhY
 2ZQFCJAzYlqllsSY6itoBaDv3kFI8rH3a8D6bV7PtWXw/WV3FK1LE6PcRG/lko0+IKkmSv3Hq
 71MYFrQM+WPPQr2d9opHReVzWI2P9/2SFE3Q34vS/DCMoZjyFGO6uoDJNQMn8e7ZRW9M8ic0y
 LdfftSbOgHAibODvfMKzPXbXYiCWlfW1pCgZJ6OhXPu7nBevyWgVKB+fzHaGfwjiVhg0WH+V/
 dv859PVKK3sSNOMOR5FRvWdLqUbczTXYKxbdU8GEJqZz3eroF2tZgslfehkvUG8qN6mZxLfxT
 4wAfEt3rMkC883dNHwblZfIiabzGAGxJRQhIYmqsvGk6pFQB3+T6JeZzJopR0g6wcqaaD+nGJ
 +kWYEqzoBApBp30mTjC7BEiVIg+kxt2P5G23y5PkJWUWc3JB+Wo41ZIXFii7a+wjXp2uuDJvv
 wfZ9mM5YI6LF5Z0mxDA2jksTVjx+ptobbXP1rpazriXC/6ipxG0xkMjpcb3KYMDPnDJTAC8j5
 yahJeXVMDZCRkzAUhaxF5VBvf652LkII3AryA/c7OlbebyBDK1+Y1u38x03/qK/FX1tl935Qk
 0+zvHZhqT8qib8IOoEi0+VKDU2fmVjIyOCGmvrQFMktvgFWIrZrk9jbsLFl0Iq+tfsijrBuv7
 ZrjUaxqZMgyeipARAyCTqH/9Qn0WZPDr+i9UiYGngZpCh9erPOlSS/zrgwjOqxh3DZ9GQ8vVI
 CIgbjyq7ABezcdpBs1vV+y/IM/ptzbI2oBj5/ajxKuz0bfYDYYacQq3AiF38fxZ/xjp/UOvpB
 E37szZNxse/N98sRE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-589323230-1580397201=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miriam,

On Tue, 21 Jan 2020, Miriam R. wrote:

> El lun., 20 ene. 2020 a las 22:41, Johannes Schindelin
> (<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
> >
> > Finally, it would be nice to have a link to a public repository with t=
he
> > branch from which these mails were generated.
> >
>
> This is the link of the current branch:
> https://gitlab.com/mirucam/git/commits/git-bisect-work2.8.2
> I will add the public repository link on next cover-letters.
> Thank you for the suggestion.

Excellent, thank you very much!
Dscho

--8323328-589323230-1580397201=:46--
