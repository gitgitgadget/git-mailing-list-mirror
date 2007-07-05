From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Thu, 5 Jul 2007 23:29:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707052327350.9789@racer.site>
References: <Pine.LNX.4.64.0707051312260.9789@racer.site>
 <81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com>
 <7vsl82dcj0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707051811310.9789@racer.site>
 <7vfy42d6m0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707052018260.9789@racer.site>
 <20070705214032.GB8751@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 00:29:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ZpO-0008A7-Qx
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 00:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758461AbXGEW3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 18:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758018AbXGEW3b
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 18:29:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:45534 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752006AbXGEW3b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 18:29:31 -0400
Received: (qmail invoked by alias); 05 Jul 2007 22:29:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp013) with SMTP; 06 Jul 2007 00:29:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9qctw/IH9+chxuGP8oXPN4ijXyeiWGcCHPwb/13
	/wxrABwFzTlH7M
X-X-Sender: gene099@racer.site
In-Reply-To: <20070705214032.GB8751@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51700>

Hi,

On Thu, 5 Jul 2007, Alex Riesen wrote:

> Johannes Schindelin, Thu, Jul 05, 2007 21:22:43 +0200:
> > Yes, templates are nice. But I don't think that templates are the way to 
> > go for introducing nice features as rr-cache.
> 
> Looks like you're trying to enforce the feature, not introduce.

Yes. Actually, since long I wondered if this feature should not be 
controlled by a core.rerere variable.

> It changes the user-visible behaviour, and this can be unexpected.

Yes, but I think for the better.

> It is not like you see people asking question: "How do I avoid repeating 
> the same boring conflict?" every day on vger or irc.

That is because people have been trained to cope with CVS. They do not 
even know rerere exists.

> That said, the templates are installed with every make install (and I 
> suppose with every .deb and .rpm), and template is copied in every new 
> repo, so people will get the rr-cache sooner or later. What's wrong with 
> "a bit later" than "much sooner"?

In the part of my reply that you conveniently scissored, I explained that 
it is often not "a bit later", but "never".

Ciao,
Dscho
