Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5DB202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 16:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965226AbdIYQKR (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 12:10:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:58183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965224AbdIYQKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 12:10:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lcjgd-1dXb7r44qV-00k7M1; Mon, 25
 Sep 2017 18:10:13 +0200
Date:   Mon, 25 Sep 2017 18:10:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
In-Reply-To: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1709251808350.40514@virtualbox>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:crMbRpHkZ0p1JorQGqFjF3PaOfko7CENsqYcnXnzQFOl8KF1MJA
 3gHRHHwbhq70FTWHumzoqD23gJNAnwov/6wDSTGDC0qoMr3Wb8tOpZsW7cHSrIxrW4VzJhw
 cC48pQ8SOmNMGH9zGVHp6TTlmHxt7+tzZWDDxG2k2Tp3JdNME8O2EbRKpLcDaIKpHo9EDtl
 pLYbrP2hio3Qovw9DIDiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:94H5RnMO5co=:Z4R+ZmWPlTnqCdlSgdO3Uh
 Xj7myatL67UhKge8rK+whvYaKoevL3ulVAHiHdFarYnCMwibYW8q/eZAYBHT+6Mh2NSNxUFNi
 uTKfZtT7mOYZG9q5HOf8eFOR6rYU1OWJCrVlrI4BRRD+n3pLYKVYjyFPBL3H5U0CQp33ngKCz
 dBDebmOeMzH/GdJJhSiPXkNqVmaE9SZEwadWKokysEC01cuKO9MKBSN2DrkK+KKv4trktQscO
 Q8rOnauHUB9T2d3H7ugSb3XK3YuOan64D/uxSIK3LvDUUThyMEJzHhA8eNZe7VU8yfSYvYGNQ
 vZqKawEKZfwRaC9qSHnG3GY1pF0R72+57PRhBky3Iw4qWr/cETnCskoS9bIs5FrS94SbDW53l
 OSx06QzfgY/AsIh/dovvxEjGrBDByhulFkj6Gq4RnLqhPoAVukrklJ8D4+prVGHJBpaOcgTCA
 ZG5GgIvJfocFezlaGU4MnGnt72pZ62j2neEbs9upCK/SxMTrrv0eWuB0kwxrV3sA+zL4InxmE
 FSERdetoNUF/z9g0uIKSVnR+FSyVjhF00AwuJsXeJGP6I0Xt2Dt+tUO3KDSlnoYUWK4N8bnFe
 n/Q0ShiAtK5p1z7ZaKCWXTDInutiST4MhjX2npjCj6a6+mLgaX9JChh8V5cpfwijk79ttepHk
 kVZFtxvS4W9wqz3rrPKi2BG/evFYWF5+5wm6ky2dBuEcIIEvHQSQLVDZvh4idYFigvWVHCGr7
 vRpRBIO4YOwi98vMdv4TajZnOrvuUOYq7nzV0w7dvVv/kQA4+DQTDxIzBs4WevZRir5HmWkTl
 11xW/Y03fKqNuHfuHIhpSV64jjqgGyUrm7j7Sb26CsELdlfH2w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 21 Sep 2017, Jeff King wrote:

> Johannes, this is an adaptation of your 67e5ce7f63 (status: offer *not*
> to lock the index and update it, 2016-08-12). Folks working on GitHub
> Desktop complained to me that it's only available on Windows. :)

Okay, so this is trying to help me by upstreaming a patch from Git for
Windows?

If so: thanks!

The changes, in particular the different semantics, will guarantee that I
have to work on the consumer's side here, though, leaving me even less
time for the Git mailing list, so I will need a lot more help with
upstreaming patches.

Ciao,
Dscho
