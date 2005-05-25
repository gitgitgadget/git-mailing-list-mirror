From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] show changed tree objects with recursive git-diff-tree
Date: Wed, 25 May 2005 09:38:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505250934040.16151@localhost.localdomain>
References: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
 <7vsm0hpbub.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505202025480.2206@ppc970.osdl.org>
 <Pine.LNX.4.62.0505231724270.16151@localhost.localdomain>
 <7vmzqjn7qh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 15:41:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Daw5y-0002wM-Bs
	for gcvg-git@gmane.org; Wed, 25 May 2005 15:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVEYNkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 09:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVEYNj1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 09:39:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23947 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262345AbVEYNjT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 09:39:19 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IH1001Q4SKDT3@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 May 2005 09:38:37 -0400 (EDT)
In-reply-to: <7vmzqjn7qh.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 24 May 2005, Junio C Hamano wrote:

> How about this patch instead?  Does it do what you need?  My
> understanding of your needs is that you do not like having to
> call diff-tree (w/o recursive) only to get tree IDs involved,
> because you are indeed interested in the whole tree and prefer
> recursive behaviour; for that reason I made -t to imply -r.

Yes, that does what I need, thanks.

Now there is only the minor inconsistency that the recursive output 
without -t doesn't display tree objects while the non recursive output 
does output tree objects regardless.  Do we care?


Nicolas
