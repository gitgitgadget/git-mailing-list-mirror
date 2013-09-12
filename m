From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH/RFC] Developer's Certificate of Origin:  default to COPYING
Date: Thu, 12 Sep 2013 18:11:02 -0400
Message-ID: <1379023862-29953-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 13 00:11:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKF6d-0004Jv-Tn
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 00:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab3ILWLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 18:11:15 -0400
Received: from smtp.bbn.com ([128.33.1.81]:38903 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768Ab3ILWLN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 18:11:13 -0400
Received: from socket.bbn.com ([192.1.120.102]:42652)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VKF6T-000Afw-NN; Thu, 12 Sep 2013 18:11:09 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0394D40093
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234705>

The "Developer's Certificate of Origin" refers to "the open source
license indicated in the file", but there is no such indication in
most files in the Git repository.

Update the text to indicate that the license in COPYING should be
assumed if a file doesn't excplicitly indicate which license applies
to the file.

The phrase "accompanies the file" was chosen to support different
default licenses in different subdirectories (e.g., 2-clause BSD for
vcs-svn/*, LGPL2.1+ for xdiff/*).

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
I'm bringing this up because, to this layman's eyes, it seems like a
potentially troublesome oversight.  IIUC, one of the purposes of the
Developer's Certificate of Origin is to make it easy for developers to
declare which license covers a contribution.  Requiring a license
declaration protects the project and its users from copyright
litigation.

What happens if the file(s) being modified do not indicate which
license applies to the file?  Is there no license?  Does it default to
the main project license in COPYING?  This lack of clarity makes me a
bit nervous (law is already too nondeterministic for my liking), so
I'd like to see a change that makes it explicit.

Notes:
  * I am not a lawyer.  (Maybe a lawyer should be consulted?)
  * This change might not be necessary.
  * This change might be wrong.
  * I hope I'm not just wasting everyone's time by bringing this up.

 Documentation/SubmittingPatches | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 7055576..c5ff744 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -227,13 +227,15 @@ the patch, which certifies that you wrote it or otherwise have
 the right to pass it on as a open-source patch.  The rules are
 pretty simple: if you can certify the below:
 
-        Developer's Certificate of Origin 1.1
+        Developer's Certificate of Origin 1.2
 
         By making a contribution to this project, I certify that:
 
         (a) The contribution was created in whole or in part by me and I
             have the right to submit it under the open source license
-            indicated in the file; or
+            indicated in the file (or, if no license is indicated in
+            the file, the license in COPYING that accompanies the
+            file); or
 
         (b) The contribution is based upon previous work that, to the best
             of my knowledge, is covered under an appropriate open source
@@ -241,7 +243,8 @@ pretty simple: if you can certify the below:
             work with modifications, whether created in whole or in part
             by me, under the same open source license (unless I am
             permitted to submit under a different license), as indicated
-            in the file; or
+            in the file (or, if no license is indicated in the file,
+            the license in COPYING that accompanies the file); or
 
         (c) The contribution was provided directly to me by some other
             person who certified (a), (b) or (c) and I have not modified
-- 
1.8.4
