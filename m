From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: [PATCH] Fix small typo in git send-email man page.
Date: Fri, 17 Aug 2007 17:38:24 -0400
Message-ID: <11873867051906-git-send-email-seanlkml@sympatico.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 23:39:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM9XM-0001Bj-OX
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 23:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbXHQVjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbXHQVjO
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 17:39:14 -0400
Received: from bay0-omc2-s18.bay0.hotmail.com ([65.54.246.154]:16777 "EHLO
	bay0-omc2-s18.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753406AbXHQVjM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 17:39:12 -0400
Received: from BAYC1-PASMTP12.bayc1.hotmail.com ([65.54.191.185]) by bay0-omc2-s18.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 17 Aug 2007 14:39:11 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by BAYC1-PASMTP12.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 17 Aug 2007 14:39:48 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with esmtp (Exim 4.43)
	id 1IM9XC-0008Tl-FV
	for git@vger.kernel.org; Fri, 17 Aug 2007 17:39:10 -0400
Received: from sean by guru.attic.local with local (Exim 4.67)
	(envelope-from <sean@guru.attic.local>)
	id 1IM9WT-00081W-UA
	for git@vger.kernel.org; Fri, 17 Aug 2007 17:38:25 -0400
X-Mailer: git-send-email 1.5.3.rc5.18.gcb57
X-OriginalArrivalTime: 17 Aug 2007 21:39:48.0843 (UTC) FILETIME=[22D80BB0:01C7E117]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56089>

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 Documentation/git-send-email.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index d243ed1..08a023e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -62,7 +62,7 @@ The --cc option must be repeated for each user you want on the cc list.
 --signed-off-by-cc, --no-signed-off-by-cc::
         If this is set, add emails found in Signed-off-by: or Cc: lines to the
         cc list.
-        Default is the value of 'sendemail.signedoffbycc' configuration value;
+        Default is the value of 'sendemail.signedoffcc' configuration value;
         if that is unspecified, default to --signed-off-by-cc.
 
 --quiet::
-- 
1.5.3.rc5.18.gcb57
