From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 5/5] Document the new --graph option for log and rev-list
Date: Sun,  6 Apr 2008 14:47:24 -0700
Message-ID: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
References: <1207507332-1866-4-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 23:48:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jicig-0007E8-SP
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 23:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbYDFVr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYDFVr1
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 17:47:27 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:50958 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbYDFVr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 17:47:26 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id DB49572BAF7;
	Sun,  6 Apr 2008 17:47:25 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id B835B72B491;
	Sun,  6 Apr 2008 17:47:25 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id C68EB14100BB; Sun,  6 Apr 2008 14:47:24 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207507332-1866-4-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78934>

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 Documentation/rev-list-options.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2648a55..ce6a101 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -75,6 +75,16 @@ you would get an output line this:
 	-xxxxxxx... 1st on a
 -----------------------------------------------------------------------
 
+--graph::
+
+	Draw a text-based graphical representation of the commit history
+	on the left hand side of the output.  This may cause extra lines
+	to be printed in between commits, in order for the graph history
+	to be drawn properly.
++
+This implies the '--topo-order' option by default, but the
+'--date-order' option may also be specified.
+
 Diff Formatting
 ~~~~~~~~~~~~~~~
 
-- 
1.5.3.6
