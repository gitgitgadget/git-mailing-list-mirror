Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA56C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1529061053
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKBNb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:31:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:36427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhKBNbz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 09:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635859757;
        bh=tEp57L8bKdvm+aSc+l8DyStlAX1YAzPYnhZ6+E1nubA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cEqHz5nax+b47Ea6zXIIXUPT7k3nX/3AFjSKAz20pUjfyrZdNxM/MeR3myImS2iCN
         J3lTRWouRtwH4bHXzkgfAAqJrrzYJAFm7QSpxXg/+PIyeFm+X2tRn0M/42CODXkQSg
         CTa50/MB8f0zw0Na2tFKSN/ZYh+OwFsW1sANs0dw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1mQERQ2wKH-00rGm2; Tue, 02
 Nov 2021 14:29:17 +0100
Date:   Tue, 2 Nov 2021 14:29:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.34.0-rc0
In-Reply-To: <CAPUEspjD_aVXdRrRAxoDG8p4tykJbgLAdknBX7aUY-QaSR1sSA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111021428060.56@tvgsbejvaqbjf.bet>
References: <20211030163005.5734-1-johannes.schindelin@gmx.de> <CAPUEspjD_aVXdRrRAxoDG8p4tykJbgLAdknBX7aUY-QaSR1sSA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JmoltoPE2D+oy1KPIJ5T0hysh8q9UUsGKepqLbFkHYar7S39VtO
 /4z5c+m5y6ZB0zwQGh3bFf51lZwIkeT/d7TGGJIYGoYEtkOaWP2j5mhSbqQ73yDzvj9b4+m
 U8YPoQyW0WmLRgEy62CRYOsqUps2LRFGkWVSYGUcvbGcKyaa/6qOp/ET0iEoq6TqiBh1hzT
 KKu4ImLDKpRMKvb3OKOTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixSllCWeugQ=:zUehsfmG8m8qpkBaiA9GdV
 fN5KflVcO2qsqfi2KtYR2iDWUUD6I3BLgwa6zjkM4deIjiHNvFVVKocV3Lmsd4TX9teG2v1l+
 S7BFQxvDTYSprTS+zAzDUalIDPe0DI/q3QvQ6FYaRj6HN0EptKQokD/ofiS1Dnrj24gTkog1z
 dNFfvGmOqL0xh2ri1aOkHVVdM8M2IpxQHP0eQxL/AG4OdxxC0kufFroZKH/686VNG+XCsYHzh
 3wvAZoIGOBzHUn1jvuequ3+I+Z4OmXdMez0aqHpGdqkuq2yLh8eQx0nz4qdsy0ZimxCL45xmp
 M6qHCZGSFR5+rT9GWTPfJOHJHC/KEMoMEokP4EVpmBpA/KOmXhir0ILRRbS2cvvXDiSwLhKtk
 GTaep37vhRrprGrbZ09KytI29UoIq6dfkda239wyUggOuKqV4KwMesSszL29HdKAUxdThj+qX
 Oscsnt2Zx/sM3xsveT9gRgJIobqAtpgkCLZzJlYkoZZM6g6qaSVe+ti5QGgDLjMeKmjyvy5lD
 MKySA5YO9q0zPpAGwYdWoQuXHdBTeGCOQKv+j4Eh11HEM6mxoQ8K9084GAVYABpreRkFMdWD2
 EOxRHb1c6K0/C93T4IsvdAIYdgiWm70+akBoDWkplvCRjoQSOZZJ9OrWSyBKQ7gh6C6YEXRio
 xQ7IN8WXyukb9ng68r6NrxWcvzTQcSEFqzybOFuP6KPKiie16cyBqUXdnHpzKq1N7/OKPk8AB
 8gKLXEMHRLSEy3zP7BmOtZeUT9pvt2oJpl3bhyx7ODhWDXprkrBFiNr6HoXCyerhQPng/sDQN
 oLJ0e8FYI0QC3eHNgczF5XkqrhC/ez3PK/6NT7R79zBwIS6JOGD/K6WdfDvAMFxVG/HTCdzGY
 xGq8AW4t57d4mSVleVGA/km/XMxDKVEETFF+9LAjwC5AEiYynJUAW+1m9416EpEHhPvh+/d7q
 5J+S6Geg4jEtpzwg/NHidUNHFTVTEPDaw84gIw5JpjADpriHxRBB/uTjSaY2n0SjJ0+aADZhx
 3Y7Ut8x69FGSw4cbnhCEziEF2lvZ4WBCSG6Dkp6mGP+7kthKgjRNWhr+7CmfFFAOEB3O1/w2s
 hAuyOWZH7g8xpo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Sat, 30 Oct 2021, Carlo Arenas wrote:

> Also "fixes" the issues some were having when using the default vi
> editor (against all advice and common sense) and that were more
> visible when under the experimental Windows Terminal[1]
>
> Carlo
>
> [1] https://github.com/microsoft/terminal/issues/9359

Ah, this came in via
https://github.com/git/git/commit/3d411afabc9a96f41d47c07d6af6edda3d29ec92=
.

Will mention it in the release notes.

Thanks,
Dscho
