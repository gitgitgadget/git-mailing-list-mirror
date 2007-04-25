From: Nicolas Pitre <nico@cam.org>
Subject: Re: Making git disappear when talking about my code (was: Re: GIT vs
 Other: Need argument)
Date: Wed, 25 Apr 2007 16:31:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704251626140.12375@xanadu.home>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home>
 <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
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
 <Pine.LNX.4.64.0704251345220.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 22:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgo8z-0004GV-01
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993103AbXDYUbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993107AbXDYUbK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:31:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36836 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993103AbXDYUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:31:08 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH2008G8MBRVY80@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Apr 2007 16:31:04 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704251345220.28708@iabervon.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45567>

On Wed, 25 Apr 2007, Daniel Barkalow wrote:

> Linus has stated a preference on the lkml for being told about branches in 
> the syntax used for anonymous pulls: URL branchname.
> 
> That is, you say:
> 
>   Please pull from:
>     git://server/path branch
> 
> And he cuts and pastes into the command line:
> 
>   git pull git://server/path branch
> 
> Now, this syntax isn't available for git-clone, because git-clone puts the 
> optional directory to create after the URL. But, in an ideal world, this 
> is how it would work; you could see a pull request, and just type "git 
> some-command <paste>".

Maybe git-pull could be made usable just as well from an empty 
repository (isn't it already?) as a substitute for clone.


Nicolas
