From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] document "intent to add" option to git-add
Date: Mon, 20 Oct 2008 20:36:25 -0400
Message-ID: <20081021003625.GA32569@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 02:37:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks5Fm-0001Fd-Ga
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 02:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbYJUAg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 20:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbYJUAg3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 20:36:29 -0400
Received: from peff.net ([208.65.91.99]:3208 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbYJUAg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 20:36:29 -0400
Received: (qmail 17042 invoked by uid 111); 21 Oct 2008 00:36:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 20:36:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 20:36:25 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98749>

This was added by 3942581 but never documented.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-add.txt |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 2b6d6c8..6fc20b0 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--all | [--update | -u]] [--refresh] [--ignore-errors] [--]
-	  <filepattern>...
+	  [--all | [--update | -u]] [--intent-to-add | -N]
+	  [--refresh] [--ignore-errors] [--] <filepattern>...
 
 DESCRIPTION
 -----------
@@ -92,6 +92,15 @@ OPTIONS
 	and add all untracked files that are not ignored by '.gitignore'
 	mechanism.
 
+
+-N::
+--intent-to-add::
+	Record only the fact that the path will be added later. An entry
+	for the path is placed in the index with no content. This is
+	useful for, among other things, showing the unstaged content of
+	such files with 'git diff' and commiting them with 'git commit
+	-a'.
+
 --refresh::
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
-- 
1.6.0.2.770.gb4241.dirty
