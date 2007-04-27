From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Add support for grep searches
Date: Fri, 27 Apr 2007 05:47:29 +0200
Message-ID: <20070427034729.GU4489@pasky.or.cz>
References: <20070427034138.1646.15989.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 05:47:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhHQl-0002LF-O9
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 05:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbXD0Drd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 23:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754053AbXD0Drc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 23:47:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45411 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213AbXD0Drb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 23:47:31 -0400
Received: (qmail 6875 invoked by uid 2001); 27 Apr 2007 05:47:29 +0200
Content-Disposition: inline
In-Reply-To: <20070427034138.1646.15989.stgit@rover>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45677>

On Fri, Apr 27, 2007 at 05:41:39AM CEST, Petr Baudis wrote:
> The 'grep' type of search greps the currently selected tree for given
> regexp and shows the results in a fancy table with links into blob view.
> The number of shown matches is limited to 1000 and the whole feature
> can be turned off (grepping linux-2.6.git already makes repo.or.cz a bit
> unhappy).

It seems that with basically a single exception, Git is remarkably
unemotional and cold...

	http://repo.or.cz/w?p=git.git&a=search&h=HEAD&st=grep&s=hate%5B%5Ev%5D

...and pretty much all the feelings are brought to us from the wild CVS
world...

	http://repo.or.cz/w?p=git.git&a=search&h=HEAD&st=grep&s=love

  You could say that git lacks a human dimension here! Maybe we should at least
make it utter some awesome jokes at random moments (more usage errors = less
jokes for the user, that'll teach 'em).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
