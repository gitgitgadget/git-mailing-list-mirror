From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Thu, 5 Jul 2007 18:15:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707051811310.9789@racer.site>
References: <Pine.LNX.4.64.0707051312260.9789@racer.site>
 <81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com>
 <7vsl82dcj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 19:15:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Uvi-0000XG-L9
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 19:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757389AbXGERPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 13:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756674AbXGERPn
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 13:15:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:52489 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756651AbXGERPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 13:15:42 -0400
Received: (qmail invoked by alias); 05 Jul 2007 17:15:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 05 Jul 2007 19:15:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19q1s8jALJq2uRz+xLJ3Y5LsDquw9xqo40OpcAf2D
	eF+jNdIRxgs7yZ
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl82dcj0.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51687>

Hi,

On Thu, 5 Jul 2007, Junio C Hamano wrote:

> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> > On 7/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> We have a working implementation of rerere since long ago, and we even
> >> make sure that it works as expected in a test case.  It is also a very
> >> useful feature, so why not turn it on for the benefit of users who are
> >> not even aware of it? This patch does that.
> >
> > Maybe just create in template directory?
> 
> Sounds saner.

Does it?

I had the impression that the templates are meant for site-specific 
modifications. My patch tried to make it more standard than that.

For example, you _could_ have set core.logallrefupdates from the 
templates, yet you chose not to, but rather hard-wire it into "git init". 
Which I completely agree to.

Ciao,
Dscho
