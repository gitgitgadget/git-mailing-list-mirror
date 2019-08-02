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
	by dcvr.yhbt.net (Postfix) with ESMTP id 705E11F731
	for <e@80x24.org>; Fri,  2 Aug 2019 14:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbfHBOsr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 10:48:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:59075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731923AbfHBOsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 10:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564757323;
        bh=Tsv8myBxD7d0gfUrFxzc2uF8bz5vQzAIvoHD1865hNk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ba8U2zCKhxIlpk4KRfh8X6HIbBiRWusqi6pDebmKu9csI/uS8MUm2NkIibRbxcoVY
         wvR7QwmaUK7x6lLSA5cILhKuZy7l4rZkx4QqIZJWyfpEMvGSHcWoBQoMuBlbcnktCd
         5SM2gI+MOtNKo8DJZbIehYO/Ts/TapC9Buk+hSts=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1iCae634Fp-00ucCZ; Fri, 02
 Aug 2019 16:48:43 +0200
Date:   Fri, 2 Aug 2019 16:48:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
In-Reply-To: <2ed82d63-2a53-4aa8-a60b-d69150290a7f@syntevo.com>
Message-ID: <nycvar.QRO.7.76.6.1908021647550.46@tvgsbejvaqbjf.bet>
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com> <20190731171956.GA26746@sigill.intra.peff.net> <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com> <nycvar.QRO.7.76.6.1908021331590.46@tvgsbejvaqbjf.bet>
 <2ed82d63-2a53-4aa8-a60b-d69150290a7f@syntevo.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qPk3qILVCl9EeK9RbibvvdKFiasC+AKbsnpZOe98gBjUWMPc7xo
 dE6W0hloivbNBoohq9l4tf3agBPwFm9jai5AhMZwlzNQgd/MwhfcZCWRbSJf0aI3LZqTsUK
 Ln92eqByNA+5O2CG6rlScM3uAam+LtbJRDve7I7oY1a1idh9So+GH8gouKvtENmo0TkRMJn
 Uh15dyCzWdDcGHZaZlvEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3ogJNO6x3a0=:NNls+LdYCjwN6mIw4EYgg0
 RK8TQkGtL4m51AOCuYl3UqIOQmz+Kb3A68uPzZ02GIbMPiLzKgTwHzrGO5Bc7UHKyJkjLyxMA
 7vlTi0rx1UKdv/E0hj2WrVVl/IguBQiScPLKA6dk+pPM12Xd6gqt2RLWHvnq5UhiddCnOk0AC
 ZPvq9J4yOprXKfwu/A/WszkSVbPpXltd1vvGDJOtgHuiXNawAEK5DnwDqyBb0xoInNv+yPX0M
 ZlowUZJ46woW1LY+tPiGF3UWcYCdtDXpO8c4wFNYFn5BMwK2Gy0lPGVolVzSl35uAXRtMi21/
 gHGap7e7bel+cOG05bdiaPV3omp5j29POfO2Hb06me8p2RGFn36++Z4c1nCNEmpc2g58U/CS2
 WQs1J/wQQy6Isqt/EmuvEiIuSaCYwb3xunuJKxAklvPXVep2qwPEPmi86BCzRue053/2oihqi
 7fm/pkp9pMaHEoquxRhsNNPOFC3lkQ6EvYzJEUqlftD4bCTVQid10VgrErZdyZbEtNWYkfVYa
 ciysVld9UXU6NTO9NvM+cH9CMOgmeK5a9ItcN0pGlVwHTk1XDdDGLVu3+QeYA2cBWqbVtcjla
 dhAEcu/tCnaVNpQZolO6ISTBMxzqSH8J8cZmzDmGxFiDIK2EzVVNyfyq6Veka8yMOqnqFXvt1
 X81Depbcq6ozK0sdUq36wl2uNJdN4BYtD1dshnb2dfc3ufbKS1fBtB1Nd05WHgjrTCQ5Pk73N
 zAXSV3MvkUiFS/IEZHLQjH7+r3g3XyOl04vCIsxtPXgFCGElHDquA/EdprJmzo8fBsD+QQ9kC
 EFiS+FRz1X30iTzan0RrYHBbcofzbkFlKN9zAR+opbimgiCc10mMJl4P7WseIqR5btZ9H3r3R
 AudIYY+G4CtD52O0NZAIq3xXLuNozymlYoRv2NB/oN1z26e6pekA+tE/MCRi4roB80gMvfAI2
 y7xRCATn/9Gg8u6khQk+NgrjAp+8ElJi/RXCETir3dKnsecJTq4FACeuCVmQMm4JsLotz4uwI
 sYzqt09CMGxSHr8e04uTPp++iGETcQASP9GRkiT3UfA8J66AZDhwraiYBkqlMhhPm2yAVlHOM
 UdcBtfxAQV6S6ZLoYOdCrpORyORnQItPYSDu+F0V5BkACzOeLi1myK7KDyl2pONJjicVXnyMC
 DVKcQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr,

On Fri, 2 Aug 2019, Alexandr Miloslavskiy wrote:

> On 02.08.2019 13:33, Johannes Schindelin wrote:
> > Please note that I have a patch series (currently on hold because of t=
he
> > v2.23.0 feature freeze) to teach `git reset` an `--stdin` option:
> > https://github.com/gitgitgadget/git/pull/133
>
> Perfect! Less work for me :)
> Once your patch is accepted, could you please send me a mail?

How about subscribing to that PR so you get updates without requiring me
to remember to send you a manual email?

Ciao,
Johannes
