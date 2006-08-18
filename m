From: Nicolas Pitre <nico@cam.org>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 10:49:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608181041420.11359@localhost.localdomain>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
 <44E546F2.7070902@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 16:49:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE5fE-0002Xg-6f
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 16:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWHROtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 10:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWHROtb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 10:49:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63054 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030452AbWHROtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 10:49:31 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4700L7I7UIY710@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 Aug 2006 10:49:30 -0400 (EDT)
In-reply-to: <44E546F2.7070902@gmail.com>
X-X-Sender: nico@localhost.localdomain
To: A Large Angry SCM <gitzilla@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25668>

On Thu, 17 Aug 2006, A Large Angry SCM wrote:

> Junio C Hamano wrote:
> ...
> > * "A Large Angry SCM" wrote a nice summary, "Git files data
> >   formats documentation".
> > 
> >   Message-ID: <44D51D47.9090700@gmail.com>
> > 
> >   With one final update by Nico yesterday, I think it is ready
> >   for inclusion.
> > 
> >   Does somebody care to make a patch out of it to add it to
> >   Documentation/technical/, maybe removing pack-format.txt there
> >   after making sure all it talks about is covered by the new
> >   documentation?
> > 
> >   I do not have enough "virginity" to spot omissions in the
> >   description anymore, so comments from somebody new to the
> >   system are very much appreciated.
> > 
> 
> Two things:
> 
> 1) I disagree with Nico's assessment that, other than his, there can not
> exist any type 2 packs that have bit 6 set to mean copy from result.

Care to explain why?

Since this code is mine I can tell you that no official GIT version ever 
produced such a pack.  The code to make use of that bit was quite 
involving and the end result wasn't great at all so I never published 
said code.  This is also why current GIT accepts both pack version 2 and 
3 without any distinction using the same code in patch-delta.c on the 
basis that no version 2 packs ever used that bit.


Nicolas
