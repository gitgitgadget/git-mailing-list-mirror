From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Terminology] Push vs. upload?
Date: Wed, 21 Sep 2005 18:52:34 +0200
Message-ID: <20050921165234.GD21971@pasky.or.cz>
References: <20050920001136.GK18320@pasky.or.cz> <Pine.LNX.4.58.0509191753100.2553@g5.osdl.org> <20050920014448.GA30912@pasky.or.cz> <Pine.LNX.4.58.0509191858020.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:55:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7q0-0007Rn-Ce
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVIUQwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVIUQwh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:52:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51676 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751155AbVIUQwg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:52:36 -0400
Received: (qmail 4189 invoked by uid 2001); 21 Sep 2005 18:52:34 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509191858020.2553@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9063>

Dear diary, on Tue, Sep 20, 2005 at 03:59:15AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Tue, 20 Sep 2005, Petr Baudis wrote:
> > 
> > Yes, but I'm just arguing about the naming - if you just take the word
> > "pull", "push" is the obvious opposite to that and vice versa, so if we
> > are going to use words "pull" and "push" in the same context, this
> > relation should be preserved. So "push" really _should_ mean
> > 
> > 	ssh other-end 'git-pull'
> 
> Well, I actually called it "send" as in "git-send-pack".
> 
> But anybody who has ever used BK would still type "push", so I'd make that 
> an alias anyway.
> 
> Not "upload". Upload is the reverse of "download", and we don't do that.

All right, now I agree that "upload" isn't that appropriate, since
git-ssh-upload isn't actually for any push-related activity, even though
it is a git-ssh-fetch counterpart - it is so in a different sense.

I don't want to name it cg-send because I think that would be way too
easily confused with sending patches over e-mail. So it ended up being
cg-push again. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
