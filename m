From: Petr Baudis <pasky@suse.cz>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 00:06:04 +0200
Message-ID: <20060919220604.GE8259@pasky.or.cz>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <Pine.LNX.4.64.0609191416500.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Dice <dicej@mailsnare.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:06:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnjI-0002Lq-Pv
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWISWGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWISWGI
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:06:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64930 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751188AbWISWGG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 18:06:06 -0400
Received: (qmail 24457 invoked by uid 2001); 20 Sep 2006 00:06:04 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609191416500.4388@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27294>

Dear diary, on Tue, Sep 19, 2006 at 11:51:49PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> Another thing you CAN do, is to just number them in time in a single repo. 
> Every time you do a commit, you can create a "r1.<n+1>" revision, and that 
> would work. It wouldn't look like the SVN numbers do, and it would only 
> work _within_ that repository, but it would work.
> 
> But it would mean that "r1.57" is _not_ necessarily the child of "r1.56". 
> It might be that "r1.56" was done on another branch, and is totally 
> unrelated to "r1.57" (other than they sharing some common ancestor far 
> back).

This is actually exactly how SVN revision numbering works. There's just
a single number (no '1.') and it indeed jumps randomly if you have
several concurrent branches in your (ok, Linus does not have any, just
someone's) repository.

> You're going to hit a few confusing issues if you really want to call 
> things "r1.x.y.z"

Noone does, that indeed would be horrible. But having the commits
numbered inside a repository would indeed make for simple usage if you
need to type in commit ids frequently, and could make Git a bit
friendlier to newcomers.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
