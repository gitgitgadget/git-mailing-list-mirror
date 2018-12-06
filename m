Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB49211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 20:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeLFUJB (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 15:09:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:57279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeLFUJA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 15:09:00 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5tU1-1hNfuB1hc1-00xumK; Thu, 06
 Dec 2018 21:08:46 +0100
Date:   Thu, 6 Dec 2018 21:08:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     "Coiner, John" <John.Coiner@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
In-Reply-To: <20181205210104.GC19936@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1812062100020.41@tvgsbejvaqbjf.bet>
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com> <20181205210104.GC19936@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:u+40NRH4ATTCsyU6ZBCczYPQvUN+iAFEFqPO9IwgOYCSYNzhqMa
 WtNT5td5yNVOf4TylZOZBHt5vdm/aKt0UpbhnobcJhHGiW1HEVN07O8/X7pmDpX8/kznnh7
 noZh+wTwTlhQgheNw1udhIkw2pfIKvzw+6y6PYjufDMdoNC0siz6s6EjseYMt9paQMqfTms
 N63FfLt+Ytr6hOqZTEWYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ujMvs0Nq+6c=:NzWlVO0xmNZZNwPvODhpmu
 1KaEVli/kashHsZYS70/Wuz2cP2xw3BI1NtQ7VhM2GVpBZz3eIBRn3ojEcp0PXCtdT1FPaSuS
 puKwGMsiodGnNfU0W9Fx7V445YBb41eugANA32WzTkz+vCSXML8R2PFBdi711CSjupj5dzY01
 oj6p+N9wDUvK36awIYXmDu1gqy62b85GMFOoduCqZfYMOSPV3xfBEAbN/U3iT1hLiOR/eYfEk
 7o1QlYx6xlm+ON09ADpETXlCUY1mX96rgOugGMQTnDJjrtYhza51MeWu9TXZ7lswRmEZJVEew
 uw1rVUfRhMipEyv9DVTqsvnJY9ZZAh4GJLz+zjpSperwDilTm5uNzjExmUOUWIHQNmDjiGrti
 NRFnr19AUdMm8jp16oxwHqaMuahnNQEOerLpNmoWrHm03i4kXdHr2Ad9VvhPjPCNykZvCIblx
 mkCYe6jCxunGOxCkJWf4+E7LgiwpOVdKM4Q4BbVrCKMPD7a/g7Gz855NxuVld9oU3xQpdRBCB
 ehi3qjbWtIHwe70/RMnfvyde/QXauT2xdBEvFIMiwO2RMjq85+9aT0WTfTOJ0XFJ41Yw1IsSG
 It71NU8UI13l7bozVTPEPpaEJyqaF2ZS/T+vXReNZK8YkM0gEAPKjhnMuoMf29E2GnokH+5yE
 EHWAbcVgUEm6tBL5DAI/ZUqb1+bxIxqi0l4f9iljkSGdGklGQikT6OL3lIjxHQ2VU/BBeXAC7
 K/Ltyc+54vUrLyjehQSpP8VUJqKyNCDMYzPWTI7cPDxIuZHyvUtOZd/zzQ6eUnyujqs+EpmFk
 ZSKJPXOM5D3y+HEXSWEnPPbHX9kf2KAU0OlCuNcp+sqpc1r0IhXarNlJ9vwsIzzpS7utcG4gX
 4UMI41hApQBwai83mKsMpD6BQYRFs0EiPJejGNouzN2wKsTiaIjvm+lD9puuEin9XrjCHmmBg
 F/Fj0xluMVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 5 Dec 2018, Jeff King wrote:

> The model that fits more naturally with how Git is implemented would be
> to use submodules. There you leak the hash of the commit from the
> private submodule, but that's probably obscure enough (and if you're
> really worried, you can add a random nonce to the commit messages in the
> submodule to make their hashes unguessable).

I hear myself frequently saying: "Friends don't let friends use
submodules". It's almost like: "Some people think their problem is solved
by using submodules. Only now they have two problems."

There are big reasons, after all, why some companies go for monorepos: it
is not for lack of trying to go with submodules, it is the problems that
were incurred by trying to treat entire repositories the same as single
files (or even trees): they are just too different.

In a previous life, I also tried to go for submodules, was burned, and had
to restart the whole thing. We ended up with something that might work in
this instance, too, although our use case was not need-to-know type of
encapsulation. What we went for was straight up modularization.

What I mean is that we split the project up into over 100 individual
projects that are now all maintained in individual repositories, and they
are connected completely outside of Git, via a dependency management
system (in this case, Maven, although that is probably too Java-centric
for AMD's needs).

I just wanted to throw that out here: if you can split up your project
into individual projects, it might make sense not to maintain them as
submodules but instead as individual repositories whose artifacts are
uploaded into a central, versioned artifact store (Maven, NuGet, etc). And
those artifacts would then be retrieved by the projects that need them.

I figure that that scheme might work for you better than submodules: I
could imagine that you need to make the build artifacts available even to
people who are not permitted to look at the corresponding source code,
anyway.

Ciao,
Johannes
