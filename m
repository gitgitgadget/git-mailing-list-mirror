From: "David S. Miller" <davem@davemloft.net>
Subject: weird pull behavior as of late
Date: Sun, 23 Apr 2006 17:59:53 -0700 (PDT)
Message-ID: <20060423.175953.52710961.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 24 03:00:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXpR4-0003G0-36
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 03:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWDXA7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 20:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWDXA7m
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 20:59:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31387
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751470AbWDXA7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 20:59:42 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1FXpQi-0005nx-Fy
	for git@vger.kernel.org; Sun, 23 Apr 2006 17:59:56 -0700
To: git@vger.kernel.org
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19078>


I just pulled from Linus's linux-2.6.git tree knowing there was a bit
of activity over the past day:

Generating pack...
Done counting 446 objects.
Deltifying 446 objects.
 100% (446/446) done
Unpacking 446 objects
Total 446, written 446 (delta 235), reused 0 (delta 0)
 100% (446/446) done
* refs/heads/origin: fast forward to branch 'master' of master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6
  from f4ffaa452e71495a06376f12f772342bc57051fc to 6b426e785cb81e53dc2fc4dcf997661472b470ef

Updating from f4ffaa452e71495a06376f12f772342bc57051fc to 6b426e785cb81e53dc2fc4dcf997661472b470ef
Fast forward
 MAINTAINERS |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

I got 446 objects and this amounted to just a 4 line change to the
MAINTAINERS file? :-)

If I do a "gitk ORIG_HEAD.." all the changes are there, just the
diffstat it spits out during the pull is weird.

Just FYI...
