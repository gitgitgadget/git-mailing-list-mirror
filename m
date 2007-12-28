From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-sh-setup: document git_editor() and get_author_ident_from_commit()
Date: Fri, 28 Dec 2007 23:25:39 +0100
Message-ID: <1198880739-8480-1-git-send-email-vmiklos@frugalware.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 23:26:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8Neo-0003nw-Gd
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 23:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbXL1WZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 17:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbXL1WZz
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 17:25:55 -0500
Received: from virgo.iok.hu ([193.202.89.103]:30418 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbXL1WZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 17:25:55 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1D4091B2510;
	Fri, 28 Dec 2007 23:25:54 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 742B6541E4;
	Fri, 28 Dec 2007 23:24:26 +0100 (CET)
Received: from vmobile.example.net (dsl5401C7EF.pool.t-online.hu [84.1.199.239])
	by genesis.frugalware.org (Postfix) with ESMTP id 8F483176C03D;
	Fri, 28 Dec 2007 23:25:53 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 02495186C1F; Fri, 28 Dec 2007 23:25:39 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc2-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69300>

These 2 functions were missing from the manpage.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-sh-setup.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 1ea1faa..fd024d7 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -44,6 +44,10 @@ set_reflog_action::
 	end-user action in the reflog, when the script updates a
 	ref.
 
+git_editor::
+	runs the proper editor based on GIT_EDITOR, core.editor, VISUAL or
+	EDITOR.
+
 is_bare_repository::
 	outputs `true` or `false` to the standard output stream
 	to indicate if the repository is a bare repository
@@ -57,6 +61,10 @@ require_work_tree::
 	if so.  Used by scripts that require working tree
 	(e.g. `checkout`).
 
+get_author_ident_from_commit::
+	outputs code for use with eval to set the GIT_AUTHOR_NAME,
+	GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE variables for a given commit.
+
 
 Author
 ------
-- 
1.5.4.rc2-dirty
