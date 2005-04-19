From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: More git pull problems
Date: Tue, 19 Apr 2005 09:31:13 +0100
Message-ID: <20050419093113.D13488@flint.arm.linux.org.uk>
References: <E1DNlmx-00029W-L2@flint.arm.linux.org.uk> <20050419080251.A11988@flint.arm.linux.org.uk> <20050419082341.GC2393@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 10:27:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNo4h-0000TZ-T7
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 10:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVDSIbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 04:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDSIbT
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 04:31:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52752 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261189AbVDSIbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 04:31:17 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNo8Z-0001ed-1V; Tue, 19 Apr 2005 09:31:15 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNo8X-00048B-U6; Tue, 19 Apr 2005 09:31:13 +0100
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050419082341.GC2393@pasky.ji.cz>; from pasky@ucw.cz on Tue, Apr 19, 2005 at 10:23:41AM +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 10:23:41AM +0200, Petr Baudis wrote:
> Dear diary, on Tue, Apr 19, 2005 at 09:02:51AM CEST, I got a letter
> where Russell King <rmk@arm.linux.org.uk> told me that...
> > My automatic pull this morning produced the following messages, which
> > seem to indicate that something's up with git pull now.
> > 
> > git-pasky-0.4 (7bef49b5d53218ed3fa8bac291b5515c6479810c)
> > 
> > > New branch: 945a2562ee9e632bc6b3399fd49e028c39d19023
> > > Tracked branch, applying changes...
> > > Fast-forwarding 945a2562ee9e632bc6b3399fd49e028c39d19023 -> 945a2562ee9e632bc6b3399fd49e028c39d19023
> > > 	on top of 945a2562ee9e632bc6b3399fd49e028c39d19023...
> > > gitdiff.sh: trying to diff 67607f05a66e36b2f038c77cfb61350d2110f7e8 against itself
> 
> This means nothing more than you pulled your tracked branch for the
> first time, but before you already had the latest copy; this wouldn't
> have happened with subsequent pulls, and it was fixed some time ago - it
> would be really nice if you could try the new pull and merge.

That's not the case.  This tree has been sitting around for about 6 days
now, and every day at 7am it gets a git pull.  One thing which did change
was the version of git installed, which now has this "fast forwarding"
feature in.

Maybe gitmerge.sh should check whether it needs to do anything before
attempting to do something?

-- 
Russell King

