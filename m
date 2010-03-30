From: Greg Bacon <gbacon@dbresearch.net>
Subject: [PATCH] Documentation: Clarify support for smart HTTP backend
Date: Tue, 30 Mar 2010 12:20:57 -0500
Message-ID: <1269969657-16101-1-git-send-email-gbacon@dbresearch.net>
Cc: Greg Bacon <gbacon@dbresearch.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 30 19:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwfHX-0007GN-IE
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 19:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab0C3RbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 13:31:09 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:53001 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778Ab0C3RbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 13:31:08 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2010 13:31:08 EDT
Received: from relay4.r5.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay4.r5.iad.mlsrvr.com (SMTP Server) with ESMTP id 47124C296;
	Tue, 30 Mar 2010 13:21:28 -0400 (EDT)
Received: by relay4.r5.iad.mlsrvr.com (Authenticated sender: gbacon-AT-dbresearch.net) with ESMTPSA id 0D4B8C1C8;
	Tue, 30 Mar 2010 13:21:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143583>

In the description of http.getanyfile, replace the vague "older Git
clients" with the earliest release whose client is able to use the
upload pack service.

Signed-off-by: Greg Bacon <gbacon@dbresearch.net>
---
 Documentation/git-http-backend.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 5238820..277d9e1 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -35,7 +35,7 @@ These services can be enabled/disabled using the per-repository
 configuration file:
 
 http.getanyfile::
-	This serves older Git clients which are unable to use the
+	This serves Git clients older than version 1.6.6 that are unable to use the
 	upload pack service.  When enabled, clients are able to read
 	any file within the repository, including objects that are
 	no longer reachable from a branch but are still present.
-- 
1.6.6.2
