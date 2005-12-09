From: Junio C Hamano <junkio@cox.net>
Subject: Re: as promised, docs: git for the confused
Date: Fri, 09 Dec 2005 15:23:49 -0800
Message-ID: <7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
References: <20051209215414.14072.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 00:25:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekrb8-00062C-5v
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 00:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVLIXXx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 18:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVLIXXw
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 18:23:52 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:4298 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932266AbVLIXXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 18:23:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209232224.SQZU26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 18:22:24 -0500
To: linux@horizon.com
In-Reply-To: <20051209215414.14072.qmail@science.horizon.com>
	(linux@horizon.com's message of "9 Dec 2005 16:54:14 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13438>

linux@horizon.com writes:

> Some users want to track someone else's repository.
> Others...

Exactly.  That's why task oriented list would be most useful.
Here is a starter.


Everyday GIT Cheat Sheet Or Git With 20 Commands
================================================

Repository Administration
-------------------------

  * "init-db" or "clone" to create the initial repository.
  * hooks.
    - public accessible via dumb protocols: need
      update-server-info in hooks/post-update
    - CVS style shared repository: see howto/update-hook-example
      for ideas on branch head policy
  * "fsck-objects", "repack" and "prune".


Individual Developer
--------------------

Standalone tasks

  * "show-branch" or "gitk" to see where you are.
  * "diff" or "status" to see what you are in the middle of.
  * "log" to see what happened.
  * "whatchanged" to find out where things come from.
  * "checkout" and "checkout -b" to switch branches.
  * "commit" to advance the current branch head.
  * "reset" to undo unpublished changes.
  * "checkout -- path" to undo working tree chanegs.
  * "pull ." to merge between branches.
  * "rebase" to maintain topic branches.
  * "fsck-objects", "repack" and "prune".

Working as a participant

  * all the commands useful for standalone individual developer tasks.
  * "pull origin" to keep up-to-date.
  * "push upstream" in CVS style shared repository workflow.
  * "format-patch" in kernel style public forum workflow.

Integrator
----------

  * all the commands useful for standalone individual developer tasks.
  * "am" to apply patches.
  * "pull somewhere-else" to merge from trusted lieutenants.
  * "format-patch" to send suggested alternative to contributors.
  * "revert" to undo botched changes.
  * "push public" to publish the results.


It might be surprising that only handful commands are of
everyday use among 100+, but the ones listed above are the only
ones I use every day.  The exact number depends on how you count
multi-purpose commands like "checkout" and "pull", but only
these need to be learned to play all roles listed above.

	am
	checkout
	checkout -- path
	checkout -b
	commit
	diff
	fetch
	format-patch
	fsck-objects
	gitk
	init-db
	log
	prune
	pull .
	pull other
	push
	rebase
	repack
	reset
	revert
	show-branch
	status
	whatchanged
