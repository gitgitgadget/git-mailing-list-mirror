From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 3/8] Doc: Improve shallow depth wording
Date: Sun, 16 Sep 2012 11:57:58 +0100
Message-ID: <1347793083-4136-4-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 14:45:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDEDl-0003YP-GG
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 14:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab2IPMoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 08:44:16 -0400
Received: from smtp2go.com ([207.58.142.213]:41657 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab2IPMoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 08:44:16 -0400
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205616>

Avoid confusion in compound sentence about the start of the commit set
and the depth measure. Use two sentences.

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 49cdc57..fa4acab 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -258,9 +258,11 @@ a positive depth, this step is skipped.
   unshallow-line   =  PKT-LINE("unshallow" SP obj-id)
 ----
 
-If the client has requested a positive depth, the server will compute
-the set of commits which are no deeper than the desired depth, starting
-at the client's wants. The server writes 'shallow' lines for each
+If the client has requested a positive depth the server will compute
+the set of commits which are no deeper than the desired depth. The set
+of commits start at the client's wants.
+
+The server writes 'shallow' lines for each
 commit whose parents will not be sent as a result. The server writes
 an 'unshallow' line for each commit which the client has indicated is
 shallow, but is no longer shallow at the currently requested depth
-- 
1.7.8.msysgit.0
