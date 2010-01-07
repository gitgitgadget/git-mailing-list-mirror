From: Nelson Elhage <nelhage@MIT.EDU>
Subject: [PATCH] Documentation: pack-objects: Clarify --local's semantics.
Date: Thu,  7 Jan 2010 17:10:14 -0500
Message-ID: <1262902214-24977-1-git-send-email-nelhage@mit.edu>
Cc: Nelson Elhage <nelhage@mit.edu>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 07 23:15:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0dj-0001T7-Fh
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 23:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab0AGWPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 17:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364Ab0AGWPa
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 17:15:30 -0500
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:65213 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754254Ab0AGWP3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 17:15:29 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2010 17:15:29 EST
X-AuditID: 1209190e-b7b45ae000000c32-c7-4b465bd3a2c4
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU [18.7.7.80])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 44.B6.03122.3DB564B4; Thu,  7 Jan 2010 17:10:28 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id o07M9jGk002579;
	Thu, 7 Jan 2010 17:09:45 -0500 (EST)
Received: from PHANATIQUE.MIT.EDU (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o07MAdDE028177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 7 Jan 2010 17:10:40 -0500 (EST)
X-Mailer: git-send-email 1.6.5.40.g402af7
X-Scanned-By: MIMEDefang 2.42
X-Brightmail-Tracker: AAAAARJXwWM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136397>

The current documentation suggests that --local also ignores any
objects in local packs, which is incorrect. Change the language to be
clearer and more parallel to the other options that ignore objects.

While we're at it, fix a trivial error in --incremental's
documentation.

Signed-off-by: Nelson Elhage <nelhage@mit.edu>
---
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
1.6.5.40.g402af7
