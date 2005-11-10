From: Petr Baudis <pasky@suse.cz>
Subject: Re: Do I misunderstand cg-merge --squash option
Date: Thu, 10 Nov 2005 20:29:23 +0100
Message-ID: <20051110192923.GT30496@pasky.or.cz>
References: <200511100025.05993.alan@chandlerfamily.org.uk> <20051110101206.GP30496@pasky.or.cz> <200511101915.53736.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 20:31:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaI70-00060q-6H
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVKJT31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKJT31
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:29:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:1950 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751219AbVKJT31 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 14:29:27 -0500
Received: (qmail 21530 invoked by uid 2001); 10 Nov 2005 20:29:23 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200511101915.53736.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11508>

Dear diary, on Thu, Nov 10, 2005 at 08:15:53PM CET, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> said that...
> On Thursday 10 Nov 2005 10:12, Petr Baudis wrote:
> > Why do you want to do a squash merge?
> 
> I used git experimentally as I built a web application from scratch, learning 
> both what I wanted the application to look like and how to do it with the 
> packages I was using.  There is several hundreds of commits that are totally 
> irrelevant (both because they were all different directions I was trying and 
> then backing out of and because I saved state just were I was when I gave up 
> for the day).
> 
> So what I was experimenting with was whether I could somehow get rid of that 
> history (at least in one branch) before making that history public.

Aha. That sounds reasonable.

> > I told you in the documentation - "re-merging with that branch later
> > will cause trouble". If you want to be able to re-merge the branch
> > later, you shouldn't use squash merge. And you shouldn't use squash
> > merge anyway, expect for few narrow use cases.
> 
> I know - I saw the warning - and I was only experimenting.  I just didn't 
> understand what had happened.

If you would be doing something like this again, it's best to merge, and
then rather than continuing to develop what you merged, just throw that
branch again and re-clone the merged repository.

Right now, what about trying to manually select the merge base?

	public$ cg-merge -b v1.0 master

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
