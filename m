From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Doc User-Manual: Patch cover letter, three dashes, and --notes
Date: Sun, 21 Oct 2012 22:34:08 +0100
Message-ID: <1350855250-2844-2-git-send-email-philipoakley@iee.org>
References: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Blake <eblake@redhat.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 23:34:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ3A9-00069L-2O
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 23:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab2JUVeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 17:34:09 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:31540 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932569Ab2JUVeI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 17:34:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAFAFlohFBcHlx7/2dsb2JhbABEhSu7ZIEJgiEBBVYjEAhJOR4GE4gIuiWLeYZVA6YqgnCBYg
X-IronPort-AV: E=Sophos;i="4.80,626,1344207600"; 
   d="scan'208";a="51202681"
Received: from host-92-30-92-123.as13285.net (HELO localhost) ([92.30.92.123])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 21 Oct 2012 22:34:05 +0100
X-Mailer: git-send-email 1.7.11.msysgit.1
In-Reply-To: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208154>

Show that git format-patch can have a cover letter, include patch
commentary below the three dashes, and notes can also be
included.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/user-manual.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 85651b5..d918c53 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1787,6 +1787,11 @@ $ git format-patch origin
 will produce a numbered series of files in the current directory, one
 for each patch in the current branch but not in origin/HEAD.
 
+`git format-patch` can include an initial "cover letter". You can insert
+a commentary on individual patches using a three dash line after the
+commit message, and before the patch itself. `git format-patch --notes`
+(v1.8.1) will include the commit's notes in the similar manner.
+
 You can then import these into your mail client and send them by
 hand.  However, if you have a lot to send at once, you may prefer to
 use the linkgit:git-send-email[1] script to automate the process.
-- 
1.7.11.msysgit.1
