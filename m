From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 15:41:29 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
References: <200704171041.46176.andyparkins@gmail.com>
 <200704171803.58940.andyparkins@gmail.com>
 <Pine.LNX.4.64.0704171107510.5473@woody.linux-foundation.org>
 <200704172012.31280.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 21:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdtYc-0007z4-KJ
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 21:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031188AbXDQTld (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 15:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031186AbXDQTld
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 15:41:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10943 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031184AbXDQTlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 15:41:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGN00FCKQP5L5D0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Apr 2007 15:41:31 -0400 (EDT)
In-reply-to: <200704172012.31280.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44811>

On Tue, 17 Apr 2007, Andy Parkins wrote:

> On Tuesday 2007, April 17, Linus Torvalds wrote:
> 
> > Trust me. There's NO WAY IN HELL it will "work" in any other sense
> > than "limp along and not be usable".
> 
> Well I'm making progress, "limp along" is a significant step up from 
> impossible.  :-)
> 
> Look, my primary objection to this is the SHOUTING about how impossible 
> it is even though I've tried to address every problem you've thrown at 
> me - I'm finding it really difficult to figure out why you're trying so 
> hard to dissuade me from even _trying_.  If it all goes wrong (as I 
> fully accept it might), so be it, I can live with that; I'll even be 
> happy to tell you you're right and I'm wrong.  Why is this such a 
> problem?
> 
> Keywords are so hated by everyone that I doubt they would ever be 
> accepted into git - it's an intellectual exercise for me at this stage 
> really. 

I cannot do otherwise than ask at this point in the debate: why isn't 
the makefile rule sufficient for your needs?  Why going through a 
complicated path that no one else will support due to its numerous 
pitfalls?

> > Yes, you can make your "print it out" example work, but as alreadyt 
> > mentioned, you could have done that some other way, with a simple 
> > makefile rule, quite independently (and much better) than the SCM 
> > ever did.
> 
> That's just being obtuse - no other tool cares in the slightest about 
> the keywords, there are more "tools" in the world than just the VCS.

... which reinforces my question: why force a task on the VCS if it 
doesn't fit well with its fundamental design?


Nicolas
