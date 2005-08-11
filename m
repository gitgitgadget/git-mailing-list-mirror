From: Petr Baudis <pasky@suse.cz>
Subject: Re: cogito - how to drop a commit
Date: Thu, 11 Aug 2005 23:59:53 +0200
Message-ID: <20050811215952.GF25280@pasky.ji.cz>
References: <20050806223436.GA6495@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 00:00:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3L5p-0007lk-Am
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 00:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVHKWAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 18:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVHKWAA
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 18:00:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64265 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932354AbVHKV77 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 17:59:59 -0400
Received: (qmail 15830 invoked by uid 2001); 11 Aug 2005 21:59:53 -0000
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20050806223436.GA6495@mars.ravnborg.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Aug 07, 2005 at 12:34:36AM CEST, I got a letter
where Sam Ravnborg <sam@ravnborg.org> told me that...
> I accidently commited too many files to my tree today, and now I want to
> drop the commit so I have logically separate commits.
> 
> What is the right way to do this - in cogito hopefully.
> 
> I do not mind to execute a few git commands, but for my daily usage I
> expect cogito to hanle everything and dropping a commit has proved
> useful for me from time to time, so I expect it be be implemented in the
> porcelain somehow.
> 
> I have read the help for cg-seek - but it di not convince me to be what
> I seeked.

cg-admin-uncommit, be sure to read --help first. Linus' pruning notes
apply as well, cg-admin-uncommit won't delete it from the database
(I personally don't care about that and never pruned so far).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
