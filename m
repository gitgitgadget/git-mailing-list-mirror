From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: point to "History Simplification" from -- <path>
Date: Tue, 30 Aug 2011 01:18:19 +0200
Message-ID: <307fe311ad448ecd3d0643040008954a217d7ddb.1314659821.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 01:18:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyB6B-0002VK-Ik
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 01:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448Ab1H2XSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 19:18:25 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:3222 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755242Ab1H2XSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 19:18:23 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 30 Aug
 2011 01:18:20 +0200
Received: from localhost.localdomain (188.155.176.28) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 30 Aug
 2011 01:18:20 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180376>

'git log -- <path>' does not "show commits that affect the specified
paths" in a literal sense unless --full-history is given (for example,
a file that only existed on a side branch will turn up no commits at
all!).

Point the user to the "History Simplification" section to avoid
surprises.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Sparked by an IRC discussion minutes ago, where I got the paragraph
quoted back to me verbatim to "prove" it shows *all* commits affecting
a file.


 Documentation/git-log.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 6c93466..437f06e 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -69,10 +69,12 @@ produced by --stat etc.
 	its size is not included.
 
 [\--] <path>...::
-	Show only commits that affect any of the specified paths. To
-	prevent confusion with options and branch names, paths may need
-	to be prefixed with "\-- " to separate them from options or
-	refnames.
+	Show only commits that affect any of the specified paths.
+	See "History Simplification" below for a precise definition of
+	the filtering applied.
++
+To prevent confusion with options and branch names, paths may need to
+be prefixed with "\-- " to separate them from options or refnames.
 
 include::rev-list-options.txt[]
 
-- 
1.7.7.rc0.370.gdcae57
