From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] faking cvs annotate
Date: Fri, 16 Dec 2005 16:40:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512161636150.26663@localhost.localdomain>
References: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com>
 <Pine.LNX.4.63.0512160229140.6323@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90512152037u66993aadg566a2a47abd279c9@mail.gmail.com>
 <Pine.LNX.4.64.0512160843450.3060@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 22:41:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnNJB-0003qM-7T
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVLPVkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVLPVkF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:40:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64200 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932417AbVLPVkE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 16:40:04 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IRM00DFU1IP5LO0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Dec 2005 16:40:01 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0512160843450.3060@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13757>

On Fri, 16 Dec 2005, Linus Torvalds wrote:

> But, for example:
> 
> 	[torvalds@g5 linux-history]$ time git-whatchanged drivers/char/Makefile > /dev/null 
> 	real    0m37.993s
> 	user    0m41.912s
> 	sys     0m0.400s

Hmmm... I'd like to have a system like that too, where reality is 
smaller than the sum of system and user time.  ;-)


Nicolas
