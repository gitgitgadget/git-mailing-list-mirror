From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Fri, 23 Feb 2007 20:30:15 -0500
Message-ID: <20070224013015.GA9021@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070224011214.GA8369@coredump.intra.peff.net> <Pine.LNX.4.63.0702240220300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:30:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKljx-0002gf-UM
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933317AbXBXBaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933318AbXBXBaS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:30:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3829 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933317AbXBXBaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:30:17 -0500
Received: (qmail 20484 invoked from network); 23 Feb 2007 20:30:28 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Feb 2007 20:30:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2007 20:30:15 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702240220300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40482>

I said:

> > > Alex Riesen and Shawn Pearce suggested ":/" instead of ":::", to 
> > argument? Why not just add a '--grep' or similar option to indicate that 

Hmm, I completely misread your patch comments in the first place, so
forget my suggestion; it obviously needs to be a per-committish
indicator, not a per-command flag.

I think :/ is slightly easier on the eyes than :::. Plus it opens the
door for :? to find the oldest such match (though I'm not sure if it
would be by topology or date).

Of course it's starting to look a bit like line noise...maybe we just
need :-/ and :-).

-Peff
