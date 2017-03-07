Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05A91FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 23:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756529AbdCGXG6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 18:06:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:63378 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755817AbdCGXGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 18:06:36 -0500
Received: from virtualbox ([95.208.58.5]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNZ9u-1ceE121M7O-007CIC; Tue, 07
 Mar 2017 23:34:10 +0100
Date:   Tue, 7 Mar 2017 23:34:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: Re: fatal error when diffing changed symlinks
In-Reply-To: <xmqqfuip7y07.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703072332370.3767@virtualbox>
References: <CAC0icTZ87yeYndPFyjD4nkJBcw5SC-bgUJYbEzYqH7YhSFZvuQ@mail.gmail.com> <xmqqshn34gsh.fsf@gitster.mtv.corp.google.com> <xmqqtw7j1i6d.fsf@gitster.mtv.corp.google.com> <20170224203523.mdoh4ivhwflmpr6j@sigill.intra.peff.net> <alpine.DEB.2.20.1702251336420.3767@virtualbox>
 <xmqqfuip7y07.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ppdr2mXgbmqo/+J8+++2Jrnyq7ElP2MzIiP0pWsw3ar8WAnvZPK
 sJN2dFygjKEv9zXhWu9CasGoU+o5zWYyRlDcSvs/fZQVNXRlHkrArVmXwzjI/bPfdjDHwyM
 /Lrn6HabMbKiGTwEV29uWv5QRp/9Sde62Vo6zExvEfdw+/SixwdkkgYPCwyZi9cd7PDplhI
 tk7+Su4cfjmx3tBgBZKjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xnIHwgWMJb8=:jiprPK+mdkdeF2dm5qiXiD
 haLgWpONxGaPwBXYYjrSX3Zj2+kU4dwqmr7AWSDQN6Wesdemo+sK/qhZG19k4xTwNV8SO2lwG
 azi/ESwVcSAJSX6MHgHpgxQ/89OLKoQlznYImUjlDQMd6bSDvi50U0e9nx/294WhuxV+0KIxD
 OxkC5yx72litXaZtPthV2zikr6Yz/BYTv0ZP7699jo/SIPUMlJOCy0KQfGWgUgajvjYGkyDox
 hDFxhBGjzBE8GnNuQejtTDLOtV4kTv6+34kMw9Hp4pVBgLR6R04cf8+08GkB6nNDEtl0n7lJW
 nnynzCB/RSWkMkHt6ztTJp4aTRkKs53Nn2r/s0zYZdFfQaUAX1Ca1hN7HO/03ZIqaE7+cfngZ
 SRTmoOWyJNu+WqvGUq8Nx7TXHZuZBHpmWv1GzHyNVdDrMhj3zWHUVOqivYXzSHncSw+DDwKpd
 gl/gFz3TaqvAyx7wwf0oHr24s/PRudC1kSkvAWC8MvQZ5NjlNB0SujPgTjhfmjSiFR5wWfvPb
 t/7oNzlMf2e9Eu5IfAhin0myCnbEwtrab/yMazlqJV8UMliQ/2fiwB08c1v4xtqkHovlFCqr+
 ZSzzCwGQU5Vfb0uufQ+gyj2V1OSJCuuXIHdiOn2GhkEQL1vD78reCzVQ5O4iXrcjUUnw94VtJ
 gJXnDdsB4c6H8XQqiFYJlpKj6lkue+S0n2pKbCOQvykZfIPa56xz7yIjbP9IHEwD1IM7vjXvi
 w1m0iOKDCO/PuZbWYxsJEdDuR+TjYilvSsFHFtbe+JvbFZBbTHWcFvwcNXjloZ2PHcwuOAAkJ
 3b23DXF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > When viewing a working tree file, oid.hash could be 0{40} and
> >> > read_sha1_file() is not the right function to use to obtain the
> >> > contents.
> >> > 
> >> > Both of these two need to pay attention to 0{40}, I think, as the
> >> > user may be running "difftool -R --dir-diff" in which case the
> >> > working tree would appear in the left hand side instead.
> >> 
> >> As a side note, I think even outside of 0{40}, this should be checking
> >> the return value of read_sha1_file(). A corrupted repo should die(), not
> >> segfault.
> >
> > I agree. I am on it.
> 
> Friendly ping, if only to make sure that we can keep a piece of this
> thread in the more "recent" pile.
> 
> If you have other topics you need to perfect, I think it is OK to
> postpone the fix on this topic a bit longer, but I'd hate to ship
> two releases with a known breakage without an attempt to fix it, so
> if you are otherwise occupied, I may encourage others (including me)
> to take a look at this.  The new "difftool" also has a reported
> regression somebody else expressed willingness to work on, which is
> sort of blocked by everybody else not knowing the timeline on this
> one.  cf. <20170303212836.GB13790@arch-attack.localdomain>
> 
> A patch series would be very welcome, but "Please go ahead if
> somebody else has time, and I'll help reviewing" would be also
> good.

Unfortunately, the obvious fix was not enough. My current work in progress
is in the `difftool-null-sha1` branch on https://gihub.com/dscho/git. I
still have a few other things to tend to, but hope to come back to the
difftool before the end of the week.

Ciao,
Johannes
