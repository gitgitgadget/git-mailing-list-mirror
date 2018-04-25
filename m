Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B021F42D
	for <e@80x24.org>; Wed, 25 Apr 2018 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDYIUm (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 04:20:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:54397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeDYIUh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 04:20:37 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlDx4-1edqNn1jmw-00b54O; Wed, 25
 Apr 2018 10:20:13 +0200
Date:   Wed, 25 Apr 2018 10:20:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
In-Reply-To: <CABPp-BFwN7nkA1ss0Ca+TSgrqsJLrBscWCOn7Eu0ZS5TmnopvA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804251019070.4978@tvgsbejvaqbjf.bet>
References: <20180420133632.17580-1-benpeart@microsoft.com> <20180420133632.17580-2-benpeart@microsoft.com> <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com> <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
 <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com> <xmqqwox19ohw.fsf@gitster-ct.c.googlers.com> <1fb11850-4c20-5327-a63a-6d1f5aa18ea4@gmail.com> <xmqqy3hd8q2k.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1804241354520.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CABPp-BFwN7nkA1ss0Ca+TSgrqsJLrBscWCOn7Eu0ZS5TmnopvA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Urwd9ggXinyv1ePFQf/a+88FU1FgYpxhq4Z26qXYYfIZUd21kAu
 FRtu133u9cQXuqMxbwECiHs2mQpYovPrbZJaAI+18b0BbtdNvmKuwtic4HivL9zt+5TRcFY
 Tv0nzrlwE86ShT4MpEAMJN5kMnNFtMDRjo5aYbTt3KuoI/w7TNzU8bELd8G2282j3E2C2tn
 O7dcOoc1pDnlY8ruY+nrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xxY6JZTR2qw=:seKJnl/6GpzOiHGKGdMpmG
 eo+t+OFv1t2n4dzEz6xc06W9klA+/mFZ8/+J2zLrk6KMnPg9STZe3TmIs079vkJQyLeWRATHo
 XauEAeQrnnsUegp7+P5+WzBzOThWsjznwhTsTXNImJFCMwFnUKJkBIim5vpTWUP5zAiloBGzc
 HzAyxxhP191LQaZtpl1ELLY+V08Gh9EmGJc0fg/B9apMkQLRZwZrjBTbhHrygcRFecT14iSbQ
 oU5bbnz8Zx4GiFVuyHAvqMexRY0F97Wzeba5ozgRt//lrY/p9SxgGtVbnil8M8a96bpHUtw3+
 sRhWGOchLLzBkSpDYD9jhFHi5GcyHEbFOI32HVTNYAQ/LsPPOHZ2wepprRAAxoFG7OZzmp9ZS
 Li0pjVedWBdUjBrt3JVifUGE7Aum93xlWenw093HZKUy5Vc4a6hvBsBpGeiVwXAsaweoIpHrO
 axsOY6AFZcd0rBYjizAaErp3GCTNYwtz5t6TjQvWjpCoBfThK1dcTjWj/datxL5nJA4+5TKR4
 hJajzzs4K/5lCx9NTgqvcrouwu3ZaNukLJsvfyXegxZafQ/diB/vRrR7dH4Lf55evF2F+y2kM
 6xp7+DZR6XMrDvmgujV/qD5oW7cJcgOVDY58PQEp7SDtIw7ja0QbuUYu9fQ+sdtcUgqv7coGi
 NG0FZVx2RY/j3K6LhGysjxszgVDC7JHeKBCfSVRZ3SJOP/bRqrFxFVjumD5HGBI0NNYXwahTv
 ZH+FxnF9Ox5HId3yZB+LIYUfHUnkWNV6vyiXIXjlBffY97ATWOfUitI7V+WaZ3Ei3McBaF1/r
 IKYIv5IvA85hH2+FoLrtDdyyEXDz39KKzHO4+wXPld+5ppLGVA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 24 Apr 2018, Elijah Newren wrote:

> On Tue, Apr 24, 2018 at 4:58 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 24 Apr 2018, Junio C Hamano wrote:
> >
> >> Yeah, but as opposed to passing "oh, let's see if we can get a
> >> reasonable result without rename detection just this time" from the
> >> command line, configuring merge.renames=false in would mean exactly
> >> that: "we don't need rename detection, just want to skip the cycles
> >> spent for it".  That is why I wondered how well the resolve strategy
> >> would have fit your needs.
> >
> > Please do not forget that the context is GVFS, where you would cause a lot
> > of pain and suffering by letting users forget to specify that command-line
> > option all the time, resulting in several gigabytes of objects having to
> > be downloaded just for the sake of rename detection.
> >
> > So there is a pretty good point in doing this as a config option.
> 
> I agree you need a config option, but I think Junio has a good point
> that it's worth at least checking out the possibility of a different
> one.  In particular, you could add a merge.defaultStrategy (or maybe
> merge.twohead to be similar to pull.twohead??) that is set to
> 'resolve', and use that to avoid rename detection.
> 
> Perhaps performance considerations rule out the resolve strategy and
> favor recursive, or maybe you need the 'recursive' part of the
> recursive strategy (rather than the rename part), or perhaps there's
> some other special reason you need to go this route, but since you are
> avoiding renames right now it's at least worth considering the resolve
> strategy.

I would really hesitate to go to a different merge strategy. The recursive
strategy really has the best track record in general, and we have to use
all kinds of branching models (including heavily criss-crossed ones) with
GVFS Git.

Ciao,
Dscho
