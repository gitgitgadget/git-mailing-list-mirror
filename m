From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] denser delta header encoding
Date: Wed, 29 Jun 2005 01:49:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506290146270.1667@localhost.localdomain>
References: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain>
 <7vmzp9kbcf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506282217010.19755@ppc970.osdl.org>
 <7virzxk9nd.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506282244110.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 07:42:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnVKj-0007ZD-JD
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 07:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVF2FtH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 01:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVF2FtH
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 01:49:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38655 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262434AbVF2FtE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 01:49:04 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIU007JW05S5A@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Jun 2005 01:49:04 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0506282244110.19755@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Jun 2005, Linus Torvalds wrote:

> 
> 
> On Tue, 28 Jun 2005, Junio C Hamano wrote:
> > 
> > OK, not too much damage done.  I'll fix the rest up.
> 
> Actually, I already did, and pushed out. And this time I verified it by 
> doing a "git-cat-file -s" on every object on a packed repo.

Damn!

And just when I was about to send a new patch with the thing nicely 
abstracted to fix the dammage.

OK... let me pull again to see what's left then.


Nicolas
