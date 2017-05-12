Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A957220188
	for <e@80x24.org>; Fri, 12 May 2017 11:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbdELLJY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 07:09:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:53795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932184AbdELLJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 07:09:23 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ljqgb-1dk7xI33VJ-00bsO0; Fri, 12
 May 2017 13:09:05 +0200
Date:   Fri, 12 May 2017 13:09:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/
 for good
In-Reply-To: <20170512091104.5yl57m4x6z5oxq3r@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1705121304310.146734@virtualbox>
References: <cover.1494509599.git.johannes.schindelin@gmx.de> <20170512091104.5yl57m4x6z5oxq3r@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gqEeqxcZ9+4i1BYx7JjblF/e9cqJhBNGmrPmAQixijWmnskgOTL
 TJxgWSrwjkHZ7+p5lRVml16lubXBIv9G7ketzlbil3+uwNOjerluFyD2c0LftzfqlofJPcB
 lB1/6D0Ok2yIElaaYdcdyRMP9+nvgNY2ROZbkpzyMxNSYkDx4ah4Tj0u4V6OopPCoWdWOOd
 3eWsh42o3y3qWWrBvJbOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QjswsJy4QPE=:VRhneKoHWlP81NBurlRDor
 E5ivWDjCIEoIxCscZ8XmOEh8if0Oy1w4oPKf32F4r1xnGrksB8M0cScwKf4A1zNzflxEGMQuW
 UUwEwK2bSVJnZd0o4GNsurGvfbL5+DtVjVH4+UqI78pZ6uHhcqYgpu5DjVM/y8eI6Wz22ajQ4
 0vbWCUH3fpTYrj74Lb8WJZSuTvuiWLTncrw8+FfTp5wRM+p74re0REbawH7iI0WUeWCHmEswU
 rzudgGpxhvYnFcN5V+OI5HX8C5iwBMqlVH+9naHGgjXBi7Fwobejn49rSt3Q/EOD3LI+DXpUU
 qRO5I/k65xdybgRP9XrULiLl6cE5nAo9GsdB0K5Wy1ccaiHWvi22jhlHDo9sVRmVsCrmfD6Rz
 UsrFxX3dn8iiHbKMyb3Y/iqInLOLRUKCvClv2nKGEU7cnHa1Zryj4+WkeJtGL+5RO5b7/8apW
 UnuiQNbKhpSrMqWy6Ry7c1z0xTecTA6wQJ6z+M+EUH9CBEWkRQ5cgh2taOp65N4IUoKRqGZG4
 t5y9l37Ez+T2XcdpyA4Yxx9QBwKnQ8cruiKgMU3PMZ/VF40JjNxo5vQkA4CaWW6TAm8FP0WK8
 +ZEfd6Qgl00QtrJz/T0H5zrigMEwtQMCswuxm3xNT2JKV3Yy8gu8dVDdGIDhMIuBRaJ3l23XE
 2XuPsrScIkIjkjr/WMXe7+WjxiP2ccuIsrqD+91PGaddugTT0UF+cMQQFckHaVhuErnsxs6YT
 yRpQrxlcd1XJ6tDOrdIVVvVYzF11hkFa1H2Fo7W/gGNH95q0gOVZ/Mpm4GHSmythoFIqqkdDd
 k+lHfHM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 12 May 2017, Jeff King wrote:

> On Thu, May 11, 2017 at 03:47:33PM +0200, Johannes Schindelin wrote:
> 
> > Git uses the config for remote/upstream information in favor of the
> > previously-used .git/remotes/ and .git/branches/ for a decade now.
> > 
> > Nothing in Git writes to these files any longer, and the most
> > prominent user of .git/branches/ (Cogito) is long abandoned.
> > 
> > It is time to start not only deprecating this feature, but *really*
> > deprecating it. Like, really, *really*. For reals.
> 
> I like the goal, and the patches themselves (both the deprecations and
> the actual removal) all look good to me.

Thanks!

> If we want to start slow (and if Junio is right that there may be some
> people who are actually using this feature, we probably should), step 0
> may be making people aware that it's on the horizon, even before we
> start issuing annoying warnings to them. This thread does that to some
> degree, but we could also put it in the release notes for a version.
> That's not guaranteed to get people's attention, but it gives more
> opportunity for them to speak up before installing a version of Git that
> produces warnings whenever they fetch.

Okay. I do not think there is any value in putting this into the release
notes, of course, as 1) next to nobody reads them, at least not closely,
and 2) people who still use .git/branches/ very clearly missed the release
notes of a decade ago that .git/branches/ is not the way to go.

Of course, it takes what it takes. If we spend 6+ cycles deprecating a
feature that only one person may still use, for what we know, so be it.

Ciao,
Dscho
