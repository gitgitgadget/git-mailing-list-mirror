From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Fri, 9 May 2008 11:53:24 -0400
Message-ID: <20080509155323.GA28966@sigill.intra.peff.net>
References: <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil> <20080508224827.GA2938@sigill.intra.peff.net> <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net> <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com> <48246A44.7020303@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geert Bosch <bosch@adacore.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri May 09 17:54:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuUvG-0001Vb-1p
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 17:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbYEIPxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 11:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbYEIPxX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 11:53:23 -0400
Received: from peff.net ([208.65.91.99]:2131 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbYEIPxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 11:53:22 -0400
Received: (qmail 4924 invoked by uid 111); 9 May 2008 15:53:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 09 May 2008 11:53:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2008 11:53:24 -0400
Content-Disposition: inline
In-Reply-To: <48246A44.7020303@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81616>

On Fri, May 09, 2008 at 10:14:12AM -0500, Brandon Casey wrote:

> >   -  Objects will not be accessible by ordinary git commands for a while,
> >      before they are really removed, avoiding surprises
> 
> Unreferenced objects are sometimes used by other repositories which have
> this repository listed as an alternate. So it may not be a good idea to
> make the unreferenced objects inaccessible.

But that is precisely what we're going to do, but in two weeks. Isn't it
better to have the dependent repo fail while the change is recoverable?

-Peff
