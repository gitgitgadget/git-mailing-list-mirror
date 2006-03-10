From: Mike McCormack <mike@codeweavers.com>
Subject: [PATCH] Document the --attach flag.
Date: Fri, 10 Mar 2006 13:47:24 +0900
Organization: CodeWeavers
Message-ID: <441104DC.10805@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030305010804070009090807"
X-From: git-owner@vger.kernel.org Fri Mar 10 05:51:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHZbQ-0002bB-7X
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 05:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWCJEvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 23:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWCJEvp
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 23:51:45 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:62664 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751101AbWCJEvp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 23:51:45 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FHZbL-0004dC-0w
	for git@vger.kernel.org; Thu, 09 Mar 2006 22:51:44 -0600
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17450>

This is a multi-part message in MIME format.
--------------030305010804070009090807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


---

  Documentation/git-format-patch.txt |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)


--------------030305010804070009090807
Content-Type: text/x-patch;
 name="2dbe606be2d9fadb7d8e84f5fed0d1c4a34377b7.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2dbe606be2d9fadb7d8e84f5fed0d1c4a34377b7.diff"

2dbe606be2d9fadb7d8e84f5fed0d1c4a34377b7
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 7c467c5..bc85a62 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,7 +9,7 @@ git-format-patch - Prepare patches for e
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [-s] [-c]
+'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [-s] [-c]
 		 [--diff-options] <his> [<mine>]
 
 DESCRIPTION
@@ -60,6 +60,9 @@ OPTIONS
 	standard output, instead of saving them into a file per
 	patch and implies --mbox.
 
+--attach::
+	Create attachments instead of inlining patches.
+
 
 EXAMPLES
 --------


--------------030305010804070009090807--
