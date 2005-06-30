From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 17:05:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>
References: <7vll4r1sxz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 23:01:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do69M-0008Ah-W0
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 23:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVF3VHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 17:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbVF3VHc
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 17:07:32 -0400
Received: from iabervon.org ([66.92.72.58]:61700 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263077AbVF3VHB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 17:07:01 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Do6DU-00069R-00; Thu, 30 Jun 2005 17:05:00 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll4r1sxz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jun 2005, Junio C Hamano wrote:

> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> In fact, the most recent push was gone with a
> 
> LT> 	git-send-pack master.kernel.org:/pub/scm/linux/kernel/git/torvalds/git.git
> 
> Congrats for a job well done.
> 
> Now is there anything for us poor mortals who would want to have
> a "pull" support?  Logging in via ssh and run send-pack on the
> other end is workable but not so pretty ;-).

I suspect that I'll be able to merge send-pack/receive-pack with
ssh-push/ssh-pull this evening, and then it'll have the feature of not
caring too much which side your command line is on.

	-Daniel
*This .sig left intentionally blank*
