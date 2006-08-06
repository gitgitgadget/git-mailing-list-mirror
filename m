From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/6] gitweb: Further refactoring
Date: Sun, 06 Aug 2006 03:01:50 -0700
Message-ID: <7vmzai89o1.fsf@assigned-by-dhcp.cox.net>
References: <200608060206.49086.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 12:02:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9fSQ-0008Hc-Es
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 12:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWHFKBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 06:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWHFKBw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 06:01:52 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41372 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932236AbWHFKBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 06:01:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060806100151.PNN10979.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Aug 2006 06:01:51 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24970>

The earlier 9-series looked fine, so I intend to apply them all
to "next".  However, they were all tab damaged and it was very
painful to fix up the patch.

This series, PATCH 1/5 (6?) looks fine (it is a bugfix for
git_diff_print), but among others, one of them had a seriously
fishy preimage (e.g. as you can see in "next", I haven't
accepted the function rename patch but 3/6 talks about
format_mark_referencing), and at that point my patience ran out.

Please check what I pushed out on "next"/"pu" tonight, and
consider patches missing from there dropped on the floor for now
(which does not mean they are rejected, except for the one that
touches diff_print and still uses /usr/bin/diff, which I
commented on).  It probably is a good idea to make sure further
patches resent are based on (or at least apply cleanly to) the
commit f16db173a4680aebc2f14c103a1e125c3f4d4531.

Please note that I am primarily concentrating on polishing what
is in "master" to finish 1.4.2 for now, so I might have missed
breakage in these gitweb patches that I queued for "next".

Comments, tests and fixups are all very welcomed.
