From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFH] Merge driver
Date: Fri, 9 Sep 2005 13:25:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509091320420.23242@iabervon.org>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
 <7v1x407min.fsf@assigned-by-dhcp.cox.net> <431F34FF.5050301@citi.umich.edu>
 <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net> <4320536D.2010706@citi.umich.edu>
 <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
 <43207FE6.2030108@citi.umich.edu> <Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
 <432089D8.4060507@citi.umich.edu> <7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509091151520.23242@iabervon.org> <7vy866jio4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>, cel@citi.umich.edu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 19:22:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDmYr-0000TN-UO
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 19:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVIIRVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVIIRVL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 13:21:11 -0400
Received: from iabervon.org ([66.92.72.58]:37137 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030272AbVIIRVJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 13:21:09 -0400
Received: (qmail 4899 invoked by uid 1000); 9 Sep 2005 13:25:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Sep 2005 13:25:09 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy866jio4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8246>

On Fri, 9 Sep 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > It tries to make sure that there is room to put stuff for resolving a 
> > conflict without messing with modified files in the directory.
> 
> I agree it can be used that way, but nobody seems to use it for
> that purpose as far as I can tell hence my earlier comment.  But
> let's leave the door open by having them as independent
> options.

Ah, okay. I hadn't realized that resolve used -u for that call to 
read-tree. You're entirely right.

	-Daniel
*This .sig left intentionally blank*
