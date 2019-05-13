Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B5B1F461
	for <e@80x24.org>; Mon, 13 May 2019 14:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfEMOxc (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 10:53:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:58101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730696AbfEMOxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 10:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557759204;
        bh=M5hQyRH4gF6Ufre60tOPZCUu+ruYOBhqwxBzTRG6dzQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DEe3b2LmxwkeYoEWTN4AueyCBZfFTmo2rI/HaG0pdVhrFFjzzu3O5/QSnQMp2eMxn
         x46fPHBJ/XbhunpaTWFRnrWvZDnWpirtP+NMYc5OwVmKHgWIsczNnZLXQuqyJG9iWO
         yyqMDPXsicaQsPZLkA9JcRIck5z8nFpxWUfBoSWk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33Ib-1ggnP72z8P-013MFm; Mon, 13
 May 2019 16:53:24 +0200
Date:   Mon, 13 May 2019 16:53:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: nd/merge-quit, was Re: What's cooking in git.git (May 2019, #01;
 Thu, 9)
In-Reply-To: <CAPig+cQghcdgN-qAF=b3NEgzBOXY2Ce9GWi95Q=JdPuTEnMPfQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905131647160.44@tvgsbejvaqbjf.bet>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905092251200.44@tvgsbejvaqbjf.bet> <CACsJy8DTErpeoNHUkCieDafnjc3iwg6QKAp2VP-8tUNYh33tJA@mail.gmail.com> <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1905131605280.44@tvgsbejvaqbjf.bet> <CAPig+cQghcdgN-qAF=b3NEgzBOXY2Ce9GWi95Q=JdPuTEnMPfQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BnNBn9sTT0jMvkagHspeoBoUARKEZFsmdf55bXUimrKB1cHk3S5
 Ub/VtII7oYxkUw1Edr4Wvv12gLNKPE+gKn0Nz51f8ftLqTPutl9XM3M8FWoeofymtZeue08
 ijRsA8FHClsivCEfd+ur7P7ihkKTKffzgXqJ/bmLCNixULRoLXjMUm+iLyAGh9dZN1SU91c
 f0jQT39qzmCQ3SVQsbnCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4GfVjy84hPU=:hxMr4Yy80cfV2OrAHrjIPA
 JQgQWkqxlfAn1XPWsC1QWvwUSXrO2hU0ZYRI+0/3hOu+XihWLBkZjLAzWTXErBnJSFLwJo2fj
 XwdF7kEJRbUSHF0h/oxscO0paz0orSfx9PAnt71oANYmyI+YYF71IShyU2M5YBS5L/+gYJlMA
 SzFNDYnEVx0B0OKz0QaM4LMOHZUfIkpxMSV4jCia15nanQQf3raq38eSi8DvR/VqAh4qW3PCo
 6HeT71yPbbi0PrrQpvJkEuQAY97pDD6wXrrc3fgQyfib0WWNkrfVIZM754q+Vfeq8bfxP1Y0+
 p6Fn0X3iFGzeutobLqJjjdai8m38PcmAUFx6nkA5pu4toYDy82r1WxevgY3yUbkbl2WWEBir7
 3mjYrW2Slw3HZ3Xvhw8MzQG/v6bSy2f1dZkRE2u6j44C/2D83E06+iPQCgphTYT3aZ8m0Zm1Z
 9k3t8zb5yPPdxUsl23ckE/z6RuW2RszJ+0U+PGWK9RXROXFW4I1unh93mMWRBdAz2opZaFUfq
 5ILhfuXUjUlogG4qRQp1I2FiZT13QMV+3FvWPnW3gk+tpWNsoCVtghj20ZNc1L8Do5ot78Nk3
 FmKl6ipN9TxA4L/VZ47iRaMWiJbNzyzCC8myxNQrsLvb4+wP/icdVpjYxKHGd10YI+3ehMF74
 A3VTIYn7tQrf+Nfpw+fIg8Ch0j86OZzNYdEpUmAepCz1dHM0zFtyWafJFKa5jSSdUsWGZdFsi
 bkO5YGGGKHCtzqpUqP3KI51012lvWmODD2YjNgfPGiltwgJMe4TQBFkLSN8YsEcLwPlJYPuvm
 Odv6Lk74dGIlmwKuZEoz8j6fIH6XqNfdLfIfJ6ynyiBvmGLgJVFl51xKIVy+8d0Qa0qL2FE83
 jCBrMgBIryOClp6Ychr/NMXT6Zx+9yf8tzKt0h/ThiFMQbv70uoZuUPg5uJwQYxahU/HTxnOL
 8rctr2nwjrA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 13 May 2019, Eric Sunshine wrote:

> On Mon, May 13, 2019 at 10:06 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > I should have posted the link, as it may not be totally obvious where =
you
> > can download artifacts:
> >
> > https://dev.azure.com/mseng/AzureDevOps/_build/results?buildId=3D94644=
74&view=3Dartifacts
>
> This link leads to a Login page requiring some sort of Microsoft ID.

Ah, whoops, that is not the build that I was looking for (it is for an
internal fork of Git which I use extensively to test various things).

And the public Azure Pipeline that actually publishes those artifacts only
runs for the four integration branches.

Still, you should be able to replicate my findings with the
`failed-test-artifacts` artifact from
https://dev.azure.com/git/git/_build/results?buildId=3D569&view=3Dresults

Ciao,
Dscho


