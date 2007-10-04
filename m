From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFT] cvsserver: only allow checkout of branches
Date: Thu, 4 Oct 2007 18:18:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710041816230.4174@racer.site>
References: <200710031348.50800.wielemak@science.uva.nl>
 <200710041506.13154.wielemak@science.uva.nl> <Pine.LNX.4.64.0710041622070.4174@racer.site>
 <200710041906.21004.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Thu Oct 04 19:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdUNr-00057o-U0
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 19:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbXJDRTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 13:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbXJDRTF
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 13:19:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:60523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751972AbXJDRTD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 13:19:03 -0400
Received: (qmail invoked by alias); 04 Oct 2007 17:19:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 04 Oct 2007 19:19:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5NfhyMxX5gQgIJPDG5WGQW8jBM5iNynIoh7drBR
	CMySXBOpI7l5O3
X-X-Sender: gene099@racer.site
In-Reply-To: <200710041906.21004.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59987>

Hi,

On Thu, 4 Oct 2007, Jan Wielemaker wrote:

> On Thursday 04 October 2007 17:29, Johannes Schindelin wrote:
> > It does not make sense to check out tags or "HEAD".
> >
> > Noticed by Jan Wielemaker.
> 
> Thanks (though it won't bite me a second time :-)

Heh.  But this is Open Source, so we can make it better for others, too.  
Thank you for spending so much time on this, and actually uncovering that 
error in cvsserver!

> > ) +    {
> > +	$log->warn("Checkout failed: $module is not a branch");
> > +	print "error 1 Checkout failed: $module is not a branch\n";
> 
> There are various places where it says print "...", one that even
> started some suggestion on what might be wrong, but these things don't
> end up at a visible place when using ssh as transport. Its a good idea
> this one is at least in the logfile as well. Not sure, but might
> printing to stderr work better?

I think not.  AFAICT stderr is not visible with cvs either.  I somewhat 
hoped that the "error 1" was an indicator to the cvs client to show the 
message, but that's way beyond my knowledge...

Ciao,
Dscho
