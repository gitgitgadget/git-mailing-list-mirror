From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fetch: add missing documentation
Date: Tue, 24 Sep 2013 01:30:23 -0400
Message-ID: <20130924053023.GA5875@sigill.intra.peff.net>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
 <1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
 <20130924050343.GF2766@sigill.intra.peff.net>
 <CAMP44s1FFTS=wOcWBfqg3zt3TO-aM83oXHcGwBcwvt_HnXrn8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:30:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLCi-0002Qb-2h
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757Ab3IXFa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:30:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:53117 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab3IXFa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:30:27 -0400
Received: (qmail 32551 invoked by uid 102); 24 Sep 2013 05:30:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 00:30:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 01:30:23 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1FFTS=wOcWBfqg3zt3TO-aM83oXHcGwBcwvt_HnXrn8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235262>

On Tue, Sep 24, 2013 at 12:23:21AM -0500, Felipe Contreras wrote:

> > Should this be "upstream remote" rather than "upstream branch"? I don't
> > think we should be looking at branch.*.merge at all for git-fetch.
> 
> As a general user, how do I configure the "upstream remote"?

Yeah, it's not a term we use elsewhere, so it's not great. Probably
"default remote" would be better, or even just say "branch.*.remote for
the current branch" or something.

I dunno. I don't particularly like any of those, but I really dislike
the imprecision of "upstream branch" in this case.

-Peff
