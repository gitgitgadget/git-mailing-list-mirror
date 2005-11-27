From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sun, 27 Nov 2005 19:22:44 +0100
Message-ID: <20051127182244.GK22159@pasky.or.cz>
References: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de> <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de> <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org> <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net> <7vpson4tqi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511260855560.13959@g5.osdl.org> <7vr792fnta.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511270949540.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 27 19:23:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgRAW-0000ib-UQ
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 19:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVK0SW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 13:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVK0SW3
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 13:22:29 -0500
Received: from w241.dkm.cz ([62.24.88.241]:16560 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751135AbVK0SW3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 13:22:29 -0500
Received: (qmail 11343 invoked by uid 2001); 27 Nov 2005 19:22:44 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511270949540.13959@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12816>

Dear diary, on Sun, Nov 27, 2005 at 07:01:37PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> If you use "-r", it acts the way you'd expect. If you _don't_ use "-r", it 
> acts strangely, but very consistently with git-diff-tree: it only ever 
> shows the _first_ part of a pathname. So
> 
> 	git-ls-tree HEAD drivers/char/
> 
> should show just one entry: "drivers". While adding a "-r" should show all 
> files under drivers (and the trees leading up to it).
> 
> And yes, you're right. That's a much bigger change by my suggested diff, 
> and more likely to cause confusion.

Ugh. That's really weird. Wouldn't a better approach be to fix
git-ls-files to behave more sanely? (That is, listing the entry for
drivers/char instead of drivers?)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
