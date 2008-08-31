From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Document clarification: gitmodules, gitattributes
Date: Sun, 31 Aug 2008 18:00:27 +0200
Message-ID: <1220198427-13017-1-git-send-email-hendeby@isy.liu.se>
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 31 18:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZpRU-0005kD-Qh
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 18:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbYHaQAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 12:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbYHaQAa
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 12:00:30 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:50529 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYHaQA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 12:00:29 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id D25E025AB1;
	Sun, 31 Aug 2008 18:00:27 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 11210-04; Fri,  4 Jul 2008 02:08:56 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 2817925AA4;
	Sun, 31 Aug 2008 18:00:27 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 1E0762ED78; Sun, 31 Aug 2008 18:00:27 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.258.g6c63a
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94487>

The SYNOPSIS section of gitattibutes and gitmodule fail to clearly
specify the name of the in tree files used.  This patch brings in the
initial `.' and the fact that the `.gitmodules' file should reside at
the top-level of the working tree.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

If this patch isn't accepted, the reverse changes should be made to
the gitignore documentation.

/Gustaf

 Documentation/gitattributes.txt |    2 +-
 Documentation/gitmodules.txt    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 1f23d27..5fb5007 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -7,7 +7,7 @@ gitattributes - defining attributes per path
 
 SYNOPSIS
 --------
-$GIT_DIR/info/attributes, gitattributes
+$GIT_DIR/info/attributes, .gitattributes
 
 
 DESCRIPTION
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f8d122a..d1a17e2 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -7,7 +7,7 @@ gitmodules - defining submodule properties
 
 SYNOPSIS
 --------
-gitmodules
+$GIT_WORK_DIR/.gitmodules
 
 
 DESCRIPTION
-- 
1.6.0.1.258.g6c63a
