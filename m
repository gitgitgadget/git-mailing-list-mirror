From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH 1/4] Minor grammatical fixes in "git log" man page
Date: Fri,  8 Nov 2013 19:32:07 -0500
Message-ID: <1383957130-2979-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 09 01:47:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vewhr-0001oH-46
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 01:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab3KIAq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 19:46:59 -0500
Received: from mailhub129.itcs.purdue.edu ([128.210.5.129]:43049 "EHLO
	mailhub129.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752445Ab3KIAq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Nov 2013 19:46:58 -0500
X-Greylist: delayed 782 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2013 19:46:58 EST
Received: from megahurtz.itap.purdue.edu (pal-nat184-053-008.itap.purdue.edu [10.184.53.8])
	(authenticated bits=0)
	by mailhub129.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rA90Xn8S006474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 Nov 2013 19:33:55 -0500
X-Mailer: git-send-email 1.8.4.2
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237476>

git-log.txt: grammatical fixes under --log-size option

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
 Documentation/git-log.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 34097ef..243a9c5 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -56,10 +56,10 @@ Note that this affects all diff-based output types, e.g. those
 produced by --stat etc.
 
 --log-size::
-	Before the log message print out its size in bytes. Intended
+	Before the log message, print out its size in bytes. Intended
 	mainly for porcelain tools consumption. If Git is unable to
-	produce a valid value size is set to zero.
-	Note that only message is considered, if also a diff is shown
+	produce a valid value size, this is set to zero.
+	Note that only message is considered. Also, if a diff is shown,
 	its size is not included.
 
 -L <start>,<end>:<file>::
-- 
1.8.4.2
