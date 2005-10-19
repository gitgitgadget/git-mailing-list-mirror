From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection for single file
Date: Tue, 18 Oct 2005 22:20:21 -0700
Message-ID: <7virvuhylm.fsf@assigned-by-dhcp.cox.net>
References: <4dd15d180510181256i1c5a82d9ld62acaedb493cf71@mail.gmail.com>
	<7vu0fepn0x.fsf@assigned-by-dhcp.cox.net>
	<7virvujkcw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510182004100.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Ho <davidkwho@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 07:21:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES6NG-0005q6-Hi
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 07:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbVJSFUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 01:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbVJSFUX
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 01:20:23 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60328 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751522AbVJSFUW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 01:20:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019051950.DTSA2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 01:19:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510182004100.3369@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Oct 2005 20:12:43 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10264>

Linus Torvalds <torvalds@osdl.org> writes:

> See what I'm saying?
> ...
> The performance impact of pruning the pathnames _before_ diffing them was 
> absolutely staggering. You couldn't reasonably do a "git-whatchanged -p" 

Yes, I understood and agreed to that logic on May 27th.  That's
why the message you are responding said we could add a new flag,
to give the choice to the user to accept full-tree scan.

The "diff-tree --stdin that follows rename history" example
might want to have some change in either the core side of diff,
or in the rev-list.  It may help to have both.  I still haven't
thought through the issues.

BTW, I really liked your example that piped multiple diff-trees
together.  That is a neat trick.
