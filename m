From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] count-delta.c: Match the delta data semantics change in
 version 3.
Date: Thu, 09 Feb 2006 20:54:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602092053200.5397@localhost.localdomain>
References: <Pine.LNX.4.64.0602091736500.5397@localhost.localdomain>
 <7v7j846qco.fsf@assigned-by-dhcp.cox.net>
 <7vbqxg3tdd.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 02:54:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7NUZ-0002LW-8N
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 02:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWBJByd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 20:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWBJByd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 20:54:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49638 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750986AbWBJByc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 20:54:32 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IUG00H367YVIJA0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Feb 2006 20:54:32 -0500 (EST)
In-reply-to: <7vbqxg3tdd.fsf_-_@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15856>

On Thu, 9 Feb 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > I agree with the general direction and this futureproofing is a
> > good thing to have before 1.2.0, I think.
> >
> > The bit is however _already_ looked at by the count_delta(),
> > to assess the extent of damage, IIRC.  Should we be
> > futureproofing that bit as well?
> 
> Something like this?

Right.


Nicolas
