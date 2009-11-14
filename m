From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH] Doc: mention the crlf attribute in config autocrlf section
Date: Sat, 14 Nov 2009 11:35:00 -0700
Message-ID: <1258223700-4009-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Nov 14 19:39:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9NWW-0006fz-Uo
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 19:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbZKNSis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 13:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbZKNSis
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 13:38:48 -0500
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:33917 "EHLO
	QMTA01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbZKNSir (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 13:38:47 -0500
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by QMTA01.emeryville.ca.mail.comcast.net with comcast
	id 56YD1d0031HpZEsA16eKFA; Sat, 14 Nov 2009 18:38:19 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA14.emeryville.ca.mail.comcast.net with comcast
	id 56et1d00T5FCJCg8a6etGW; Sat, 14 Nov 2009 18:38:54 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 0D8AC89114;
	Sat, 14 Nov 2009 11:38:52 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132878>

The reverse reference has long existed, and the autocrlf description
was actually obsolete and wrong (saying only file content is used),
not just incomplete.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 Documentation/config.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1e2120..0dc6b12 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -169,9 +169,10 @@ core.autocrlf::
 	writing to the filesystem.  The variable can be set to
 	'input', in which case the conversion happens only while
 	reading from the filesystem but files are written out with
-	`LF` at the end of lines.  Currently, which paths to consider
-	"text" (i.e. be subjected to the autocrlf mechanism) is
-	decided purely based on the contents.
+	`LF` at the end of lines.  A file is considered
+	"text" (i.e. be subjected to the autocrlf mechanism) based on
+	the file's `crlf` attribute, or if `crlf` is unspecified,
+	based on the file's contents.  See linkgit:gitattributes[5]. 
 
 core.safecrlf::
 	If true, makes git check if converting `CRLF` as controlled by
-- 
1.6.4.GIT
