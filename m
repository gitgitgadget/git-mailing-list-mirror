Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED18208CD
	for <e@80x24.org>; Mon,  4 Sep 2017 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbdIDQAG (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Sep 2017 12:00:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:49320 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753764AbdIDQAF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2017 12:00:05 -0400
Received: from virtualbox ([37.201.193.79]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPUZ7-1dt0WB1gtV-004gWN; Mon, 04
 Sep 2017 17:59:46 +0200
Date:   Mon, 4 Sep 2017 17:59:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Jeff Hostetler <git@jeffhostetler.com>, martin.agren@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH] hashmap: add API to disable item counting when
 threaded
In-Reply-To: <20170902081747.lca2kkzpniykdxy2@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1709041758350.4132@virtualbox>
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com> <20170830185922.10107-1-git@jeffhostetler.com> <20170830185922.10107-2-git@jeffhostetler.com> <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
 <20170902081747.lca2kkzpniykdxy2@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WZfKHCRP/QIbmk1brkI9lWcOTsTJNF6kPsb/HOt9Ctro1mSYWi1
 J31xsu+ZczcRBBhQloVTWEabHaG6qqnVmjtFnZdcXVj4G34oC6UDGWp6i71TvOdb7xQpFvw
 2lmIDb9zc1hN5Zlf2b0QPlgNXcDaC2+PSudSuSs19N480WCW8i4OUNEDsWRLxnvPOJBzL7f
 cgp18B1bpyjZkn5wQDGYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JuKCp5/BQ4I=:Yi7p91MXF/sXD2r7kPQvAr
 pVAcxqVRvOLTM/yh1KbzQC/W9zcXdr9qVfZ05joyVDOiUlO32Rj+JjlOM6AG02HIWu3jgp3Z+
 nlWvsudosyAI240eue/LLZ8rTeRR5pD2xJ7Bh98upIBayuQFm1Y6a/f5bgjbrafhMCb1NB8Q3
 QFyXklxaBCjgTxV7Z7R+TNswNxFkCafUjDuQbXWNuh5nRJMy899+5K4VLL1zk752Bdz0SsRdz
 Jv0Yh4KqZhhZM3eMRmPFzOE8fzemrHfIIQWTk0uogGie2jOADt49RFzJzLcKGAYTh4Yrq6NHO
 FSGd75m7iC3/s73BiEemyFtpcpkKiSRVOFiY/rh2XqyiH4WnRTSSEHEStiHHpyNinH20k47JH
 cGfMmJQKLQ224dQOfYKhPey7riNPD+guuDybu4bTVVp6penNHV4ErLUp1R2LwM1eTNhQERGID
 I4+djSJP5/m+bVPUgZ3I/Arw3BznPyYrSft1K+vYOPejxEacPAm3teXzuJgzmJ3oziBEE0zaC
 QF5yzv2fJ6zDrb1YZR5/ZArLf6El59lb+R68O03i4VpBY38q+GJYj8vd3dJjnjyE9/gnz5snH
 5o+spSLqip4/lJQDLprgwUs6ErZ5vbKOI+Bs7hJKsD/ITLlFKqvzCG/M6OZx07awAz0aKGKz+
 87VIAKg/ZhiEmSaejWWqrr9DkufHJOFMKOZ6CsaZQzKyor39X9X0/ShaDVf+8hESvvVyCkxOL
 WxQO4leYRPMeJBdon6ODg8GG0A/8Q76QOfjFUAYajSpSOylEbUkZwghSHE+aOHy4K3c4HeeF8
 upP35RUT7jUtDkn/QPA95UQNQJ8S05h1it9K7skETlA2zG8Q4U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 2 Sep 2017, Jeff King wrote:

> On Sat, Sep 02, 2017 at 01:31:19AM +0200, Johannes Schindelin wrote:
> 
> > > https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/
> > [...]
> > > +static inline void hashmap_enable_item_counting(struct hashmap *map)
> > > +{
> > > +	void *item;
> > > +	unsigned int n = 0;
> > > +	struct hashmap_iter iter;
> > > +
> > > +	hashmap_iter_init(map, &iter);
> > > +	while ((item = hashmap_iter_next(&iter)))
> > > +		n++;
> > > +
> > > +	map->do_count_items = 1;
> > > +	map->private_size = n;
> > > +}
> > 
> > BTW this made me think that we may have a problem in our code since
> > switching from my original hashmap implementation to the bucket one
> > added in 6a364ced497 (add a hashtable implementation that supports
> > O(1) removal, 2013-11-14): while it is not expected that there are
> > many collisions, the "grow_at" logic still essentially assumes the
> > number of buckets to be equal to the number of hashmap entries.
> 
> I'm confused about what the problem is. If I am reading the code
> correctly, "size" is always the number of elements and "grow_at" is the
> table size times a load factor. Those are the same numbers you'd use to
> decide to grow in an open-address table.
> 
> It's true that this does not take into account the actual number of
> collisions we see (or the average per bucket, or however you want to
> count it). But generally nor do open-address schemes (and certainly our
> other hash tables just use load factor to decide when to grow).

In the worst case, there is only one bucket when the table is grown
already, is all I tried to point out.

Ciao,
Dscho
