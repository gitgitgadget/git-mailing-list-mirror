From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Fri, 23 Feb 2007 20:12:15 -0500
Message-ID: <20070224011214.GA8369@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:12:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKlSX-00045O-8Z
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933307AbXBXBMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933300AbXBXBMS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:12:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3690 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933307AbXBXBMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:12:17 -0500
Received: (qmail 19474 invoked from network); 23 Feb 2007 20:12:28 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Feb 2007 20:12:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2007 20:12:15 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40476>

On Fri, Feb 23, 2007 at 11:48:38PM +0100, Johannes Schindelin wrote:

> > To name a commit, you can now say
> > 
> > 	git rev-parse ':::Initial revision of "git"'
> 
> Alex Riesen and Shawn Pearce suggested ":/" instead of ":::", to reflect 
> the searching nature ("/" is the key to search in "less" output).

Is there a particular argument for using a special syntax in the commit
argument? Why not just add a '--grep' or similar option to indicate that
we will be grepping the commits logs?

-Peff
