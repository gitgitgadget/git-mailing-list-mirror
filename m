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
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D761F462
	for <e@80x24.org>; Thu, 23 May 2019 20:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbfEWUt3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:49:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:55323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfEWUt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558644559;
        bh=R2kok3conkar6SIeid6msu3QXMzqpZBSCf27F5c9XVA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T5EBKTryyZCAjfXEEz4dobFxV+sbvhzDBVogwgtV7xA/sGQBUpm+Q7PDxZmroqJFm
         3xF78s/NLNbJaU/EimudrO222OMEwqu1Msy9Cd1x5Pena2TzUBsY1DnfBXIManOsbp
         1IXt5tO+bB2e6MpjhrpffcdIN2Uq2DxFdlJKzo0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVe87-1h8JIu2n7P-00Ywgt; Thu, 23
 May 2019 22:49:19 +0200
Date:   Thu, 23 May 2019 22:49:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix fsmonitor after discard_index()
In-Reply-To: <87ef74a1dv.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905232245390.46@tvgsbejvaqbjf.bet>
References: <pull.165.git.gitgitgadget@gmail.com> <87ef74a1dv.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1745083161-1558644560=:46"
X-Provags-ID: V03:K1:Cl3war3NMWitXQT6vqwdMeNvBmXq3rhCEXbwqc7dXwiadf2RaQm
 /HHhmsSYLS2m6xfuWyjv1Bmj63ZsiUc9eFFrceD4ooGDo6dC5mFf3nn+Js/yPORieBlu2zX
 2iIeyL7ARfMd8rRAAqV9GxJqjIf/XG+8jZey9YWvW3RydKDbegt9kJFBzeOkhDMq7AQYzrq
 tHfbp9tg+EGMcVAbIVG5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QV6s2mk2Sgs=:UF+AVVL1P2Gyjq3gpd7C9t
 f8wRYuo+FTkKUTvXGlqLJH5XZU76xrNr+GlFQoGuV8K+ENkgwLeYHx3ieoqQe87liMeZmoG0C
 Y2Q6OM1f7Gbe2WXyGUcOV+OxytlD70qEt5QYUJcLq7mb2dO+5G6mUbWluYQ50GDFovDyzhMoK
 BBKZMx69xI2u0xoDjpFnHr98nd77HXDuKNdZprJOhn/4h3LTVZUQlVeLivkIDrOo74Ax2Frvi
 NgnJvL55SUGgsAfY5vBgtWvHYfrwHgMxm7MZ3kriTh8MKAzNM7KXLnSMOCkIqdSY2sNVvoai2
 ikp9VE0uVKccaFF/uYlsb8oNuouZRU+iBAfbJoS8ukVmbBBOr8prhxx2aDt9otyMjbH1VjxT6
 hHJWCjWnG5LbGGJernPgwMtLo345ja/AvW9HL2uebMK/O/bb50S/0iE8UyULbDinYtwl7+Ocl
 dFIgYCHN29m7tN2X9K+jBA8cTM+MSPpj7qX2eqQue1I7jzhcaf1xkm/g684ZR5a9M7GwvazPS
 4wTRaRPQBcwNYKGqEnbKPi5FxhYgK69ZMlG63IGfbqwb4qHbPfpS8Eq1L4b8veRAAJFkH8gpo
 q73tz2kYsrJfpP4wARl2nj2z8VdQrKgCOuT4iXENpny0coa5k/gYEwTTFi0J+S2REZVdQJlnQ
 dkwpLzk+n8LounMNOUFtTIB1Hiw2ZzBddpPySDFMejLSWb+j2i5kMnPgqicY1mhrso581PEQi
 IRCi/K0cPWb86QlV29HZFDbMULJWV8cCBZiU81ybcFmImvmLNhrpoDxTKllX8mLeiBwZv5mA+
 zf99xEio2qS+LA8JNmTEr5tIngaXzUmJREz6T0mNl40jXAnyPRjn06aBi18gJPOwsF3JvW4uR
 01TrlxLEnjQPz+BuhO+K5KGTAPUQ92Y2hOMW1cp0oC3qPLKp85Z3WyM+AuUlGcgyXxfaiBUGj
 LVufJ73IP/ORIuqztNRNYw9sjSOO7WE5Xr8bWtE383wG/X1C8W/8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1745083161-1558644560=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 18 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Sat, Mar 16 2019, Johannes Schindelin via GitGitGadget wrote:
>
> > It was reported by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > [https://public-inbox.org/git/nycvar.QRO.7.76.6.1903142058130.41@tvgsb=
ejvaqbjf.bet/T/#mb8718fe52e4721dacd3b143a09187ff9090ef4e3]
> > that there were problems with the fsmonitor feature in conjunction
> > with the newly built-in git stash/git rebase.
> >
> > The culprit really is that the fsmonitor flag that says whether it was
> > queried already was not re-set after discard_index() was called by
> > mistake.
> >
> > This fixes that, and apparently also other long-standing fsmonitor
> > issues.
>
> I've added this to my internal build & now the test suite passes in the
> fsmonitor mode without any test skipping.
>
> > (Note that there is still a flakiness around t7519
> > [https://github.com/git-for-windows/git/pull/2127#pullrequestreview-21=
5010574]
> > where it tries to make sure that the fsmonitor hook can prevent unnece=
ssary
> > lstat() calls, but that seems to be unrelated to this here bug.)
>
> FWIW Since February 1st, 2018 I've run my builds on CentOS [67] through
> an GIT_FSMONITOR_TEST=3D$PWD/t7519/fsmonitor-all test and have never
> encountered this flakyness, and I built pretty much on every "next"
> push-out.
>
> The fix sounds good, just one data point on the rarity of the race in
> practice. I hadn't noticed this being flaky.

I finally found some time to track this down (it only took me two
days...): it is a racy condition that *hides* the bug.

Details and a fix in https://github.com/gitgitgadget/git/pull/223

Ciao,
Dscho

--8323328-1745083161-1558644560=:46--
