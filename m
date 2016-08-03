Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BAC1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbcHCQey (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:34:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:53830 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751501AbcHCQex (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:34:53 -0400
Received: (qmail 5641 invoked by uid 102); 3 Aug 2016 16:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 12:34:52 -0400
Received: (qmail 1764 invoked by uid 107); 3 Aug 2016 16:35:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 12:35:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 12:34:49 -0400
Date:	Wed, 3 Aug 2016 12:34:49 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160803163449.iwjv4youmsf6okme@sigill.intra.peff.net>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de>
 <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 08:33:12AM -0700, Junio C Hamano wrote:

> On Wed, Aug 3, 2016 at 4:59 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > I disagree, however, with the suggestion to sift through your `pu` branch
> > and to somehow replace local branches with the commits found there.
> 
> To be more in line with the "e-mailed patch" workflow, I think what I should
> do is to send the version I queued with fixups back to the list as follow-up.
> Just like reviewers review, the maintainer reviews and queues, the original
> author should be able to work in the same workflow, i.e. reading and applying
> an improved version of the patch from her mailbox.

Leaving aside Dscho's questions of whether pulling patches from email is
convenient for most submitters (it certainly is for me, but I recognize
that it is not for many), I would much rather see incremental fixup
patches from you than whole "here's what I queued" responses.

The reason is that your fixups may not be the only ones needed. There
may be others on the list that come before or after, and I may even have
already made fixes locally for "v2" that haven't been on the list. If I
haven't made any changes yet, I can throw out my topic, start with what
you queued, and then apply other changes incrementally. But if I have,
then I need to convert yours to a diff, which requires checking out the
same base, applying yours, and running diff. Much easier to get the diff
in the first place. :)

That only covers changes to the code, though. It does not help with
fixups to commit messages. It would be neat to have a microformat for
specifying and applying patches to commit messages.

-Peff
