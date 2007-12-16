From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] whitespace: fix config.txt description of indent-with-non-tab
Date: Sat, 15 Dec 2007 22:48:39 -0500
Message-ID: <1197776919-16121-7-git-send-email-bfields@citi.umich.edu>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
 <1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-2-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-4-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-5-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-6-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:49:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kVe-0003KB-0i
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758838AbXLPDs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758696AbXLPDs6
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:48:58 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56283 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758640AbXLPDsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:48:47 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3kUb-0004F9-AI; Sat, 15 Dec 2007 22:48:41 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197776919-16121-6-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68437>

Fix garbled description.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fabe7f8..ce16fc7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -307,7 +307,7 @@ core.whitespace::
   before a tab character in the initial indent part of the line as an
   error (enabled by default).
 * `indent-with-non-tab` treats a line that is indented with 8 or more
-  space characters that can be replaced with tab characters.
+  space characters as an error (not enabled by default).
 
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
-- 
1.5.4.rc0.41.gf723
