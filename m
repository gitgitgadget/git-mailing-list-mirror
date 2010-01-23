From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: add missing :: in config.txt
Date: Sat, 23 Jan 2010 23:13:17 +0100
Message-ID: <9dfb8ea11c58f502e653abc4e517a798b8005dae.1264284658.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:16:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYoHj-0006Vb-HY
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab0AWWNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255Ab0AWWNl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:13:41 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:17641 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932131Ab0AWWNl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:13:41 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sat, 23 Jan
 2010 23:13:40 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sat, 23 Jan
 2010 23:13:17 +0100
X-Mailer: git-send-email 1.6.6.1.577.gf1430
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137866>

bed575e (commit: support commit.status, --status, and --no-status,
2009-12-07) forgot to add the :: that sets off an item from the
paragraph that explains it, breaking the layout.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

[I'm merely sending this out because I stumbled over it.  All the mail
Cced to me unfortunately has to wait till tomorrow.]

 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8dcb191..17901e2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -716,7 +716,7 @@ color.ui::
 	terminal. When more specific variables of color.* are set, they always
 	take precedence over this setting. Defaults to false.
 
-commit.status
+commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
 	message.  Defaults to true.
-- 
1.6.6.1.577.gf1430
