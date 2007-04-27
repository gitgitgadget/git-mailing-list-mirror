From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] [PATCH] git-mirror - exactly mirror another repository
Date: Fri, 27 Apr 2007 20:00:12 +0200
Message-ID: <20070427180012.GA4489@pasky.or.cz>
References: <20070427021505.1740.58136.stgit@rover> <4631642B.2010501@gmail.com> <20070427043812.GX4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 20:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhUks-0003Wt-5b
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 20:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbXD0SBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 14:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756199AbXD0SAw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 14:00:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43504 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756990AbXD0SAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 14:00:15 -0400
Received: (qmail 20862 invoked by uid 2001); 27 Apr 2007 20:00:12 +0200
Content-Disposition: inline
In-Reply-To: <20070427043812.GX4489@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45737>

On Fri, Apr 27, 2007 at 06:38:12AM CEST, Petr Baudis wrote:
> But heck, maybe with all the nifty fetch--tools git-fetch is already
> doing it. But there seems to be basically zero documentation, the code
> is not that easy to follow and it's too late for me to be decyphering it
> now... 

Ok, so it seems that git-fetch already can do almost all of this; at
least it seems that I'm far from being alone in not realizing it. :-)

With the refspec +refs/heads/*:refs/heads/* and git remote prune
(thanks, Shawn!), it seems that git-fetch can already do everything
git-mirror tries to do, except updating the HEAD, but especially with
the symref embedding in git-ls-remote that Junio proposed, even that
should be fixable easily, right?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
