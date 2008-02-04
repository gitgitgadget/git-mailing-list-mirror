From: Toby Allsopp <Toby.Allsopp@navman.co.nz>
Subject: [PATCH] git-p4: Fix indentation from tab to spaces
Date: Tue, 05 Feb 2008 09:41:43 +1300
Message-ID: <87fxw8mp2w.fsf@nav-akl-pcn-343.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 21:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8Oq-00077I-Nj
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYBDU6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbYBDU6H
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:58:07 -0500
Received: from ip-58-28-171-25.wxnz.net ([58.28.171.25]:41586 "EHLO
	AKLEXFE01.mitacad.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751460AbYBDU6G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 15:58:06 -0500
X-Greylist: delayed 976 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2008 15:58:06 EST
Received: from AKLEXVS01.mitacad.com ([10.112.5.36]) by AKLEXFE01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Feb 2008 09:41:44 +1300
Received: from nav-akl-pcn-343.mitacad.com.navman.co.nz ([10.112.8.136]) by AKLEXVS01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Feb 2008 09:41:44 +1300
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-OriginalArrivalTime: 04 Feb 2008 20:41:44.0757 (UTC) FILETIME=[5ACDF650:01C8676E]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15710.000
X-TM-AS-Result: No--5.077000-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72564>

Signed-off-by: Toby Allsopp <toby.allsopp@navman.co.nz>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c17afae..781a0cb 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1646,7 +1646,7 @@ class P4Clone(P4Sync):
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
-	depotDir = re.sub(r"\.\.\.$", "", depotDir)
+        depotDir = re.sub(r"\.\.\.$", "", depotDir)
         depotDir = re.sub(r"/$", "", depotDir)
         return os.path.split(depotDir)[1]
 
-- 
1.5.4.7.gd8534-dirty
