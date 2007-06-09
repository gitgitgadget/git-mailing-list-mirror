From: Johan Herland <johan@herland.net>
Subject: [PATCH 01/21] Remove unnecessary code and comments on non-existing 8kB
 tag object restriction
Date: Sat, 09 Jun 2007 02:12:37 +0200
Message-ID: <200706090212.37904.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:12:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwoZP-0003dL-RO
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969378AbXFIAMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968858AbXFIAMm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:12:42 -0400
Received: from smtp.getmail.no ([84.208.20.33]:64512 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbXFIAMl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:12:41 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00901DX5GZ00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:12:41 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000KJDX2CP20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:12:38 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009AXDX1AH00@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:12:38 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49527>

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/mktag.c b/mktag.c
index 070bc96..b82e377 100644
--- a/mktag.c
+++ b/mktag.c
@@ -12,15 +12,8 @@
  * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
  * shortest possible type-line, and "tag .\n" at 6 bytes is the
  * shortest single-character-tag line.
- *
- * We also artificially limit the size of the full object to 8kB.
- * Just because I'm a lazy bastard, and if you can't fit a signature
- * in that size, you're doing something wrong.
  */
 
-/* Some random size */
-#define MAXSIZE (8192)
-
 /*
  * We refuse to tag something we can't verify. Just because.
  */
-- 
1.5.2
