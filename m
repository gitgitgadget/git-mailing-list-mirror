From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Many new features for cg-diff and cg-log
Date: Wed, 8 Jun 2005 22:40:13 +0200
Message-ID: <20050608204012.GN982@pasky.ji.cz>
References: <20050608144632.A28042@flint.arm.linux.org.uk> <tnxhdg8g6e1.fsf@arm.com> <20050608181747.GA982@pasky.ji.cz> <42A754D5.10705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 22:37:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg7IW-00037L-D3
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 22:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVFHUks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 16:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFHUks
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 16:40:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40673 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261604AbVFHUkS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 16:40:18 -0400
Received: (qmail 1919 invoked by uid 2001); 8 Jun 2005 20:40:13 -0000
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
In-Reply-To: <42A754D5.10705@gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jun 08, 2005 at 10:28:05PM CEST, I got a letter
where Dan Holmsand <holmsand@gmail.com> told me that...
> Petr Baudis wrote:
> >FYI, I plan to release 0.11.2 this evening. I'll try to go through some
> >more queued patches before and update cg-log to fully use git-rev-list.
> 
> In that case, you might want to have a look at this patch. I've been 
> tinkering with cg-log and cg-diff for some time, and just about got 
> ready to send you a patch.
> 
> Sorry about the monster patch, but I wanted to get it to you quickly...

Well, it can always go to 0.11.3 or something.  I probably wouldn't take
it to the tree just before release anyway even if you sent it split up,
since due to the size of the changes, it's bound to have some hidden
bugs. ;-)

> [PATCH] Many new features for cg-diff and cg-log

Ok, this is really too big. Could you please split it up some? Also,
I've been hacking on cg-log too (and will make it use git-diff-tree -v
yet this evening), so you'll need to update it to apply to the latest
version.

I like what's inside (at least from the description), though! (Well,
mostly. But I'll comment on specific patches. No major objections.)

> - Selection of ranges by date or maximum number of commits to show.

Ad date, isn't that already supported now? The -r arguments can be a
date. Ad maximum number of commits, what'd be its use?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
