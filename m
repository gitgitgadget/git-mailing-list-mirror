Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B511F859
	for <e@80x24.org>; Wed, 24 Aug 2016 07:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbcHXH5n (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 03:57:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:60720 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752279AbcHXH5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 03:57:42 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MIyCj-1ba05Q15zt-002UXV; Wed, 24 Aug 2016 09:57:29
 +0200
Date:   Wed, 24 Aug 2016 09:57:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] cat-file --textconv/--filters: allow specifying the
 path separately
In-Reply-To: <xmqqy43s3fin.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608240957040.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <787224ce9a382ddd1180a408e784ca26993e5603.1471524357.git.johannes.schindelin@gmx.de> <xmqqfuq26mu3.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608191521410.4924@virtualbox>
 <xmqqy43s3fin.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EuOubJJzD/NL6Qr2Os4vdJRx6ywKcKDMvlVkFpa2oJNc6ppEFTe
 P3QR2G2eO6PPf0M9lTYU9rY3SknO+OniH5vtFsrYhLPj4CyFtwTvRo9EgIleHVjO9oPpvNU
 iLF/g7G/EJRisNZfYp9DTCCkQFJ96CLxdUCdiBA7hfx3jJVN4HkV++dE+rxcK/KkI1OgPeY
 vETtCVGt9CPjS7kGI3avA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m4yQ3PUuSPo=:MLYjYFGN0o4FXXuML8pGxf
 xGQ4s9gKC5oFtm8W72tASCvcc6WYL8k0eZV9u/TnJnWdh6y+tu2v/p45/Mz8wRpaPFjEHasCs
 4MWQITJFSGfcL35CDgXn8vH31+uaZAyaAhz6/edg4Yn1QdLkA4cHX0VayCbJU1UDnt7tqsYnJ
 qkQFUyCgsNvUfpz6titPK2SYIGi2y6DIkIOKyz8EnK/0/yQzsMAJyGMXgPWzRY5veSAIpsLy0
 cCv2xyTY2Tkn7pAgcrOSWbQKO+0OWPat/yrwNvupSZVcTjVUcPDuWMV6Lq0hQ6O73PnmnPEAj
 SL40TXCj682ywVBkK4I80Cc39IVL7Uk+54Fd5ElqweO6PV61D8tCrh+nvfKu3mwmaANh/ozz6
 x33aTwzx2qRnNcYU65so2jeT+9dsM5gXrdABBnPfM6Gp6GNSh0PLgcqHyhyD/YO1BbWP/sCR+
 EC4CMDhsCjUOatVMMiO3MiqIZmgN0NbYJJwtB4TOh6bwsQ3X+yOUI9ofoMGubSEqNDdOBQ3xZ
 o6T+UBVMEPC1cGGfQEUW1bFIATWR4e7mh2vPK4bVPuJP3yY8/aiM2E6iMe2RkjG9mFCbD0QPf
 svLHcF7SWJxCWp/O+KJOUcht76eoyia5lBu0Zxy6LORI0qaN57Sy6/hKY4XzKO8VKJ3SZkS6X
 H/Q/dsJmNdKow7j5ExX5zkH3ymuH4Ogpv7WhFvaZ1KWE2Al8/r+DD3NjHUg2OVivqkbSu5FZt
 XaXJQ+iRQvFgl3br6ouFL3ZridBaQqmiQtTcvCzM0eURaLQmFbTOH10J0S4NPgMTkLmZSDZVm
 7/JmT1e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 19 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I think I saw some code to ensure "when giving this option you need
> >> that option in effect, too"; they should be tested here, too, no?
> >
> > No, I would rather not test for that. These conditionals are purely for
> > any user's convenience, in case they specify an option that has no effect.
> > They are absolutely not essential for the function introduced in this
> > patch series.
> 
> I didn't say "you would want to test these, no?", did I?
> 
> I do not want to see bugreports that say "I wanted to use this new
> feature and by mistake gave only --path without giving --filter; Git
> should have complained.  I found a bug, hooray!" when somebody in
> the future refactors the command line option parsing and breaks the
> check you already have.

I added a test to verify that --path without --filters nor --textconv
complains.

Ciao,
Dscho
