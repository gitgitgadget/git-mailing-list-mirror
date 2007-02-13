From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] git-gui: fix typo in GIT-VERSION-GEN, "/dev/null" not "/devnull"
Date: Tue, 13 Feb 2007 15:26:16 +0000
Message-ID: <200702131526.17153.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 16:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGzXz-0005Fs-Gy
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 16:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbXBMP0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbXBMP0U
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 10:26:20 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:18827 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750739AbXBMP0T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 10:26:19 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 13 Feb 2007 15:28:55 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HGzXv-0000Et-00
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 15:26:19 +0000
X-TUID: 4c0225d64e9a2c36
X-UID: 238
X-Length: 868
Content-Disposition: inline
X-OriginalArrivalTime: 13 Feb 2007 15:28:55.0859 (UTC) FILETIME=[AC9C6830:01C74F83]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39533>

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I think this would make git-gui get the wrong version number as the script
wouldn't complete successfully.

 git-gui/GIT-VERSION-GEN |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/GIT-VERSION-GEN b/git-gui/GIT-VERSION-GEN
index 8fac8cb..9966126 100755
--- a/git-gui/GIT-VERSION-GEN
+++ b/git-gui/GIT-VERSION-GEN
@@ -10,7 +10,7 @@ tree_search ()
 {
 	head=$1
 	tree=$2
-	for p in $(git rev-list --parents --max-count=1 $head 2>/devnull)
+	for p in $(git rev-list --parents --max-count=1 $head 2>/dev/null)
 	do
 		test $tree = $(git rev-parse $p^{tree} 2>/dev/null) &&
 		vn=$(git describe --abbrev=4 $p 2>/dev/null) &&
-- 
1.5.0.rc4.365.g5eff6
