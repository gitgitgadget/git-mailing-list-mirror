From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 2/7] Documentation: git push repository can also be a remote
Date: Wed, 29 Oct 2008 21:25:40 +0100
Message-ID: <1225311945-17100-3-git-send-email-mail@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:28:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHe9-0006P1-HO
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYJ2UZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754462AbYJ2UZx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:25:53 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:42697 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238AbYJ2UZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:25:49 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id ACA0714062;
	Wed, 29 Oct 2008 21:25:49 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id C272214068;
	Wed, 29 Oct 2008 21:25:48 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99408>

This is copied from pull-fetch-param.txt and helps the reader
to not get stuck in the URL section.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index df99c0b..02c7dae 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -28,7 +28,9 @@ OPTIONS
 -------
 <repository>::
 	The "remote" repository that is destination of a push
-	operation.  See the section <<URLS,GIT URLS>> below.
+	operation.  This parameter can be either a URL
+	(see the section <<URLS,GIT URLS>> below) or the name
+	of a remote (see the section <<REMOTES,REMOTES>> below).
 
 <refspec>...::
 	The canonical format of a <refspec> parameter is
-- 
1.6.0.2.514.g23abd3
