From: Jeff King <peff@peff.net>
Subject: Re: When does git check for branch-X being uptodate with
 origin/branch-X?
Date: Mon, 21 Mar 2016 17:18:34 -0400
Message-ID: <20160321211834.GA1068@sigill.intra.peff.net>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
 <20160321202810.GD32071@sigill.intra.peff.net>
 <CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
 <20160321205043.GA436@sigill.intra.peff.net>
 <CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:21:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai7GQ-00044e-FB
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 22:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758109AbcCUVSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 17:18:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:35566 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757953AbcCUVSh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 17:18:37 -0400
Received: (qmail 8826 invoked by uid 102); 21 Mar 2016 21:18:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 17:18:36 -0400
Received: (qmail 9729 invoked by uid 107); 21 Mar 2016 21:18:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 17:18:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2016 17:18:34 -0400
Content-Disposition: inline
In-Reply-To: <CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289463>

On Mon, Mar 21, 2016 at 09:12:18PM +0000, Thomas Adam wrote:

> On 21 March 2016 at 20:50, Jeff King <peff@peff.net> wrote:
> > But that's just my opinion. Did you have some specific change you're
> > interested in? I don't think removing that message is productive; it
> > _is_ useful information. Perhaps it could be more clear that we are
> > talking about the tracking branch?
> 
> I don't have a specific change in mind per-se, rather than to discuss
> how we might be able to improve the error message, or document
> somewhere that it's referring to the tracking branch.  Maybe that's
> the point--is it worth mentioning the time/date of when the cache was
> last updated?  That is:
> 
> "branch-X is uptodate with origin/branch-X (as of DD-MM-YY HH:MM:SS)"

Again, just my opinion, but that looks awfully clunky. And it doesn't
address the other messages (you might be behind origin/branch-X by N
commits, or ahead by N, but only as of that particular date). Do we want
to annotate every message whose value was computed based on a tracking
branch?

> No one's suggesting that this message is removed, I'm not sure where
> you got that from?

You said earlier:

> [...]it's more a case of whether even printing that message is useful?

I didn't know quite what you had in mind, which is why I asked. If we
all agree that removing it is a bad idea, then good, we don't have to
bother discussing that option. :)

-Peff
