From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] Documentation: use single-parameter --cacheinfo in example
Date: Thu, 11 Sep 2014 17:19:51 +0200
Message-ID: <1410448791-31514-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 17:20:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS6AZ-00070h-7z
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 17:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbaIKPUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 11:20:17 -0400
Received: from mailer.zib.de ([130.73.108.11]:53398 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbaIKPUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 11:20:16 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s8BFKCGp001810;
	Thu, 11 Sep 2014 17:20:12 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s8BFKBEd019339;
	Thu, 11 Sep 2014 17:20:11 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
X-Miltered: at mailer.zib.de with ID 5411BDAC.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5411BDAC.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 5411BDAC.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256848>

The single-parameter form is described as the preferred way.  Separate
arguments are only supported for backward compatibility.  Update the
example to the recommended form.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-update-index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index dfc09d9..82eca6f 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -202,7 +202,7 @@ merging.
 To pretend you have a file with mode and sha1 at path, say:
 
 ----------------
-$ git update-index --cacheinfo mode sha1 path
+$ git update-index --cacheinfo <mode>,<sha1>,<path>
 ----------------
 
 '--info-only' is used to register files without placing them in the object
-- 
2.1.0.137.gbf198b9
