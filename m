From: Thomas Zander <zander@kde.org>
Subject: fixlet in docs.
Date: Wed, 16 Jan 2008 23:48:21 +0100
Message-ID: <200801162348.21439.zander@kde.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 23:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHDR-00065L-7M
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbYAPW6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754853AbYAPW6H
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:58:07 -0500
Received: from hoat.troll.no ([62.70.27.150]:39809 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885AbYAPW6F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 17:58:05 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2008 17:58:05 EST
Received: from localhost (localhost [127.0.0.1])
	by hoat.troll.no (Postfix) with ESMTP id 31B8E58095;
	Wed, 16 Jan 2008 23:48:31 +0100 (CET)
Received: from hoat.troll.no ([127.0.0.1])
 by localhost (hoat.troll.no [127.0.0.1]) (amavisd-maia, port 10024) with LMTP
 id 05007-06; Wed, 16 Jan 2008 23:48:29 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	by hoat.troll.no (Postfix) with ESMTP id C51EB58093;
	Wed, 16 Jan 2008 23:48:29 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m0GMmRLH000373;
	Wed, 16 Jan 2008 23:48:29 +0100
Received: from lacuna.local ( [172.20.1.14])
    by sx01.troll.no (Scalix SMTP Relay 11.3.0.11339)
    via ESMTP; Wed, 16 Jan 2008 23:48:26 +0100 (CET)
x-scalix-Hops: 1
User-Agent: KMail/1.9.6
Content-Disposition: inline
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70762>

>From 785f928973e3ec3e5ca27f322fb44890e843a340 Mon Sep 17 00:00:00 2001
From: Thomas Zander <Thomas Zander zander@kde.org>
Date: Wed, 16 Jan 2008 23:42:00 +0100
Subject: [PATCH] Fixlet in doc; there was an open brace without a closing one.
 Signed-off-by: Thomas Zander <zander@kde.org>

---
 Documentation/core-tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index bd6cd41..aa40dfd 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -578,7 +578,7 @@ particular state. You can, for example, do
 $ git diff my-first-tag
 ----------------
 
-to diff your current state against that tag (which at this point will
+to diff your current state against that tag which at this point will
 obviously be an empty diff, but if you continue to develop and commit
 stuff, you can use your tag as an "anchor-point" to see what has changed
 since you tagged it.
-- 
1.5.3
-- 
Thomas Zander
