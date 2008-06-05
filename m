From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Thu, 5 Jun 2008 05:46:13 -0400
Message-ID: <20080605094613.GA17089@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806051105.02802.trast@student.ethz.ch> <20080605092016.GA16748@sigill.intra.peff.net> <200806051138.28889.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 05 11:48:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4C3q-0006OA-6X
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 11:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbYFEJqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 05:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbYFEJqR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 05:46:17 -0400
Received: from peff.net ([208.65.91.99]:2538 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689AbYFEJqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 05:46:16 -0400
Received: (qmail 22065 invoked by uid 111); 5 Jun 2008 09:46:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 05 Jun 2008 05:46:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jun 2008 05:46:13 -0400
Content-Disposition: inline
In-Reply-To: <200806051138.28889.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83892>

On Thu, Jun 05, 2008 at 11:38:15AM +0200, Thomas Rast wrote:

> Maybe git gui could do a sort of "toggle the lines I click" interface.
> But I don't know anything about Tk, or Tcl, or git gui :-(

That would probably be a reasonable interface. But I don't use git-gui,
so I personally am not interested in that. ;)

> Now I'm slightly confused.
> 
> Doing it that way would be almost like my original patch
> 
>   http://www.spinics.net/lists/git/msg66971.html
> 
> minus the numeric prefixes -- meaning that you have to say y/n to
> _every_ line in the patch, at least until all remaining hunks are the
> same and you can answer the rest with a/d.

Hmm, I suppose it is. Sorry, I'm just trying to brainstorm a bit about
other options, but I think that my proposal really isn't that good an
idea.

-Peff
