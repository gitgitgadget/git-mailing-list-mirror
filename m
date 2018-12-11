Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A09720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 12:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLKMkE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 07:40:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:35195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKMkE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 07:40:04 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4ScS-1hOWRZ0zC0-00ygyV; Tue, 11
 Dec 2018 13:40:01 +0100
Date:   Tue, 11 Dec 2018 13:40:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     silvio.fricke@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] http: add http.version option to select http protocol
 version
In-Reply-To: <CAPig+cQW5_9fH-P8X50Mx5kGJRwEOskw2L49Ajk+3D4xWpcOHg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812111334260.43@tvgsbejvaqbjf.bet>
References: <98295da2b5295795414eaf85a40b9ae62b1b2dca.1544482124.git.silvio.fricke@gmail.com> <CAPig+cQW5_9fH-P8X50Mx5kGJRwEOskw2L49Ajk+3D4xWpcOHg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:edv2vqznOgN84vh5CJbhiMOMGPsF2101i4+0iTFzAbKudp/QaX9
 sbImmXd+TdW8nSHlPBxGVJU3FjxaD3PbnatmGmFikRjjHd4HjgKnNUztEwmyAVcptPw5Zi8
 lbV9LEqTD2fXZgp4cQU41eyTgp1J9pzA5qOUiaBDUkqevtjXFVF4v1q3KnEEiVgu5/b7l+w
 wHA6jEUP7o92XyQx0WwEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TvRnG+PBB0c=:WaZyDAfvTJk4w8Yn+mUraa
 UKrrP+CllP/pfMh9r7smr0fiKy2nB+FQl2rRb9onPlofmbFw0u3qxRrfCxwyh1Yvb0FGOl//1
 Jb84Ok6urBSy9VVb0/NYD14o/j+3IEZuOGYMyeeXLkmIirXOl9Ls/qjCL1Jkleie07fTIQkVI
 T8/sJdWcHn7bbBOw7FVMkJ0+I9ll5k4Ex7Gs2o4ACDbUyvjGNBe3cXtDoBy/gNFOWl/Vlqt/R
 zlhDc9zEq2Vq1gPK7dtqS/qg1otuFncd7+Wlhqxd+GSIGlePHIve8VN6czbFnwjicwTsI6ipE
 6Ty4BtC8QC6OKyBsnehLg2areNrEj+oFpNKZ/S1H8rtxVUeDYtIi3qr9pCoTiBYKwPWigL6/w
 g2U1HICgIGyGtFgYke81/7wnQMUSSeMc4kjBad+20yFG9QOT02865zMMRWcdn3cb7W7T63+kK
 GK4ViFCeEYWFO3HZTvRBUfg9u08+bcy56sTx5pkbTH3I2AgGlDPXY21Nic3JH2T6pP/LE+bTS
 Y0ii9xnFgRzcjRciVOCihzOzdaYUqcUeLDLIyRGZ8duixnKYLgcSSXlc4V1gbQZIkKT4TKRaK
 qqM/WVUWYX+MumYQLIzvBpRet3WCmDdqzQ8bG2bbxbYXLZDawZ1k98o9EbRLwf90AwGfaeS2w
 FpS9O1zKOj2sIXbo0jYimWlPREtPGRaprKiJnUr/odwsv3qTB5gJISfZzEfdmkugnoVz+pkML
 aYlS2KorRbj0IU7fdY+mOp6EBaCSE5i/iMIMOGLnSMh/f7JMNXd/cK2TIk04lrD8PfX7Fla/a
 6iMQZ7YKfnn9ZG8kkUyh2VQ+TmA/N7G5ur6mameH9bGcEhGEmk9rMiSd9W9g4TBNWJFXtaAnH
 fEf30CIPC+RpNYk0xniZeq+Zx8muOs9Dt8vrUdJ74bDdlrezWtG68u9TGDUkKRPpQmAsTCXSZ
 NMqaXM+PVPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 10 Dec 2018, Eric Sunshine wrote:

> On Mon, Dec 10, 2018 at 5:50 PM Silvio Fricke <silvio.fricke@gmail.com> wrote:
> > HTTP has several protocol versions. By default, libcurl is using HTTP/2
> > today and check if the remote can use this protocol variant and fall
> > back to a previous version if not.
> >
> > Under rare conditions it is needed to switch the used protocol version
> > to fight again wrongly implemented authorization mechanism like ntlm
> > with gssapi on remote side.

Please note that this has been addressed for NTLM in
https://github.com/curl/curl/pull/3345 and the gssapi problem is probably
worked around by https://github.com/curl/curl/pull/3349.

Both patches were backported to the cURL version included in Git for
Windows v2.20.0.

> > Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
> 
> This looks very similar to [1] which is already in Junio's "next"
> branch (although not yet in a released version of Git).

Small correction: it is in Git *for Windows* v2.20.0, so in a manner of
speaking it *is* in a released version of Git.

The reason: even if we included the NTLM/Kerberos patches in Git for
Windows, there might be other scenarios where neither of those patches
catch.

Ciao,
Johannes

> [1]: https://public-inbox.org/git/71f8b71b346f132d0dc9a23c9a7f2ca2cb91966f.1541735051.git.gitgitgadget@gmail.com/
> 
