Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A261FBB0
	for <e@80x24.org>; Sun, 27 Nov 2016 10:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753626AbcK0K6l (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 05:58:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:51694 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753517AbcK0K6j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 05:58:39 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MO7Ca-1c7dFP2oI0-005Uz3; Sun, 27
 Nov 2016 11:58:19 +0100
Date:   Sat, 26 Nov 2016 14:01:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1611261400300.117539@virtualbox>
References: <cover.1480019834.git.johannes.schindelin@gmx.de> <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de> <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net> <alpine.DEB.2.20.1611242211450.117539@virtualbox>
 <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net> <alpine.DEB.2.20.1611251201580.117539@virtualbox> <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net> <alpine.DEB.2.20.1611251841030.117539@virtualbox> <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611261320050.117539@virtualbox> <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:55rcw5MIQ0cPDqM/3ajeN+MBrMSZdfQenpfvifp8v9AfdmOZ9aa
 xr8+/JL/ywjRxsnUyJ9wZHqBZhCNBTXeNYuuuVuAuyBToc6u2luHas0XZDUDN+f/pryqFnA
 trsxGvCw1XN5XEWvELbMpnfyIgniZjTj066PVvTBflNoznuxhQZHY7EU6QZwY4xR9/lPnfz
 z80oV2OV7yIskWMshZydg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cCU5irzmjRU=:m4X7KK9BN+WWZ7Da97WLBD
 u/p++r8wZRK4pHAvo9aZfs6wUWxvi9BZCnLhJ+X6SSdOaKapm39rEyyAkkqLfPy+buUa/zkmb
 n+qo+Z47WMbJIkRH0cZYqV3ggnqyg1vlJkwd+lNnde1A6E08HkvPhzEH0uAldJ/pImuuVvnMr
 DHbeSo1gwWn6lAeCRAJgP27AUmv6iBGchi5VAVYRJ6Z43hmNUTsSZ1d4U0tUxCg6ABb/+WJn4
 3A49X+vcXKRcznOMOQT2M5vjYLUv2niZEBn4SGk9mjYvQnSQRUH2LqjHOWJkNlbgliMxpyqCa
 slNmyvBAkB42fpxiuQtNIYkvAeZ37Dmsfzd9ZHmmeTOUgahQLr5li/GDAiDedohO/wY7MJs1l
 vHAqE2OHL5aEF6q6iwXjY3XNc+R57w86jEGu0YnD7r+qWkmFquMKIkjo97VdLXsdq4Ke2NMpp
 Yk0fZ1kDsWkOuvcky13s+iq81MbLDHT0PtwFjkAxpF4e9Na70LyKpoZj8sTeVIp6OnTQsC/ww
 bEqnJ2YiGwbL65vczIwiD27diBhpOK7PIbDbhjCvpENiTsDnQWLZyZNaHxCFRGGU8hhGLwbTz
 pMUxfWTJI3o+Y91VJ8K77aW1hdFXXlVhsX/GM2MIMdyybnHg710nDx5UNmpXb0ZDoO0MDEMNQ
 gl9w9H7gXKGuh37/Zl+MUnNWgy3Evw+nFvQ7lNmjCBree6UzfwFWfPGXhgDNYlOQ+B7+HengX
 izU/8wl1G8ptOFSFxsIem/V5E9dy5AbJHilFR7Z0OIEsXbJqb2+EydYnqNbec2f7yhlZ5pOko
 AcVj1TD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 26 Nov 2016, Jeff King wrote:

> On Sat, Nov 26, 2016 at 01:22:28PM +0100, Johannes Schindelin wrote:
> 
> > In other words, GIT_CONFIG_PARAMETERS is *explicitly scrubbed* from the
> > environment when we run our tests (by the code block between the "before"
> > and the "after" statements in the diff above).
> 
> Sorry if I wasn't clear. I meant to modify t7800 to run the tests twice,
> once with the existing script and once with the builtin. I.e., to set
> the variable after test-lib.sh has done its scrubbing, and then use a
> loop or similar to go through the tests twice.
> 
> If you want to control it from outside the test script, you'd need
> something like:
> 
>   if test "$GIT_TEST_DIFFTOOL" = "builtin"

That is a bit magic. I first used "GIT_USE_BUILTIN_DIFFTOOL" and it did
not work. My name is arguably more correct (see also Jakub's note about
"naming is hard"), but yours works because there is a "TEST" substring in
it.

Ciao,
Dscho
