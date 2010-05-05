From: Leif Arne Storset <lstorset@opera.com>
Subject: [PATCH] Documentation/config.txt: GIT_NOTES_REWRITE_REF overrides notes.rewriteRef
Date: Wed,  5 May 2010 16:16:25 +0200
Message-ID: <1273068985-25380-1-git-send-email-lstorset@opera.com>
References: <201005051600.03446.trast@student.ethz.ch>
Cc: Leif Arne Storset <lstorset@opera.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 05 16:20:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9fSc-0002zB-0u
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 16:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760247Ab0EEOUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 10:20:20 -0400
Received: from smtp.opera.com ([213.236.208.81]:40594 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755321Ab0EEOUU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 10:20:20 -0400
Received: from nynorsk.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o45EHp6n027660;
	Wed, 5 May 2010 14:17:51 GMT
X-Mailer: git-send-email 1.7.1
In-Reply-To: <201005051600.03446.trast@student.ethz.ch>
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146398>

The documentation erroneously mentions the GIT_NOTES_REWRITE_REF
override in the description of notes.rewrite.<command>.  Move it
under notes.rewriteRef where it belongs.

Signed-off-by: Leif Arne Storset <lstorset@opera.com>
Acked-by: Thomas Rast <trast@student.ethz.ch>
---
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
