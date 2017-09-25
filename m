Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D924D202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 15:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935898AbdIYPz3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 11:55:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:55477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934482AbdIYPz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 11:55:29 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnwxU-1dPfx32wJc-00g0wn; Mon, 25
 Sep 2017 17:55:13 +0200
Date:   Mon, 25 Sep 2017 17:55:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/21] Read `packed-refs` using mmap()
In-Reply-To: <20170920185724.ix7isdxfrsecxkjj@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1709251753560.40514@virtualbox>
References: <cover.1505799700.git.mhagger@alum.mit.edu> <20170920185724.ix7isdxfrsecxkjj@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:30yn2kqCq8J+ccFxq+03SNyMgFbsEbxPwXrLCePfrp7TbXIXIMa
 LgwDsw0UQzVehFkEE1ERVSILAbbVqRj9wj2f0510NdlAg1mD0G25vNQCV+uuJu1bM54fTBc
 jyJbmeRqrcHi9WBfztAZF5AhCf16zo1hXWbn1OY63ohzf5/0BQJCv6Esl0DQ+gKm2laRfGN
 QeekDAfgWGlihupQ3grow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WvULs04dfCQ=:FwPWgNRMsKa5cCzsYIjBzb
 MWIWD82mJNyKo8mYajzeSydoAWNo94EvlAcb5H4jVTiPrsgsqkKHCT11UsJM1rHVw05UnUrYq
 vldeB9k4+2ywlaTlQpe/Mpl5k24F14ifZok7RA86/DmlL2u35m856gu/K8/cMAOn1QYzyWIbb
 5NNOXBGE+xpp3O77/E/yAc53XoyJrbOl6gepgpKx2acz/tG1udHZv82n9i1TmP4t/Z1XQpPKT
 Esh00IpOZ5PR516qLZTZMXFJ2cZ8gpkNQXw/jH3CFK0rZLnQkASwqyo9l/pne9Ul+900q/EkK
 2/WN+wDW2t0Iy/JEVWiiVLi9LUcAETeZ8CUTTBeEoBip/5e8+sD+phQ4+Pob0CeaBQBiKhqrw
 DRTEy3jhda+xLqLkGXUl1vFJwQqIoxQUNc2ew7cU8yIqvrBci6+TuLDbiMwslB4hTWETuBJT7
 nMpCm7UVTCk+sfPm9phJMrCd+0OxDr7E2m4SVm2D3TDK9GyEkWBbCFFbFsmWtSg5xUCeN8ktL
 WS75k1dTNAzPm5jUxZKA1QXKKLEcYBzffubgnFOsUf3HnEJ7h1EBsnsM68jsNU/FVyLVUSQLN
 WPjKcOOh9LhoTKS9FzGv3kYqQj2KC+HtnV9QpFXdakSrX0TpuAZkLildq2PQqX1DCk9MsYpvT
 Wxpx79kAxbHFVZdIr4ZnqJc6RrpLYDfRHxk+HmgfTyMFPUAfpcHbu+J8GwfnTt8fKS9zWVF6m
 pk4XfVY9DusoTS0r+Pn3kN5Cr1oDbhdm4kQs1whIZgoQ7J+Jydx+yMQ6nfvV2ibTYKuBvG36Y
 nuHf0JlTjZ02fm+jixscKoRowUemW3763WDnuQrHsI8Bn3sGwU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,


On Wed, 20 Sep 2017, Jeff King wrote:

> On Tue, Sep 19, 2017 at 08:22:08AM +0200, Michael Haggerty wrote:
> 
> > This branch is also available from my fork on GitHub as branch
> > `mmap-packed-refs`.
> > 
> > My main uncertainties are:
> > 
> > 1. Does this code actually work on Windows?
> > 
> 
> I can't really answer (1) due to lack of knowledge.

Sorry, I have only a couple of minutes per day to look through the flood
of emails from the Git mailing list and to answer them, so I forgot to say
that I had a VM build and test Michael's patches, and they worked on
Windows.

Ciao,
Dscho
