From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Sat, 24 Feb 2007 02:21:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240220300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070224011214.GA8369@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:21:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKlbK-0007KB-Sy
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933308AbXBXBVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933310AbXBXBVY
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:21:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:47033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933308AbXBXBVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:21:24 -0500
Received: (qmail invoked by alias); 24 Feb 2007 01:21:22 -0000
X-Provags-ID: V01U2FsdGVkX1/isdEOmVviDXaxJkE8UESV5QaSUmwqLR+gka5zg4
	yWgg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070224011214.GA8369@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40479>

Hi,

On Fri, 23 Feb 2007, Jeff King wrote:

> On Fri, Feb 23, 2007 at 11:48:38PM +0100, Johannes Schindelin wrote:
> 
> > > To name a commit, you can now say
> > > 
> > > 	git rev-parse ':::Initial revision of "git"'
> > 
> > Alex Riesen and Shawn Pearce suggested ":/" instead of ":::", to 
> > reflect the searching nature ("/" is the key to search in "less" 
> > output).
> 
> Is there a particular argument for using a special syntax in the commit 
> argument? Why not just add a '--grep' or similar option to indicate that 
> we will be grepping the commits logs?

--grep works with git-log, but not with rev-parse, rev-list, show, diff, 
etc.

Ciao,
Dscho
