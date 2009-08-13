From: Luke Dashjr <luke-jr+git@utopios.org>
Subject: [PATCH] Document --ignore-unmatch in git-add.txt
Date: Thu, 13 Aug 2009 16:03:19 -0500
Message-ID: <1250197399-23761-1-git-send-email-luke-jr+git@utopios.org>
References: <7vr5vfa4ha.fsf@alter.siamese.dyndns.org>
Cc: Luke Dashjr <luke-jr+git@utopios.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 23:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbhSe-0007Zi-Nd
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332AbZHMVDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 17:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756326AbZHMVDV
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:03:21 -0400
Received: from unused ([66.216.20.21]:51149 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756324AbZHMVDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 17:03:20 -0400
Received: from tsuruki (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	by zinan.dashjr.org (Postfix) with SMTP id A76EAB9DB46;
	Thu, 13 Aug 2009 21:03:20 +0000 (UTC)
Received: by tsuruki (sSMTP sendmail emulation); Thu, 13 Aug 2009 16:03:20 -0500
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <7vr5vfa4ha.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125874>

Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
---
 Documentation/git-add.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e67b7e8..6e30ee9 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
-	  [--refresh] [--ignore-errors] [--] [<filepattern>...]
+	  [--refresh] [--ignore-errors] [--ignore-unmatch] [--]
+	  [<filepattern>...]
 
 DESCRIPTION
 -----------
@@ -119,6 +120,9 @@ apply.
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
 
+--ignore-unmatch::
+	Exit with a zero status even if no files matched.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
-- 
1.6.3.3
