From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 16:48:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505191643030.20274@localhost.localdomain>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
 <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
 <7vsm0jyryf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0505191456040.20274@localhost.localdomain>
 <7vy8abx8ay.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 22:48:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYrvZ-0001hX-Om
	for gcvg-git@gmane.org; Thu, 19 May 2005 22:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVESUsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 16:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVESUsU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 16:48:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39651 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261252AbVESUsP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 16:48:15 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGR00MBY8GDC0@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 May 2005 16:48:14 -0400 (EDT)
In-reply-to: <7vy8abx8ay.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 19 May 2005, Junio C Hamano wrote:

> >>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:
> 
> NP> Yes, but 0-9 is putting a bound on the accuracy.  What if someone wants 
> NP> not more than 2% difference?
> 
> That statement is correct, but I think you are looking at it
> from a developer perspective.
> 
> I suspect people would not want to pay the price of having
> always to type many digits for the benefit of being able to
> specify differences of 2% and 5%.  Would you also complain gzip
> only lets you say -1 .. -9 and not -1.63 ;-)?

Are we talking about git plumbing or porcelain here?


Nicolas
