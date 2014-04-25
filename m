From: David Kastrup <dak@gnu.org>
Subject: [PATCH 2/2] Mention "git blame" improvements in release notes
Date: Sat, 26 Apr 2014 01:56:50 +0200
Message-ID: <1398470210-28746-2-git-send-email-dak@gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:57:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdpzj-0006iU-28
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 01:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbaDYX5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 19:57:22 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:50884 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbaDYX5U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 19:57:20 -0400
Received: from localhost ([127.0.0.1]:49926 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wdpzb-0007pY-Sz; Fri, 25 Apr 2014 19:57:20 -0400
Received: by lola (Postfix, from userid 1000)
	id 33A01E060A; Sat, 26 Apr 2014 01:57:02 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398470210-28746-1-git-send-email-dak@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247135>

Includes reasonably tasteful begging.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/RelNotes/2.0.0.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/RelNotes/2.0.0.txt b/Documentation/RelNotes/2.0.0.txt
index ffd4899..27b23c3 100644
--- a/Documentation/RelNotes/2.0.0.txt
+++ b/Documentation/RelNotes/2.0.0.txt
@@ -144,6 +144,12 @@ UI, Workflows & Features
 
 Performance, Internal Implementation, etc.
 
+ * Significant parts of "git blame" have been reimplemented by David
+   Kastrup <dak@gnu.org> for a vast gain in performance with complex
+   histories and large files.  As working on free software is his sole
+   source of income, please consider contributing to his remuneration
+   if you find this useful.
+
  * The compilation options to port to AIX and to MSVC have been
    updated.
 
-- 
1.9.1
