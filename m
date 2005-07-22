From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/2] GIT: Listen on IPv6 as well, if available.
Date: Sat, 23 Jul 2005 00:05:54 +0200
Message-ID: <20050722220554.GL11916@pasky.ji.cz>
References: <20050721.091049.46807257.yoshfuji@linux-ipv6.org> <20050722212151.GI11916@pasky.ji.cz> <20050722.173517.73563363.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 00:10:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw5ek-0003KA-W7
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 00:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVGVWF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 18:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVGVWF6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 18:05:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36104 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262198AbVGVWF4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 18:05:56 -0400
Received: (qmail 29953 invoked by uid 2001); 22 Jul 2005 22:05:54 -0000
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Content-Disposition: inline
In-Reply-To: <20050722.173517.73563363.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 22, 2005 at 11:35:17PM CEST, I got a letter
where "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org> told me that...
> In article <20050722212151.GI11916@pasky.ji.cz> (at Fri, 22 Jul 2005 23:21:51 +0200), Petr Baudis <pasky@suse.cz> says:
> > this whole getaddrinfo() magic looks horribly complicated. What's wrong
> > on just adding a similar code (or factoring it out to a function) for
> > IPv6 as there is for IPv4, just s/INET/INET6/?
> 
> Because it is the Good Way To Go; protocol independent programming.

I can see its merits, and it doesn't look so horrible after a while. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
