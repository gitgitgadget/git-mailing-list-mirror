From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Tue, 17 Oct 2006 12:51:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610171250530.1971@xanadu.home>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
 <7virim10rb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151135110.17085@xanadu.home>
 <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151150530.3952@g5.osdl.org>
 <Pine.LNX.4.64.0610160929450.17085@xanadu.home>
 <7vodsakjkg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Oct 17 18:51:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZs9u-0000gT-1P
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 18:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWJQQvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 12:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWJQQvP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 12:51:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:4531 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751308AbWJQQvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 12:51:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7A00609HHC9FV4@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 12:51:13 -0400 (EDT)
In-reply-to: <7vodsakjkg.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29093>

On Tue, 17 Oct 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Sun, 15 Oct 2006, Linus Torvalds wrote:
> >
> >> Quite frankly, I wonder if the pure "copy size extension" (aka "v3") thing 
> >> is really worth it at all. 
> >> 
> >> I mean, seriously, how much does it buy us? A couple of bytes per every 
> >> 64kB of delta copied? And the downside is that you can't re-use the deltas 
> >> with old clients and/or you have to re-create a "v2" delta at run-time 
> >> from a v3 delta by inflating, fixing and deflating it.
> >
> >...
> > In the mean time, if Junio adds the patch I posted yesterday advertising 
> > the pack version capability over the native protocol then it'll help us 
> > make things forward compatible if ever we decide to go with generating 
> > packs v3 sooner.
> 
> I've thought about this, but we hopefully would have ofs-delta
> capability exchanged soon after 1.4.3, and that would be an
> enough advertisement that the client is recent enough; although
> it is technically incorrect to tie these two independent
> features together, the improvement between v2 and v3 is dubious
> so maybe that is the easiest.

Fair enough.


Nicolas
