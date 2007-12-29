From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-sh-setup: document git_editor() and get_author_ident_from_commit()
Date: Sat, 29 Dec 2007 01:55:39 +0100
Message-ID: <1198889739-10742-1-git-send-email-vmiklos@frugalware.org>
References: <7vlk7ecp58.fsf@gitster.siamese.dyndns.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 01:56:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8Q07-0007pa-4s
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 01:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbXL2A4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 19:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbXL2A4E
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 19:56:04 -0500
Received: from virgo.iok.hu ([193.202.89.103]:30749 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbXL2A4E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 19:56:04 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0A1231B253E;
	Sat, 29 Dec 2007 01:56:02 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id DE852541E3;
	Sat, 29 Dec 2007 01:54:32 +0100 (CET)
Received: from vmobile.example.net (dsl5401CF16.pool.t-online.hu [84.1.207.22])
	by genesis.frugalware.org (Postfix) with ESMTP id D501C176C03D;
	Sat, 29 Dec 2007 01:55:59 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 47F8A186C1F; Sat, 29 Dec 2007 01:55:39 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc2-dirty
In-Reply-To: <7vlk7ecp58.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69305>

These 2 functions were missing from the manpage.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Dec 28, 2007 at 04:37:07PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> unusable, so I'd reword it like this:

here it is.

VMiklos

 Documentation/git-sh-setup.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 1ea1faa..505b4c9 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -44,6 +44,11 @@ set_reflog_action::
 	end-user action in the reflog, when the script updates a
 	ref.
 
+git_editor::
+	runs an editor of user's choice (GIT_EDITOR, core.editor, VISUAL or
+	EDITOR) on a given file, but error out if no editor is specified
+	and the terminal is dumb.
+
 is_bare_repository::
 	outputs `true` or `false` to the standard output stream
 	to indicate if the repository is a bare repository
@@ -57,6 +62,10 @@ require_work_tree::
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
