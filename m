From: Fraser Tweedale <frase@frase.id.au>
Subject: [PATCH] diff-options: document default similarity index
Date: Mon, 24 Jun 2013 21:17:12 +1000
Message-ID: <1372072632-27313-1-git-send-email-frase@frase.id.au>
Cc: Fraser Tweedale <frase@frase.id.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 13:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur4m3-0002eG-LH
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 13:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab3FXLR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 07:17:27 -0400
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:59047
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325Ab3FXLR1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 07:17:27 -0400
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r5OBHK7G027350;
	Mon, 24 Jun 2013 21:17:20 +1000 (EST)
	(envelope-from fraser@bacardi.hollandpark.frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r5OBHJKb027349;
	Mon, 24 Jun 2013 21:17:19 +1000 (EST)
	(envelope-from fraser)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228803>

The default similarity index of 50% is documented in gitdiffcore(7)
but it is worth also mentioning it in the description of the
-M/--find-renames option.

Signed-off-by: Fraser Tweedale <frase@frase.id.au>
---
 Documentation/diff-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b8a9b86..69bb3a6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -333,7 +333,7 @@ endif::git-log[]
 	a fraction, with a decimal point before it.  I.e., `-M5` becomes
 	0.5, and is thus the same as `-M50%`.  Similarly, `-M05` is
 	the same as `-M5%`.  To limit detection to exact renames, use
-	`-M100%`.
+	`-M100%`.  The default similarity index is 50%.
 
 -C[<n>]::
 --find-copies[=<n>]::
-- 
1.8.3.1
