From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 6/6] doc/send-email: clarify the behavior of --in-reply-to with --no-thread
Date: Sun,  7 Jun 2009 23:40:57 +0200
Message-ID: <1244410857-920-7-git-send-email-markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 23:41:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQ7Z-0004bz-J2
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 23:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbZFGVlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756103AbZFGVlN
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 17:41:13 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46633 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbZFGVlF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 17:41:05 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 12B7A1021A096;
	Sun,  7 Jun 2009 23:41:07 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDQ70-0007ZM-02; Sun, 07 Jun 2009 23:41:06 +0200
X-Mailer: git-send-email 1.6.3.2.221.g0ff2f
In-Reply-To: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/Sr6eyDUU10P4tNsYzRM7ehanW54Meo6oxlEkA
	bn+SG3EErj6Hkrq2Mr80s5Hp2MPpFg2x52qelw1ypNIqlPAOmD
	tExCkUXir10zEGr8NCcA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121011>

Also remove the argument from --[no-]chain-reply-to.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-send-email.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 7c5ce41..dff90f0 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -161,7 +161,7 @@ Automating
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---[no-]chain-reply-to=<identifier>::
+--[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -210,7 +210,8 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 --[no-]thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
 	If disabled with "--no-thread", no emails will have the In-Reply-To
-	header set. Default is the value of the 'sendemail.thread' configuration
+	header set, unless specified with --in-reply-to.
+	Default is the value of the 'sendemail.thread' configuration
 	value; if that is unspecified, default to --thread.
 
 
-- 
1.6.3.2.221.g0ff2f
