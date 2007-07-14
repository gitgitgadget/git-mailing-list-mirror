From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: tagging trunk in SVN with git-svn?
Date: Sat, 14 Jul 2007 13:35:09 -0700
Message-ID: <20070714203509.GA29088@muzzle>
References: <20070714140359.GA5738@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 22:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9oKh-0002bP-4a
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 22:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762932AbXGNUfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 16:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761280AbXGNUfL
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 16:35:11 -0400
Received: from hand.yhbt.net ([66.150.188.102]:41850 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762874AbXGNUfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 16:35:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C9FB62DC032;
	Sat, 14 Jul 2007 13:35:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070714140359.GA5738@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52506>

martin f krafft <madduck@madduck.net> wrote:
> Dear list,
> 
> I searched the list(s) and even read the code of git-svn, but I am
> none the wiser now. From what I understand, git-svn is primarily
> used to interact with subversion, rather than doing one-shot imports
> (which it can do as well).
> 
> I am using it now and it works like a charm (thanks!). However,
> I cannot really figure out how to tag the remote trunk from within
> git-svn. I tried `git tag tags/1.2.57`, `git tag 1.2.57` and `git
> branch tags/1.2.57`, but in none of the three cases does dcommit
> think that it needs to push anything upstream.
> 
> Is what I am trying to do possible, or do I need to use svn for
> that?

git-svn doesn't currently know how to create new tags/patches.  It's
been requested but I haven't had much time or desire to implement it,
patches accepted :)

I just use "svn cp url1 url2", but I agree having git-svn automatically
know about that branch would be nice.

-- 
Eric Wong
