From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 2/3] Document send-email --smtp-domain
Date: Fri,  9 Apr 2010 01:11:45 -0400
Message-ID: <1270789906-23735-3-git-send-email-brian@gernhardtsoftware.com>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:12:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O06Vx-0003vk-3a
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995Ab0DIFL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 01:11:56 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44486 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab0DIFLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 01:11:50 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 727201FFC057; Fri,  9 Apr 2010 05:11:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id D5AA71FFC058;
	Fri,  9 Apr 2010 05:11:36 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.243.g2ce66
In-Reply-To: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144400>

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 --smtp-debug is still undocumented.  It also appears to be a boolean that
 takes 0 or 1 instead of being of the form --[no-]smtp-debug.

 Documentation/git-send-email.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ced35b2..f171471 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -119,6 +119,12 @@ Sending
 	value reverts to plain SMTP.  Default is the value of
 	'sendemail.smtpencryption'.
 
+--smtp-domain=<FQDN>::
+	Specifies the Fully Qualified Domain Name (FQDN) used in the
+	HELO/EHLO command to the SMTP server.  Some servers require the
+	FQDN to match your IP address.  If not set, git send-email attempts
+	to determine your FQDN automatically.
+
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
-- 
1.7.1.rc0.210.ge6da
