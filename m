From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: Add an empty directory?
Date: Sat, 13 Aug 2005 14:10:26 -0600
Organization: Hewlett Packard
Message-ID: <20050813201026.GA21096@hpsvcnb.fc.hp.com>
References: <20050813173043.GA25013@hpsvcnb.fc.hp.com> <20050813180008.GJ5608@pasky.ji.cz> <20050813181945.GA2191@hpsvcnb.fc.hp.com> <Pine.LNX.4.58.0508131238150.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 22:11:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E42L2-0001Zb-Db
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 22:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVHMUK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 16:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVHMUK1
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 16:10:27 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:12174 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932277AbVHMUK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 16:10:27 -0400
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel8.hp.com (Postfix) with ESMTP id 637733C9;
	Sat, 13 Aug 2005 16:10:26 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 2BAC93A25F; Sat, 13 Aug 2005 20:10:26 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 0E4DC2AF0F; Sat, 13 Aug 2005 14:10:26 -0600 (MDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508131238150.3553@g5.osdl.org>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 13, 2005 at 12:41:45PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 13 Aug 2005, Carl Baldwin wrote:
> > 
> > The bottom line is that I don't really see many situations where it is
> > absolutely necessary but it is a convenience.  Not supporting it may
> > seem like an artificial limit that really didn't need to be there.
> 
> Well, there is an argument for not supporting it, namely that the way 
> patches work, traditionally a directory that became empty is deleted 
> (because patches have no way of saying "remove directory" or "create 
> directory").
> 
> So a system where the existence of a directory flows from the existence of 
> the files within the directory will automatically always do the right 
> thing with patches floating around.

I see your point here.  However, if git supported it then any particular
usage model on top of git could choose to do it either way.  If it
doesn't then that flexibility is not there.

> Which is a big deal for me, since most of the kernel development still 
> ends up being done with patches. Yes, we merge things with git, but a lot 
> of the development is about passing patches around for review and 
> commentary.
> 
> And the thing is, you can always create the directory in your workspace. 
> Git won't care, and won't know about it, but there's really no downside to 
> it. 
> 
> 			Linus
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
