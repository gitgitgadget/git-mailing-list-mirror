From: Fabrizio Chiarello <ponch@autistici.org>
Subject: [PATCH] builtin-clone: fix typo
Date: Fri, 19 Sep 2008 14:07:26 +0200
Message-ID: <20080919120726.GA7863@hydrogen.black.hole>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 14:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgfIT-0004Rp-W1
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 14:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbYISMkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 08:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYISMkI
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 08:40:08 -0400
Received: from latitanza.investici.org ([82.94.249.234]:63369 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYISMkH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 08:40:07 -0400
X-Greylist: delayed 1955 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Sep 2008 08:40:07 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: ponch@autistici.org) with ESMTP id 031EC98059
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96281>

Signed-off-by: Fabrizio Chiarello <ponch@autistici.org>
---
 builtin-clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index c843529..5b40e07 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -58,7 +58,7 @@ static struct option builtin_clone_options[] = {
 	OPT_STRING(0, "reference", &option_reference, "repo",
 		   "reference repository"),
 	OPT_STRING('o', "origin", &option_origin, "branch",
-		   "use <branch> instead or 'origin' to track upstream"),
+		   "use <branch> instead of 'origin' to track upstream"),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
-- 
1.5.6.5
