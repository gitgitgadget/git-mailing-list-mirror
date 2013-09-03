From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 07/11] Documentation/replace: tell that -f option bypasses
 the type check
Date: Tue, 03 Sep 2013 09:10:21 +0200
Message-ID: <20130903071026.29838.52710.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:17:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGks5-0008IL-Gc
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab3ICHRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:17:46 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:53251 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932528Ab3ICHRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:17:20 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 4CADC5D;
	Tue,  3 Sep 2013 09:17:19 +0200 (CEST)
X-git-sha1: ad7e7001abdd0f0d8740047d503f5500f44a1b58 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233697>

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
