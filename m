From: Petr Baudis <pasky@suse.cz>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Tue, 27 Sep 2005 12:17:44 +0200
Message-ID: <20050927101744.GD30889@pasky.or.cz>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net> <87psqwzs3x.fsf@ualberta.net> <7v7jd4n22i.fsf@assigned-by-dhcp.cox.net> <20050926191037.GD26340@pasky.or.cz> <7vll1jh8zr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 12:19:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKCX0-000477-7r
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 12:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVI0KRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 06:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVI0KRq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 06:17:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41610 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964888AbVI0KRq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 06:17:46 -0400
Received: (qmail 6067 invoked by uid 2001); 27 Sep 2005 12:17:44 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll1jh8zr.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9389>

Dear diary, on Mon, Sep 26, 2005 at 10:25:28PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > ... Either way, git-pull won't be equivalent to git-fetch &&
> > git-merge (or git-resolve or whatever is the core porcelain
> > command) anymore.
> 
> "pull = fetch + merge" is a reasonable approximation to use when
> you explain what they are to somebody, but taking it literally
> would harm usefulness.
> 
> It is what you have already lived with for a while.  "git pull
> .../linux/2.6.git v2.6.11-tree v2.6.12" would fetch both heads
> but merges v2.6.12 head only (because v2.6.11-tree is not
> something you can merge with).

Yes, but that's a rather obscure case. :-) But well, your use cases
convinced me that the behaviour to fetch multiple heads even if you are
going to merge just one of them is useful enough. However, I still think
that the user should be required to specify the to-be-merged head
manually if the default choice isn't explicitly written in the remotes
file.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
