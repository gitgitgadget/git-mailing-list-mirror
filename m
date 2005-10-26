From: Petr Baudis <pasky@suse.cz>
Subject: Re: Towards CVS code-exchange and gateways
Date: Wed, 26 Oct 2005 22:51:30 +0200
Message-ID: <20051026205130.GA20563@pasky.or.cz>
References: <46a038f90510251357l23886747s8024a4326ad4e392@mail.gmail.com> <46a038f90510252035yb4167e1w2ee54d82896e5906@mail.gmail.com> <20051026085302.GF30889@pasky.or.cz> <46a038f90510260211i47c8a4e1oca8be8d0833f4b68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 26 22:53:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUsFE-00011U-Hd
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 22:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVJZUve (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 16:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVJZUve
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 16:51:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11460 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964913AbVJZUvd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 16:51:33 -0400
Received: (qmail 5799 invoked by uid 2001); 26 Oct 2005 22:51:30 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90510260211i47c8a4e1oca8be8d0833f4b68@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10694>

Dear diary, on Wed, Oct 26, 2005 at 11:11:49AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> The goal for this script that I'm drafting is to be able to push
> commits back into cvs in a format that maximises the chance of
> git-cherry identifying them when they are echoed back (and thus
> avoiding bogus conflicts).

Aha, so you are not aiming for proper two-way incremental i/e, and one
will have to cherrypick to import after an export... well, I guess that
can be good enough for many cases. But to use Linus' words, the really
interesting problem is to have the proper revision tree in the CVS heads
as well, so that you could do normal merges. And it shouldn't be _that_
hard either...

> > If someone really desperately needs this, BTW, you might be able to
> > merge two Monotone branches (.git and .cvssync) to get two-way
> > incremental GIT and CVS interface, and then do that through Monotone.
> > ;-))
> 
> I'm really scared by the concept ;-)

I *think* someone actually really did something like that. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
