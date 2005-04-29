From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Odd decision of git-pasky-0.7 to do a merge
Date: Fri, 29 Apr 2005 20:21:40 +0200
Message-ID: <20050429182140.GA14202@pasky.ji.cz>
References: <20050429083615.A32271@flint.arm.linux.org.uk> <20050429100717.A5035@flint.arm.linux.org.uk> <20050429103059.A3260@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 20:16:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRa1y-0008W8-SO
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 20:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVD2SVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 14:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVD2SVo
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 14:21:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63960 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262870AbVD2SVm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 14:21:42 -0400
Received: (qmail 14631 invoked by uid 2001); 29 Apr 2005 18:21:40 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050429103059.A3260@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 29, 2005 at 11:31:00AM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> On Fri, Apr 29, 2005 at 10:07:17AM +0100, Russell King wrote:
> > rmk@hera:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(0)$ SHA1_FILE_DIRECTORY=./objects merge-base c60c390620e0abb60d4ae8c43583714bda27763f bdceb6a0162274934386f19f3ea5a9d44feb0b20
> > bdceb6a0162274934386f19f3ea5a9d44feb0b20
> > 
> > $ merge-base c60c390620e0abb60d4ae8c43583714bda27763f bdceb6a0162274934386f19f3ea5a9d44feb0b20
> > e8108c98dd6d65613fa0ec9d2300f89c48d554bf
> 
> This is the problem.  It seems that merge-base in git-pasky-0.7
> doesn't work correctly.

I'm not sure if the merge-base in git-pasky-0.7 isn't the old one yet.
We replaced it with a date-based one since the old one *was* giving bad
results.

So, what about cogito-0.8?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
