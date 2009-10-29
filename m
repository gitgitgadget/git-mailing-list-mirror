From: jari.aalto@cante.net
Subject: [PATCH] Documentation/gitk.txt: order options alphabetically
Date: Thu, 29 Oct 2009 18:59:31 +0200
Message-ID: <1256835571-6662-1-git-send-email-jari.aalto@cante.net>
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 18:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3YTE-0002VH-5r
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 18:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbZJ2RHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 13:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbZJ2RHU
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 13:07:20 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:60501 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbZJ2RHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 13:07:18 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2009 13:07:18 EDT
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 1FEA08C017
	for <git@vger.kernel.org>; Thu, 29 Oct 2009 19:00:23 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A047241BB77; Thu, 29 Oct 2009 19:00:23 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 0EF9EE51A2
	for <git@vger.kernel.org>; Thu, 29 Oct 2009 19:00:20 +0200 (EET)
Received: from git.cante.net ([192.168.1.7] helo=jondo.cante.net)
	by picasso.cante.net with esmtp (Exim 4.69)
	(envelope-from <root@cante.net>)
	id 1N3YME-0002hE-Bq; Thu, 29 Oct 2009 19:00:18 +0200
Received: from root by jondo.cante.net with local (Exim 4.69)
	(envelope-from <root@jondo.cante.net>)
	id 1N3YMF-0001pi-Lq; Thu, 29 Oct 2009 19:00:19 +0200
X-Mailer: git-send-email 1.6.5
X-SA-Exim-Connect-IP: 192.168.1.7
X-SA-Exim-Mail-From: root@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131615>

From: Jari Aalto <jari.aalto@cante.net>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/gitk.txt |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index cf465cb..08ff926 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -26,23 +26,17 @@ the 'git-rev-list' command (see linkgit:git-rev-list[1]).
 This manual page describes only the most
 frequently used options.
 
--n <number>::
---max-count=<number>::
-
-	Limits the number of commits to show.
-
---since=<date>::
-
-	Show commits more recent than a specific date.
-
---until=<date>::
-
-	Show commits older than a specific date.
-
 --all::
 
 	Show all branches.
 
+--argscmd=<command>::
+	Command to be run each time gitk has to determine the list of
+	<revs> to show.  The command is expected to print on its standard
+	output a list of additional revs to be shown, one per line.
+	Use this instead of explicitly specifying <revs> if the set of
+	commits to show may vary between refreshes.
+
 --merge::
 
 	After an attempt to merge stops with conflicts, show the commits on
@@ -50,18 +44,24 @@ frequently used options.
 	that modify the conflicted files and do not exist on all the heads
 	being merged.
 
---argscmd=<command>::
-	Command to be run each time gitk has to determine the list of
-	<revs> to show.  The command is expected to print on its standard
-	output a list of additional revs to be shown, one per line.
-	Use this instead of explicitly specifying <revs> if the set of
-	commits to show may vary between refreshes.
+-n <number>::
+--max-count=<number>::
+
+	Limits the number of commits to show.
 
 --select-commit=<ref>::
 
 	Automatically select the specified commit after loading the graph.
 	Default behavior is equivalent to specifying '--select-commit=HEAD'.
 
+--since=<date>::
+
+	Show commits more recent than a specific date.
+
+--until=<date>::
+
+	Show commits older than a specific date.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
-- 
1.6.5
