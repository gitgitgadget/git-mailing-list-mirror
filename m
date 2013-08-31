From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 07/11] Documentation/replace: tell that -f option bypasses
 the type check
Date: Sat, 31 Aug 2013 21:12:10 +0200
Message-ID: <20130831191215.26699.720.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:14:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqcV-0001Jf-JI
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab3HaTNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:13:49 -0400
Received: from [194.158.98.15] ([194.158.98.15]:48173 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752603Ab3HaTNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:13:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 4FD5C77;
	Sat, 31 Aug 2013 21:12:54 +0200 (CEST)
X-git-sha1: ad7e7001abdd0f0d8740047d503f5500f44a1b58 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233542>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 736b48c..a2bd2ee 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -21,10 +21,12 @@ replaced. The content of the 'replace' reference is the SHA-1 of the
 replacement object.
 
 The replaced object and the replacement object must be of the same type.
-There is no other restriction on them.
+This restriction can be bypassed using `-f`.
 
 Unless `-f` is given, the 'replace' reference must not yet exist.
 
+There is no other restriction on the replaced and replacement objects.
+
 Replacement references will be used by default by all Git commands
 except those doing reachability traversal (prune, pack transfer and
 fsck).
-- 
1.8.4.rc1.31.g530f5ce.dirty
