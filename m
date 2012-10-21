From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Doc SubmittingPatches: Mention --notes option after "cover letter"
Date: Sun, 21 Oct 2012 22:34:07 +0100
Message-ID: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Blake <eblake@redhat.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 23:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ3AJ-0006Ed-Bc
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 23:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618Ab2JUVeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 17:34:17 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:2161 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932608Ab2JUVeJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 17:34:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAPRohFBcHlx7/2dsb2JhbABEhSu7ZIEJgiABXCMYGGokE4gIuiSLaBGGVQOmKoJwgVkJFw
X-IronPort-AV: E=Sophos;i="4.80,626,1344207600"; 
   d="scan'208";a="388300766"
Received: from host-92-30-92-123.as13285.net (HELO localhost) ([92.30.92.123])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 21 Oct 2012 22:34:05 +0100
X-Mailer: git-send-email 1.7.11.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208156>

The git format-patch --notes option can now insert the commit notes
after the three dashes. Mention this after the regular cover letter
guidance for submitting patches.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/SubmittingPatches | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 0dbf2c9..3d8b2fe 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -179,7 +179,8 @@ message starts, you can put a "From: " line to name that person.
 
 You often want to add additional explanation about the patch,
 other than the commit message itself.  Place such "cover letter"
-material between the three dash lines and the diffstat.
+material between the three dash lines and the diffstat. Git-notes
+can also be inserted using the `--notes` option.
 
 Do not attach the patch as a MIME attachment, compressed or not.
 Do not let your e-mail client send quoted-printable.  Do not let
-- 
1.7.11.msysgit.1
