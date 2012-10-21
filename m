From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Doc notes: Include the format-patch --notes option
Date: Sun, 21 Oct 2012 22:34:09 +0100
Message-ID: <1350855250-2844-3-git-send-email-philipoakley@iee.org>
References: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Blake <eblake@redhat.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 23:34:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ3A8-00069L-Jh
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 23:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab2JUVeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 17:34:09 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:23514 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932576Ab2JUVeI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 17:34:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAFAFlohFBcHlx7/2dsb2JhbABEhSu7ZIEJgiEBBVYWDRAISTkeBhOICLolkk4DpiqCcA
X-IronPort-AV: E=Sophos;i="4.80,626,1344207600"; 
   d="scan'208";a="51202684"
Received: from host-92-30-92-123.as13285.net (HELO localhost) ([92.30.92.123])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 21 Oct 2012 22:34:06 +0100
X-Mailer: git-send-email 1.7.11.msysgit.1
In-Reply-To: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208153>

git format-patch gained a --notes option. Tell the notes user.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-notes.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index b95aafa..46ef046 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -39,6 +39,10 @@ message stored in the commit object, the notes are indented like the
 message, after an unindented line saying "Notes (<refname>):" (or
 "Notes:" for `refs/notes/commits`).
 
+Notes can also be added to patches prepared with `git format-patch` by
+using the `--notes` option. Such notes are added as a patch commentary
+after a three dash separator line.
+
 To change which notes are shown by 'git log', see the
 "notes.displayRef" configuration in linkgit:git-log[1].
 
-- 
1.7.11.msysgit.1
