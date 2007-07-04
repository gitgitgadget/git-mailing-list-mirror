From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] fsck --lost-found writes to subdirectories in .git/lost-found/
Date: Wed, 4 Jul 2007 03:33:11 +0200
Message-ID: <20070704013311.GA32210@diku.dk>
References: <Pine.LNX.4.64.0707021751380.4071@racer.site> <7vabuewgdb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707030018120.4071@racer.site> <7vps3auz5y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707030133060.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 03:33:30 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5tkE-0008Ae-Ka
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 03:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302AbXGDBdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 21:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755093AbXGDBdP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 21:33:15 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:54163 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726AbXGDBdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 21:33:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 2E36F96803D;
	Wed,  4 Jul 2007 03:33:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZzlbOn4MCCFY; Wed,  4 Jul 2007 03:33:11 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id D46FE96803A;
	Wed,  4 Jul 2007 03:33:11 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id CC3A96DF845; Wed,  4 Jul 2007 03:30:17 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id B572A62A5E; Wed,  4 Jul 2007 03:33:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707030133060.4071@racer.site>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51556>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-fsck.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 08512e0..1a432f2 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -65,8 +65,8 @@ index file and all SHA1 references in .git/refs/* as heads.
 	Be chatty.
 
 --lost-found::
-	Write dangling refs into .git/commit/ or .git/other/, depending
-	on type.
+	Write dangling refs into .git/lost-found/commit/ or
+	.git/lost-found/other/, depending on type.
 
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
-- 
1.5.2.2.1451.gb0e5e

-- 
Jonas Fonseca
