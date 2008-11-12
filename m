From: Michael Adam <obnox@samba.org>
Subject: [PATCH] contrib/hooks/post-receive-email: document individual mails in comments
Date: Wed, 12 Nov 2008 17:21:28 +0100
Organization: SerNet GmbH, Goettingen, Germany
Message-ID: <E1L0ITB-00BvA3-Ct@intern.SerNet.DE>
References: <1226506888-2841305-1-git-send-email-obnox@samba.org>
Cc: Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Adam <obnox@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 17:45:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Iqs-0002jK-Nw
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 17:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbYKLQoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 11:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbYKLQoW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 11:44:22 -0500
Received: from mail1.SerNet.de ([193.175.80.2]:51991 "EHLO mail.SerNet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbYKLQoT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 11:44:19 -0500
Received: from intern.SerNet.DE by mail.SerNet.DE
	with esmtp (Exim 4.63 #1)
	id 1L0ITB-0002jq-QX; Wed, 12 Nov 2008 17:21:29 +0100
Received: by intern.SerNet.DE
	id 1L0ITB-00BvA3-Ct; Wed, 12 Nov 2008 17:21:29 +0100
Received: from intern.SerNet.DE (localhost [127.0.0.1])
	by localhost (AvMailGate-2.1.4-7) id 2841334-CaNFAy;
	Wed, 12 Nov 2008 17:21:29 +0100 (CET)
Received: by intern.SerNet.DE
	id 1L0ITB-00Bv9m-3o; Wed, 12 Nov 2008 17:21:29 +0100
In-Reply-To: <1226506888-2841305-1-git-send-email-obnox@samba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100766>

This documents the new behaviour to send individual mails for the
recipient emails in the "Config" section of the comment header.

Signed-off-by: Michael Adam <obnox@samba.org>
---
 contrib/hooks/post-receive-email |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 5deaf28..ecef707 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -27,11 +27,15 @@
 # ------
 # hooks.mailinglist
 #   This is the list that all pushes will go to; leave it blank to not send
-#   emails for every ref update.
+#   emails for every ref update. A list of recipient addresses separated
+#   by commas may be specified. Each recipient in the list will receive an
+#   individual mail.
 # hooks.announcelist
 #   This is the list that all pushes of annotated tags will go to.  Leave it
 #   blank to default to the mailinglist field.  The announce emails lists
 #   the short log summary of the changes since the last annotated tag.
+#   Lists of email addresses are treated the same way as in the mailinglists
+#   field.
 # hooks.envelopesender
 #   If set then the -f option is passed to sendmail to allow the envelope
 #   sender address to be set
-- 
1.5.6
