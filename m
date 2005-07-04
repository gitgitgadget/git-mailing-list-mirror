From: "David S. Miller" <davem@davemloft.net>
Subject: expensive local git clone
Date: Mon, 04 Jul 2005 12:57:44 -0700 (PDT)
Message-ID: <20050704.125744.59481768.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 04 22:00:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpX66-00066O-Gn
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 21:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVGDT7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 15:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVGDT7I
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 15:59:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35532
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261617AbVGDT7D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 15:59:03 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.50)
	id 1DpX4a-0005k7-MB
	for git@vger.kernel.org; Mon, 04 Jul 2005 12:57:44 -0700
To: git@vger.kernel.org
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I'm still seeing git-local-pull going crazy when attemping local
clones of kernel trees, this is from top:

22032 davem     18   0 63392  59m  920 R 76.0  5.9   5:33.15 git-local-pull     

and it's still chugging along.  This is from a simple:

bash$ git-clone-script /home/davem/src/GIT/linux-2.6/.git /home/davem/src/GIT/sparc-2.6

invocation.

I can't be the only person in the world seeing this :-)
It usually grows to around 88MB and runs for 8 minutes before
it finishes.

It must be walking the whole commit tree to the root or something
silly like that.
