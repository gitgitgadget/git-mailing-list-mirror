From: Fraser Tweedale <frase@frase.id.au>
Subject: [PATCH] documentation: fix asterisks in fetch-options
Date: Mon, 24 Jun 2013 21:31:07 +1000
Message-ID: <1372073467-29112-1-git-send-email-frase@frase.id.au>
Cc: Fraser Tweedale <frase@frase.id.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 13:31:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur4zT-0004ZZ-Vj
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 13:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab3FXLbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 07:31:19 -0400
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:54883
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750783Ab3FXLbS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 07:31:18 -0400
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r5OBVAwt029149;
	Mon, 24 Jun 2013 21:31:10 +1000 (EST)
	(envelope-from fraser@bacardi.hollandpark.frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r5OBVAv8029148;
	Mon, 24 Jun 2013 21:31:10 +1000 (EST)
	(envelope-from fraser)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228804>

Fix refspec asterisks in the -t/--tags section of the fetch-options
documentation.

Signed-off-by: Fraser Tweedale <frase@frase.id.au>
---
 Documentation/fetch-options.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9cb6496..f2ac3bc 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -61,11 +61,12 @@ endif::git-pull[]
 ifndef::git-pull[]
 -t::
 --tags::
-	This is a short-hand for giving "refs/tags/*:refs/tags/*"
-	refspec from the command line, to ask all tags to be fetched
-	and stored locally.  Because this acts as an explicit
-	refspec, the default refspecs (configured with the
-	remote.$name.fetch variable) are overridden and not used.
+	This is a short-hand for giving
+	"refs/tags/{asterisk}:refs/tags/{asterisk}" refspec from the
+	command line, to ask all tags to be fetched and stored
+	locally.  Because this acts as an explicit refspec, the
+	default refspecs (configured with the remote.$name.fetch
+	variable) are overridden and not used.
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
-- 
1.8.3.1
