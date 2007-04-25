From: Nicolas Pitre <nico@cam.org>
Subject: Re: Making git disappear when talking about my code (was: Re: GIT vs
 Other: Need argument)
Date: Wed, 25 Apr 2007 16:23:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704251523050.12375@xanadu.home>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>
 <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl>
 <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org>
 <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
 <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net> <87mz0w7g3j.wl%cworth@cworth.org>
 <87k5w07dft.wl%cworth@cworth.org>
 <alpine.LFD.0.98.0704250751330.9964@woody.linux-foundation.org>
 <87fy6o770w.wl%cworth@cworth.org>
 <alpine.LFD.0.98.0704251341280.12375@xanadu.home>
 <878xcg6zv0.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 22:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgo1C-0000UN-Vl
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993078AbXDYUXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993079AbXDYUXL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:23:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25914 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993078AbXDYUXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:23:09 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH2006FRLYIJA50@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Apr 2007 16:23:07 -0400 (EDT)
In-reply-to: <878xcg6zv0.wl%cworth@cworth.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45562>

On Wed, 25 Apr 2007, Carl Worth wrote:

> Compare what one used to be able to do with pre-separate-remotes git:
> 
> 	git clone git://git.kernel.org/pub/scm/git/git.git
> 	git checkout next
> 	git pull # occasionally
> 
> to what you have now:
> 
> 	git clone git://git.kernel.org/pub/scm/git/git.git
> 	git checkout origin/next

But if you _create_ a new branch in your repository, Git will pick it up 
automatically now with a fetch operation, which the previous branch 
layout didn't allow for.


Nicolas
