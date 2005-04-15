From: "Art Haas" <ahaas@airmail.net>
Subject: [PATCH] Fix typo in gitapply.sh
Date: Fri, 15 Apr 2005 15:22:39 -0500
Message-ID: <20050415202239.GY12224@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 15 22:19:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMXHG-0001w4-5i
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 22:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVDOUWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 16:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVDOUWT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 16:22:19 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.143]:12042 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261953AbVDOUU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 16:20:56 -0400
Received: from cable-24-158-217-121.sli.la.charter.com ([24.158.217.121] helo=pcdebian)
	by covert.iadfw.net with esmtp (Exim 4.24)
	id 1DMXLe-0003Q2-Lk
	for git@vger.kernel.org; Fri, 15 Apr 2005 15:23:30 -0500
Received: (qmail 12302 invoked by uid 1000); 15 Apr 2005 20:22:39 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi.

The variable is '$patchfifo', not '$pathfifo'. Adding the missing 'c'
will remove the stray pipes that have been left in /tmp.

Art Haas

gitapply.sh:  47b9346d2679b1bf34220fe4502f15c7d0737b0c
--- gitapply.sh
+++ gitapply.sh	2005-04-15 15:11:03.000000000 -0500
@@ -74,4 +74,4 @@
 done
 ' padding
 
-rm $pathfifo $todo $gonefile
+rm $patchfifo $todo $gonefile

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

----- End forwarded message -----

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
