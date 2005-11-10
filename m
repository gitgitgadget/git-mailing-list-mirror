From: Petr Baudis <pasky@suse.cz>
Subject: Re: Do I misunderstand cg-merge --squash option
Date: Thu, 10 Nov 2005 11:12:06 +0100
Message-ID: <20051110101206.GP30496@pasky.or.cz>
References: <200511100025.05993.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 11:13:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea9Ps-0000b0-0C
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 11:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKJKMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 05:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVKJKMJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 05:12:09 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3273 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750708AbVKJKMI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 05:12:08 -0500
Received: (qmail 14762 invoked by uid 2001); 10 Nov 2005 11:12:06 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200511100025.05993.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11477>

Dear diary, on Thu, Nov 10, 2005 at 01:25:05AM CET, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> said that...
> I am trying to take my current development repository which has several 
> hundred commits in it as I was developing my application and make a 
> simplified branch for pushing to my public repository.
> 
> I basically created a new branch (public) from the tag at the point where I 
> started the repository.
> 
> git-checkout -b public initial_commit
> 
> I then did a merge
> 
> cg-merge --squash v1.0

Why do you want to do a squash merge?

> But I don't know how to move forward and merge in changes after my v1.0 tag.  
> Any attempt to merge anything else into this "public" branch seems to throw 
> up what appears to be merge conflict, but I can't see why - when I look at 
> the results one side has extra lines, but there is no other overlap.

I told you in the documentation - "re-merging with that branch later
will cause trouble". If you want to be able to re-merge the branch
later, you shouldn't use squash merge. And you shouldn't use squash
merge anyway, expect for few narrow use cases.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
