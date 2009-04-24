From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 19:35:09 -0400
Message-ID: <20090424233509.GA15341@coredump.intra.peff.net>
References: <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com> <alpine.LNX.2.00.0904241852500.2147@iabervon.org> <20090424231436.GA15058@coredump.intra.peff.net> <b4087cc50904241631t8913c47ke3b2027b466ee1e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:36:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUww-0003IB-PB
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbZDXXfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279AbZDXXfU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:35:20 -0400
Received: from peff.net ([208.65.91.99]:58013 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755990AbZDXXfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:35:19 -0400
Received: (qmail 32723 invoked by uid 107); 24 Apr 2009 23:35:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 19:35:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 19:35:09 -0400
Content-Disposition: inline
In-Reply-To: <b4087cc50904241631t8913c47ke3b2027b466ee1e9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117523>

On Fri, Apr 24, 2009 at 06:31:26PM -0500, Michael Witten wrote:

> On Fri, Apr 24, 2009 at 18:14, Jeff King <peff@peff.net> wrote:
> > Junio suggested "object name" in another thread, which I think is nicely
> > descriptive.
> 
> The reason I don't like "object name" is that "name" has connotations
> that don't go well with the idea of referencing. Isn't "address" (or
> "location") better in this sense?

I'm not sure I agree, but if you are concerned with "name", then I think
something like "object id" or "object identifier" would probably be
better. "address" and "location" imply to me that they are part of a
contiguous set. And while technically they may be considered addresses
of a sparse 2^160 array, I'm not sure that explanation is really helping
new users understand what is going on.

What the user really cares about is that it is persistent and
unambiguous.

-Peff
