Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3275A21B11
	for <e@80x24.org>; Tue, 21 Mar 2017 20:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932402AbdCUUKB (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 16:10:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:61087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757358AbdCUUKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 16:10:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5Lqx-1bykHn1OIh-00zYwM; Tue, 21
 Mar 2017 21:09:44 +0100
Date:   Tue, 21 Mar 2017 21:09:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: USE_SHA1DC is broken in pu
In-Reply-To: <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com>
Message-ID: <alpine.DEB.2.20.1703212105030.3767@virtualbox>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com> <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com> <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HVlECPBefBdAbf0yqqOfsMXJil0XL7VLXHfaUqx78weuqaTKIHa
 EMChj6XUwTnsNK96CJtra+c5d2v0d8Dsz4Wj1QE074jvX+Qbv4GM+BbJS0W/Xloe63rezqq
 6iYjU3RdhAU/aNu+dIjF1Rcnp9eBm+cMtTuPPoZabbEfseXAFDD+STkRRrqlDbsUK7qJBZw
 YWT2AOKFD+W3dy71egNIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YGqJ6XpeeTE=:MGBAmztBRVNoYnludpOt0i
 1ICCYLDr879MaSq3RX6WU4DrbJQwoEXPsbAmGYN7xxUC/ec5H/Xz0KGIOraQ/Sv/GdHH0L9hq
 Pj/AZLmVF+f1hiTghXBZzL9tN1YHnBAbLKafMPXbPQsrQ6DZOPTvKlCy3hXwpRNMecU+8E5hZ
 DVaLTk4to+Zw1gnUw+SOQdxkwwQAYlNR0PKvXjUpd0HXEuT/OR+XuDyI9j9/iUSCKhvryyc/P
 gQZoMdMlI8rJpvkVYppE8IHtv9UZwW8wb9NVHoVzafIHgsqf4wgIffavFhCEWJ0qy9Ws8j//C
 mnlNrMfA7/8lxOcF8Y2TINv0/KabLkPBhp09fVBO6KwH4DDvDnTVY7RkOjo1ZXxRemZ4V68+e
 3ZFrmqQgY3+TFnQAUprQ+QvhX1rWK+/B5fGNZIKKDyj9sHvbQ7HPnuWHqIREfKGX4SfZcsvhV
 Tf1aZq1zIsFblPZ9EOF4jj2X+wwldDKQa3c/2NdDONg8RozCTJ3yLWoBy7lOiKnaFY/yALzS1
 +VyPna7xDosfhJViw1qwvzbamTYfU+KxcMhEfI+nkbJLOaoIrRkabsO9/vk9fjs2izEfs1+t+
 /TOVGdMFvrwiWYwJmm34z5lvSQi7a0ekVli8lyhC3T+5nLH86m2hecBHbdhAFWpydzYtd2GkY
 jmNKckEAai2CsG6wcWM9YshMGSLIqwlYkebnoDkaXsuJi4g0xcVr1TBJZhQ3awNKwqaZyNvpH
 9rYPTGmNE38n+lgE/27m6gjI3+gGfpfiN+2Pb8VkeYsKCGtMLlPSrLITkvATTHtphv71/iNdg
 f9EG+YWiOLC/iyv+Po+g1010T0mNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Fri, 17 Mar 2017, Lars Schneider wrote:

> > On 17 Mar 2017, at 11:18, Lars Schneider <larsxschneider@gmail.com>
> > wrote:
> > 
> > Would it make sense/have value to add a job to our TravisCI build [1]
> > that compiles Git in a few variations with some high profile switches
> > such as USE_SHA1DC? Running all the tests for these variations would
> > probably take to long but just compiling would be less than 2min per
> > variation.
> 
> ... or just run individual tests instead of the entire test suite for
> these variations (e.g. only t0013 for the USE_SHA1DC variation).

The best solution may be to open a PR with .travis.yml patched to enable
this flag. And then report back to he mailing list because the gentle
people here are not that used to paying attention to Continuous Testing
:-D

Ciao,
Dscho
