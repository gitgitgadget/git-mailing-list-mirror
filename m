From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Doc format-patch: clarify --notes use case
Date: Sun, 21 Oct 2012 22:34:10 +0100
Message-ID: <1350855250-2844-4-git-send-email-philipoakley@iee.org>
References: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Blake <eblake@redhat.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 23:34:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ3AI-0006Ed-St
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 23:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616Ab2JUVeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 17:34:16 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:31540 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932582Ab2JUVeI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 17:34:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAFAFlohFBcHlx7/2dsb2JhbABEhSu7ZIEJgiEBBVYjEAhJOR4GE4gIuiWSTgOmKoJwgWI
X-IronPort-AV: E=Sophos;i="4.80,626,1344207600"; 
   d="scan'208";a="51202686"
Received: from host-92-30-92-123.as13285.net (HELO localhost) ([92.30.92.123])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 21 Oct 2012 22:34:06 +0100
X-Mailer: git-send-email 1.7.11.msysgit.1
In-Reply-To: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208155>

Remove double negative, and include the repeat usage across
versions of a patch series.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-format-patch.txt | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 066dc8b..751009c 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -196,13 +196,10 @@ will want to ensure that threading is disabled for `git send-email`.
 	after the three-dash line.
 +
 The expected use case of this is to write supporting explanation for
-the commit that does not belong to the commit log message proper
-when (or after) you create the commit, and include it in your patch
-submission.  But if you can plan ahead and write it down, there may
-not be a good reason not to write it in your commit message, and if
-you can't, you can always edit the output of format-patch before
-sending it out, so the practical value of this option is somewhat
-dubious, unless your workflow is broken.
+the commit, that does not belong to the commit log message proper,
+and include it with the patch submission. The notes can be maintained
+between versions of the patch series. You can also edit the output of
+format-patch before sending.
 
 --[no]-signature=<signature>::
 	Add a signature to each message produced. Per RFC 3676 the signature
-- 
1.7.11.msysgit.1
