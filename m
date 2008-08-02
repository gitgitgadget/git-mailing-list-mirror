From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] builtin-revert.c: typofix
Date: Sat,  2 Aug 2008 03:51:21 +0200
Message-ID: <1217641881-17611-1-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 03:52:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP6II-0006Js-CO
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 03:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbYHBBv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 21:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbYHBBv2
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 21:51:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:40364 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752090AbYHBBv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 21:51:27 -0400
Received: (qmail invoked by alias); 02 Aug 2008 01:51:25 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp064) with SMTP; 02 Aug 2008 03:51:25 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19hfL9x4INhjDPmv/8M4YAn/wP44LBhpZ31zVbL7N
	QIe2kNegvaKlaB
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KP6HB-0004aR-8G; Sat, 02 Aug 2008 03:51:21 +0200
X-Mailer: git-send-email 1.6.0.rc0.49.gd39f
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91128>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 builtin-revert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index e9da870..27881e9 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -180,7 +180,7 @@ static void set_author_ident_env(const char *message)
 			email++;
 			timestamp = strchr(email, '>');
 			if (!timestamp)
-				die ("Could not extract author email from %s",
+				die ("Could not extract author time from %s",
 					sha1_to_hex(commit->object.sha1));
 			*timestamp = '\0';
 			for (timestamp++; *timestamp && isspace(*timestamp);
-- 
1.6.0.rc0.49.gd39f
