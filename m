From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Sat, 26 May 2007 23:03:00 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705262243530.3366@xanadu.home>
References: <87bqg724gp.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
 <7vk5uvjy0g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 27 05:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs92J-0002I6-QJ
	for gcvg-git@gmane.org; Sun, 27 May 2007 05:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbXE0DDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 23:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbXE0DDH
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 23:03:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55642 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbXE0DDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 23:03:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIO008Z4J50JQ50@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 26 May 2007 23:03:00 -0400 (EDT)
In-reply-to: <7vk5uvjy0g.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48512>

On Sat, 26 May 2007, Junio C Hamano wrote:

> Once you learn to _visualize_ the ordering relationship in "X op
> Y" by relying on "op" being always < or <=, you will get the
> "number line" pop in your head whenever you see a comparision
> expression, without even having to think about it, and you "see"
> X and Y on the number line:
> 
>         ... -2        -1         0         1         2  ...  
>     ---------+---------+---------+---------+---------+---------
>     true:                        0   <=  fcntl(...)
> 
> 
>         ... -2        -1         0         1         2  ...  
>     ---------+---------+---------+---------+---------+---------
>     false:    (0 <= fcntl(...))
> 
> What the comparison is doing comes naturally to you, without
> even having to translate it back to human language "X is larger
> (or smaller) than this constant".  The ordering is right there,
> in front of your eyes, before you vocalize it.

Well... it probably depends on how your brain is wired up.

I completely agree with your reasoning.  It _should_ indeed be natural 
and more obvious to always put things in increasing order.

BUT it is not how my brain is connected, and after many attempts I just 
cannot work efficiently with your method.  It simply doesn't come out 
logical for me and I have to spend an unusual amount of time on every 
occasion I encounter this structure to really get it.  To me it always 
looks backward.

And I suspect the majority of people who just cannot train their brain 
with the arguably superior representation are many, probably the 
majority. It appears to be the case for Linus.  It is definitely the 
case for me.


Nicolas, who apologizes for his defective brain.
