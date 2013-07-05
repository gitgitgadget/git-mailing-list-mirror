From: Fraser Tweedale <frase@frase.id.au>
Subject: [PATCH] diff-options: document default similarity index
Date: Fri,  5 Jul 2013 18:42:17 +1000
Message-ID: <1373013737-2448-1-git-send-email-frase@frase.id.au>
Cc: git@vger.kernel.org, Fraser Tweedale <frase@frase.id.au>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 05 10:42:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv1bD-0000Ms-EA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757166Ab3GEImg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:42:36 -0400
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:50987
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755745Ab3GEImf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jul 2013 04:42:35 -0400
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r658gNuR002485;
	Fri, 5 Jul 2013 18:42:23 +1000 (EST)
	(envelope-from fraser@bacardi.hollandpark.frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r658gN7R002484;
	Fri, 5 Jul 2013 18:42:23 +1000 (EST)
	(envelope-from fraser)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229638>

The default similarity index of 50% is documented in gitdiffcore(7)
but it is worth also mentioning it in the description of the
-M/--find-renames option.

Signed-off-by: Fraser Tweedale <frase@frase.id.au>
---
 Documentation/diff-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index a85288f..d6e4db4 100644
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
