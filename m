From: Luke Dashjr <luke-jr+git@utopios.org>
Subject: [PATCH 3/5] Document --ignore-unmatch in git-add.txt
Date: Wed, 12 Aug 2009 22:20:22 -0500
Message-ID: <1250133624-2272-3-git-send-email-luke-jr+git@utopios.org>
References: <200908121726.52121.luke-jr@utopios.org>
 <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
 <1250133624-2272-2-git-send-email-luke-jr+git@utopios.org>
Cc: Luke Dashjr <luke-jr+git@utopios.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 05:20:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbQry-0007Ge-BG
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 05:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZHMDUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 23:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbZHMDUl
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 23:20:41 -0400
Received: from unused ([66.216.20.21]:45440 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752521AbZHMDUk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 23:20:40 -0400
Received: from tsuruki (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	by zinan.dashjr.org (Postfix) with SMTP id EBD10B9DB7E;
	Thu, 13 Aug 2009 03:20:40 +0000 (UTC)
Received: by tsuruki (sSMTP sendmail emulation); Wed, 12 Aug 2009 22:20:40 -0500
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1250133624-2272-2-git-send-email-luke-jr+git@utopios.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125767>

Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
---
 Documentation/git-add.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ab1943c..6b93b4e 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
-	  [--refresh] [--ignore-errors] [--] <filepattern>...
+	  [--refresh] [--ignore-errors] [--ignore-unmatch] [--]
+	  <filepattern>...
 
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
