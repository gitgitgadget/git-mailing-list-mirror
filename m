From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git/cogito usage scenarios for CVS refugee
Date: Wed, 8 Jun 2005 20:34:14 +0200
Message-ID: <20050608183414.GD982@pasky.ji.cz>
References: <46a038f9050608025152af4163@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:32:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg5Jz-0006UQ-LP
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 20:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVFHSeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 14:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFHSeW
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 14:34:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16607 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261478AbVFHSeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 14:34:16 -0400
Received: (qmail 3534 invoked by uid 2001); 8 Jun 2005 18:34:14 -0000
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f9050608025152af4163@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jun 08, 2005 at 11:51:17AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> Trying to get my head around what usage patterns the git
> infrastructure supports. I'm interested in exploring more git-centric
> approaches...
> 
> For a project that uses CVS with a classic HEAD and FOO_15_STABLE
> approach, where FOO_15_STABLE gets only fixes -- how do I manage HEAD
> and XX_STABLE where some patches that work well in HEAD I may decide
> to merge into XX_STABLE, and some security patch may be applied first
> to XX_STABLE and then to HEAD? I can apply the patch on both branches
> -- yep. But does git help me in keeping track of what's been merged?
> 
> Does git help in any way to keep track of patches across 2.6.11.12 and
> 2.6.12rc5 ?
> 
> In a git-based project, one developer is about to merge from someone
> else's tree, are there any tools to review the patchlog that is about
> to be applied (or replayed?) against his tree? Is there any way to say
> "of the 20 commits that I'm about to merge, hold off 2" other than
> letting git apply them ... and backing them out right next?

The answer for all those questions is that git has no support for
cherrypicking (that sucks, but is hard to fix right now). git does ok
as long as one branch is superset of the other, but it does not help you
otherwise.

> And generally, is there any long-lived branch support? If I am to run
> a "local branch" of the Linux kernel, does git help me at all?

I don't understand what do you mean. How does a long-lived branch differ
from a short-lived one and what support would you expect/like?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
