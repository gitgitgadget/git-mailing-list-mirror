From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v3 3/4] Document send-email --smtp-domain
Date: Sat, 10 Apr 2010 10:53:55 -0400
Message-ID: <1270911236-32476-4-git-send-email-brian@gernhardtsoftware.com>
References: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 16:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0c4v-0006h6-Em
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 16:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab0DJOyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 10:54:07 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44348 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab0DJOyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 10:54:05 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 3A9A21FFC061; Sat, 10 Apr 2010 14:54:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.103.20])
	by silverinsanity.com (Postfix) with ESMTPA id 80FE31FFC05B;
	Sat, 10 Apr 2010 14:53:59 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.251.g42f41
In-Reply-To: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144554>

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
1.7.1.rc0.251.g42f41
