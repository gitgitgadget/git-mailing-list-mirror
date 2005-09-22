From: Petr Baudis <pasky@suse.cz>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 21:10:58 +0200
Message-ID: <20050922191058.GM21019@pasky.or.cz>
References: <E1EIVsD-0001Hu-9m@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 21:12:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIWTM-0002J8-1p
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 21:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVIVTLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 15:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVIVTLD
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 15:11:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26792 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750920AbVIVTLC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 15:11:02 -0400
Received: (qmail 2885 invoked by uid 2001); 22 Sep 2005 21:10:59 +0200
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <E1EIVsD-0001Hu-9m@jdl.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9137>

Dear diary, on Thu, Sep 22, 2005 at 08:32:45PM CEST, I got a letter
where Jon Loeliger <jdl@freescale.com> told me that...
> Which points out one of the other points of frustration
> that I feel should be addressed eventually:  A whole section
> about "What To Do When It Goes Wonky" needs to be written.
> 
> OK, so it didn't merge?  Now what?  What got left where?
> How do I recover?  What bits are in my tree, and what bits
> are in the Index, and what bits are in the Object store now?
> 
> OK, so it didn't download it left you "refs/heads/rigin.remote".
> What should I do with it now?  And later, should I re-execute
> the same "git fetch" command and hope it recovers and patches
> the pieces together?  Should I do a round of house cleaning
> before attempting to re-run some (the same?) command?

FWIW, with Cogito, interrupted or failed fetch can be safely rerun, no
extra recovery procedure is required. It *seems* that this holds for
git-fetch as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
