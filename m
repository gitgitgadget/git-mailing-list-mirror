Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440062022A
	for <e@80x24.org>; Fri, 28 Oct 2016 08:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbcJ1It3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 04:49:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:55372 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbcJ1ItZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 04:49:25 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M7UUd-1cmuc026Fj-00xO32; Fri, 28 Oct 2016 10:49:07
 +0200
Date:   Fri, 28 Oct 2016 10:49:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Lang <david@lang.hm>
cc:     John Rood <mr.john.rood@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: feature request
In-Reply-To: <alpine.DEB.2.02.1610271623260.4123@nftneq.ynat.uz>
Message-ID: <alpine.DEB.2.20.1610281047420.3264@virtualbox>
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com> <CAGZ79ka7BvaW2pkjeXe68yKHFq6JsH__x2cXoe6U4tRmZ0rY1A@mail.gmail.com> <CALj-rGfAyimf0nFFcDHVHUgj8PQaz6Cvoz_PQfqdhr=QJEpbRw@mail.gmail.com>
 <alpine.DEB.2.02.1610271623260.4123@nftneq.ynat.uz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XZ2zC8zem9keO2eD4nCCCProM/+8f3QZ0ImPKa9n3B+GZSj7LCc
 xb0hpp07j/VU72C2FWKhdP8nGK7GL8k5CopEEbLky1zLUuygwABxgKXsY9VreS2L9hjH5hj
 45EclglURsS3IKX27b+lsILGwneCGqsrgwtV5YM1nTUCnhLhKLUgSkxmyHtRelyCtNiFTKi
 1piud74WJ0G0Sn1QcDwxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ec5L86c6I9M=:C2KxYUtAkIPTb5wJE/I6Lj
 KzbLoWbLdY9bN3aSbFOEOxXjiaLiPzZnN4odiAMz7MWoNUH6EJtPJJQNV7oIBos1WhgSsd7Di
 llL6wwjOtl2CKii+zRgMFaMmC2y6h5rr3o94pUU3p7ckkGX5+KrYs0QU8CVeyROHwoLaP5AY1
 Uh6TS+rIW916mrIttPyA+fv0GkoHx/21dCAX8BkuLPDNsIBlJsjfKPHgPRtKAMVwZk7JWjaqV
 5Lt91lQ+bR4YYMaVkByalfLT4G75y2D4l8j2P0/K5uDuvXr2sSe7JTB1aBkLKWNzZDnwAR7wZ
 el3x+Mh2q6UxPf/7g6UKJsHztaxFpKGhYmgj2gb1RysDj2FMcLhdEx3vY+6OHhi2RHl8k8rSM
 EYJ+MZEyx6qqDDW7roqFMvnAzRsTeds4Hrc/FSANLYYPVxDpVe4+0KOZqGbZ5pNFCxnEXZP6s
 4lfokUiZVd+deOXHVx4zuntlogqj2o74PBqEfWFO0AKix+t2ZVHRUt+LaN3M1X37bUWjxtX2V
 3aO54WAiOpIAyI71wzARJDPNkK3XGlaHXo+jAUY0fzr6EEOHsUI2lurL6r9bSmKpYoB2pq8Df
 PcvgXhq82ILJq+YtPF8Yajz30SDU2Jbrq51WwCoOA8aj77pnP4K5Mv8xi2RdFM3CJ4YVAKTSf
 3RMSwR7+V9IW/YHzIWW6XXqamv94lVVYptLvyjx0NNy7uYugKW7WWMFn3YIW6qyV0KMQCKdKR
 7Osq2FXZwU95bIKB3nlf20EH1QRPMZVI/dPkk1NwD89aVjESeUO0vzrCpuz/lSwTUKciRtXAg
 ADXYRIt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 27 Oct 2016, David Lang wrote:

> On Thu, 27 Oct 2016, John Rood wrote:
> 
> > Thanks, I think changing the default for windows is a good idea.
> 
> notepad doesn't work well with unix line endings, wordpad handles the files
> much more cleanly.

That is why we have a `notepad` helper in Git for Windows that converts
line endings transparently before and after calling the real notepad.exe.

Ciao,
Johannes
