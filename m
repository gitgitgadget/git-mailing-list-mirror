From: Fraser Tweedale <frase@frase.id.au>
Subject: [PATCH] documentation: add git transport security notice
Date: Mon, 24 Jun 2013 20:23:34 +1000
Message-ID: <1372069414-12601-1-git-send-email-frase@frase.id.au>
Cc: Fraser Tweedale <frase@frase.id.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 12:50:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur4M4-0008Bw-AE
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 12:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab3FXKue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 06:50:34 -0400
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:59697
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752427Ab3FXKud (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 06:50:33 -0400
X-Greylist: delayed 1527 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2013 06:50:32 EDT
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r5OAOwTt012705;
	Mon, 24 Jun 2013 20:24:58 +1000 (EST)
	(envelope-from fraser@bacardi.hollandpark.frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r5OAOvLN012704;
	Mon, 24 Jun 2013 20:24:57 +1000 (EST)
	(envelope-from fraser)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228802>

The fact that the git transport has no end-to-end security is easily
overlooked.  Add a brief security notice to the "GIT URLS" section
of the documentation stating that the git transport should be used
with caution on unsecured networks.

Signed-off-by: Fraser Tweedale <frase@frase.id.au>
---
 Documentation/urls.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 3ca122f..c218af5 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -11,6 +11,9 @@ and ftps can be used for fetching and rsync can be used for fetching
 and pushing, but these are inefficient and deprecated; do not use
 them).
 
+The git protocol provides no end-to-end security and should be used
+with caution on unsecured networks.
+
 The following syntaxes may be used with them:
 
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
-- 
1.8.3.1
