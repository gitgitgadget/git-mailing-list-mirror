From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] doc: convert \--option to --option
Date: Thu, 14 May 2015 00:32:59 -0400
Message-ID: <20150514043259.GC9351@peff.net>
References: <20150513045650.GA6070@peff.net>
 <20150513050137.GF6821@peff.net>
 <20150513094841.GA10518@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 14 06:33:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YskpZ-0002xg-0S
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 06:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933439AbbENEdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 00:33:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:58410 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933305AbbENEdC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 00:33:02 -0400
Received: (qmail 7545 invoked by uid 102); 14 May 2015 04:33:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 23:33:02 -0500
Received: (qmail 19700 invoked by uid 107); 14 May 2015 04:33:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 00:33:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 00:32:59 -0400
Content-Disposition: inline
In-Reply-To: <20150513094841.GA10518@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269024>

On Wed, May 13, 2015 at 10:48:42AM +0100, John Keeping wrote:

> On Wed, May 13, 2015 at 01:01:38AM -0400, Jeff King wrote:
> > Older versions of AsciiDoc would convert the "--" in
> > "--option" into an emdash. According to 565e135
> > (Documentation: quote double-dash for AsciiDoc, 2011-06-29),
> > this is fixed in AsciiDoc 8.3.0. According to bf17126, we
> > don't support anything older than 8.4.1 anyway, so we no
> > longer need to worry about quoting.
> > 
> > Even though this does not change the output at all, there
> > are a few good reasons to drop the quoting:
> > 
> >   1. It makes the source prettier to read.
> > 
> >   2. We don't quote consistently, which may be confusing when
> >      reading the source.
> > 
> >   3. Asciidoctor does not like the quoting, and renders a
> >      literal backslash.
> 
> If we're changing all of these files anyway, it would be nice to wrap
> literal options in backticks as suggested in
> Documentation/CodingGuidelines.

I considered it, and I do prefer backticks. But I stopped short because
my goal here was to make source changes that didn't have any actual
output changes. So I'm not opposed to the output change, but it doesn't
belong in this patch.

I'm also a little hesitant just because it semes there are quite a lot
of outliers. I'm not sure if I'm helping anything to produce a patch
that changes a small subset of them (i.e., if we do it, we should really
do it thoroughly).

I dunno. If you want to do a patch on top, I'd be happy to look at it.

-Peff
