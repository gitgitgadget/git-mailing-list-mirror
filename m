From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 14:23:04 +0200
Message-ID: <20050426122304.GD18971@pasky.ji.cz>
References: <20050426032422.GQ13467@pasky.ji.cz> <426DBF94.3010502@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 14:19:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQP12-0004Sr-4d
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 14:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDZMXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 08:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDZMXN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 08:23:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38022 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261417AbVDZMXJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 08:23:09 -0400
Received: (qmail 29475 invoked by uid 2001); 26 Apr 2005 12:23:04 -0000
To: Mike Taht <mike.taht@timesys.com>
Content-Disposition: inline
In-Reply-To: <426DBF94.3010502@timesys.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 06:12:04AM CEST, I got a letter
where Mike Taht <mike.taht@timesys.com> told me that...
> 
> >  Yes, this is a huge change. No, I don't expect any further changes of
> >similar scale. I think the new interface is significantly simpler _and_
> >cleaner than the old one.
> 
> Heh. Another huge change would be moving the top level directories 
> around a bit.
> 
> 
> bindings  COPYING  git.spec  Makefile  programs  README.reference  tests
> contrib   doc      include   po        README    src  VERSION
> 
> Leaving fixing the makefiles aside as an exercise for the interested 
> reader... that's:

Actually, I've been thinking about this, but I think we just don't need
it *yet*.

And by the time we will need to make things more hierarchical, we will
hopefully have some way to deal with renames sensibly. We need something
for that too - either something ultra-smart as Linus describes, or
explicit renames, but merging not working across renames makes them
total nightmare.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
