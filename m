Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87204C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D983204EC
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 11:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FnqPad3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgGHLby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:31:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:51303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbgGHLby (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 07:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594207911;
        bh=pUaDaDMQPWpr6Yz2zm3iJ0ifcr2XRxzes6WFYZXZTG8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FnqPad3c1hSsQy0ylyYgOjc9hgY3D0kNhjqMggU81MXCy4x9keC3sIqE1p2DeSH0F
         tT2UoEyWizFLd9aGHj2vIaeweY3J0DGbGg317Wb8VqwL/sXYWFzUqmi3Ui7vt7gtuu
         bQ6xbA9Trc4l2XAZ9ILind0ygaMp+QFlBXih8ouA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([89.1.213.9]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1k6Ja31Brs-00DDif; Wed, 08
 Jul 2020 13:31:51 +0200
Date:   Tue, 7 Jul 2020 01:09:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
cc:     Zach Burdett <zrburdett@gmail.com>, git@vger.kernel.org
Subject: Re: Typo in Git 2.27.0 Setup
In-Reply-To: <17e42501-16e6-e0df-fa23-de4c09619372@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007070109340.50@tvgsbejvaqbjf.bet>
References: <CAErfNxOnX8t7RgPy_Vjq+mJwrb1XvmDHGw+aOA35varqw+TjBQ@mail.gmail.com> <17e42501-16e6-e0df-fa23-de4c09619372@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Bq7awSxcO7uN5dKfHHT3cUHRnJwDN67miuIAq8igXZAtGThj7cn
 pxU2mD+BLP5jAsMr4eGsWnenJbd81Zx36IewZvwbKvHd1EXxotFlD6tUH69vnT3aHfbwJOZ
 mbtnwA18yveMN8zpp146OUaIfORcmAfjlELfJWj5KfUJ9bJgYFiCC2aGyu3brPPzoKrPTwv
 4GlAlkYVOXV9dlpYY6olQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JWu1c9AS1cg=:1MxU5urVq2lTgEZBtYAtOm
 kDpcF6tDeYruK94ueftql5d9S5dTmNcYuxzBKlku0n4I+NvyOxG7hdBZc9ZM4MXsfQ7YqbEVE
 AbkgNvBIu3oU5YUo866XD5k+buMA58x+f3YH9ReA++PmsUHBWovhzZdMEU7324S90MtJ/1E66
 rt0WbgipTQalCnlnS83Mg5aU4RRkyQnJIORRydi3ImvN44j8Z20Rxg6LjZCV2luCWqhc94qv7
 OD5a7WSGNUCZCzyLWEGwB/cLIm4cfI3/DozxCZniZUBAmjpAx15bwgdHbTm/EhU1via5vo4oy
 sXNfup3SfZrSkjRzssf8DC0Ub//cU1alHQq6IZUJq/VeMMcmqPmvmUus+B7X4YqJL4x8fWXqA
 v6w+ciCeEKj57ugtboY1PprqgmI2eChRYzNftr0mHoWoat+w9N+LPlgfXCk2xKexZXjzHKGAq
 tzPD5o2AzLEEq6W10+O2i6C0w4lSfVCk85EekUKP7EFfvaZhCX3oko8wG/yRlb+MazjFreXfs
 Q1s/CeFhJkZUA3wGm8EyH1Y0oGyQqWo+y63WEmrL41RqHfJr68LGjL47xQrLpbS2d1y/dxpxr
 1VT1S9jjpdogolTSq3iDOU2Q1pbi9VsyXKwIs9vzR2VT1UHyD9zKn0x3QKH6wkU0jnal/wEnJ
 fchECnN+eV0ob35Fb+XCap//9EWeazVi5tvQ2b2phFRceTS3mNbG+rNKZq0sq0NXueDp49CVg
 tfnV8FI1DcahyokkszHGVIKwPc49SWSCTwOYDIcOCZ/ulXiZ8YTil4k6MnSyq7CPVq8HEPsi2
 /4ThawFZreLrB3brp0w0x8APfOAuHp0MbQJtp5bxZo3xoDV+YUJ8p30wIEszI0nWkePqETsma
 8gmUHSKbiv905Os8DpHhXtG85w2KO77ZQyyJWKa64XoynDcEBIFWdgq8AKKfP7K04xSUjdmex
 8yG2Wa83rCtxgUyTcRa5nFCNlR7jBY+0Z64anq2F9LqtjoN31w2XCbR8s+MNHZ4FrnetYi/Yk
 uDzC4iGynnfDa2v+LT1LOWzG+dWiN+xMcQtF00fReo/FVr/bgOqPLhUo4KERIL8kCExBA99XX
 xmfHnKXpb88u2j3RMvxQmWpn8aO0qc1LMh6BP7vwcsJ34CrxpH0c8dxBDHEz1X3rNFweYJpB9
 yXn6IN70DyxVUYGRVW4RGhVF1FDNHQH3TA7iiejIvo6u1Ceib7jEOm8UOAhIb/l5ez+CszzxC
 8xq7+9kNGHfGm5352CoZEV/SXpte3DBno2uw9iQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also real quick: https://github.com/git-for-windows/build-extra/pull/291

On Sun, 5 Jul 2020, Kaartic Sivaraam wrote:

> +Cc: Dscho (the Git-for-Windows maintainer)
>
> On 03-07-2020 02:13, Zach Burdett wrote:
> > Hello!
> >
> > Real quick, just thought I'd let y'all know there's a typo in the Git
> > 2.27.0 Setup for 64 bit Windows.
> >
> > When it gets to the default behavior of 'git pull,'  the last option
> > says 'Only ever fast-forard' instead of 'forward.' (see screenshot)
> >
> > Thanks!
> > - Zach
> >
>
> --
> Sivaraam
>
