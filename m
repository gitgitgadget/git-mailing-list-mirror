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
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F561F731
	for <e@80x24.org>; Thu,  8 Aug 2019 19:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404421AbfHHTTW (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 15:19:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:44215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403928AbfHHTTV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 15:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565291959;
        bh=TO9CNpU/piB9JiAktYuAaNx8HXQ30QVNXWPsT6oPPUM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lMnBT2V2td8DimjgiBZMiNCq7Hc3UKOGlo+MCHmv6WwzzoHhrLxsYpHTnYNSwWuKz
         jR2R4hiJuI4n/AQ+CX+7aaGLu3j1fQOZQhF3rngLRX82A08kDkQwOr2pNMARTiOS4B
         O/Q2/k4ewto+R/47bJ9lIS7zCYL62S+Qm4/gkhok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lz4KW-1iQcSM47Wq-014FCv; Thu, 08
 Aug 2019 21:19:19 +0200
Date:   Thu, 8 Aug 2019 21:19:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/13] example implementation of revwalk
 tutorial
In-Reply-To: <20190806231328.GB130824@google.com>
Message-ID: <nycvar.QRO.7.76.6.1908082118130.46@tvgsbejvaqbjf.bet>
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com> <nycvar.QRO.7.76.6.1907251122260.21907@tvgsbejvaqbjf.bet> <20190806231328.GB130824@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BKAD/mnvILSLIyQiOmpa1NEWzMgKVyJwyrWPy1k6Dv8YAQk7wwY
 UPXWIofgCZ0FzF+SELHzvAKq+OWNXTPB52ZjHJcH2GWKgAalxNAbS+iN4QVB2HkOFcNifFz
 Qi0MSE6B10LAjHVCgYDEMU26v6D8PdrjVg7zDrArrQELKWMX6RnJb0FuCfuiUF071Rpeclb
 NtO8cKu7g6C7CZRcOrXbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mXyZg6rNpww=:AJWK2G8n8SS93//i6ZkN7P
 prevl4gwY1o7yd/qjs/00prbsdbtA0/eXbAy2ZrvHv/ZEQyKGG7OmHXkv3gtWrtf5lxyaLbFz
 fyoFaBiAZsGSXaQXmuhbE4Qr1QNOrw8s/gn/mUxORooswypwUAIgpq0xRAlSoj8ifD6lVBsGF
 sVJ3lC7+SMKqHETcubIkmqxqtzK9bPsVK1Ygu3gNQrrWEgdBMZusRkIoNXErbVZZejPiIR2Va
 +oPFPbmDpL0uSTrTVUTTG/xBU9In2uQ1ivqWYVgQcoYZ/k34y6E7u0HHExqEZJzHwRgj2+OnF
 LBGC1hlCoJ8E3r5UlRTWKoTjMxRdSlWZfH/dsmzTOEWvOIQyPVukl1juHkoIU+Ywc0JgoJ1dm
 3rAWhldVREpRiZ7o4Ijk/ZNmuMC5EWbUfNcOCvsZDZbscEMHMct0VIB+GbW3tvd31Iw49CKy2
 pb3Q3yHBQgk2Ahpi1JSMGJEXSvlEComhJHbPZ2hz3ix+a1Y/zjAfWqX4Ctt3cozYgk0PnvI3V
 eDAG43oRl3VeOhe3dsSmxW3SMhiWiwF9SiaYuz0Kkui9fwiIe5Z1THpXWZv9Vw4EhBCIbDX6N
 vDe4uSEaY+h0E2rEAdPHAoeSBJz+0+lMFnDDTsU4APNyd4KusisKoiaCigEfDt2Jk29LYTrfR
 SxFe/XlXuVtwsbLV9yyqaFeVOo6mizp2KFDrpMw8SDKrcwGLyjcuVu2oZLdPCvUtpRby1gtmg
 iIimErkTO4LBfIlZDWkHpoVlqOqrGbJ1tQRC9IvrXUxG+GgiSR7eHYWaI/je2i+VpHYWTsaph
 gP+EafGpGA64EZz0HQf5nsQnD5BByZAzvXt75PNImHEYM3CYWXQdpPaOu/Zk8mya67g/CXPIA
 R8mUNAy8cfr3r6tB0wzwMfA0+m892h2Gt/QtHolK/iUYq3Sbl6PF7hygNvBI94by2rBEDuj5O
 XmBm2KkgSADO7hO5cKeJxqxP5tfe221MpbLbbJU7jwcfme2m47vWf2uAQGdswmXGQCQHmec/B
 8WhlEPUXXZwLlvwqgJJ+afMwVxi/kXTNVxU2DMSJlC4gvCtr+gXwM5mQdhCc6Yzxbw4hQ2umS
 IkND0Tqj5lgojz4WpsdepAnJG/lkeHE4t5oMvGRWeN+7BnIbd1qyGkVHemWVYC4gK6JbLo0T2
 /R+2I=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Tue, 6 Aug 2019, Emily Shaffer wrote:

> On Thu, Jul 25, 2019 at 11:25:02AM +0200, Johannes Schindelin wrote:
> >
> > On Mon, 1 Jul 2019, Emily Shaffer wrote:
> >
> > > Since v2, mostly reworded comments, plus fixed the issues mentioned =
in
> > > the tutorial itself. Thanks Eric for the review.
> > >
> > > Emily Shaffer (13):
> > >   walken: add infrastructure for revwalk demo
> > >   walken: add usage to enable -h
> > >   walken: add placeholder to initialize defaults
> > >   walken: add handler to git_config
> > >   walken: configure rev_info and prepare for walk
> > >   walken: perform our basic revision walk
> > >   walken: filter for authors from gmail address
> > >   walken: demonstrate various topographical sorts
> > >   walken: demonstrate reversing a revision walk list
> > >   walken: add unfiltered object walk from HEAD
> > >   walken: add filtered object walk
> > >   walken: count omitted objects
> > >   walken: reverse the object walk order
> > >
> > >  Makefile         |   1 +
> > >  builtin.h        |   1 +
> > >  builtin/walken.c | 297 ++++++++++++++++++++++++++++++++++++++++++++=
+++
> >
> > Since this is not really intended to be an end user-facing command, I
> > think it should not become a built-in, to be carried into every Git
> > user's setup.
>
> It's not intended to be checked into Git source as-is.

Then it runs the very real danger of becoming stale: we do _not_
guarantee a stable API, not even an internal one.

> > Instead, I would recommend to implement this as a test helper.
>
> I'm not sure I follow how you imagine this looking, but the drawback I
> see of implementing this in a different way than you would typically do
> when writing a real feature for the project is that it becomes less
> useful as a reference for new contributors.

To the contrary. Some code in `t/helper/` is intended to test
functionality in a way that is copy-editable.

Your use case strikes me a perfect example for such a test helper:

- It guarantees that the example is valid,
- It demonstrates how to use the API,
- In case the API changes, the changes to the helper will inform
  contributors how to change their copy-edited versions

> > This would have the following advantages:
> >
> > - it won't clutter the end user installations,
> >
> > - it will still be compile-tested with every build (guaranteeing that
> >   the tutorial won't become stale over time as so many other tutorials=
),
>
> This part of your suggestion appeals to me; so I'm really curious how
> you would do it. Do you have something else written in the way you're
> suggesting in mind?

I looked at `t/helper/test-hashmap.c` and it looks _almost_ like a
perfect example for what I have in mind: it uses a given API,
demonstrates how to use it properly, and is copy-editable.

Ciao,
Dscho
