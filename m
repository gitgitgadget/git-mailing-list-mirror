From: Leif Arne Storset <lstorset@opera.com>
Subject: [PATCH] Documentation/config.txt: Move GIT_NOTES_REWRITE_REF to notes.rewriteRef
Date: Wed,  5 May 2010 15:35:16 +0200
Message-ID: <1273066516-24469-1-git-send-email-lstorset@opera.com>
Cc: Leif Arne Storset <lstorset@opera.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 05 15:50:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9ezc-0001wO-1o
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 15:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760178Ab0EENtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 09:49:51 -0400
Received: from smtp.opera.com ([213.236.208.81]:42204 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760171Ab0EENtr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 09:49:47 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 May 2010 09:49:47 EDT
Received: from nynorsk.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o45Dcs42025937;
	Wed, 5 May 2010 13:38:54 GMT
X-Mailer: git-send-email 1.7.1
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146393>

Was notes.rewrite. The environment variable refers to globs and refs, which are only mentioned by notes.rewriteRef; notes.rewrite is boolean.

Signed-off-by: Leif Arne Storset <lstorset@opera.com>
---
This should be a trivial fix.

 Documentation/config.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92f851e..8f86050 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1359,10 +1359,6 @@ notes.rewrite.<command>::
 	automatically copies your notes from the original to the
 	rewritten commit.  Defaults to `true`, but see
 	"notes.rewriteRef" below.
-+
-This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
-environment variable, which must be a colon separated list of refs or
-globs.
 
 notes.rewriteMode::
 	When copying notes during a rewrite (see the
@@ -1382,6 +1378,10 @@ notes.rewriteRef::
 +
 Does not have a default value; you must configure this variable to
 enable note rewriting.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
+environment variable, which must be a colon separated list of refs or
+globs.
 
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
-- 
1.7.1
