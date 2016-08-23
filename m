Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43DB71FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 13:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757937AbcHWNmw (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 09:42:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:62827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757409AbcHWNmv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 09:42:51 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M6ioC-1bF9HV2eY8-00wZ6Q; Tue, 23 Aug 2016 15:42:37
 +0200
Date:   Tue, 23 Aug 2016 15:42:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
In-Reply-To: <CACsJy8BokiiDbheN1_CqWWgK3xRn8YP30t7ojjVeDnok5_M4Ow@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608231541420.4924@virtualbox>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com> <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com> <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net> <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
 <CACsJy8C30=-LGMYQJ6MO17L8Vv1q=iQGC=R8TDhC5qM1f5Lh5A@mail.gmail.com> <vpqr39harit.fsf@anie.imag.fr> <CACsJy8BNP8GDRxDGTQwcYWTovN9o11TCkUJ28=5zav3QnGv9nQ@mail.gmail.com> <vpqlgzp9bw1.fsf@anie.imag.fr>
 <CACsJy8BokiiDbheN1_CqWWgK3xRn8YP30t7ojjVeDnok5_M4Ow@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7h3N8NXbwdx7+mEOlrb3PbKhqh4D9zpk5ZKoX9eD92xB1khOePm
 5Tn2OVIXwj1iQEQqZh4Qa6WW790M1cBiJgVOnAoEL8/POxwQN4WVlhONuykfrs4pt+pQlO+
 MzLMDP0topfVMBvLDWwmb2FTZJ6e6P5PhJhmfyhy8dHYF1A6Ry8AtwbK5ggjw+V6I0PKcz3
 +pOHcsQ9MALaBQLoQFYJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BFyVNCtWrwo=:5MT6j+xOmnQZZEHUqO5ya/
 o5CVoDT/SiJ0wKiNKLtMdK/30ugne57jw8RoVBBTN48GW9QuKY3e5XV7tX2wm+IC0K3WN7pvH
 5SQfdAckMGWgly4Ox5hdZQ54+oG12lkhFO/gjXB/IOqaVdxgLtT502+BRLZUGsdbhwhxBKIYs
 wyaJ3H+VCgmya361Oj+1tW8jwfSA6MWeHYb3cqIueEiIxIjX442dW9RUFAQSF98JOvVbNgDVq
 uO7YLJedWGny/lYvcVsYFAoKGbzPpRlLfNdZ8H+j6Czwiv8Y0E61iFp7sR0OJfCChS0qO37K+
 tu9hlDp3DS907bc+WACbjWYG0fsHeT9s5LrT7G2au8/KU5IXscO2FB1Y+m9qTtyB7VyKuxBYJ
 iYLQWfj3PNd7kY10MYX5L5RmrUa1cmLbMKZNDkfJgumlx3e8Swmhv42LZbiVQcLQ9rSG1culo
 kbuA0DJxCDN3GWVyg1XGllk1S6o8TmNpsR/DFdMaABmJUSaeX2o4yHaRiomv3NdeZ5LWbulXW
 GiPJAg2mJZA51UQNCEIAQK8YVYsQtlwmmi88H41VxHutHrOXAVl6Nb/V1891TUY9fIl6/mwSX
 11TFEc6kgPi36yDjYlYUJ3U9ao7bB0fMT9YgzQAWBB5nkjZhZSg9ZYWQ14ojaueiAWq4MFo8/
 lejhYUP5LF8TPb13HGB4DtPyou2peUvb37PfAQSROKltfnU1O7loOvBQciCOQV9Ha5rhNlyvg
 sKJvyycPv6lXphMcDt+2Hw0J8w68l9hNQt33Y9nGq5YtLVKSeYEu3Qvk09nTP/GiZU0ha2RnZ
 ztMWUFO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Mon, 22 Aug 2016, Duy Nguyen wrote:

> On Mon, Aug 22, 2016 at 8:22 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> >>> I think the syntax should be design to allow arbitrary boolean
> >>> expression later if needed.
> >>
> >> I would be against that. We may extend it more in future, but it
> >> should be under control, not full boolean expressions.
> >
> > Why?
> >
> > I'm not saying we absolutely need it, but if we allow several kinds of
> > conditions (gitdir-is:... and others in the future), then it's natural
> > to allow combining them, and arbitrary boolean expression is both simple
> > and powerful (operators and/or/not and parenthesis and you have
> > everything you'll ever need).
> 
> For starter, we don't want another debate "python vs ruby vs lua vs
> ..." as the scripting language :) (for the record I vote Scheme! maybe
> with infix syntax)

FWIW I do not think that Matthieu implied that this has to be implemented.
But it does not make sense to slam the door shut prematurely, either.

Meaning: the more doors you can keep open with the new syntax, the better.

Ciao,
Dscho
