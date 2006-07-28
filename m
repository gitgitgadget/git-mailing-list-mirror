From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach the git wrapper about --name-rev and --name-rev-by-tags
Date: Fri, 28 Jul 2006 20:53:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607282042470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
 <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org> <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
 <20060525131241.GA8443@linux-mips.org> <7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607281308280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607280952200.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 20:54:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6XTN-0004o5-Gd
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 20:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161235AbWG1SyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 14:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161236AbWG1SyC
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 14:54:02 -0400
Received: from mail.gmx.net ([213.165.64.21]:41188 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161235AbWG1SyA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 14:54:00 -0400
Received: (qmail invoked by alias); 28 Jul 2006 18:53:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 28 Jul 2006 20:53:58 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607280952200.4168@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24399>

Hi,

On Fri, 28 Jul 2006, Linus Torvalds wrote:

> On Fri, 28 Jul 2006, Johannes Schindelin wrote:
> > 
> > Now you can say
> > 
> > 	git --name-rev log
> 
> I think this is wrong.

I think it is not wrong. :-)

> It may be a straightforward translation of
> 
> > 	git log | git name-rev --stdin | less
> 
> but that doesn't make it any more "correct".

I use it also for other git commands, so this was very much on purpose.

> Also, I doubt most people want every release named.

You are probably right. But _I_ want to know that e.g. commit 
a025463bc0ec2c894a88f2dfb44cf88ba71bb712 is really tags/v1.4.0^0~27^2. 
Both are immutable, but the latter is nicer to people than to computers.

> I think the common case would be that you want those releases named that 
> match heads (and tags in particular) _exactly_. If you want everything 
> named, maybe you want to do "--name-rev-all" or something.
> 
> Hmm?
> 
> (That would also likely perform a lot better)

True. But then, you probably know which head it is, because you probably 
specified it yourself on the command line.

Ciao,
Dscho
