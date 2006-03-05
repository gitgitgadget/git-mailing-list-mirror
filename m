From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sun, 05 Mar 2006 11:36:08 -0800
Message-ID: <7vwtf8fzvb.fsf@assigned-by-dhcp.cox.net>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603042058250.13139@g5.osdl.org>
	<7vfylxigxc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603050946280.13139@g5.osdl.org>
	<Pine.LNX.4.64.0603051027400.13139@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 20:36:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFz1a-00019f-HK
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 20:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWCETgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 14:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWCETgL
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 14:36:11 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:59026 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750885AbWCETgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 14:36:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305193425.XOMB6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 14:34:25 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603051027400.13139@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 5 Mar 2006 10:29:31 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17240>

Linus Torvalds <torvalds@osdl.org> writes:

> Actually, thinking more about it, I think we could get rid of SHOWN.
>
> We only ever insert a commit _once_ onto the list, using the SEEN logic, 
> so we can never pull the same commit off the list more than once. I think 
> SHOWN was for merge-order.
>
> But I might be wrong. I was thinking about SHOWN a bit when I did the 
> re-organization, but didn't dare to actually touch it, so I left it alone.

I abused SHOWN when I did --objects-edge with
mark_edge_parents_uninteresting modification in
eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4, but probably it can be
modified to use SEEN.
