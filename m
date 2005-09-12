From: Petr Baudis <pasky@suse.cz>
Subject: Re: git/cogito suggestion: tags with descriptions
Date: Mon, 12 Sep 2005 03:00:51 +0200
Message-ID: <20050912010051.GJ15630@pasky.or.cz>
References: <20050905184551.GA14720@tumblerings.org> <7vd5nn49uz.fsf@assigned-by-dhcp.cox.net> <20050905212431.GB14720@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 03:01:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEcgr-00058C-Q0
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 03:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVILBAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 21:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVILBAy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 21:00:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27782 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751112AbVILBAx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 21:00:53 -0400
Received: (qmail 29926 invoked by uid 2001); 12 Sep 2005 03:00:51 +0200
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050905212431.GB14720@tumblerings.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8354>

Dear diary, on Mon, Sep 05, 2005 at 11:24:31PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> I'm not sure. I'm not as familiar with the low-level git commands as I am with
> cogito. But cogito has a -d option for giving a tag description. I guess what
> would be closest to what I was thinking about would be this:
> 
> $ cg-tag -d "First draft, everything in place." 0.3 7540e503b9b9c1b03e44ee7fd700c844b2a02224
> $ cg-tag-ls
> 0.1     Initial idea complete                 f953b71b21a0bea682c2bed91362f2dce2cc204f
> 0.3     First draft, everything in place.     7540e503b9b9c1b03e44ee7fd700c844b2a02224 
> $
> 
> or something like that. Currently when I do the above cg-tag command,
> a subsequent cg-tag-ls gives just:
> 
> $ cg-tag-ls
> 0.1     f953b71b21a0bea682c2bed91362f2dce2cc204f
> 0.3     7540e503b9b9c1b03e44ee7fd700c844b2a02224
> 
> In fact, I probably wouldn't even be interested in seeing the actual hash key
> unless I gave a special flag, maybe -f (for "full"):
> 
> $ cg-tag-ls
> 0.1     Initial idea complete
> 0.3     First draft, everything in place.
> $ cg-tag-ls -f
> 0.1     Initial idea complete                 f953b71b21a0bea682c2bed91362f2dce2cc204f
> 0.3     First draft, everything in place.     7540e503b9b9c1b03e44ee7fd700c844b2a02224

That's a nice idea (except that I'd prefer -l). I'll implement this
after cogito-0.14.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
