Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382B01F461
	for <e@80x24.org>; Mon, 20 May 2019 14:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbfETOn4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 10:43:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:54881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbfETOnz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 10:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558363427;
        bh=98o1cVPXffm9tyVgys6YAI+mWvVhWe5VKeHw8Cf7ltA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dWHXJ/FP2TbYYLT+ZZgkE4nGfc4JCkg7D6W31xiHexFnn8SuM60r3V0lI5A2X+sqZ
         k2kwLeMYA+OEYo6wbaiFKY4q8sw6SfN2B1rf8vIh9P4pXP9A4F3P7tRTf6jF9gnQmL
         HBirYmxDHBZJM65ZSSmGF8A9t6eDAASvTVqA3RY0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1hHmFH33QO-00OEE8; Mon, 20
 May 2019 16:43:47 +0200
Date:   Mon, 20 May 2019 16:43:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git ransom campaign incident report - May 2019
In-Reply-To: <20190519050724.GA26179@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905201339540.46@tvgsbejvaqbjf.bet>
References: <CACPiFCJdXsrywra8qPU3ebiiGQP3YPC6g-_Eohbfwu_bQgfyVg@mail.gmail.com> <8736lfwnks.fsf@evledraar.gmail.com> <20190516042739.GH4596@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet> <20190517222031.GA17966@sigill.intra.peff.net>
 <20190519050724.GA26179@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Rjud37Uv5qERryV4+LxUU9wVsQIEx4LhlW4ttzGOkx3cCcPHUm3
 j2mCBOnXK06clTb3g05Y6pJea+7UNyjup9oJombKnvpumu+DPW6Jy0VDs62Y2y0G/Hh1JGW
 98bxaKFcAEnsVQyZsK1fNMcupw7XzCEBAf9UhBQAIovdkAwmoRxdo517GB87tBVZAJpWkWJ
 IUtmktWciyabrAbQZy39w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5uWhp2T6vXY=:q3S9CTTVI8zOninw20dV29
 +Q0xn75QVWLUE3es6wSn0fWswHlUEYvtMNaNWrNsufljnAhpUd3pB3wEcxsJHjYCRCvojg0mM
 Ock26AX9ajYmh5FKvb5BtkR4mysbVqLxpwBtSz79XOtWjyHxgjOXyj53HLVacIRkG5/r3UbaZ
 D89sldL1RLANPPP8tq7clZ+6mc38uwieLce1HaYClxD1Bx1Uz4Eg6ckhyJXK2zfnsNj8s4ZBT
 hadOUJHExgSOkBVnlfGFMgRipccrwt+z7mR+DNo+1rOHhYszYrki9T2Tcd89t88V+ZoiJP/E7
 E5P3xYnaf7YlUC9Yxh4zCX7rMBLiVrmHqcL6lGuE0UdeL8zCy1dfRKFPzlX03ka0Z6GqLw5/B
 k3nxe4IdGTdy1XQ4IgQu4r0Hso67jxi7pWRTETwd2YS5zsicw+xkqXLtYgFN2ueb5qS7AdIjl
 SZJTsuawIKMAEjLCAC7P+3vHf4fDvEHFVSBzRTzYm5hDrx9/zZxM/jdjoP0Qr66+IhMGJ+yG6
 gZ09v2yHoukkFtpmXw6oCOC9x/JJAUi0f0ofLOydSi0A/61lNtXTrOgp7xh/nTszLLjBJHl5V
 Q+JxAdgX76f1HXygO2MB/ge39wYhtv0qQkgO4NdBxSN4znwqc9Phj048mEKV2Aa59dVw/dK3U
 xW2cQnargzAAhFJGGqCaor/M7tglncNAq7UnvIi46hbkOwBhnwKavBgboPbONu9uCLexZcWse
 +m1oR7f9hADrGQcUX6iz35K3fsLseHDhhoM2Bk5uhM3C1vQIHFdXNymQAfLFHxTVM6RHK9pFK
 GekKoAYMyXzMbjH+RN7X9ORqDDt7vk7WzVf5FGsva3CyJB3YlESnI76NES0VTNpc7N2XENGVx
 Q1seZfqNFxoeyFvKgfLPlM+FQgDKbREjwWN+0RTDcvggsUHE9esK3rwp5lt5Nw3+5hqISsZ3Q
 kCBCHkhqn9BV5sJlQFXoLQC4Z6VqxvRwRoVvhO0iSt6cYVEVExcAL
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sun, 19 May 2019, Jeff King wrote:

> On Fri, May 17, 2019 at 06:20:31PM -0400, Jeff King wrote:
>
> > What if we did this:
> >
> >   1. Do not ever write the password part of a URL into config.
> >
> >   2. When we extract the user/pass out of a URL, put them into the
> >      credential struct, so that when we successfully authenticate, we
> >      trigger storage. This _might_ actually happen already, but we
> >      should definitely confirm it.
> >
> >   3. If the user has no credential helper defined, then do one of:
> >
> >      a. Warn them that the credential was not recorded, but that they
> >         can use "git clone -c credential.helper=3Dstore" as a fallback
> > 	(but probably worded in a way to recommend using something
> > 	stronger if possible).
> >
> > 	This is slightly annoying because following the advice requires
> > 	re-cloning. Fixing it up from there is more like:
> >
> > 	  git config credential.helper store
> > 	  git fetch
> > 	  [interactively input password]
> >
> >      b. Just use credential-store. Optionally notify them of what
> >          happened (and that they might want to choose a better helper)=
.
>
> So here are patches to do that. Step 2 is indeed how things work
> already, so nothing was needed there (there are still 3 patches because
> there was a bit of prep-work ;) ).

Thank you for working on this!!!

> I did 3b here: automagically enabling credential-store. I'm still on the
> fence on whether that's a good idea or not.

I think you're right, it is a good idea. It is built by default (because
it has no 3rd-party dependencies), and it should be "safe enough".

I'll just have to look into mapping the Unix-y `chmod()` to a
Windows-appropriate ACL action, I guess. AFAICT we don't do that yet.

> I don't have any data on how many victims of this ransom campaign might
> have been helped by this. But it certainly seems like a decent best
> practice. I'd hope that _most_ people have moved on to using a
> credential helper and supplying the initial password interactively these
> days; this is really just aimed at people who don't know better. So the
> goal is making them a bit more secure, but also educating them about the
> other options. Hopefully without breaking any workflows. :)

Well, let's also not underestimate the side effect of educating people
(even transitively) by the mere action of doing something about it and
talking about that.

Ciao,
Dscho

>
> -Peff
>
>   [1/3]: transport_anonymize_url(): support retaining username
>   [2/3]: clone: avoid storing URL passwords in config
>   [3/3]: clone: auto-enable git-credential-store when necessary
>
>  builtin/clone.c            | 37 +++++++++++++++++++++++++++++++++++--
>  credential.c               | 13 +++++++++++++
>  credential.h               |  6 ++++++
>  t/t5550-http-fetch-dumb.sh | 12 ++++++++++++
>  transport.c                | 21 ++++++++++++++-------
>  transport.h                | 11 ++++++++++-
>  6 files changed, 90 insertions(+), 10 deletions(-)
>
