From: Nelson Elhage <nelhage@MIT.EDU>
Subject: [PATCH resend] Documentation: pack-objects: Clarify --local's semantics.
Date: Thu, 18 Feb 2010 22:29:30 -0500
Message-ID: <1266550170-17013-1-git-send-email-nelhage@mit.edu>
Cc: git@vger.kernel.org, Nelson Elhage <nelhage@mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 04:34:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiJdc-0005NT-2M
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 04:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0BSDei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 22:34:38 -0500
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:60426 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754272Ab0BSDei (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 22:34:38 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2010 22:34:37 EST
X-AuditID: 1209190c-b7cfcae00000096b-47-4b7e059ff201
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 20.8B.02411.F950E7B4; Thu, 18 Feb 2010 22:29:35 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o1J3TZp0002893;
	Thu, 18 Feb 2010 22:29:35 -0500
Received: from PHANATIQUE.MIT.EDU (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o1J3TsaZ025180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 18 Feb 2010 22:29:55 -0500 (EST)
X-Mailer: git-send-email 1.6.6.30.g1e6fd
X-Brightmail-Tracker: AAAAARLva3Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140403>

The current documentation suggests that --local also ignores any
objects in local packs, which is incorrect. Change the language to be
clearer and more parallel to the other options that ignore objects.

While we're at it, fix a trivial error in --incremental's
documentation.

Signed-off-by: Nelson Elhage <nelhage@mit.edu>
---
 This is an unmodified resend of a patch I sent about a month ago
 which received no response.

 Documentation/git-pack-objects.txt |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index f54d433..d8e5686 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -117,14 +117,13 @@ base-name::
 	standard input.
 
 --incremental::
-	This flag causes an object already in a pack ignored
+	This flag causes an object already in a pack to be ignored
 	even if it appears in the standard input.
 
 --local::
-	This flag is similar to `--incremental`; instead of
-	ignoring all packed objects, it only ignores objects
-	that are packed and/or not in the local object store
-	(i.e. borrowed from an alternate).
+	This flag causes an object that is borrowed from an alternate
+	object store to be ignored even if it appears in the standard
+	input.
 
 --non-empty::
         Only create a packed archive if it would contain at
-- 
1.6.6.30.g1e6fd
