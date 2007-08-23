From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 10:55:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708231051210.20400@racer.site>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <alpine.LFD.0.999.0708221313350.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 11:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO9PY-0005iK-S6
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 11:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474AbXHWJz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 05:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758437AbXHWJz1
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 05:55:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:34699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757011AbXHWJz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 05:55:26 -0400
Received: (qmail invoked by alias); 23 Aug 2007 09:55:25 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp058) with SMTP; 23 Aug 2007 11:55:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RuWxskATRveMeo5qAEXiGyE9xI1SfYa2oAJGgiI
	v9MNQ1iBTw4VEd
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0708221313350.16727@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56486>

Hi,

On Wed, 22 Aug 2007, Nicolas Pitre wrote:

> On Wed, 22 Aug 2007, Johannes Schindelin wrote:
> 
> > What is wrong with going from shell to C?  C _is_ portable.  Instead 
> > of relying on _yet_ another scripting language, introducing _yet_ 
> > another language that people have to learn to hack git, introducing 
> > _yet_ another place for bugs to hide, why not just admit that shell is 
> > nice for _prototyping_?
> 
> This is a narrow view of the programming world that I don't share.

Well, you have to admit that some things are really, really hard to do in 
shell.  Just from the top of my head: locking, data structures, 
portability, scalability, process control.  There are a lot more, I guess, 
but for the _core_ of Git I really prefer C.

> C is portable indeed, which is one of its upsides.  But it has many 
> downsides too for many _users_, that as a Git _developer_ you apparently 
> conveniently ignore.

I do not want to shove C down the throat of every Git user.  You can use 
_whatever_ scripting language you like.

Nevertheless, this is _different_ from the choice for _core_ Git.  
Eventually I'd like to be able to run Git on embedded systems, or my 
digital watch.

> > Why do we have to to have the same discussion over and over and over 
> > again?
> 
> Because, as shown by the recurring nature of this discussion, using C for 
> everything is evidently not the optimal solution.

I think the reason is different (as shown by the content of the 
discussion).

Ciao,
Dscho
