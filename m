From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 13/13] git-notes(1): add a section about the meaning of history
Date: Fri, 12 Mar 2010 18:04:37 +0100
Message-ID: <3ca76d6ba7f58880e6260c9ad4893425d1189787.1268413246.git.trast@student.ethz.ch>
References: <cover.1268413246.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 18:06:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq8JU-00018m-8M
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 18:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758656Ab0CLRFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 12:05:43 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:30419 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758650Ab0CLRFe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 12:05:34 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:27 +0100
Received: from localhost.localdomain (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:13 +0100
X-Mailer: git-send-email 1.7.0.2.417.gbc354
In-Reply-To: <cover.1268413246.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142047>

To the displaying code, the only interesting thing about a notes ref
is that it has a tree of the required format.  However, notes actually
have a history since they are recorded as successive commits.

Make a note about the existence of this history in the manpage, but
keep some doors open if we want to change the details.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Johan Herland <johan@herland.net>
---


 Documentation/git-notes.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 02a2baf..4e5113b 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -121,6 +121,20 @@ OPTIONS
 	GIT_NOTES_REF and the "core.notesRef" configuration.  The ref
 	is taken to be in `refs/notes/` if it is not qualified.
 
+
+NOTES
+-----
+
+Every notes change creates a new commit at the specified notes ref.
+You can therefore inspect the history of the notes by invoking, e.g.,
+`git log -p notes/commits`.
+
+Currently the commit message only records which operation triggered
+the update, and the commit authorship is determined according to the
+usual rules (see linkgit:git-commit[1]).  These details may change in
+the future.
+
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
-- 
1.7.0.2.417.gbc354
