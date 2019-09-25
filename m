Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9E01F463
	for <e@80x24.org>; Wed, 25 Sep 2019 12:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfIYMel (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 08:34:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:48785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbfIYMel (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 08:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569414871;
        bh=bBMa9N7NVMSo5QvtiXwYik6Sokm4nvzXv4s474VVzoc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PWUbZgXmCZS3wJWRb+31m1Ym41KnVVoKAY0AcZWmFph1+L+6n/WDQDwMVJKwkg9Jf
         snUgcbQ4JP9NjbT5IDUmtSm75FKkwfKzDfLXIAP2BXxG0bB5MYhm/OxsLnfDDAhhfL
         wCpCAd/UIXUVjuVTrfkp+rUCoiLhKztRxD8gW3J4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1hhbEK1dnX-00ed7M; Wed, 25
 Sep 2019 14:34:31 +0200
Date:   Wed, 25 Sep 2019 14:34:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
In-Reply-To: <20190924210918.GC20858@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1909251424380.15067@tvgsbejvaqbjf.bet>
References: <20190924064454.GA30419@sigill.intra.peff.net> <89c6f5b7-aeab-740c-06b6-e50232266fd4@web.de> <20190924210918.GC20858@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1094410051-1569414873=:15067"
X-Provags-ID: V03:K1:xnX+9T/qupdcqHv/E2U72pde2+7KI6zjX3whnNy0VOJ09wqmLfb
 tgQydZHGRrPzzhKYsdtLPI5QHdeQFoSQS43RnoLBXV6Bh/OnfUhN2NkHDLQn0Z+giJuiiCp
 eR6IZGMk8D/cUY9XOZBKUXTDIAE1bQuOWpa/kyoONrTuXbTwUmeZGTIJ8TsCwrZc3XDYbVi
 1GxSG3sge7CvR6LfECTPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zAfyvv1DdGo=:WEcW9rTO/PV01BFyoIQRQs
 SmGTYMESgbkeqlFh+b4KY4ZuKoZcYA8JeEVE6R0jNlIo4ViXho5+0ICusLUS4egcdgPE3DsUV
 id7L6jyTkjC8zXN6kQ8J016Uv/EqZAmcqrX3FfPHS1H4s+094kzwO1+ZIJgMeoFQGvRO9xXoh
 rciHbN1fSKxlOcztASViSKvTGRiA5bNVIyypWKKc2W/Dp55OMni9wFJq0JGNQESr3I0YkIQos
 7sc954jOAIIQaZzI0Y1axN6fwVFxS0JB+oP629C5JvpBn2nxiNn/9vHkBJ2S69FCTW3+bVrou
 HWU5vQMAg/99qOLDa8IS9xdueGeNWVCzkJbv0tgOW8b0b2nJyUCHhEjxt8dtdzTKSm39Hs4Ti
 EBBbO3onWeOOvlMkpKHGlZSlEWi7vz4oj+I6R//4s4tWcSyaas6fr3hjPzsYLEjmtNszDhJIs
 F0AtCvnSMziuxk3QvzNMZSGFhdf56v8ZfKB2oRc0qtgMgEC8eCFCf63dHXs25Yz6AyvSMT92L
 LSYrfphjCYgSl1Lmk5Y0o2cUHgpz72RS9Jyk1a+6X96q4VncEfCVLtoImuBIq6POPSDfCfKAe
 1yST5MGghmvf8hP4DPI3lvFSwXjHfT4UiBgpPGbRkpgHFzNaUf0JkY6iSpDpp7v6wiu0LubBv
 +nkKNYxTR/Pf15qI6nkZ7YZUEoEvfGouw8hhJvq2jSJbkSJehVoysi1/cAi6qvrPdj7j1IDPr
 /2tXjbF3UdsaprfT+eiSPbCHfadR/XZ80fl74xJNeUyIy0l5lY2WCcCb9p20siXxa3pJ1nfZR
 6FttVMKluKKqTUlj5KfHYF4xfz7/KPLAsyA1I8QPjY6RJluegFnI0iMYq/o2nMNrPNtpmo94N
 8qwLVWViyMn+lRuG7gNEpqR46C3l0xYL+9ERTqGhFlTVRsv263H49+Y7VGcwk6q+Gj296oWew
 roTD1/++2h1sv8GRBdJx805ggyqrrQs922WSjpvjUYLVBg1nmJT2LcPHdEdvpwVT9MQri+5hY
 Uz8d72KQUTz6TdtsuR2x32Kpui9ViuqF9xsKXI7li/oSGzayk04Whke66NCjIJ1ot1ilcVd+5
 5OI8h040OM+G5VC+njBMHdxJy/TM6o9UFXBhzGS85YCQIYV4+Sw/4VilnktIznH4T9vEOlzuh
 CbnRU939l+elU415mSbUE4gRycI0sg1BXP3M3Fkt5LHd07XHTHT6b4Py8p9Jxxd/ywK+f0UWM
 GhLaaxvtYouA5JY9PD9pTH6iqkOiWS+n8TE/9YM1YRyU2Bm/gZP9UdBMUNeI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1094410051-1569414873=:15067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 24 Sep 2019, Jeff King wrote:

> On Tue, Sep 24, 2019 at 10:14:55PM +0200, Ren=C3=A9 Scharfe wrote:
>
> > > +* Trolling, insulting/derogatory comments, and personal or
> > > political attacks
> >
> > Hmm.  Trolling can be helpful, if done right.  I consider this to be
> > a good example: https://git-man-page-generator.lokaltog.net/.  Wrote
> > some texts that look like that..
>
> I suppose one man's joke is another man's troll. [...]

And we could now try to dive into that rabbit hole and discuss every
detail about it, but...

> [...]
>
> Again, I really think the point here is not to enumerate all
> possibilities. It's to set some general expectations, and to make it
> clear that we value the idea of having a genial atmosphere for
> communication that we have a document and a reporting mechanism.

This is a very important point. No CoC can be complete, ever, just like
Git will probably never be complete.

The proposed solution is to give power to a committee of trusted members
of the Git developer community. The key word here is _trust_. I don't
think there can be any doubt that Junio, Peff, Christian and =C3=86var hav=
e
earned the trust of the Git developer community.

For those two reasons, I am totally fine with leaving mostly
hypothetical scenarios a little vague. Because I trust that committee.

Ciao,
Dscho

--8323328-1094410051-1569414873=:15067--
