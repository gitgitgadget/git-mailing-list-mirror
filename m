From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 23:27:25 +0200
Message-ID: <20050722212725.GJ11916@pasky.ji.cz>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722204120.GD11916@pasky.ji.cz> <7vr7dqpmm4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Bryan larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:34:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw54Z-00061x-23
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVGVV2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVGVV2D
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:28:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50183 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262184AbVGVV11 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 17:27:27 -0400
Received: (qmail 27286 invoked by uid 2001); 22 Jul 2005 21:27:25 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr7dqpmm4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 22, 2005 at 11:16:51PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Wonderful start.
> 
> Later on, Porcelains could agree on what @TOKEN@ are generally
> available, and even start using a common script to pre-fill the
> templates, like:
> 
>   $ git-fill-template-script <template> <output-file> var=val var=val...
> 
> In your example, I see AUTHOR_NAME, AUTHOR_EMAIL, and
> AUTHOR_DATE (I'd use GIT_AUTHOR_NAME etc to match existing
> environment variables, though) would be something that are
> probably common across Porcelains, and the Porcelain would not
> even have to bother passing them as the command argument to
> fill-template.

Good idea. More interesting exercise would be to make a script which
extracts the values back after the user had a chance to touch it.

> About FILELIST, the default would be to do "git-diff-cache --name-only
> HEAD", but if a Porcelain keeps track of "modified" files differently
> it can be overridden by passing FILELIST as an explicit parameter.

Cogito shows '[NMD] filename' in place of @FILELIST@.

This brings me to another subject, M and N are pretty hard to
distinguish visually without close inspection of the output. What about
switching to use A instead of N everywhere?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
