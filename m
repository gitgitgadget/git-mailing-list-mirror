From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 22:45:33 -0400
Message-ID: <20110826024533.GB17625@sigill.intra.peff.net>
References: <20110825204047.GA9948@sigill.intra.peff.net>
 <5qgbkjmEZ8jSRkpVNieElg1bcVbuEStD525CFu1hZPQ7F03R3EzjXwQdDKQBOnR1zWDiZBsGu53K20rbOGpYd6rmp2-e-ZI3Z42BKT01TVI@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 26 04:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwmQW-0006Ib-Jv
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 04:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab1HZCph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 22:45:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36658
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab1HZCpg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 22:45:36 -0400
Received: (qmail 22539 invoked by uid 107); 26 Aug 2011 02:46:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 22:46:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 22:45:33 -0400
Content-Disposition: inline
In-Reply-To: <5qgbkjmEZ8jSRkpVNieElg1bcVbuEStD525CFu1hZPQ7F03R3EzjXwQdDKQBOnR1zWDiZBsGu53K20rbOGpYd6rmp2-e-ZI3Z42BKT01TVI@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180148>

On Thu, Aug 25, 2011 at 05:29:36PM -0500, Brandon Casey wrote:

> > Also, any other extensions that would go into such a list?
> 
> *.bib diff=bibtex
> *.tex diff=tex

I had those ones already. ;P

> *.[Ff] diff=fortran
> *.[Ff][0-9][0-9] diff=fortran

Thanks, I'll add those. I don't see a big problem with generalizing
f[0-9][0-9] to always be fortran, even though many of those numbers
aren't used. I don't think I've ever seen one used for anything else.

Should all of our matches be case-insensitive? That is, should we be
matching both .HTML and .html? Clearly lowercase is the One True Way,
but I don't know what kind of junk people with case-insensitive
filesystems have, or whether we should even worry about it.

> Wikipedia says that .for is an extension for fortran, but I've never
> seen that in the wild.  Maybe it's a windows thing (3-char ext).

We can leave it out. It's easy enough for somebody to add their own
gitattribute if they want, or to even complain that it should be in the
default set. I was trying to keep this list to the utterly common, not
become a catalogue of obscure fortran customs. :)

-Peff
