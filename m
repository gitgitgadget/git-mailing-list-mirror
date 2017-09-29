Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61B82047F
	for <e@80x24.org>; Fri, 29 Sep 2017 11:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbdI2LjN (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 07:39:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:56937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbdI2LjK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 07:39:10 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfTVx-1da4H51LA1-00p8zM; Fri, 29
 Sep 2017 13:39:06 +0200
Date:   Fri, 29 Sep 2017 13:39:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
In-Reply-To: <xmqqfubnwuuz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709291337220.40514@virtualbox>
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.21.1.1709152122360.219280@virtualbox> <xmqqfubnwuuz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fHFKZ71oOO9oNLtclh9d03GZWsKJj56AW2/u41jlQ00TuIm2zC2
 UbKJZqL+3iq5H3VvTTWzQd1dgOJDbbUaMh22DxHgd+mCbuJ8qr+uzREPKLUPqthcNuV/g+r
 wDIe8h7OF4yoclW9fbcIrA7xjduWJXuueaibJ3rqhWAZvTr3kNGvzIVHaRo+CqH+JQgq1LG
 Fyr3/b8KGDfNPsZoeL/gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T+Q2gfusMao=:b5ZhCL1oy2SRpdtAvUh8ts
 ddTs5J4H5c5hznA7+N9bifoBOfpf5B91JORErbttToPg36NvCLaGXPA1ddTEMZF8waPRo/tLf
 DSjCKsiVzi8C+RkguWktVMYE/2CrZEmfHy11/GUIrBF/6ZVpdw+j1shajIkHZSDWWUQ92x9Mf
 CERtA9WSsM5KSoweuHTE00dRq1syf38sOUfi91OayORpcb8+4RY0LTWAlYZBeHyy9isk9KG6G
 GLD+/HXCZIKZd+LvwKmF38E0RSLqQ4XRSZldXNbcWUDbyV71PriRzp+4K4Xk5N40K5Rt9Bp34
 Izp3mdMNwD5A9br2hfQINtRHiQ9lN39FYszjnEfNCH4MlUgTekL3bdPLnPqDlz8oD2mANLbiu
 tmuoHgq/PWuDf7cP+pVmZlwyiBtIUHnIq4jianpIwxc8bIzA6OsK8+fm9kV8KbkHpseAlSM+N
 atn9N+tBwtuaW0APcimp8MpQ6ga5CNOhRVXO78K9iMFxr87p83T3ZIMT2wz4jlhDhKcNwk/Uy
 oqfWhi7ttv5u8MrrTxwQOaFwfS9qCCkpX1Nd1LPiUj6FucW3V9lV9bmYs1SBTqdSAHzcAy1By
 3n846taKkg7j7z++ZS9ReorRo7xANETWXnKBBn9/Dy8ZBavz/Kwo5eyY71p5Um5uqiOX+bvMd
 CsL5MdXVZv6aCkUSjU8mCskNPJr/6JkRP/Pat4792J/PgJeUKa4ycTiOuXbabWPbisj7jHcPb
 RXQmjZJeD833NnMVLjbV6ILfHF+wDQTbpg155o23ex+LG9lsNgiovt9rQKg2LBwTUgbuKbIUx
 sNOondDXnY5HtvgZR3OTPF4MIc7PmnT4bKVC8j3e6VttXWsruQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 16 Sep 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 15 Sep 2017, Junio C Hamano wrote:
> >
> >> --------------------------------------------------
> >> [Cooking]
> >> 
> >> [...]
> >> 
> >> * mk/diff-delta-uint-may-be-shorter-than-ulong (2017-08-10) 1 commit
> >>  ...
> >>  Dropped, as it was rerolled for review as part of a larger series.
> >>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
> >> 
> >> [...]
> >> 
> >> * mk/use-size-t-in-zlib (2017-08-10) 1 commit
> >>  ...
> >>  Dropped, as it was rerolled for review as part of a larger series.
> >>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
> >> 
> >> 
> >> * mk/diff-delta-avoid-large-offset (2017-08-11) 1 commit
> >>  ...
> >>  Dropped, as it was rerolled for review as part of a larger series.
> >>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
> >> 
> >> 
> >> --------------------------------------------------
> >> [Discarded]
> >> 
> >> [...]
> >
> > These three topics are still in the wrong category. Please fix.
> 
> Hmph, but did the larger series these refer to actually land?

As I have to read these long mails to keep track of the current status of
some submissions, I do not care. However, in the context of this mail, it
does not make sense to have discarded patch series in the cooking section.
It's simply confusing.

Ciao,
Dscho
