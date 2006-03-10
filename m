From: Mike McCormack <mike@codeweavers.com>
Subject: [PATCH] Describe how to add extra mail header lines in mail generated
 by git-format-patch.
Date: Fri, 10 Mar 2006 13:47:59 +0900
Organization: CodeWeavers
Message-ID: <441104FF.9010202@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000108080109050204030905"
X-From: git-owner@vger.kernel.org Fri Mar 10 05:52:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHZbz-0002ix-O3
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 05:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWCJEwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 23:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCJEwV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 23:52:21 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:3273 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751333AbWCJEwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 23:52:20 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FHZbu-0004e2-LU
	for git@vger.kernel.org; Thu, 09 Mar 2006 22:52:20 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: git@vger.kernel.org
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17451>

This is a multi-part message in MIME format.
--------------000108080109050204030905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


---

  Documentation/git-format-patch.txt |    9 +++++++++
  1 files changed, 9 insertions(+), 0 deletions(-)


--------------000108080109050204030905
Content-Type: text/x-patch;
 name="38fb623a9fe06cb56f96ee1f25a64d576372f997.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="38fb623a9fe06cb56f96ee1f25a64d576372f997.diff"

38fb623a9fe06cb56f96ee1f25a64d576372f997
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index bc85a62..7cc7faf 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -64,6 +64,15 @@ OPTIONS
 	Create attachments instead of inlining patches.
 
 
+CONFIGURATION
+-------------
+You can specify extra mail header lines to be added to each
+message in the repository configuration as follows:
+
+[format]
+        headers = "Organization: git-foo\n"
+
+
 EXAMPLES
 --------
 


--------------000108080109050204030905--
