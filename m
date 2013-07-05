From: Fraser Tweedale <frase@frase.id.au>
Subject: [PATCH] documentation: add git transport security notice
Date: Fri,  5 Jul 2013 18:41:26 +1000
Message-ID: <1373013686-2137-1-git-send-email-frase@frase.id.au>
Cc: git@vger.kernel.org, Fraser Tweedale <frase@frase.id.au>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 05 10:42:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv1af-0008FL-JI
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157Ab3GEImA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:42:00 -0400
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:53747
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757074Ab3GEIl7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jul 2013 04:41:59 -0400
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r658ff9c002173;
	Fri, 5 Jul 2013 18:41:41 +1000 (EST)
	(envelope-from fraser@bacardi.hollandpark.frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r658fcKO002172;
	Fri, 5 Jul 2013 18:41:38 +1000 (EST)
	(envelope-from fraser)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229637>

The fact that the git transport does not do any authentication is
easily overlooked.  For example, DNS poisoning may result in
fetching from somewhere that was not intended.

Add a brief security notice to the "GIT URLS" section of the
documentation stating that the git transport should be used with
caution on unsecured networks.

Signed-off-by: Fraser Tweedale <frase@frase.id.au>
---
 Documentation/urls.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 60ba300..9c8f524 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -11,6 +11,9 @@ and ftps can be used for fetching and rsync can be used for fetching
 and pushing, but these are inefficient and deprecated; do not use
 them).
 
+The git transport does not do any authentication and should be used
+with caution on unsecured networks.
+
 The following syntaxes may be used with them:
 
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
-- 
1.8.3.1
