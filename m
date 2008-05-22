From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Documentation: Fix skipped section level
Date: Thu, 22 May 2008 04:28:43 +0200
Message-ID: <1211423323-5024-1-git-send-email-hendeby@isy.liu.se>
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 22 04:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz0Yq-0001tY-D3
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 04:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbYEVC2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 22:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755376AbYEVC2r
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 22:28:47 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:54854 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078AbYEVC2q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 22:28:46 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id AECD8259AC;
	Thu, 22 May 2008 04:28:44 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 13127-06; Thu,  8 May 2008 07:37:10 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id C828224F8F;
	Thu, 22 May 2008 04:28:43 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 938FF177A0; Thu, 22 May 2008 04:28:43 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.499.g878b8
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82601>

With xmlto 0.0.18 it seems to demand that no section levels are
skipped.  The commit 'implement gitcvs.usecrlfattr' (8a06a632976ead)
one such skip, which here is removed by increasing the level of the
offender.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

This seems to only be in next so the patch applies there.

/Gustaf

 Documentation/git-cvsserver.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index cd0685e..a33382e 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -302,7 +302,7 @@ Legacy monitoring operations are not supported (edit, watch and related).
 Exports and tagging (tags and branches) are not supported at this stage.
 
 CRLF Line Ending Conversions
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 By default the server leaves the '-k' mode blank for all files,
 which causes the cvs client to treat them as a text files, subject
-- 
1.5.5.1.499.g878b8
