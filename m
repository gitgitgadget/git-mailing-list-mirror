From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Thu, 18 May 2006 14:46:16 -0700
Message-ID: <7viro3nh07.fsf@assigned-by-dhcp.cox.net>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
	<Pine.LNX.4.64.0605181435230.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 23:46:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgqK5-00047b-Lw
	for gcvg-git@gmane.org; Thu, 18 May 2006 23:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWERVqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 17:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWERVqS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 17:46:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33753 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932147AbWERVqR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 17:46:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518214617.HGTB27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 17:46:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605181435230.10823@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 18 May 2006 14:37:06 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20304>

Linus Torvalds <torvalds@osdl.org> writes:

> Is it/does it?
>
> I'd assume that if you have a graft, you _want_ the history to be hidden 
> and pruned. 
>
> That's how you'd drop history, if you wanted to do it on purpose.

I haven't looked at what the test does, but I think he is
talking about the opposite.  fsck by design does not honor
grafts, and if you grafted a history back to your true root
commit, that "older" history will be lost.
