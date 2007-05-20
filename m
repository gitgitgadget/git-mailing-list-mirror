From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Sun, 20 May 2007 23:47:32 +0200
Message-ID: <20070520214732.GC942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net>
 <20070520195930.GX942MdfPADPa@greensroom.kotnet.org>
 <20070520205444.GC25462@steel.home>
 <20070520210954.GB942MdfPADPa@greensroom.kotnet.org>
 <20070520212432.GE25462@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 23:47:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HptFe-0000qI-7q
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbXETVrf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756746AbXETVrf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:47:35 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:57055 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756639AbXETVre (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:47:34 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JID00ATL0J8R3@psmtp04.wxs.nl> for git@vger.kernel.org; Sun,
 20 May 2007 23:47:33 +0200 (MEST)
Received: (qmail 2087 invoked by uid 500); Sun, 20 May 2007 21:47:32 +0000
In-reply-to: <20070520212432.GE25462@steel.home>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47929>

On Sun, May 20, 2007 at 11:24:32PM +0200, Alex Riesen wrote:
> Sven Verdoolaege, Sun, May 20, 2007 23:09:54 +0200:
> > On Sun, May 20, 2007 at 10:54:44PM +0200, Alex Riesen wrote:
> > > Sven Verdoolaege, Sun, May 20, 2007 21:59:30 +0200:
> > > > > I am very worried about this big red switch that says "all
> > > > > subprojects to be cloned and checked out, or nothing".  I think
> > > > > this would not work well with projects that truly need
> > > > > superproject support (i.e. very large ones, where most people
> > > > > would not want to clone and check out every single subproject).
> > > > 
> > > > It's pretty easy to add a "submodule.*.skip" or "submodule.*.ignore".
> > > > Since the subcloning only happens at checkout, you could set these
> > > > before doing a checkout.
> > > 
> > > And set them back after doing the checkout?
> > 
> > What do you mean?  Why would you set them back?
> 
> Why should I set them before doing a checkout?
> 
> > I guess I'm missing something.
> 
> "checkout" is an operation which is done often. It never had to be
> configured before.

There is going to have to be *some* way of selecting which
subprojects you want to check out.  A config option that you
have to set only once (or not at all if you are happy with
the default) seems to be the easiest way.  You can have git-gui
set them for you if you want.

How would _you_ specify which subprojects to checkout ?

> > Well... the subproject as a whole is independent of the superproject,
> > but the checkout in the superproject is not entirely independent.
> >
> 
> Junio was talking about branch in subproject, wasn't he?

That's a local thing.

skimo
