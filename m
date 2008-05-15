From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
	whitespace.
Date: Thu, 15 May 2008 07:23:19 -0400
Message-ID: <20080515112319.GA13038@sigill.intra.peff.net>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com> <20080428094119.GA20499@sigill.intra.peff.net> <e2b179460804280256g4ff903bu39c9460086df7157@mail.gmail.com> <20080513091143.GA26248@sigill.intra.peff.net> <e2b179460805131110k3cf582fdn9b8bd31046b90ca7@mail.gmail.com> <e2b179460805150316n77513037y5409042b01170d4e@mail.gmail.com> <20080515112030.GA12781@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 13:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwbZG-0002pu-LN
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 13:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbYEOLXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 07:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbYEOLXW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 07:23:22 -0400
Received: from peff.net ([208.65.91.99]:3407 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbYEOLXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 07:23:21 -0400
Received: (qmail 24953 invoked by uid 111); 15 May 2008 11:23:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 May 2008 07:23:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2008 07:23:19 -0400
Content-Disposition: inline
In-Reply-To: <20080515112030.GA12781@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82200>

On Thu, May 15, 2008 at 07:20:30AM -0400, Jeff King wrote:

> I have started tagging my auto-builds as you suggest. It should be easy
> enough to push to a repo.or.cz repository. Although I'm not sure of the
> utility of auto-publishing this information. Who is going to look at it?

Also, if there is interest in an automated "this is now broken on
platform X", I think the interesting thing is not "what was the last
passing state" but rather "what is the output of 'make test' for the
failing state." So:

> I had assumed a workflow more like "it passes 99% of the time; in the
> remaining 1%, the cron job kicks off a message to the owning user, who
> then investigates and/or writes a bug report to the list."

In that case, I think the interesting automation is making a problem
report from a failed case.

-Peff
