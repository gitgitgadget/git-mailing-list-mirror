From: Fraser Tweedale <frase@frase.id.au>
Subject: [PATCH] documentation: add git transport security notice
Date: Wed, 26 Jun 2013 15:53:59 +1000
Message-ID: <1372226039-31689-1-git-send-email-frase@frase.id.au>
Cc: Fraser Tweedale <frase@frase.id.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 07:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrigL-0002Tu-FD
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 07:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab3FZFyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 01:54:13 -0400
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:50076
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751195Ab3FZFyN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jun 2013 01:54:13 -0400
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r5Q5s2nR031765;
	Wed, 26 Jun 2013 15:54:02 +1000 (EST)
	(envelope-from fraser@bacardi.hollandpark.frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r5Q5s1iL031755;
	Wed, 26 Jun 2013 15:54:01 +1000 (EST)
	(envelope-from fraser)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229030>

The fact that the git transport does not do any authentication is
easily overlooked.  For example, DNS poisoning may result in
fetching from somewhere that was not intended.

Add a brief security notice to the "GIT URLS" section
of the documentation stating that the git transport should be used
with caution on unsecured networks.

Signed-off-by: Fraser Tweedale <frase@frase.id.au>
---
 Documentation/urls.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 3ca122f..b58a647 100644
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
