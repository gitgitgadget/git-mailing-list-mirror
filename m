From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 21:27:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711262124411.27959@racer.site>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz>
 <alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwlV2-00060k-80
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbXKZV16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbXKZV16
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:27:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:60741 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750716AbXKZV15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:27:57 -0500
Received: (qmail invoked by alias); 26 Nov 2007 21:27:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 26 Nov 2007 22:27:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AFL8mgYEAzIORtlumHMdM0YS2p9+olK6qENao7l
	gqrh5d1P8YKeR8
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66128>

Hi,

On Mon, 26 Nov 2007, Nicolas Pitre wrote:

> On Mon, 26 Nov 2007, David Kastrup wrote:
> 
> > Get rid of plumbing at the command line level.
> 
> We can't get rid of plumbing.  It is part of Git probably forever and is 
> really really convenient for scripting in any language you want.

I agree, but that's not even the complete truth.  Git would be not even 
half as useful as it is without its scriptability.

So it is not only convenience, but very much a reason that git development 
is so fast.  That, and that more people than elsewhere let code talk.  
Which is also much easier when you have a scriptable system.

Ciao,
Dscho
