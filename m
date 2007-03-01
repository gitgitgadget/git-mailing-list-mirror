From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 3/4] Documentation/git-send-email.txt: Fix labeled list formatting
Date: Thu,  1 Mar 2007 22:41:16 +0300
Message-ID: <11727780982140-git-send-email-vsu@altlinux.ru>
References: <1172778077659-git-send-email-vsu@altlinux.ru> <11727780872894-git-send-email-vsu@altlinux.ru>
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMrAZ-0004VI-Uz
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 20:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965538AbXCATm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 14:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965539AbXCATmZ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 14:42:25 -0500
Received: from master.altlinux.org ([62.118.250.235]:3917 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965538AbXCATmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 14:42:25 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id CBF6CE40E8; Thu,  1 Mar 2007 22:42:21 +0300 (MSK)
X-Mailer: git-send-email 1.5.0.2.285.g5347
In-Reply-To: <11727780872894-git-send-email-vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41121>

Mark continuation paragraphs of list entries as such to avoid
getting literal paragraphs instead.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 Documentation/git-send-email.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 4c8d907..35b0104 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -26,13 +26,13 @@ The options available are:
 
 --bcc::
 	Specify a "Bcc:" value for each email.
-
-	The --bcc option must be repeated for each user you want on the bcc list.
++
+The --bcc option must be repeated for each user you want on the bcc list.
 
 --cc::
 	Specify a starting "Cc:" value for each email.
-
-	The --cc option must be repeated for each user you want on the cc list.
++
+The --cc option must be repeated for each user you want on the cc list.
 
 --chain-reply-to, --no-chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
@@ -87,8 +87,8 @@ The options available are:
 	Specify the primary recipient of the emails generated.
 	Generally, this will be the upstream maintainer of the
 	project involved.
-
-	The --to option must be repeated for each user you want on the to list.
++
+The --to option must be repeated for each user you want on the to list.
 
 
 Author
-- 
1.5.0.2.285.g5347
