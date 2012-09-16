From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 2/8] Doc: shallow clone deepens _to_ new depth
Date: Sun, 16 Sep 2012 11:57:57 +0100
Message-ID: <1347793083-4136-3-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 14:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDDzr-0003h2-Pz
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 14:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab2IPMak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 08:30:40 -0400
Received: from smtp2go.com ([207.58.142.213]:59449 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab2IPMaj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 08:30:39 -0400
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205613>

Clarify that 'depth=' specifies the new depth from the remote's
branch tip. It does not add the depth to the existing shallow clone.
(details from pack-protocol.txt).
Clarify that tags are not fetched. (details from shallow.txt)

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 39d326a..b4d6476 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -10,7 +10,8 @@
 --depth=<depth>::
 	Deepen the history of a 'shallow' repository created by
 	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
-	by the specified number of commits.
+	to the specified number of commits from the tip of each remote
+	branch history. Tags for the deepened commits are not fetched.
 
 ifndef::git-pull[]
 --dry-run::
-- 
1.7.8.msysgit.0
