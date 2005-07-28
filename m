From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 18:23:46 +0200
Message-ID: <20050728162345.GD17952@pasky.ji.cz>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <7vwtnadi1y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 18:25:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyBBa-000852-Le
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 18:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVG1QYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 12:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVG1QYH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 12:24:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52239 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261611AbVG1QXu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 12:23:50 -0400
Received: (qmail 21637 invoked by uid 2001); 28 Jul 2005 16:23:46 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtnadi1y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 06:14:17PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> My gut feeling is that Johannes is right here, at least about
> the send-pack side.  Storing "master" pulled from a remote under
> a name different from the remote is a different story.  I do not
> have much problem with that.

But that means you already have to manage the mapping anyway, with all
the burden of configuration items etc. And what if repository A has
branch 'foo' and repository B also has branch 'foo'?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
