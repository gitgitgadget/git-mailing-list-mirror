From: Jerald Fitzjerald <jfj@freemail.gr>
Subject: [PATCH] missing return
Date: Wed, 30 May 2007 05:39:58 -0700
Message-ID: <465D709E.7040402@freemail.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jfj@freemail.gr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 14:52:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtNev-0008C3-9H
	for gcvg-git@gmane.org; Wed, 30 May 2007 14:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbXE3MwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 08:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbXE3MwH
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 08:52:07 -0400
Received: from aiolos.otenet.gr ([195.170.0.93]:51225 "EHLO aiolos.otenet.gr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbXE3MwG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 08:52:06 -0400
X-Greylist: delayed 871 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 May 2007 08:52:05 EDT
Received: from [87.202.74.230] (athedsl-19026.home.otenet.gr [87.202.74.230])
	by aiolos.otenet.gr (8.13.8/8.13.8/Debian-3) with ESMTP id l4UCbRo1032075;
	Wed, 30 May 2007 15:37:30 +0300
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48757>

OK for mainline?

---

diff --git a/base85.c b/base85.c
--- a/base85.c
+++ b/base85.c
@@ -66,7 +66,7 @@ int decode_85(char *dst, const char *buf
 		 */
 		if (0x03030303 < acc ||
 		    0xffffffff - de < (acc *= 85))
-			error("invalid base85 sequence %.5s", buffer-5);
+			return error("invalid base85 sequence %.5s", buffer-5);
 		acc += de;
 		say1(" %08x", acc);
 
