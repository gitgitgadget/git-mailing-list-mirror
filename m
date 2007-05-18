From: Jeff King <peff@peff.net>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 08:58:36 -0400
Message-ID: <20070518125836.GB4116@coredump.intra.peff.net>
References: <11793556363795-git-send-email-junkio@cox.net> <11793556371774-git-send-email-junkio@cox.net> <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517110225.GA3334@steel.home> <20070517124622.GP4489@pasky.or.cz> <20070517134649.GA20853@coredump.intra.peff.net> <7vzm438evr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Alex Riesen <raa.lkml@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 14:58:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp22i-0006Eg-N1
	for gcvg-git@gmane.org; Fri, 18 May 2007 14:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbXERM6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 08:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbXERM6m
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 08:58:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4248 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465AbXERM6l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 08:58:41 -0400
Received: (qmail 3638 invoked from network); 18 May 2007 12:58:39 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 18 May 2007 12:58:39 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2007 08:58:36 -0400
Content-Disposition: inline
In-Reply-To: <7vzm438evr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47605>

On Thu, May 17, 2007 at 11:49:12AM -0700, Junio C Hamano wrote:

> > Instead, why not:
> >   1. url location is supplied in configuration as
> >      [subproject "kernel/"]
> >        url = git://git.kernel.org/pub/linux-2.4.git
> >   2. .gitmodules is simply read as a lower-priority version of
> >      configuration
> 
> That does not support seeking back and forth between appliance
> release #1 and release #2 which wants to say they want to bind
> two different things at the same kernel/ path, does it?

I had a vague notion that the subproject could hold _both_ of them,
since it's really the commits you're flipping between. But obviously
that has quite complex semantics, so now it's me doing the handwaving.

What is the planned behavior when doing such a switch? I.e., if I have
kernel/ bound to linux-2.6, and I do a 'git-checkout' back in time to a
version that wants linux-2.4 bound at kernel/, what will happen? Blowing
away my subproject repo doesn't seem right.

-Peff
