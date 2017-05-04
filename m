Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20786207B3
	for <e@80x24.org>; Thu,  4 May 2017 11:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdEDLdH (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 07:33:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:50694 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdEDLdF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 07:33:05 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEsXW-1dGiaU0N3a-00G0ya; Thu, 04
 May 2017 13:33:00 +0200
Date:   Thu, 4 May 2017 13:32:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
In-Reply-To: <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705041328190.4905@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox> <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com> <alpine.DEB.2.20.1705021756530.3480@virtualbox>
 <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com> <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com> <alpine.DEB.2.21.1.1705041104070.4905@virtualbox>
 <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-921409014-1493897580=:4905"
X-Provags-ID: V03:K0:WXcjvNPrvmORmqo8UunOWqsY09XhwVf/kvRCZodtcWj02ClIxXT
 M1W4HsIWAgWV/fE1l1UanmMMOdsUKUz3Fr4oKbs84ZRvc1RpwBmrZEDZVIX1Q7pWtubDE69
 3FurAKEdYLxCm6byA7Bz9uRmPQ2T+OxFEGee/cXAOyqSNMIVsOFkQncssglKhfAp/30OWJD
 jBBJ8CfqB8MEtTvtwnPxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QKG/B7O9Jh0=:lfoerLHZY75t5lS/jV8hfM
 tFVqm9tzzDBVpwwpJm6imN13Yd//IEDRljBKY7RyObZD4G0lQMfwfnH8uhsVpcSfiYddUH6a5
 RssFqR1lHeHglxyM2SRY2HeueA6olOoaxy/QOIv2cSygl2cH1LcF9BeQKvKM0Qx2diXUmXsAH
 xCHbbmKtmn9nsmJU1kkecbmYS9lnvTL/Rr1REn17fRZR8WousvJ5tYuHGRMmOFUK6n3WV0PGf
 2tSaxzfmBJs64j7p2jyW+VbNfg4cEKFuawrz/xSAyC1yVhGoO7NoQ7QcrG5HHp30BDJBU9KMv
 kTP4YFgl99scNQjKFPOOp59VfwJb1K7HH9bGqWRAsZIVI6LNtIIcou3Tw7dGExFL4WKiFooAN
 1nkm1ZfBNN6d3XxOa+a2xHmcA2njBATHGRxuDX5+fHLuhrTd3P/Cim+USuigJM20jdkpdf26i
 ZVG9QrelaT2cgJh3jiLbzATDyncxM5jTvNKcAMFU5uJ4Ymso1avXSmgSyHArnOse9Ea22x242
 91sBeFn6pwVHxrb7a8QsZwT3Az+a2V1iDPbyNYXNXqmRocTkSBJYCkxtpneWCtQ67/wWT6zIg
 nIQANJbM2lwr+RewcI7FJZaHfPeUn8wqZSEZ/WrriL3aW3gAtQ2R7gxBlFa3042SzPIKZ/08k
 aQi/OlYyqrGLVnra6bC8Z+ASWcNfxfUm2XMayD5SFm8Ebh224DHov8MctdkJ6HaWsFRv4A1Cz
 YPcM0Fgpvlz1qHBpAKwiAJar5Sjd9e967suHKqU3UzZELqfCQFV2GJjXUz3VhizJD7yJn+0mC
 7Ja4B0T
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-921409014-1493897580=:4905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Thu, 4 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> So I think if your criteria for working on integrating v2 is users
> noticing it elsewhere and asking you for it you'll likely never switch
> to it.

Speaking for myself, my biggest problem with your patch series is to find
the time to work on packaging PCRE v2 as an MSYS2 package.

If you force me to make that time *now*, by forcing the switch to v2 in
`pu`, you will disimprove my mood. That's all.

If, however, you are gently with people like me, offering this as an
opt-in, so that I can play with it when I find some time to build PCRE v2
in MSYS2's context, I will be pretty happy, and of course will ship Git
for Windows with the faster PCRE support as soon as I am satisfied that it
works correctly.

That should make you happy, too, as you will get quite a bit of testers
that way. Gently.

Ciao,
Dscho
--8323329-921409014-1493897580=:4905--
