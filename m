From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] Add definition of <commit-ish> to the main git man page.
Date: Mon, 05 Mar 2007 14:46:05 -0500
Message-ID: <E1HOJ8H-0000G9-6Y@candygram.thunk.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOJ8h-0000mh-S8
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 20:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbXCETqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 14:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbXCETqM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 14:46:12 -0500
Received: from THUNK.ORG ([69.25.196.29]:33413 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbXCETqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 14:46:10 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HOJDs-0005nS-I0; Mon, 05 Mar 2007 14:51:52 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HOJ8H-0000G9-6Y; Mon, 05 Mar 2007 14:46:05 -0500
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41478>


Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/git.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0577ad0..e875e83 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -241,6 +241,12 @@ Identifier Terminology
 	operate on a <tree> object but automatically dereferences
 	<commit> and <tag> objects that point at a <tree>.
 
+<commit-ish>::
+	Indicates a commit or tag object name.  A
+	command that takes a <commit-ish> argument ultimately wants to
+	operate on a <commit> object but automatically dereferences
+	<tag> objects that point at a <commit>.
+
 <type>::
 	Indicates that an object type is required.
 	Currently one of: `blob`, `tree`, `commit`, or `tag`.
-- 
1.5.0.1.74.g2470
