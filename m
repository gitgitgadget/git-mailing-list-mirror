From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Fri, 23 Feb 2007 20:57:31 -0500
Message-ID: <20070224015731.GA10198@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070224011214.GA8369@coredump.intra.peff.net> <Pine.LNX.4.63.0702240220300.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070224013015.GA9021@coredump.intra.peff.net> <Pine.LNX.4.63.0702240248210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKmAL-0004Lp-4B
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933330AbXBXB5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933331AbXBXB5e
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:57:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3834 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933330AbXBXB5d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:57:33 -0500
Received: (qmail 22224 invoked from network); 23 Feb 2007 20:57:45 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Feb 2007 20:57:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2007 20:57:31 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702240248210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40491>

On Sat, Feb 24, 2007 at 02:49:31AM +0100, Johannes Schindelin wrote:

> > door for :? to find the oldest such match (though I'm not sure if it 
> > would be by topology or date).
> By topology makes no sense with more than one root.

Agreed, but by date might not make sense if you have clock skew. I had
assumed your patch for "youngest" was by distance to ref, but I suppose
that doesn't make sense if you are looking over a set of possibly
unconnected refs. So I think trusting the clock may be the only
sensible thing.

-Peff
