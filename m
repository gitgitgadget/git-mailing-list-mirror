From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-local-pull?
Date: Thu, 4 Aug 2005 22:12:30 +0200
Message-ID: <20050804201230.GC24479@pasky.ji.cz>
References: <Pine.LNX.4.62.0508031259430.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 22:14:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0m58-00075G-QX
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 22:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVHDUMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVHDUMd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:12:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:6923 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262655AbVHDUMc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 16:12:32 -0400
Received: (qmail 16765 invoked by uid 2001); 4 Aug 2005 20:12:30 -0000
To: barkalow@iabervon.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508031259430.23721@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Aug 03, 2005 at 07:11:00PM CEST, I got a letter
where barkalow@iabervon.org told me that...
> IIRC, git-local-pull still doesn't work for a packed source repository, 
> because it doesn't include the possibility of copying a pack (or 
> extracting an object) if the requested object is in a pack.
> 
> I can probably fix it if anyone cares, but it's not something I use 
> personally, so I don't know if it's worthwhile. It should probably be 
> removed if we don't fix it, since it will fail on any popular repository 
> at this point.

I want to use it in Cogito again, since copying everything obviously
sucks and I want to hardlink, so repacking is not a solution either.
Didn't you post some patches to fix this long time ago, actually?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
