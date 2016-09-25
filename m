Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BDF1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 18:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756369AbcIYSZs (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 14:25:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:64042 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753951AbcIYSZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 14:25:47 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lvl0u-1as9r53lYS-017XkW; Sun, 25 Sep 2016 20:25:24
 +0200
Date:   Sun, 25 Sep 2016 20:25:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 0/2] patch-id for merges
In-Reply-To: <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609252023320.129229@virtualbox>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net> <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net> <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:piSqI6UNiIss8EM0rEAgpRikAAvU4aVV+HY7duUcxw7lynvA2hP
 532El361RKE/ZO9SNY6eHVrGcywT4Z3bDpN5pR4erRnsxcr299rToWoG6UE7nzERvdijDrU
 wTd7Abnq9FNC1qJLaQnm++W5i3ubr8RZoBG76t6+9LDHc3kZ8eB9SOXRa/Nz2v+GCH6EbJj
 lFxn4KxKe31JoaIaghQAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4fW4+hbzYCg=:a/gWV1tho01Yp+8jH8kcmF
 5sDMEL258vxgfk49frKRBumiAeR8az0Ub7iDRKxgXeDvZejzUgNiJ+9DY2Rj6jEXvasb0RdFe
 pvrspC+qVVNLpurxK7DIKGaCWJPXqSYlChQzbNFHXsMn5E4T7TdaJTsSF5+pTBt8jaJizIr+w
 xDIUsGlRco+4Y6XtH906RAXfA2NBhtYO8f9bbQSywyoMGyoHqk5Y6qFxdkgpJevPsFdB11M8v
 tzY/xsss46kf3i37iScC8VZ/EkqQOMFHJRPgpYIKDKONRijWhggyLe/hRf3/Thn6fNcdsQO/N
 7zKnn7oUaKhFbLawSrFzirl9XIvCCwkYq05d11lNPNhxe3tnPtZyRxOMezBjrGnClJz7c6jTM
 XGBSA5O+Bx9B35kaBF7l8QWy24XX9tHOSpvjV6XhkE78Czy0qWbLSntJXtnj3FRAJmM1q1JNi
 v4buPIjM1Iy5bFn/OBp4/xC9EQfpzCd3k1jlEC1X+LkIHYsT5qJU2HqpOtpFXvOYSveff2uZ4
 HcrfWTQpcyMwDPjkvHp7jM5Unj4pUCgSsEqvAd8YK6rR3BSYjWS1dZzYxa9H4L0hd9VYa4lS2
 rFjZyHmIBKm/BOSIks4B0LqsEi8jEFM80ohWD/ycH52wXv0zzYsvz1Z2c/UcmjrD7DpFdCWbS
 0fzdhs2EWgPstKSiYGhbmJAzVM8qDZbmswFFbSBZ6K0796Uw+/AwXrjlKvvmudirFCvxtDjMX
 m5DZ5strVmb0SwPYrok9ApY+K+784vxmLYcHHhkViJGKT8/JNzIUdsshExv/WoRZuI15S7c1J
 K+synjJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 9 Sep 2016, Jeff King wrote:

> Frankly, I still like v2 better, but I do not feel like arguing with
> Johannes about it anymore.

Sorry that I was a pest. I do care deeply about making our code cleaner,
though, which in my mind means less of this "let exit() clean everything
up and give the callers no chance to do anything anymore" approach, which
to me always felt like we're basically teaching Git to shrug instead of
being useful when something bad happens.

Ciao,
Dscho
