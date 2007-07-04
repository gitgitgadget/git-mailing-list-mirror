From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-repack: generational repacking (and example hook
 script)
Date: Wed, 4 Jul 2007 02:01:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707040155240.4071@racer.site>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782608-git-send-email-sam.vilain@catalyst.net.nz>
 <alpine.LFD.0.999.0707022331080.26459@xanadu.home> <4689D77D.20601@vilain.net>
 <alpine.LFD.0.999.0707031020300.26459@xanadu.home> <468AE462.1040202@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jul 04 03:01:53 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5tFg-0003iv-Dt
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 03:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbXGDBBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 21:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbXGDBBt
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 21:01:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:49421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754166AbXGDBBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 21:01:48 -0400
Received: (qmail invoked by alias); 04 Jul 2007 01:01:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 04 Jul 2007 03:01:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mzedt1jem+TN7yJlDGsp+0Qt0p4bPdWpzLr4Sft
	lOQ3ykQLW8JZSM
X-X-Sender: gene099@racer.site
In-Reply-To: <468AE462.1040202@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51555>

Hi,

On Wed, 4 Jul 2007, Sam Vilain wrote:

> Nicolas Pitre wrote:
> >> 1. Do you agree that some users would want their git repositories to be
> >> "maintenance free"?
> >
> > I'm not so sure.
> 
> Well, no offence, but I think you should withhold from voicing a
> fundamental concern as this, because you're not one of its target users.

Let's put it this way. A lot of car drivers would probably agree that it 
is a Good Thing (tm) if their car automatically went to get gas, before it 
ran out of it. Less hassle, right?

Yes, except if your car decides to get gas when you are already late, 
speeding, trying to catch your plane.

Same holds for Git. Is is worth the hassle having to wait for this 
automatic git-gc when your boss is waiting impatiently for you to show 
some results?

Now, you seem to argue that the cost of a single git-gc should be 
decreased. But I maintain that the _usefulness_ of git-gc is decreased 
that way, too.

In all of my projects, the most efficient setup is one big pack. That is 
why I set up some cronjobs on the machines that run 24/7, and that is why 
I run "git-gc --prune" when idling, on almost all my repos.

Ciao,
Dscho
