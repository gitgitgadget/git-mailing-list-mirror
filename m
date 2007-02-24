From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Sat, 24 Feb 2007 03:14:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240311240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070224011214.GA8369@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702240220300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070224013015.GA9021@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702240248210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070224015731.GA10198@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 03:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKmQR-0002BF-M9
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 03:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbXBXCOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 21:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbXBXCOO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 21:14:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:54843 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933342AbXBXCON (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 21:14:13 -0500
Received: (qmail invoked by alias); 24 Feb 2007 02:14:12 -0000
X-Provags-ID: V01U2FsdGVkX1/dokco4xTdIpxyNnizT5xfUUNN+sig7u7nKGAoBP
	YFuQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070224015731.GA10198@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40494>

Hi,

On Fri, 23 Feb 2007, Jeff King wrote:

> On Sat, Feb 24, 2007 at 02:49:31AM +0100, Johannes Schindelin wrote:
> 
> > > door for :? to find the oldest such match (though I'm not sure if it 
> > > would be by topology or date).
> >
> > By topology makes no sense with more than one root.
> 
> Agreed, but by date might not make sense if you have clock skew. I had 
> assumed your patch for "youngest" was by distance to ref, but I suppose 
> that doesn't make sense if you are looking over a set of possibly 
> unconnected refs. So I think trusting the clock may be the only sensible 
> thing.

Given that most commits _will_ have a unique oneline, I think it does not 
matter that much. After all, the principal use case I see for it is 
finding a commit, given a shortlog, or a mail subject, or even a sentence 
muttered over the phone.

Ciao,
Dscho
