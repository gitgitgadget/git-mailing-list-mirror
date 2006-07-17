From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Mon, 17 Jul 2006 01:29:43 -0700
Message-ID: <7vhd1ghbwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 17 10:30:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2OUi-0001y3-JV
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 10:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWGQI3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 04:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWGQI3o
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 04:29:44 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58016 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750732AbWGQI3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 04:29:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060717082943.ZHPE8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Jul 2006 04:29:43 -0400
To: git@vger.kernel.org
X-maint-at: 8fced61cbc32f0c4b81a3dcecfeb40b7d96339ce
X-master-at: b9718d41c7e9c171e432bafac97a33be36f0e2bf
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23967>

Quite a bit of stuff has been merged, and I have tagged the tip
of the master as v1.4.2-rc1, before heading for Ottawa.

Notable changes in the "master" branch includes:

  - Merge-base has been improved thanks to a test script by
    ALASCM.

  - A handful gitweb enhancements and fixes by Alp Toker and
    Luben Tuikov.

  - git-svn is now out of "contrib/" status.

  - Many documentation updates.

  - Fixed a performance bug in git-show-branch, which affected
    git-merge.

  - Fixed a nonsense output from git-fmt-merge-msg when pulling
    HEAD from a remote repository, spotted by Linus.

  - "git-log --merge" helps the archeology during a conflicted
    merge, per request by Linus.

  - git-grep boolean expression to allow --and, --or, and --not
    is now in "master".

  - A few updates to git-daemon by Matthias Lederhofer.

  - A handful portability fixes by Pavel Roskin and Shawn Pearce.

  - Ref-log updates by Shawn Pearce.


* The 'next' branch, in addition, has these.

  - "checkout -f" and "reset --hard" fixes, when the new tree
    should have file "foo" and the old tree and/or working tree
    has directory there.  Earlier we failed to instantiate file
    "foo", and did not report an error.  Testing is appreciated.

  - git-apply fixes that was started by a test script by Eric
    Wong.  Testing is appreciated on this stuff.

  - Perly git by Pasky with help from others.

  - Optional autoconf by Jakub Narebski.

  - A WIP of merge-recursive by Johannes and Alex Riesen.

  - A usability enhancement of format-patch for imap-send users by
    Josh Triplett

  - A new loose object format support by Linus.

  - An update to diff to make --name-only, --name-status,
    --check and -s mutually exclusive by Timo Hirvonen.

* The 'pu' branch has an experimental "read-tree --rename" to
  teach renames to git-merge-resolve, but currently it fails a
  few of its own tests.


I noticed that "git diff" from subdirectories does not seem to
pick up the configuration from $GIT_DIR/config properly.  I
suspect that fixing this breakage properly would help us later,
as more and more commands learn to use the configuration
mechanism to store user preferences, and the same fix would be
applicable to them.  If somebody can fix this while we are away
this week, that would be wonderful ;-).
