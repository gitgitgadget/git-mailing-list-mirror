From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Problem with cg-diff <file>
Date: Mon, 30 May 2005 02:32:42 +0200
Message-ID: <20050530003242.GA1036@pasky.ji.cz>
References: <1117408555.7072.109.camel@pegasus> <20050529233840.GY1036@pasky.ji.cz> <7vis11ftvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcel Holtmann <marcel@holtmann.org>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 02:37:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcYHU-0004mx-Sl
	for gcvg-git@gmane.org; Mon, 30 May 2005 02:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVE3AjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 20:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVE3AfU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 20:35:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23686 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261485AbVE3Acs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 20:32:48 -0400
Received: (qmail 32239 invoked by uid 2001); 30 May 2005 00:32:42 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vis11ftvm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 02:19:09AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> ... git-diff-tree (in contrast to
> PB> git-diff-cache) won't take the pathspec as its trailing arguments,
> 
> PB> Junio, is there any specific reason for that, or is the end of
> PB> git-diff-tree argument list the right spot for the pathspec stuff?
> 
> Baffled.  Are you at Linus tip?
> 
> Linus correctly decided that diff-tree does not have to call
> diffcore_pathspec(), which may be what confused you to make the
> comment "... in contrast to git-diff-cache) won't take ...".
> But it does not call it only because it does not need to.  It
> filters the filepairs itself on the input side using the
> trailing arguments; since diffcore_pathspec filters as the first
> one in the chain as the input filter, calling it from diff-tree
> would not cull anything further.

Ok, so this is what you get when you mix: sleepiness, performing only
mental experiments not verified in practice, and inattentive reading of
the code.

I'm sorry for bothering. Instruct yourself from my bad example, please.
:-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
