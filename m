From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 3/4] Implement git-checkout-cache -u to update stat information in the cache.
Date: Tue, 17 May 2005 00:01:53 +0200
Message-ID: <20050516220153.GA8609@pasky.ji.cz>
References: <7vll6gqj3z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue May 17 00:07:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXniz-0003ZX-4b
	for gcvg-git@gmane.org; Tue, 17 May 2005 00:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVEPWDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEPWDM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 18:03:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47567 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261889AbVEPWB5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 18:01:57 -0400
Received: (qmail 19563 invoked by uid 2001); 16 May 2005 22:01:53 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll6gqj3z.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 11:23:12PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> With -u flag, git-checkout-cache picks up the stat information
> from newly created file and updates the cache.  This removes the
> need to run git-update-cache --refresh immediately after running
> git-checkout-cache.

I actually feel ok with this, but I wonder about Linus' opinion about
it.  :-)

> *** The one I posted earlier failed to add a couple of files
> *** that the patch should have added.  Please discard it and
> *** replace it with this one.  Thanks.

That reminds me, the patches would be a little easier for me to process
if you followed the /dev/null convention. (You don't need to rediff your
older patches just because of that, or even bother about it if it's a
problem for you, though.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
