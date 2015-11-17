From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] diff-highlight: match up lines before highlighting
Date: Tue, 17 Nov 2015 17:50:45 -0500
Message-ID: <20151117225045.GF27862@sigill.intra.peff.net>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
 <1446516334-27652-4-git-send-email-jonathan.lebon@gmail.com>
 <20151103214416.GC22484@sigill.intra.peff.net>
 <20151103220314.GE22484@sigill.intra.peff.net>
 <CAM0PgJ4erahEZsL75c4mytF158xxeE6itG8KOMMi4n-zBTHcww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Lebon <jonathan.lebon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 23:50:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyp5Q-0007P9-3k
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 23:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbbKQWus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 17:50:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:59004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750867AbbKQWus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 17:50:48 -0500
Received: (qmail 15398 invoked by uid 102); 17 Nov 2015 22:50:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 16:50:47 -0600
Received: (qmail 30969 invoked by uid 107); 17 Nov 2015 22:51:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 17:51:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Nov 2015 17:50:45 -0500
Content-Disposition: inline
In-Reply-To: <CAM0PgJ4erahEZsL75c4mytF158xxeE6itG8KOMMi4n-zBTHcww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281426>

On Tue, Nov 17, 2015 at 12:18:28AM -0500, Jonathan Lebon wrote:

> > In the other thread I mentioned earlier, the solution I cooked up was
> > dropping highlighting entirely for hunks over a certain percentage of
> > highlighting. I wonder if we could do something similar here (e.g.,
> > don't match lines where more than 50% of the line would be highlighted).
> 
> I looked over but haven't tested the patches in the other thread yet. But
> overall, the LCS definitely looks promising. I'm hoping to find some time
> to have a more serious go at it and maybe pick it up where you left off.
> [...]
> Thanks again for reviewing these patches and apologies for the delayed
> reply.

Great! I look forward to seeing what you produce. Let me know if you
want me to clarify anything from that earlier discussion.

And don't worry about delayed replies; it's part of the normal workflow
around here.

-Peff
