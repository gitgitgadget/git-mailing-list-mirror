From: Toby Corkindale <toby.corkindale@rea-group.com>
Subject: [PATCH] Add notes that some $GIT_DIR/info/ files are not copied by
 clone, etc.
Date: Thu, 27 Mar 2008 15:36:58 +1100
Organization: REA Group
Message-ID: <47EB246A.1030402@rea-group.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030609060206050208000104"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 05:29:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JejkQ-0002Aw-FP
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 05:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbYC0E27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 00:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbYC0E27
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 00:28:59 -0400
Received: from mel-nat68.realestate.com.au ([210.50.192.68]:14909 "EHLO
	mel-nat68.realestate.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976AbYC0E26 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 00:28:58 -0400
Received: from [192.168.53.6] ([192.168.53.6]) by mel-nat68.realestate.com.au with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Mar 2008 15:28:36 +1100
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
X-OriginalArrivalTime: 27 Mar 2008 04:28:36.0276 (UTC) FILETIME=[0609CF40:01C88FC3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78329>

This is a multi-part message in MIME format.
--------------030609060206050208000104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------030609060206050208000104
Content-Type: text/x-patch;
 name="0001-Add-notes-that-GIT_DIR-info-files-are-not-copied-b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Add-notes-that-GIT_DIR-info-files-are-not-copied-b.patc";
 filename*1="h"

---
 Documentation/gitattributes.txt |    4 ++++
 Documentation/gitignore.txt     |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 84ec962..b3b497b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -63,6 +63,10 @@ path in question, and its parent directories (the further the
 directory that contains `.gitattributes` is from the path in
 question, the lower its precedence).
 
+The $GIT_DIR/info/attributes file is used when you wish to only affect certain
+repositories. It will not be copied to other repositories by automatic
+operations such as clone, fetch, etc.
+
 Sometimes you would need to override an setting of an attribute
 for a path to `unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index e847b3b..435f23c 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -34,6 +34,9 @@ precedence, the last matching pattern decides the outcome):
    files generated as part of the project build.
 
  * Patterns read from `$GIT_DIR/info/exclude`.
+ * The $GIT_DIR/info/exclude file is used when you wish to only affect
+   certain repositories. It will not be copied to other repositories by
+   automatic operations such as clone, fetch, etc.
 
  * Patterns read from the file specified by the configuration
    variable 'core.excludesfile'.
-- 
1.5.4.3


--------------030609060206050208000104--
