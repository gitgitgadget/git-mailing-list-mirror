From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: error: char103: premature end of data
Date: Fri, 8 Jun 2007 00:11:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080003470.4046@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 01:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRAS-0004GO-Ne
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762068AbXFGXNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762197AbXFGXNP
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:13:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:39946 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762068AbXFGXNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:13:14 -0400
Received: (qmail invoked by alias); 07 Jun 2007 23:13:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 08 Jun 2007 01:13:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cOmwuh5JcCsuiCHhRohLbd+H3V+nHjv9TOL/gj3
	gUtoJjbEfgNckn
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706072348110.4046@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49407>

Hi,

On Thu, 7 Jun 2007, Johannes Schindelin wrote:

> I somehow suspect that this has something to do with the recent work on 
> the tag objects. If so, NACK on that patch series from me.

Okay. Instead of doing the work I have to do, which I cannot, because 
a vital part of git stopped working for me, I tracked down that it is 
indeed that monster commit v1.5.2.1-134-gc7de6eb AKA ':/Refactor git tag 
objects;'

I have to repeat my NACK on it. I did not have time to review it, when 
you sent it, so I tried to find what is wrong now (when I don't have 
time for it to begin with).

But it is really intrusive, introduces problems, is less than readable, 
and it is not at all clear what problems it solves, while it looks like it 
could be broken down to easily-reviewable fixes, cleanups, and changes, so 
please fix it while I recover from my troubles.

Ciao,
Dscho
