From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining cg-*-id
Date: Mon, 19 Sep 2005 23:56:08 +0200
Message-ID: <20050919215608.GA13845@pasky.or.cz>
References: <1127166049.26772.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:57:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHTct-0001t6-6m
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 23:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbVISV4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 17:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbVISV4L
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 17:56:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49376 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932659AbVISV4K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 17:56:10 -0400
Received: (qmail 25907 invoked by uid 2001); 19 Sep 2005 23:56:08 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1127166049.26772.26.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8915>

Dear diary, on Mon, Sep 19, 2005 at 11:40:49PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hello,

> I believe Cogito should keep the command list short.  When the *-id
> utilities got the cg-prefix, the list became longer by 3 commands.

well, those commands are semi-public, actually. E.g. cg-help does not
list them.

> What if we join cg-commit-id, cg-parent-id and cg-tree-id into one cg-id
> (or cg-admin-id) utility?  It would work like cg-commit-id in absence of
> switches, -p would make it work like cg-parent-id, and -t would make it
> cg-tree-id.

Perhaps cg-object-id? I'm not principially opposed to that, but I don't
see much value in it either. Perhaps if this would come along with
the usage of git-rev-parse (see below)...

> Alternatively, this functionality should go to git.  It's low-level
> enough to be there.

There is git-rev-parse, but it is not as powerful (cannot take dates and
sha1 completion does not work when listing parents) - OTOH it can
complete sha1 ids even inside packs, which is really useful. Still, IMHO
its usage is awful, so it'd take place for cg-Xnormid, but we would
still keep the *-id frontends (which would also handle the dates).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
