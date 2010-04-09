From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v2 2/3] Document send-email --smtp-domain
Date: Fri,  9 Apr 2010 11:34:04 -0400
Message-ID: <1270827245-28958-3-git-send-email-brian@gernhardtsoftware.com>
References: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 17:35:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0GEk-0000fO-0J
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 17:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab0DIPe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 11:34:29 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45994 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab0DIPeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 11:34:16 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 48C511FFC058; Fri,  9 Apr 2010 15:34:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.102.129])
	by silverinsanity.com (Postfix) with ESMTPA id 1E7261FFC056;
	Fri,  9 Apr 2010 15:34:10 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.243.g2ce66
In-Reply-To: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144441>

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
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
1.7.1.rc0.243.g2ce66
