From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Thu, 14 May 2015 17:17:27 -0400
Message-ID: <20150514211727.GA15528@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
 <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
 <20150514042544.GA9351@peff.net>
 <9350a00074264bb847210410a6f6c340@www.dscho.org>
 <20150514173828.GA7966@peff.net>
 <c2fd3e038c821ec340c085a825baabc7@www.dscho.org>
 <xmqqwq0aj25e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:17:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0Vb-0000QK-E2
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965362AbbENVRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:17:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:58863 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965116AbbENVRa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:17:30 -0400
Received: (qmail 27155 invoked by uid 102); 14 May 2015 21:17:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 16:17:29 -0500
Received: (qmail 28142 invoked by uid 107); 14 May 2015 21:17:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 17:17:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 17:17:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwq0aj25e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269099>

On Thu, May 14, 2015 at 02:10:53PM -0700, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >> My asciidoctor just comes from the Debian package. Looks like it's over
> >> a year old at this point. I should probably be testing with something
> >> more recent.
> >
> > We installed asciidoctor via `gem` and have version 1.5.2.
> 
> What I'll be pushing out today will have some "interesting" mark-up
> in Documentation/git-cat-file.txt (on 'jch' or 'pu') from David's
> '--follow-symlinks' topic.  I think AsciiDoc formatting looks OK,
> but can you check it with both older (peff) and newer (dscho)
> asciidoctor to see how well it shows?  Look for --follow-symlinks
> in the output.

What's in 366bc15e9 (your SQUASH) looks terrible with older asciidoctor.
The "[normal]" bumps us out of the list item, left-aligning all of the
other paragraphs, and then the "+" continuation is treated literally
(probably because we are not inside a block).

I don't see any reason we cannot use normal "+" continuation here (but
the hanging paragraphs need to be left-aligned, then).

-Peff
