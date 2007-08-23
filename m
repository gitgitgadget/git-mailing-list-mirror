From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 11:19:48 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708231110280.16727@xanadu.home>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
 <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <alpine.LFD.0.999.0708221313350.16727@xanadu.home>
 <Pine.LNX.4.64.0708231051210.20400@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 23 17:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOETV-0006zk-Ar
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 17:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762831AbXHWPTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 11:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762866AbXHWPTx
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 11:19:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47376 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762486AbXHWPTw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 11:19:52 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JN8001BGFX2LLM0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 23 Aug 2007 11:19:51 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0708231051210.20400@racer.site>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56504>

On Thu, 23 Aug 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 22 Aug 2007, Nicolas Pitre wrote:
> 
> > On Wed, 22 Aug 2007, Johannes Schindelin wrote:
> > 
> > > What is wrong with going from shell to C?  C _is_ portable.  Instead 
> > > of relying on _yet_ another scripting language, introducing _yet_ 
> > > another language that people have to learn to hack git, introducing 
> > > _yet_ another place for bugs to hide, why not just admit that shell is 
> > > nice for _prototyping_?
> > 
> > This is a narrow view of the programming world that I don't share.
> 
> Well, you have to admit that some things are really, really hard to do in 
> shell.  Just from the top of my head: locking, data structures, 
> portability, scalability, process control.  There are a lot more, I guess, 
> but for the _core_ of Git I really prefer C.

I don't dispute that.

I'm more concerned about easy scripting of Git operations that can be 
shared across different environments.

> I do not want to shove C down the throat of every Git user.  You can use 
> _whatever_ scripting language you like.

Sure.  I was thinking that a common scripting language, shipped with Git 
itself that would work out of the box either on Linux or Windows, could 
benefit the whole Git user base, with a possible side effect of being 
able to also run the test suite everywhere.  If that has no sufficient 
merits to other people and only remains a peep dream of mine then so be 
it.


Nicolas
