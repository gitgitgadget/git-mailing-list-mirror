From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Wed, 2 Nov 2005 00:30:35 +0100
Message-ID: <20051101233035.GB1431@pasky.or.cz>
References: <20051027203945.GC1622@pe.Belkin> <20051028015642.GA31822@vrfy.org> <20051028023833.GA19939@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 00:32:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX5aX-0004Op-4j
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 00:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVKAXam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 18:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbVKAXam
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 18:30:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:19657 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751436AbVKAXal (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 18:30:41 -0500
Received: (qmail 31395 invoked by uid 2001); 2 Nov 2005 00:30:35 +0100
To: Chris Shoemaker <c.shoemaker@cox.net>
Content-Disposition: inline
In-Reply-To: <20051028023833.GA19939@pe.Belkin>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10970>

Dear diary, on Fri, Oct 28, 2005 at 04:38:33AM CEST, I got a letter
where Chris Shoemaker <c.shoemaker@cox.net> told me that...
> Here's a side-by-side comparison.  Open two browser tabs and flip between them:
> 
> http://www.codesifter.com/cgi-bin/gitweb-difftreeP.cgi?p=git.git;a=shortlog
> http://www.codesifter.com/cgi-bin/gitweb-difftreeNames.cgi?p=git.git;a=shortlog
> 
> I've used a project you all are familar with, and that has more than
> two files.  The first page uses 'git-diff-tree -p $hash|wc -l'.  The
> second page uses 'git-diff-tree -r --name-only|wc -l'.  (Oh and I have
> a merge indicator now.)
> 
> How do they compare for showing damage-potential?  I think they both
> do a reasonable job.  I think the full patch diff is a bit better, but
> it does cost.

What about having the color indicate the number of affected files (let's
say on a blue..red scale) and the width the size of patch?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
