From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-gc "--aggressive" somewhat broken
Date: Sun, 08 Jul 2007 23:46:44 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707082341460.26459@xanadu.home>
References: <alpine.LFD.0.999.0707061310390.8278@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707061512550.8278@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 05:46:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7kDB-0003W3-SA
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 05:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758723AbXGIDqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 23:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758679AbXGIDqq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 23:46:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19221 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758631AbXGIDqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 23:46:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKW00COK7TWK120@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 08 Jul 2007 23:46:45 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0707061512550.8278@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51947>

On Fri, 6 Jul 2007, Linus Torvalds wrote:

> 
> 
> On Fri, 6 Jul 2007, Linus Torvalds wrote:
> > 
> > If we want to be really aggressive, we migth decide to pass a new flag to 
> > pack-objects that does something closer to what "aggressive" was meant to 
> > do: it would use existing delta's if they exist, but _despite_ existing it 
> > could look if there are even better choices.
> 
> This is a totally untested patch that may or may not work.
> 
> The reason I say "may not work" is not just that I haven't really tested 
> it, it's also because I haven't thought it through very well.
> 
> In particular, does this possibly cause infinite loops of delta chains? 
> Probably. It would need code to explicitly make sure that we don't do 
> that, but I couldn't even convince myself as to why we might not hit that 
> case _already_ with delta re-use, so maybe there's something going that 
> protects us against it.

There is.

> Anyway, consider this a starting point for somebody else who wants to 
> really try to look into this.

This is a real teaser.  But I have real work to do if I want to leave on 
vacation this summer, and therefore I'll then be on vacation.  So if I 
end up looking at it myself it will be in September.


Nicolas
