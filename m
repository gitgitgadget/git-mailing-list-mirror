Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31904202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 15:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbdCHPjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 10:39:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:64599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751657AbdCHPjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 10:39:14 -0500
Received: from virtualbox ([37.201.192.247]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgGDK-1caAny40xi-00NjZw; Wed, 08
 Mar 2017 16:37:25 +0100
Date:   Wed, 8 Mar 2017 16:37:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: RFC: Another proposed hash function transition plan
In-Reply-To: <22719.59633.269164.986923@chiark.greenend.org.uk>
Message-ID: <alpine.DEB.2.20.1703081637030.3767@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>        <22719.680.730866.781688@chiark.greenend.org.uk>        <CA+55aFyyi0vBBApf9grYQzF2PRZMjtCzkB4LzYvLpqQ-Z7QfJQ@mail.gmail.com> <22719.59633.269164.986923@chiark.greenend.org.uk>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xW4IVeLlSza3qV9vq3AJud/iRWHLVdcvbJtV9mq//khUNHfAGtK
 FPta0x+oq5mZ0xYOPcbB5z8ijeVLSf9cMlrecZvyoSaz+c2YVHuJiOZU+gRUg3YPdc8bTIY
 4X1dbHy/rAoL8QwAznCsqRBm8TYHq43/vOHAHfMaayQ21mWQ4oHrhGbd/DjifH88IJ5PUxv
 It/yHRoFnnejxw/X23K/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RcLR0Xfci8A=:yoxd57G+pRrX1+Br6DYfOK
 j1S1EU8/TqTe3VysWgKL1eRBIfzLhFwMnkH0q5YK1ZzKL/wGCElhwH8YwTmjsW6+ED3iky++H
 HsAAbLsvrlJBUkORg0yho+3CH3tjea6eibdkEN8kl0L3uY5AT9bOg9KlM9uqgJGuyFbQDpTSx
 0zTq0XN5BA5buzRQK0qTWavZ9v2YRSoERSo9A5cGdQ6B27sdmFV1jCOb8ODIuCGoMS0iWDxSV
 h/BTIdFXdkn6C6EMYhbcc+MGgjA+kWxuPQFRkhg98x/4ZG3XEPQ9G33vEHhsAKmZm3Km6PNr9
 GYDL+c+AupkuLDmEQ8meOkMzNXyZp8DtgN01MkhDMjlIOxLNQLGoQGfWpZpmIMAXkdU/0WFfC
 w6Jn/rWEPGRgFWQIc+GfE8eKcMrbccu9YTZnkNxthnGrnDm1ZOT1m7XdWqfxoWGYaR1nWc2Ff
 lcEuKSy0xnJ0O5OvQO7gakrIwY8LwjKpgxMywG7Sk81h+M2hF0guk0wV2EJjg06g4lD/BisqL
 fMvKwgddXDACNeT4GheJ5so89Hd1LJRHPmLa5Rv808Fn+9QDPj8tmBLEmPRaMLdcvc+QAaC+R
 QhRESzNX7V/GbfdklfcFwYeWnhZ4a911HUZU4MFE4thIRw6tRd98/q/EhC/kiowyhiYc2QOQP
 Qd16NuRDPjZ2JcumevUSwPDS6ajbvscnb7Lwu0qtWIL/GYTPpcH4hzQWcYFkSZfNG1neq8cVn
 +l9YzGRIJHQesJxn4Iu9Nt0Lc1cKx/woa7QnKtI/ZOJ5Z6Q2MwRQPjgDyS6Pms6o4W+bTw4hY
 o5jNJSb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ian,

On Wed, 8 Mar 2017, Ian Jackson wrote:

> Few people use uppercase in ref names because of the case-insensitive
> filesystem problem;

Not true.

Ciao,
Johannes
