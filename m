From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] Fix break in git-rev-list.txt
Date: Wed, 22 Aug 2007 18:18:03 +1000
Message-ID: <11877706831306-git-send-email-qtonthat@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 10:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INlPs-0007pM-OA
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 10:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbXHVISL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 04:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbXHVISK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 04:18:10 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:43650 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbXHVISJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 04:18:09 -0400
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=localhost.localdomain)
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1INlPf-00005U-R6; Wed, 22 Aug 2007 18:18:04 +1000
X-Mailer: git-send-email 1.5.3.rc5.1q
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56356>

Also fix some innocent missing of quotes.

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 Documentation/git-rev-list.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index cbbc234..a0c611e 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -298,8 +298,8 @@ used in the output.  When the starting commit is specified as
 'commit@{now}', output also uses 'commit@\{timestamp}' notation
 instead.  Under '\--pretty=oneline', the commit message is
 prefixed with this information on the same line.
-+
-Cannot be combined with --reverse.
+
+Cannot be combined with '\--reverse'.
 
 --merge::
 
@@ -375,7 +375,7 @@ By default, the commits are shown in reverse chronological order.
 --reverse::
 
 	Output the commits in reverse order.
-	Cannot be combined with --walk-reflogs.
+	Cannot be combined with '\--walk-reflogs'.
 
 Object Traversal
 ~~~~~~~~~~~~~~~~
-- 
1.5.3.rc5.1q
