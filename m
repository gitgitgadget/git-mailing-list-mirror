From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] delta micro optimization
Date: Fri, 10 Feb 2006 15:38:57 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602101516310.5397@localhost.localdomain>
References: <Pine.LNX.4.64.0602101335160.5397@localhost.localdomain>
 <7vhd77vv9o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 21:39:02 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7f2k-00007N-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 21:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWBJUi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 15:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWBJUi7
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 15:38:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8272 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932178AbWBJUi6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 15:38:58 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IUH00CEYO0XKG30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 10 Feb 2006 15:38:57 -0500 (EST)
In-reply-to: <7vhd77vv9o.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15881>

On Fri, 10 Feb 2006, Junio C Hamano wrote:

> That looks obviously correct but it really is micro.  Have you
> benched it?  On which architectures?  Does it help everywhere or
> register starved ones benefit more than others?

I doubt the performance difference would be measurable on i386 although 
the code is a bit smaller.

On ARM it causes a code reduction of 12.5% in count-delta.o.


Nicolas
