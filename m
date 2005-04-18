From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Add + Status patches
Date: Tue, 19 Apr 2005 00:35:30 +0200
Message-ID: <20050418223529.GK5554@pasky.ji.cz>
References: <42641AE4.9050700@dgreaves.com> <7v64yju7er.fsf@assigned-by-dhcp.cox.net> <42643224.60407@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 00:32:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNemQ-0001T7-Cx
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDRWfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDRWfo
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:35:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7856 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261198AbVDRWfi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 18:35:38 -0400
Received: (qmail 15523 invoked by uid 2001); 18 Apr 2005 22:35:30 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <42643224.60407@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 12:18:12AM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Junio C Hamano wrote:
> 
> >DG> It allows:
> >DG>  find src -type f | git add -
> >
> >I am slow today, but have you considered using xargs?
> >
> > 
> >
> yep thanks :)
> I know you _could_ do it with xargs - but you _could_ use the raw git 
> commands too. This is a "be nice to the user" layer and I was 
> 'surprised' that neither
> git add .
> nor
> git add -r .
> worked.

Actually, when I saw your patch, the xargs solution rushed through my
mind but I thought that '-' might be practical too. Thinking about it, I
couldn't come up with anything. So, what about instead making git add .
to work? ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
