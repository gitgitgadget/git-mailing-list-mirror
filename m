From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: rev-list-options: Fix -g paragraph formatting
Date: Sun, 10 Aug 2008 15:04:34 +0200
Message-ID: <1218373474-1653-1-git-send-email-trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 10 15:06:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSAc5-0002jf-Aa
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 15:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbYHJNE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 09:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbYHJNE2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 09:04:28 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:23438 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504AbYHJNE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 09:04:28 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 15:04:26 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 15:04:26 +0200
X-Mailer: git-send-email 1.6.0.rc2.29.g7ec81
X-OriginalArrivalTime: 10 Aug 2008 13:04:26.0433 (UTC) FILETIME=[9DF2FB10:01C8FAE9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91833>

- Add an escape to @{now}.  Without the escape, the brace does
  something magic and eats half the sentence up to the closing brace
  at 'timestamp}'.

- Join the last paragraph with a '+'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/rev-list-options.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ee6822a..7e04f38 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -270,10 +270,10 @@ With '\--pretty' format other than oneline (for obvious reasons),
 this causes the output to have two extra lines of information
 taken from the reflog.  By default, 'commit@\{Nth}' notation is
 used in the output.  When the starting commit is specified as
-'commit@{now}', output also uses 'commit@\{timestamp}' notation
+'commit@\{now}', output also uses 'commit@\{timestamp}' notation
 instead.  Under '\--pretty=oneline', the commit message is
 prefixed with this information on the same line.
-
++
 Cannot be combined with '\--reverse'.
 See also linkgit:git-reflog[1].
 
-- 
1.6.0.rc2.29.g7ec81
