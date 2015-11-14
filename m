From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] git-candidate: git based patch tracking and review
Date: Sat, 14 Nov 2015 03:17:08 -0500
Message-ID: <20151114081707.GA32739@sigill.intra.peff.net>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
 <5643107B.20501@alum.mit.edu>
 <20151111151204.GA4249@salo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Richard Ipsum <richard.ipsum@codethink.co.uk>
X-From: git-owner@vger.kernel.org Sat Nov 14 09:18:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxW1q-0004n7-3t
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 09:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbbKNIRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2015 03:17:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:57530 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750974AbbKNIRK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2015 03:17:10 -0500
Received: (qmail 22266 invoked by uid 102); 14 Nov 2015 08:17:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Nov 2015 02:17:10 -0600
Received: (qmail 1067 invoked by uid 107); 14 Nov 2015 08:17:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Nov 2015 03:17:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Nov 2015 03:17:08 -0500
Content-Disposition: inline
In-Reply-To: <20151111151204.GA4249@salo>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281301>

On Wed, Nov 11, 2015 at 03:12:05PM +0000, Richard Ipsum wrote:

> > All that being said, my gut feeling is that a system like this should
> > not be developed within the Git project itself. Code review is a
> > complicated thing, and I expect that different people will have very
> > different ideas about how it should work. It would be a bad idea for the
> > Git project to "bless" one system by including it in our source tree.
> > (Earlier in the Git's history it was easier to get something accepted
> > into "contrib", but that has gotten much harder over time.)
> 
> The aim is not to bless one particular system but to eventually
> provide a common data model that all review systems can share,
> so that it is possible to do distributed reviews with arbitrary UIs
> in a widely compatible way.

I think that's a laudable goal, but I didn't see any discussion or
documentation of the data model in your patches. Maybe that would be a
good place to start.

> If we add git-candidate to contrib then it can act as a reference
> implementation, so that this data model can be validated and tested
> by additional developers.

That can happen outside of git's contrib/ directory, too.

I think Michael's "bless" argument applies to the data model, too. Is
your data model a good one? Should other systems adopt it, or is it
still a work in progress? We don't know yet.

I think I'd rather see it prove itself before entering the git tree, if
only because it doesn't really gain anything by being inside the git
tree. Once upon a time that was a good way to get publicity and easy
hosting, but these days it is easy to find git hosting, and I am not
sure people actually explore contrib/ all that much.

-Peff
