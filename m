From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 5/5] git-name-rev.txt: document --no-undefined and --always
Date: Sun,  8 Jun 2008 03:36:12 +0200
Message-ID: <1212888972-29039-5-git-send-email-s-beyer@gmx.net>
References: <7vy75hlzvv.fsf@gitster.siamese.dyndns.org>
 <1212888972-29039-1-git-send-email-s-beyer@gmx.net>
 <1212888972-29039-2-git-send-email-s-beyer@gmx.net>
 <1212888972-29039-3-git-send-email-s-beyer@gmx.net>
 <1212888972-29039-4-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 03:37:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K59qf-0000LG-3G
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 03:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973AbYFHBgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 21:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbYFHBgi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 21:36:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:56077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755516AbYFHBgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 21:36:35 -0400
Received: (qmail invoked by alias); 08 Jun 2008 01:36:33 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp053) with SMTP; 08 Jun 2008 03:36:33 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+pOvAntLipqgbVIZVUpdYhBssOl1n67KDeNog/RN
	1ZB+XEJep8jPBr
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K59pM-0007Yw-V5; Sun, 08 Jun 2008 03:36:12 +0200
X-Mailer: git-send-email 1.5.6.rc1.21.g03300
In-Reply-To: <1212888972-29039-4-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84244>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
See commit 2cf9f445e9074df1a45f5179cef0d4bb8647dd8

 Documentation/git-name-rev.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 12784d7..ffac3f8 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -41,6 +41,13 @@ OPTIONS
 	of linkgit:git-describe[1] more closely.  This option
 	cannot be combined with --stdin.
 
+--no-undefined::
+	Die with error code != 0 when a reference is undefined,
+	instead of printing `undefined`.
+
+--always::
+	Show uniquely abbreviated commit object as fallback.
+
 EXAMPLE
 -------
 
-- 
1.5.5.1
