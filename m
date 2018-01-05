Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89B31F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeAEVG2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:06:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:61628 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753021AbeAEVG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:06:28 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LpcBS-1f9Or13aL8-00fVnx; Fri, 05 Jan 2018 22:06:17 +0100
Date:   Fri, 5 Jan 2018 22:06:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Isaac Shabtay <isaac@shabtay.com>,
        git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
In-Reply-To: <xmqqfu7kcca9.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801052201050.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>        <20180103222821.GA32287@sigill.intra.peff.net>        <CAK2k7nQcY+QQBfda6CHM8tFo3i4XX2tXxHKv73t6SJ4rRvWo1w@mail.gmail.com>        <20180104040124.GA11626@sigill.intra.peff.net>
 <xmqqfu7kcca9.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zJfFsVzQfE0s32PV5lUVgftOfSZVPCtS0bOQeX7SiMbB1iXa/KL
 BC6rtVflhe7lfVRAD2buGSmC+JOXC5Jj8tNG6+B5ppPU36fo21SP16DtfBswF4vT1mJOGia
 g+Qw+p1p2z8/Yobaf5imTUcGfGBa+ZsiedeQpTVS5RW9ocw3GNN6RCtUjnzFBXsLdZn1Jl5
 DYOjix0eNi3VRPpSXmyHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k1m2Plwoq5c=:e2laB5grMTxdSzoAhStSF7
 c+hkw8uPAC99UzoOnjrJ+NJZcUWLpZjAvbEd22NWy7+kAhcGT0cKZtWhTBWSWybn1tX25cATS
 NDnNBBkA1UpqzaShjWuJLZb2m0DxGkBhGmFEvKgVkaahUmMrlfHlSrqbPWubUb7y2QHiBIVGy
 6lOlzQxxFpIz8dQ67ntcoK0QDRy44745ew5bPGdqycrDkyXeUJxg+q02CFm2b1r+W0tdRFa3L
 Fen5RSIKrPA9Kbq99tIiwZGKoISTrKEBkbOtqQRvw1u6yxcBd0KK+VQ2o1o6OSJeprw/UQ8Wl
 fcvBUHxyYSvB26wRZXaVD+bVtas9ZxYBoWuTVBdu7pIEqvav1crOpSkrwTfRPfttHOGQ3Vv2E
 F2gL0732Dw2gXIqzGqomm/8y//ahVVZcD98Fdm3LPnndyM0OoESHJtH4PqBcpbCSFA5l69au8
 7De9V6iePHN1CPdsz0zGYC+7HhE/1ZFVUApOh09nSHma1bKPscDaPRZ1HlwpskPM9cx2HjjKu
 OJCN+lqOgd9UDVAl6Osw/9j/li6McDVrvaMsptQHhp0jsaJcmIuDWJEoKb0snDI/KXvV3udUs
 zRjVrDdZ4R8WolbQ8+96Ks04ynbbITzupR2HvARLHmyGQxSTygA9THF3kv+MHB7yxQZJSSi4N
 vmzsn6gDODxRjk2MTXBuCTh3YCQ1NQX37ArbXTtwXAC2dldV6Vo8teKsMQimZfyP+o0i2iVpM
 Pkk+thrEdJvZ46cyc20NalaJm0TCc0dOoA6nytnzpEfKExMf3HtQDQj+cE+LbynTldIuqD+QT
 EfxOrf9Zi3zd2q6+3SmRExlD8TrZlo825RJSA0MObYbSu5zukPMSFTak5L3N0Sy+qqth3nd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Fri, 5 Jan 2018, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Jan 03, 2018 at 02:42:51PM -0800, Isaac Shabtay wrote:
> >
> >> Indeed interesting... this one's for the books...
> >> Thanks for the patches. Any idea when these are going to make it to the
> >> official Git client builds? (specifically the Windows one)
> >
> > They haven't even been reviewed yet.

FWIW I went through them in that PR that Isaac opened (and which I updated
with Peff's patches, rebased), and I found nothing obviously wrong with
them. They seem to be straight-forward enough.

Just s/m(y temporarily removing its objects)/b\1/ and s/(call stat
directly)( the same scratch)/\1 using\2/

Ciao,
Dscho
