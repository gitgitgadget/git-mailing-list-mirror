Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5866C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 16:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821D06121F
	for <git@archiver.kernel.org>; Wed,  5 May 2021 16:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhEEQN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 12:13:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:54937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233835AbhEEQNY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 12:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620231140;
        bh=PUAGp6hg6IZwTGG3cvxBA6dH//zbhza0iKDmT0KvaTc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IvaZ38QFWlCe5toI1GieoEJkXJ3XVG//izcRmHAB7r34UzJY8ds+vNMm1liATYmdY
         rWg6OkM6oSJbtSga4D3T4ea8XC07RoB98K/WXW/hOoLvNOgI5Zj2MHxhkcNlAA/VAg
         hYzgubdMslrwHepMaOYyY20vF7rD+x2WQBW+URFc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.146.104] ([89.1.212.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1lgX3k1TJ2-002GUH; Wed, 05
 May 2021 18:12:20 +0200
Date:   Wed, 5 May 2021 18:12:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: Nesting topics within other threads (was: [PATCH] repo-settings.c:
 simplify the setup)
In-Reply-To: <87eeeuymtl.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2105051808190.50@tvgsbejvaqbjf.bet>
References: <87k0omzv3h.fsf@evledraar.gmail.com> <patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com> <1ecb3727-106f-3d04-976a-36aa03a61caf@gmail.com> <87eeeuymtl.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-822896925-1620231036=:50"
Content-ID: <nycvar.QRO.7.76.6.2105051810450.50@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:6VfAFncPPSc4bUya5Ud5AzgF3iZkHqm4zq4hjYqTme0UJV426qz
 vYEhzzu6Dd0VgUZK2Yjou5khjgcAwMoNOmpNRkIyYj6p4rcTHlXFQJXWHR0jTIvLaUqE/U1
 T/cUtPNRLzTG9zMe4QDUarVXWVbGKMbyPuG+kj3QPtRFJqQK+cGwSv2iB/gUs0DPGkAQwnB
 uqdpJovPd3g5F1pGaVJog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QEcz5hewZ1s=:hrxOaeqWGxBF2Am9qOOKSu
 /pw/USIbIT0TwHCz7NCtugFU71fp2akhtgOUEAX9HyvUleBFBSB3bB9MkUDrwbyhqbZ0I7lAF
 7e4xw0rQRaG1UJNY2RI+yYkjs00VKjNFwVCBrfJ3WvZuzg/wpXlQRVq8lo6fNOxwrY21uwl34
 xhX/cf16f+/8CPbM9RlArM6J86CSSjzL98tGcY8kaD4DNA2aP2m7H1xEUz9iTX4aSOhSLy+0D
 RSkqHut/A2Vvce3CFSZB/ud4hT8V5+uq4ZtpF3OGrNSQL8KHjIE4XdJKYUFQNEmiknJ2MMz/B
 WhJ9SSq+iWGvNrMslWIXOv5U4BxibM3RKHIKrHSy8ZlW6Wafd7fOG53A7FiubjuQ3YY5tJ+tT
 SimkUJKP1bSUzM91FJmFyLQ77dzcLqaPpu3DFwt/7UxrcD2MyH3YXkRktd91TGio3SNAaXkaG
 q2GAaUt/k1fiW4Nop++iFp/V4QYX++15BmyWonhkF6JsyGECx5JKvZX/JnZ4VFg6+HnOBMLP5
 0/NMLlNVHVKDfyeLuueCVmpgVeLdoye7Y3dilLmlxsrdGyLg3LKQpx1QQpWELdMbv8qaazBHA
 Y6x/7ogbcpLa3vhRyKDMNLCVYh8D4sOuzjv/Q2uHhy0KdQLBw41FVhUgtqF0XO9noAS5HIWMG
 MfXdLqlr4diTJAAiaXkGKc0fABjzt/0lbBpo4bCd5gQxUJGYj+CoFNajXJyR8l91QQMuPP53R
 Y+QvHAwwNliAWSbza0NNgVSw0Lg/fobcfDahREj6cUipfvxG6qsOPr/gawYarz9oF9GMRTFMT
 dAFp6VhYWwGZ6ly33M63leYnHLrjAGhfsLTgGXqqkscme1Atb7bV5gGPATDztfaoc1jWrLa9y
 0bCNo85xlAt6oB6oaOe941H53aIaoZLGooZj5Vhkz/8RihC8F5CeexBURL8jlM0kidcyKUyoF
 zSnFopaayMq5pE1w6BZb03FJYNpfO9BE2x+r14TPmn751ldi1sLfQK/5JoYeaxo/4Gb6ZYmo+
 iqiR3ewh+h9n/mtBbDbG3bNvwjkrUx4T5Kwf3JpjoZmMg/z+sbVXc0u5vn6saeVOWOMKTq/Lv
 GdxRYuXErZ6gDHsrXzJGbV0l7UXKbH+7ihag53cAdixPu9z++WUnre+gtUkIDlMXp+lBN/65c
 ilJJ1ZPCaYnWySOVbRCVGTv7toAPaFE4F5qkzOfpG9Hnfk/hDpen4fSuhr7C5F1+PReF0z0zj
 Hw84UKnYIvQfUO+7x
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-822896925-1620231036=:50
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2105051810451.50@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Thu, 29 Apr 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Apr 28 2021, Derrick Stolee wrote:
>
> > On 4/28/2021 12:26 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> Simplify the setup code in repo-settings.c in various ways, making th=
e
> >> code shorter, easier to read, and requiring fewer hacks to do the sam=
e
> >> thing as it did before:
> >
> > [...]
> > Since I've committed to reviewing the FS Monitor code, I'd prefer if
> > this patch (or maybe its v2, since this is here already) be sent as
> > a top-level message so it can be discussed independently.
>
> As a practical matter I think any effort I make to accommodate your
> request will be dwarfed by your own starting of a sub-thread on
> E-Mail/MUA nuances :)
>
> When [1] was brought up the other day (showing that I'm probably not the
> best person to ask about on-list In-Reply-To semantics) I was surprised
> to find that we don't have much (if any) explicit documentation about
> In-Reply-To best practices. [...]
>
> 1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2103191540330.57@tvgsbe=
jvaqbjf.bet/

I find it a bit disingenous to reference my complaint about your
disconnected cover letter (which _definitely_ belongs with the patches for
which it covers) with the practice of hiding patches or patch
series deep in a thread discussion an (lengthy!) patch series,
_especially_ if it threatens to totally conflict with that patch series
and thereby disrupt the flow.

Couldn't you hold off with your patch for a while, instead help FSMonitor
get over the finish line, and _then_ submit that simplification of
repo-settings? That would be constructive, from my perspective.

Ciao,
Dscho

--8323328-822896925-1620231036=:50--
