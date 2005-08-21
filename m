From: Junio C Hamano <junkio@cox.net>
Subject: 1dfcfbce2d643b7c7b56dc828f36ced9de2bf9f2
Date: Sun, 21 Aug 2005 11:49:47 -0700
Message-ID: <7vy86vf7lg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 21 23:34:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6xSC-0007ZF-BM
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 23:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVHUVeE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 17:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVHUVeE
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 17:34:04 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:26060 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751132AbVHUVeD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2005 17:34:03 -0400
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LIoH22004766
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 11:50:17 -0700
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050821184949.KJGO12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 Aug 2005 14:49:49 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A couple of people noticed that the latest commit in the
"master" branch seems, eh, odd.

It was not a screw-up of any of the git tools, just me screwing
up in an early morning/late night editing session when checking
things in.

    $ git whatchanged -p --max-count=1 <that commit>

shows the true story.  The commit message has the excess, but
the patch for the commit has exactly the thing I wanted it to
have and nothing else.

My policy is not to rewind "master" and "rc" once it hits the
public repository; otherwise it would make pulling from these
branches unnecessarily confusing for other people.

Although it is embarrassing, the screw-up this case is only the
commit log message, and running "git revert" once and then "git
revert" again would not make it less confusing, so I will keep
things as they are.
