From: Petr Baudis <pasky@suse.cz>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 18:38:46 +0200
Message-ID: <20050926163846.GD21019@pasky.or.cz>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz> <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Coxall <quasi@cream.org>,
	Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 18:42:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJw0B-0004cb-HP
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 18:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbVIZQit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 12:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbVIZQit
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 12:38:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4331 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751663AbVIZQis (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 12:38:48 -0400
Received: (qmail 19184 invoked by uid 2001); 26 Sep 2005 18:38:46 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9309>

Dear diary, on Mon, Sep 26, 2005 at 05:04:25PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> You basically have to run fsck on your repository after an rsync. And if 
> it returns errors, you're screwed unless you remember what your old heads 
> were.

Actually, it would be nice to be able to tell git-fsck-objects to only
verify objects which are referenced between given two commits (perhaps
just make it support the ^object notation). Then I wouldn't mind running
that after each rsync fetch in Cogito.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
