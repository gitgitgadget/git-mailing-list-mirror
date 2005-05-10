From: Petr Baudis <pasky@ucw.cz>
Subject: Re: "git-checkout-cache -f -a" failure
Date: Wed, 11 May 2005 01:03:58 +0200
Message-ID: <20050510230357.GF26384@pasky.ji.cz>
References: <118833cc05050911255e601fc@mail.gmail.com> <7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>,
	GIT Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 00:56:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVdeY-0001Zv-55
	for gcvg-git@gmane.org; Wed, 11 May 2005 00:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVEJXEC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 19:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEJXEC
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 19:04:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5801 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261844AbVEJXD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 19:03:59 -0400
Received: (qmail 8628 invoked by uid 2001); 10 May 2005 23:03:58 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 11, 2005 at 12:57:34AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "MW" == Morten Welinder <mwelinder@gmail.com> writes:
> 
> MW> git-checkout-cache is having problems when files change from directories to
> MW> plain files or vice versa.  cg-seek seems to be similarly affected.
> 
> Could you give this patch a try?  It lets checkout-cache remove
> a file where you want to have a directory (because you want to
> create something underneath) or remove a whole subdirectory
> where you want to have a non-directory, when '-f' parameter is
> specified.
> 
> If things test well, I'll put this in the git-jc repository and
> ask Linus to pull from it alongside with other accumulated
> patches when he returns.

Chilling.

What if you have some files not tracked by git in the subdirectory?
Either you need to check for this and deal with it (Cogito's approach
would be to remove the git-tracked files and rename the subdirectory),
or not do it at all. Or at least please use -F or something if you
really want this and like to gamble.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
