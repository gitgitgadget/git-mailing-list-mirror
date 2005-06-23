From: Jeff Garzik <jgarzik@pobox.com>
Subject: 'dotest' fails, patch(1) succeeds
Date: Thu, 23 Jun 2005 03:37:37 -0400
Message-ID: <42BA66C1.30400@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050203000606000308080508"
X-From: git-owner@vger.kernel.org Thu Jun 23 09:38:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlMHm-0007NZ-Kl
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 09:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVFWHnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 03:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVFWHnj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 03:43:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42674 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262594AbVFWHho (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 03:37:44 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DlMHM-00038x-3z; Thu, 23 Jun 2005 07:37:40 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------050203000606000308080508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Trying to use git-tools' "dotest" script to merge an mbox into a kernel 
git repo failed, but patch(1) was OK with it:

	[jgarzik@pretzel netdev-2.6]$ dotest /g/tmp/mbox

	Applying 'e1000: fix spinlock bug'

	fatal: corrupt patch at line 10
	[jgarzik@pretzel netdev-2.6]$ patch -sp1  < /g/tmp/mbox
	[jgarzik@pretzel netdev-2.6]$


Ideas?  Full data needed to reproduce is attached.  .git/HEAD is 
a4936044001694f033fe4ea94d6034d51a6b465c.

	Jeff




--------------050203000606000308080508
Content-Type: application/x-bzip2;
 name="mbox.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mbox.bz2"

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
5EqaObAv6o/rVbuigsDHj/8XckU4UJArmbx2
--------------050203000606000308080508--
