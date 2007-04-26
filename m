From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 9/9] Document --dry-run and envelope-sender for git-send-email.
Date: Wed, 25 Apr 2007 19:37:23 -0700
Message-ID: <1177555043691-git-send-email-robbat2@gentoo.org>
References: <1177555043986-git-send-email-robbat2@gentoo.org>
 <11775550432104-git-send-email-robbat2@gentoo.org>
 <1177555043272-git-send-email-robbat2@gentoo.org>
 <11775550432268-git-send-email-robbat2@gentoo.org>
 <11775550433288-git-send-email-robbat2@gentoo.org>
 <11775550432746-git-send-email-robbat2@gentoo.org>
 <11775550433329-git-send-email-robbat2@gentoo.org>
 <1177555043174-git-send-email-robbat2@gentoo.org>
 <11775550433762-git-send-email-robbat2@gentoo.org>
Cc: Junio C Hamano <junkio@cox.net>,
	"Robin H\. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 04:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgty1-0001Ck-AD
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbXDZCoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbXDZCoK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:44:10 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:47637 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754686AbXDZCoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:44:07 -0400
Received: (qmail 18686 invoked from network); 26 Apr 2007 02:44:06 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 02:44:06 +0000
Received: (qmail 18832 invoked from network); 25 Apr 2007 19:37:41 -0700
Received: from grubbs-int-e1000.local.orbis-terrarum.net (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 25 Apr 2007 19:37:41 -0700
Received: (nullmailer pid 32461 invoked by uid 0);
	Thu, 26 Apr 2007 02:37:23 -0000
X-Mailer: git-send-email 1.5.2.rc0.43.g2f4c7
In-Reply-To: <11775550433762-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45603>

From: Robin H. Johnson <robbat2@gentoo.org>

Catch the documentation up with the rest of this patchset.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 Documentation/git-send-email.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 682313e..393d79a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -85,6 +85,15 @@ The --cc option must be repeated for each user you want on the cc list.
 	Do not add the From: address to the cc: list, if it shows up in a From:
 	line.
 
+--dry-run::
+	Do everything except actually send the emails.
+
+--envelope-sender::
+	Specify the envelope sender used to send the emails. 
+	This is useful if your default address is not the address that is
+	subscribed to a list. If you use the sendmail binary, you must have
+	suitable privileges for the -f parameter.
+
 --to::
 	Specify the primary recipient of the emails generated.
 	Generally, this will be the upstream maintainer of the
-- 
1.5.2.rc0.43.g2f4c7
