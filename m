From: Petr Baudis <pasky@suse.cz>
Subject: Re: My Itchlist
Date: Sat, 13 Aug 2005 22:05:04 +0200
Message-ID: <20050813200504.GL5608@pasky.ji.cz>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508051924390.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 22:06:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E42Fn-00019T-AX
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 22:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVHMUFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 16:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVHMUFH
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 16:05:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57614 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932242AbVHMUFG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 16:05:06 -0400
Received: (qmail 18006 invoked by uid 2001); 13 Aug 2005 20:05:04 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508051924390.3258@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 06, 2005 at 04:39:01AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Fri, 5 Aug 2005, Junio C Hamano wrote:
> > - teach git-apply "reverse" and possibly "fuzz".
> > 
> >   I think this might help Porcelain; currently they have to
> >   interpret git extended diff headers themselves.
> 
> Reverse would definitely be useful. "fuzz" is really pretty dangerous. I 
> think that once a a patch doesn't apply, you really want to have helper 
> tools like a graphical "wiggle" etc, and that really means that it's not 
> "git-apply", it's something totally different.

I don't know, but I come across fuzzy patches quite frequently and any
problems have been always _extremely_ rare. And in any case, I can (and
do) verify it right away by doing cg-diff and checking what changes did
the patch really do.

> And quite frankly, if you have a tool that can handle unified diffs 
> already, then extending it for the git rename stuff should be pretty easy. 
> It's not like we haven't wanted renaming patches for at least a _decade_ 
> already, it's just that nobody ever did them. 

That reminds me I should finally add support for renames to cg-patch...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
