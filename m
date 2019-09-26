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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5091F463
	for <e@80x24.org>; Thu, 26 Sep 2019 19:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfIZTc4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 15:32:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:57397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbfIZTc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 15:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569526371;
        bh=jx9483KgHNn8OzPhFC9WmXvFfMRQbzxHFZaA0Y1nJPA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gQSGMZhCp9iRrxohWKQRmIfHHjKyqtC0XDKoSc6dB/ABTnCz1U7IqHfJIJJbNg8aj
         cF3OBh2Sl9F0WUbyRbFQySjck+H2mkWHm3fUISeUSEk+xEMK6bBNWJsIShe8MDZQee
         Qfd2eXp/iy/AhNy53WTT0jTK7fq1N2Bw5oC81rx4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1hzBzT3lbx-00wnqe; Thu, 26
 Sep 2019 21:32:51 +0200
Date:   Thu, 26 Sep 2019 21:32:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <20190926094723.GE2637@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1909262132090.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190904194114.GA31398@sigill.intra.peff.net> <20190923180649.GA2886@szeder.dev> <20190926094723.GE2637@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1109489840-1569526372=:15067"
X-Provags-ID: V03:K1:wwU54lE51qn/itFJpmUNcHt3xO1Xhk3g7H8F05g2JUDNvAPR+oY
 ebtx5TL/AeX5QRwEutJKmiwAt4rh4HT1dZh2xfBFOb6BZmMMW6HogcPkreAmV+Msdu+okbg
 qAbPl2GiAodOUwTO4qw3dAXq1z0jj7HrWzjM60OBrCbiY6ue+uM0LEv6dRu5MlEwS5gF1Tn
 CJ4zSEnlDuxwfv+CrRv9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G5lEfwa3/jc=:UyyyNQ4/1Y2BOiHqN+sMki
 tFBwh4d7w3OZe6GvfM0uDXi5/yC4Ffv+uwhpxjvaSy/Z/3CYWPoZw2U+G3dL3icKUHQskyvUD
 wzrfitegAbtHpOK64/Qq5RZjW2TAz9f2ZXmp6vyjrrHaobRqQuP+hyUyJg22yD1dUig8saz/X
 kcJDN/4dB8dxXjFOX/FCPF1bzVpx28Uahvoqgqzr0EDIZNgSBKsgTBUTUvvtywmPhVm5sKZBU
 HtGxuN4LDFtnGohgAq9aeYUT5sjU6/mzD/MoihMZqvx1WNf/OxVoaVaaC7uFlCztPUn83CtgM
 H4jg38lzx/NqLKGtov1XHe63+6bh9+59QeUpmPOOEvNqHC6s3Gvrgxs+xzHG51Ybm4iLidJmm
 IpM68dkP4zCdrzCyWXC4nALT8A0evj9nnBWPkx9pzyec10a3spdidcItjpaI2PxwZhuF6ydQv
 99kJokDoiQ3HI2NyrtqC1iqOyexmbKWGX50qEw2/DCzNXUcVRmhKMixGgCbSZGlPczs0cKW2z
 PXRyQKWZFRfvywtPlcBlk1vz8XMDKDhgD0vlo3G/G5i8nE1P4TYEWFlsR4YiarmP9R71+EsHH
 ZQrreuF2SPe3NAShT5tuNiEJ/4cLD2+5qyQA3Sn8QvrYiH2W1tEPnD/GOVPJbLkvZp3vLnazi
 hEUaQw16b5p2ZRWOOeyZPXFPaQ9vQmX8qYgzCi0isVMz2m9gmDa8atEEVeqT8c4qLyUIvAeYs
 B/uEPpcDuDaeqhCrGYXUBWgCHo/QtNZyPJJCV0PpY91Zhv29Ch+kok72RjBgtteUe3pZMzrZl
 mVJ1F5DwuXdVJTDUdU0on/d85yH18Ni99p/S869ppN7mNtpof6BDfzMq71w37oCnByZ4JSxMz
 jReZD0rkQGaIEshzz0M6VfLmwO7+cxhwhar9JItyzDA1yGhj+odQT4dS7/f/+lN4hKyZHE0zS
 eBCwjwhP37fzxmyYsdjUjQaUMfODV+QLY6kLZLvkhA30irbGf5mOF9dka/dDd4efpu181nw+W
 ShnXpw5qecf3E8jht6KKjaBTyLe77kCGq5GYZgO3tDE7tAd2qWzXGDW+/Clus71eyHMr7rT1c
 8hahyRI8sgp1JMqcWzfiyOFo2+GAJyehh9xddzZ/YkSOa/a7seoWhYyaeq1bCXb3HmZQyGcvM
 HDAxicp22WQa0oSDAwbkTgWS2b4wN2MpDX34J01t7kjd27KurHB5xXeFDTvg+Bzr1F1mkWhXe
 Wz/mFPzqyxBojz8M0u0YXgnb3vDsZt/mbauMN6NkOScpGsoGJsG4EGt3x2wI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1109489840-1569526372=:15067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 26 Sep 2019, SZEDER G=C3=A1bor wrote:

> On Mon, Sep 23, 2019 at 08:07:09PM +0200, SZEDER G=C3=A1bor wrote:
> > Here is one more idea for microprojects:
> >
> >   Find a group of related preprocessor constants and turn them into an
> >   enum.  Also find where those constants are stored in variables and
> >   in structs and passed around as function parameters, and change the
> >   type of those variables, fields and parameters to the new enum.
>
> Peff thought elsewhere in the thread that this is a good idea, so I
> wanted to try out how this microproject would work in practice, and to
> add a commit that we can show as a good example, and therefore set out
> to convert 'cache_entry->ce_flags' to an enum...  and will soon send
> out a RFH patch, because I hit a snag, and am not sure what to do
> about it :)  Anyway:
>
>   - Finding a group of related preprocessor constants is trivial: the
>     common prefixes and vertically aligned values of related constants
>     stand out in output of 'git grep #define'.  Converting them to an
>     enum is fairly trivial as well.
>
>   - Converting various integer types of variables, struct fields, and
>     function parameters to the new enum is... well, I wouldn't say
>     that it's hard, but it's tedious (but 'ce_flags' with about 20
>     related constants is perhaps the biggest we have).  OTOH, it's all
>     fairly mechanical, and doesn't require any understanding of Git
>     internals.  Overall I think that this is indeed a micro-sized
>     microproject, but...
>
>   - The bad news is that I expect that reviewing the variable, etc.
>     type conversions will be just as tedious, and it's quite easy to
>     miss a conversion or three, so I'm afraid that several rerolls
>     will be necessary.

I thought Coccinelle could help with that?

Ciao,
Dscho

--8323328-1109489840-1569526372=:15067--
