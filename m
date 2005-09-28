From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Wed, 28 Sep 2005 09:56:31 -0700
Message-ID: <7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
	<Pine.LNX.4.58.0509251153090.3308@g5.osdl.org>
	<7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509280819000.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 18:57:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKfES-0005LD-Ng
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 18:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVI1Q4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 12:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVI1Q4d
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 12:56:33 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37041 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751108AbVI1Q4c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 12:56:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050928165629.YOGX4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Sep 2005 12:56:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9438>

Linus Torvalds <torvalds@osdl.org> writes:

> git-resolve might want to verify the old head. On the other hand, it looks 
> like it's being phased out, so maybe nobody cares?

It was my mistake -- git-merge does it, and I should do the
same in git-resolve.  Thanks for pointing it out.

Have you had a chance to look at the git-merge change to remove
the stupid clean-tree requirements?  I have been planning to
inflict the 'use git-merge instead of git-resolve' change on you
sometime soonish (like today ;-).  Having said that, I myself
would vote against phasing out 'git-resolve' -- being able to
say 'git resolve master hold fast' to fast forward the master
head to topic branch head of 'hold' (my topic branches are often
rebased to allow this) is quite useful.

I have one unrelated request.

Could I have a copy of .git/{branches,remotes,refs}/* from the
primary repository you do your kernel work please?
