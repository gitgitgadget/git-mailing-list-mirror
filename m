Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75AFE1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 11:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392456AbfHBL4e (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 07:56:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:40409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbfHBL4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 07:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564746977;
        bh=/+EiKNTFCx1fCxlBvga3hLxm/pc+xlf9zYx7INaHVtw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hr/rljTR4PsR/m4ZZnJNbgfrS8ege+AQcXD9ujDl0J7vwixe8CmoDwOWrW8Lv1WSm
         8HIXSRKpGn3+dtSrvWS9hyDxqpVMZ7OCgi17Bj+CjvZQWz/MRVF6LjyAnHa5IRZWb6
         5aDnL1J9zlUM3oQon7p7dlsbBh4fFGQB7cL4ofcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO24-1iiF7h0ZLM-00okvO; Fri, 02
 Aug 2019 13:56:17 +0200
Date:   Fri, 2 Aug 2019 13:56:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Josh Steadmon <steadmon@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
In-Reply-To: <20190802015247.GA54514@google.com>
Message-ID: <nycvar.QRO.7.76.6.1908021347580.46@tvgsbejvaqbjf.bet>
References: <cover.1560295286.git.steadmon@google.com> <cover.1564009259.git.steadmon@google.com> <20190725234229.GM20404@szeder.dev> <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet> <20190726220348.GF43313@google.com> <20190801180829.GP43313@google.com>
 <20190802015247.GA54514@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-109896202-1564746978=:46"
X-Provags-ID: V03:K1:/FnlsRkicbHcDWr/4VhlyPiSwNxh78uoI3CESlnDSFp9bUmGGer
 xVtjpoC6gcCWWkO9DBoyVbhs2tuOPatOGgwcNIIPFL5Kyl/lnz40qJ9FsDrOPSk1VPfCLVm
 Rtw+/yN37Ry6+mu3WSTaAQg7X0yLH+quwcJxecLBpcTSYcLKEDvJZBLt+ep09LcJRYpsf7X
 C+VfcbV8eKd/p94eWXwHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1laejNkrZ2w=:VvMtr4Y8WU3IqENlSUd1lE
 MEIO3yD3yEldIZdtpae4S/YLn5tzDXMLDbZjbwlxqXzsoVnYs63BJ1Yr5VQBUliIFUddPzLex
 aEwb1ch/p0psro0cmHQ3AwRZOXwtHUiO6layFhpWopB/WF1gRumlE7YVedTPfgmOA9lDdYdKU
 1Eog/DIcz74tLOfuCt3DPEfNnmP7uA1LLzgUYY1JJFdj4r5fSMXh15NpsXAYRLqPweO0mNidp
 8RTpNmty23pGj+5YHPmzDQr/KXY/OrLKTWmqLcijMSqqbtmE0gbupU9TDhE0NnoOuamBMmQ2y
 VdxjiZHdQ5E9iroxQT8L43rp8azfZIbkbQfThWXYFKCOnwNPGrfbxENKIT1PnhJI19niDp6du
 HCDRm/dJkWe6XYd2IBrZt7sQHYE+dM6WutKmwGZXUTZcNf8acfxZ7QhO/xn12gaiJCItLzFA6
 u1SUM4UxPKtv9mEHN8zYPAuMnPwkXBiaZ20O791wI5ktPZyzRIwxfwzu6+lVi5pnW1ANlx29i
 GhdOWjKPGyJ41oLwdfTlL1gQPnyqK7Mx/zvVUbfrdyolCVHm/5wDiXiO5evX0ftC/Kkyz1/CW
 ji1EQA9Q8ApJAfEl4LBuZfi54pGqXhaCI8z9JMvqMU/dOi/6iYLblaBtqTy997ZlrvB4hGxAW
 UZ7xKeEfc+StcocEo7UtXI1GyDgQ6I3e4NigfChU8UJ5iUebxE27GRm42/oRUimxw4dKJzsYE
 i/YlWvFXmgJjcgX1RBN0tBvt/RSXFpOQgbKS/rcLO2Aa4iX+HcgN0sHh+xBiwf0+MaqRZ0d2x
 GUEUug80KDBXDsVxQ70iBVeCLnwOeBqB7t3HMofp3vEV4aSdT8RS2dli3Nr2xVrZFxjU82vbc
 HzN6hZf5ERVIqcrYV1/qtcV37KE9FVV3tdlV+x4G2DYxr0Z7M1zquqkzOuS6amjjbXQpHJyse
 KOaGduDuVdz9z27xb9Cm0DFJyVse6iG7knBUYwhotCW9/tyXLVutAzRtoyMGV5UO5J1H8NyrZ
 XrD+S9KXkADgc3GlVRmNfpfLYMDkKSEqK2fIzvsM2oEK9LEKswss6MghvG/vIwVVUYzAjtC8Q
 +U8w0AuKD13p6UltkzYeUv0qpqshkMBGoyKacfbKPqb7E168/C9+MNQuhGkuykaim4+J193U8
 oSmY4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-109896202-1564746978=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jonathan & Josh,

On Thu, 1 Aug 2019, Jonathan Nieder wrote:

> Josh Steadmon wrote:
> > On 2019.07.26 15:03, Josh Steadmon wrote:
>
> >> [ajv-cli] can validate the full 1.7M line trace output in just over a
> >> minute. Moreover, it has helpful output when validation fails. So I
> >> would be happy to re-implement this using ajv-cli.
> >
> > Unfortunately, ajv on Travis is much slower than on my work machine. I=
t
> > still takes over 10 minutes to complete, and is killed by Travis since
> > it doesn't provide any progress indicator while it's running.
>
> Alas.
>
> What do you think of making the validation disabled by default and
> using a parameter (see "Running tests with special setups" in
> t/README) to turn it on?  That way, it should be okay for it to take
> 10 minutes because this would only affect such specialized workers as
> choose to set that parameter, instead of all of them.
>
> G=C3=A1bor, if we introduce such a parameter, do you think it would make
> sense for us to set up a worker that passes it?

Oh my.

What do we want? To validate the JSON output. Do we want to validate it
in a smart way? Yes!

So how about adding a separate test script that activates Trace2, then
runs a _few_ selected, very specific commands, starting with a set that
Josh thinks representative, validate the generated JSON, and then only
add new invocations if we *ever* see violations of the schema, to verify
that we don't regress on that front again?

Such a script can't take more than a couple of seconds to run, I am
sure. And it would totally strike a sensible balance between benefit and
time spent.

Generating JSON output that respects the given schema is *such* a niche
problem that I am really against punishing every person who wants to run
the test suite by having to sit through 10 minutes, at the same time I
do not want this feature to be totally untested by default, either.

We do _not_ have to validate the 10,001st instance of a `git commit`'s
corresponding JSON. The 10k invocations before that validated fine,
there is little doubt that this one, as well as the following 59,724
invocations won't violate the schema, either.

It's not hard to test smartly. Use a really small, representative sample.

I am usually against trying to be too smart, but in this case using a
really small sample (my gut feeling says: at most a dozen) is Just Smart
Enough.

Ciao,
Johannes

--8323328-109896202-1564746978=:46--
