Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5492023C
	for <e@80x24.org>; Thu,  7 Jul 2016 03:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758AbcGGDfm (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 23:35:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:41264 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753231AbcGGDfm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 23:35:42 -0400
Received: (qmail 27356 invoked by uid 102); 7 Jul 2016 03:35:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jul 2016 23:35:42 -0400
Received: (qmail 31653 invoked by uid 107); 7 Jul 2016 03:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jul 2016 23:36:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2016 23:35:38 -0400
Date:	Wed, 6 Jul 2016 23:35:38 -0400
From:	Jeff King <peff@peff.net>
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Peter <peter.mx@gmail.com>, git@vger.kernel.org
Subject: Re: Fwd: git rm
Message-ID: <20160707033538.GA7595@sigill.intra.peff.net>
References: <CAK8tuqiZjfrvHCoxkFUqoDx0+9=FUxfE93aMhUkYYZAAWm-u_w@mail.gmail.com>
 <CAK8tuqhMiHqPoK4gk7onT+VXsLJE5ogcpu7dc=_8am+ifL=5yQ@mail.gmail.com>
 <87a8hubtw4.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a8hubtw4.fsf@linux-m68k.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 06, 2016 at 06:42:19PM +0200, Andreas Schwab wrote:

> Peter <peter.mx@gmail.com> writes:
> 
> > I am a lightweigt git user so by all means not a reference, but I was
> > wondering why exactly does "git rm" also delete the file (remove it
> > from the working tree). I see it as an unintended behaviour as git is
> > written in a way that it preserves the most data.
> 
> The data is still preserved.  You can restore it with "git checkout HEAD
> <file>".

Assuming the file is present in HEAD, of course. But if it is not, then
git should (and does) complain and ask for "-f".

-Peff
