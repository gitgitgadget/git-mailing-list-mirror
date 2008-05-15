From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-clone: fix initial checkout
Date: Thu, 15 May 2008 06:54:04 -0400
Message-ID: <20080515105403.GA10592@sigill.intra.peff.net>
References: <BB5BF79E-ECAE-4F63-AFF1-8C13F23D3D10@sb.org> <20080515044402.GA3517@sigill.intra.peff.net> <20080515045026.GA26161@sigill.intra.peff.net> <alpine.DEB.1.00.0805151042570.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 12:55:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwb6y-0001Ty-OO
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 12:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbYEOKyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 06:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbYEOKyI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 06:54:08 -0400
Received: from peff.net ([208.65.91.99]:2563 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbYEOKyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 06:54:08 -0400
Received: (qmail 22842 invoked by uid 111); 15 May 2008 10:54:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 May 2008 06:54:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2008 06:54:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805151042570.30431@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82198>

On Thu, May 15, 2008 at 10:48:25AM +0100, Johannes Schindelin wrote:

> Somewhere in the process of finishing up builtin-clone, the update of
> the working tree was lost.  This was due to not using the option "merge"
> for unpack_trees().

Looking at how "git-checkout" does it made me think that might be
related, but for some reason I didn't try the obvious.

Thanks.

Tested-by: Jeff King <peff@peff.net>

-Peff
