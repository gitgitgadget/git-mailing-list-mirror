From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 22:52:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610152247270.17085@xanadu.home>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
 <7virim10rb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151135110.17085@xanadu.home>
 <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151422510.17085@xanadu.home> <45329359.1030302@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 04:53:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZIbC-0006ID-VZ
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 04:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWJPCw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 22:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWJPCw7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 22:52:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26937 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751304AbWJPCw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 22:52:58 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J77003XQK09LLS1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 15 Oct 2006 22:52:57 -0400 (EDT)
In-reply-to: <45329359.1030302@gmail.com>
X-X-Sender: nico@xanadu.home
To: A Large Angry SCM <gitzilla@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28946>

On Sun, 15 Oct 2006, A Large Angry SCM wrote:

> Nicolas Pitre wrote:
> > 
> > The delta-base-offset case included a new object type that wasn't used
> > before hence there is no room for confusion, and yet that new delta object
> > could be encoded according to pack version 2 or pack version 3 which makes
> > it orthogonal to the pack version itself.
> 
> It's not a new object type. It's a new object _encoding_ method.

Not at all.  If it was only a question of encoding method, then both of 
them could always be interchangeable and supersede the other, which is 
not the case here.


Nicolas
