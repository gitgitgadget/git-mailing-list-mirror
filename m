From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Wed, 28 Sep 2005 10:29:49 -0700
Message-ID: <7v3bnpt81e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
	<Pine.LNX.4.58.0509251153090.3308@g5.osdl.org>
	<7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509280819000.3308@g5.osdl.org>
	<7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509281007200.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 19:31:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKfkt-0005je-TC
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 19:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbVI1R3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 13:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVI1R3x
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 13:29:53 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16550 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751465AbVI1R3v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 13:29:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050928172948.MAYH29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Sep 2005 13:29:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509281007200.3308@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 28 Sep 2005 10:13:17 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9442>

Linus Torvalds <torvalds@osdl.org> writes:

> Heh. My kernel has none of that. Well, it obviously has refs, but even 
> there it literally has just one head: "master". The rest are the standard 
> tags you see in public.

I was wondering the URL shorthand you mentioned is being used in
practice.  In theory, you do not "have to write out in full"
anymore ;-).

Message-ID: <Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
From: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 15 Jul 2005 15:42:42 -0700 (PDT)

And it's not necessarily just the branch handling, but more of a generic
shorthand: I'd love to be able to mix something like

	git pull jgarzik/misc-2.6 upstream

and "jgarzik" would be expanded (through something like .git/branches) to 
"master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/"), resulting in the 
_full_ path being expanded to

	master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6 upstream

which I have to write out in full (or, more commonly, cut-and-paste) right
now.
