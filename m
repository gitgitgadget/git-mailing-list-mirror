Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1BE1F859
	for <e@80x24.org>; Mon,  8 Aug 2016 11:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbcHHLto (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 07:49:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:57536 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbcHHLtn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 07:49:43 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LskKv-1b4RZq1fHl-012FoL; Mon, 08 Aug 2016 13:49:23
 +0200
Date:	Mon, 8 Aug 2016 13:49:21 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] t5533: make it pass on case-sensitive filesystems
In-Reply-To: <20160808112147.b4ypgazlorlyy752@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608081347020.5786@virtualbox>
References: <93e1fb21d1d24c5b751e2d9d25d9220704bae5aa.1470322425.git.johannes.schindelin@gmx.de> <xmqqwpjw4fmj.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608051613570.5786@virtualbox> <20160808112147.b4ypgazlorlyy752@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WcztPIUszA0wQNXKWMrNMhlkV+41mp5UXWb60nOtuuWOHlL4HKL
 0XQifIyTvM0wIOYyzZx4zDfiODp0It9VOx/jUezz4bfqB2lPIo5+8BsORvRVS5T9fsQHYpD
 KCh6DA9h2oNXGsOItRBx86S5w+Y/ahLal9YR8PT/7VhnqtV1cMJ05CoC+nOBVejH6f+R6kN
 aNiI9P9pq8WbtrqfKru4A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:77ltu9ZHLAE=:7T3vpxodXyCzc8JdHNkop2
 zzhQF86Lpqu3SMrzk8Tkhf695VARcHftxXo0isI5cIaGnlCGo4zecBvUT8e/+3i4+v+TVWhsw
 hPtbq0fyGs+QlxmQKIBqiazkQKqpxHM45yetN3xZVTUJs5S81YnBXb7PnFrf/3TYwm9taNL5L
 TF2DmezIHyW4A43ox3k1usRsrC0SavBrGNTVco0SMmo1NxmDs0n2TdcO+nr/x7TLCGQiApEmi
 46R+OjEyYoWCv6XbTv915QLvnVnNkvyI6oFkyuhjpnN6sa771kpmMf4inBxs3VXk6tn1R2h1v
 Y1QzVbZakQfy2rs+tk/iv8ji1WP0YRTFwq60J7+r8dWj9kUp5LM7FETcntjAxM1SH7U5A3bru
 2LVdNfszjpQaHy4We4Wxo3Ub1u/JDfH/jKWPMaPYlUBgOPnfSAi/hWEVYRtmEqF0l8tvIJPPS
 3zct9DMd23d+pAFGRDnSBG3LdJhqKMk09+bFv3jokjdy9wlELGzf2N1dkjhH5inVSYA5YGauO
 0EXRS1gayjQOO059p0uEoU05babobmgQF+kR59nipnYjSTzTdLBJ4pNxMdWLqdkIA4GGRW5gh
 UfYp0JILxgIBJVRN36owdI7G6hKjdxHaKLXyJJnvbzL0Cs6Tj5sWqRw8EASEZXLxWaZjFkkgX
 2QBAn+AFR3yF5CUVwzrMmfCrCsnmluVW35QkgD0ncH5uZjKvelxSeN6hFPlPC8iig4W/9sQWQ
 pclES85A72kObaRVrFYmwIBgXvx8thdhXiCWhwt5+58ZiPAH7P1QvVro53Mysj88NkfMnzwoH
 yE0DrGJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Mon, 8 Aug 2016, Jeff King wrote:

> On Fri, Aug 05, 2016 at 04:19:08PM +0200, Johannes Schindelin wrote:
> 
> > > The fix is meant for jk/push-force-with-lease-creation topic, but I
> > > had to find it out by the old fashioned way, i.e. running blame for
> > > these lines in 'pu' to find eee98e74f9 is the culprit and then
> > > running "git branch --with eee98e74f9".  The only thing the line
> > > made easier is I _could_ start the blame at the named commit (which
> > > is on 'next') instead of 'pu'.  When I took that "base-commit"
> > > series, I was hoping that it would give us a lot more useful
> > > information.
> > 
> > Sorry for that. The way my mail-patch-series.sh script works is that
> > it tries to determine which branch between `master`, `next` or `pu` is
> > the base (and it then submits *all* commits that are on top of that
> > branch).
> > 
> > So my branch was indeed based on `next` for that reason, not on top of
> > `jk/push-force-with-lease-creation`. Otherwise, I would have
> > resubmitted John's patches because the script would have determined
> > that my patch is on top of `master`, not on top of `next`.
> 
> Do you fetch from the main git.git repository, or Junio's gitster/git
> workspace on GitHub?

Neither. I typically fetch from https://github.com/git/git.

Even so, I can in general find out relatively easily what commit is the
tip of the branch I am looking for.

In this here case, I was just too lazy (or too busy with other stuff,
depending on your point of view), is all ;-)

Ciao,
Dscho
