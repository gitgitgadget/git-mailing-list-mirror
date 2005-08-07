From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.4 (preview)
Date: Sat, 06 Aug 2005 23:00:20 -0700
Message-ID: <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 07 08:00:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1eDB-0007Q4-Cb
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 08:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVHGGAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 02:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVHGGAX
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 02:00:23 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48834 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751113AbVHGGAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 02:00:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807060020.JBZF15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 02:00:20 -0400
To: git@vger.kernel.org
In-Reply-To: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 05 Aug 2005 18:52:06 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I said:

> My tentative plan is for 0.99.4 to finish send-pack, 0.99.5
> to enhance fetch-pack, 0.99.6 to finish the first pass for the
> documentation updates and stabilizing the binary packaging.

Ok, I am almost ready to push 0.99.4 out.  Here is what I have
in the public repository.

  - The branches master & pu are as usual.  Modulo bugs, I
    consider send-pack enhancement finished.

  - There is an "rc" branch whose Makefile already says 0.99.4.
    I've been working on Debian and RPM packaging issues today,
    with help from Chris Wright and H Peter Anvin, in this
    branch.

The plan is to stabilize the binary packaging issues in the "rc"
branch, and ordinary feature updates and bugfixes in "master" or
"pu" branch as usual.  When things are ready, "rc" and "master"
will be merged, 0.99.4 gets created and tagged, and "master" and
"pu" will continue from there.

I would appreciate if folks familiar with binary packaging,
especially RPM, give final sanity checks on what is currently in
"rc" branch.
