From: Jeff King <peff@peff.net>
Subject: Re: Bug report: Author/Commit date in ISO 8601 format
Date: Tue, 26 Aug 2014 10:22:03 -0400
Message-ID: <20140826142203.GA31205@peff.net>
References: <53FC3768.3090905@arc-aachen.de>
 <20140826130610.GG29180@peff.net>
 <53FC894F.9060402@arc-aachen.de>
 <20140826133326.GA30887@peff.net>
 <F8DE5B94F596455FA56956B8A865EC73@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Oliver Busch <oliver.busch@arc-aachen.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 16:22:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMHdU-0007DI-9F
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 16:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758329AbaHZOWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 10:22:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:59253 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758140AbaHZOWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 10:22:06 -0400
Received: (qmail 22751 invoked by uid 102); 26 Aug 2014 14:22:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 09:22:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 10:22:03 -0400
Content-Disposition: inline
In-Reply-To: <F8DE5B94F596455FA56956B8A865EC73@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255906>

On Tue, Aug 26, 2014 at 10:10:33AM -0400, Jason Pyeron wrote:

> > But I am not sure that "omitted" means "can be replaced with a space".
> > And while you can define "by mutual agreement" as "git defines the
> > format, so any consumers agree to it" that is not necessarily 
> > useful to
> > somebody who wants to feed the result to an iso8601 parser 
> > that does not
> > know or care about git (i.e., it shoves the conversion work onto the
> > person in the middle).
> 
> Omitted /T?/ does not mean replaced with another character.

I would agree. But that is the argument made in the thread I linked
earlier.

I do not think there is much point in re-opening the argument, though.
Whatever git generates, changing the output would probably cause a lot
of pain.  We are likely better off adding a new, "real" iso8601 format
option (we can even deprecate the old one, or slate it for switching,
but we would need a notification period).

-Peff
