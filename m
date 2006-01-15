From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on empty commit
Date: Sun, 15 Jan 2006 01:48:56 -0800
Message-ID: <7vmzhx7ref.fsf@assigned-by-dhcp.cox.net>
References: <20060114021800.4688.qmail@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 10:49:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ey4VT-0007rR-DP
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 10:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWAOJs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 04:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWAOJs6
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 04:48:58 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:58778 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751885AbWAOJs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 04:48:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115094740.OROB20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 Jan 2006 04:47:40 -0500
To: ltuikov@yahoo.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14695>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Now the last merge introduced an empty commit, since
> tree A and tree B had been in sync (only local and
> remote trunk had been out of sync).  While it was expected
> that no commit would be introduced since they were in sync.
>
> Was the empty commit correct behavior?

I do not quite follow you, but immediately before the "empty
commit" (I presume you mean the last "git merge" that merges
treeA head in treeB), you say "the treeA and treeB had been in
sync".  What do you exactly mean?  The tree object in the head
commits in treeA branch and treeB branch were identical?

If that is the case, the commit being empty is the correct
behaviour, because there is no difference in the set of files
introduced by that commit.  And the commit being made is also
the correct behaviour, because those two branches have different
development history, and the commit is what binds them together.
