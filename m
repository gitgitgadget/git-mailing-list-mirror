From: Jeff King <peff@peff.net>
Subject: [PATCH] doc: clarify definition of "update" for git-add -u
Date: Thu, 8 May 2008 13:25:06 -0400
Message-ID: <20080508172506.GA29802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geoffrey Irving <irving@naml.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 19:26:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju9sT-0007IA-Pn
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 19:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642AbYEHRZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 13:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbYEHRZG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 13:25:06 -0400
Received: from peff.net ([208.65.91.99]:2785 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756047AbYEHRZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 13:25:04 -0400
Received: (qmail 8975 invoked by uid 111); 8 May 2008 17:25:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 13:25:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 13:25:06 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81543>

The "-u" option is described only in terms of "updating"
files, which in turn is described only as "similar to what
git commit -a does". Let's be a little more specific about
what updating entails.

Suggested by Geoffrey Irving.

Signed-off-by: Jeff King <peff@peff.net>
---
The wrapping is funny to make the text diff easier to read. Junio, do
you prefer it that way, or in the canonical form?

 Documentation/git-add.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 35e67a0..e2389e3 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -71,7 +71,9 @@ OPTIONS
 	the specified filepatterns before exiting.
 
 -u::
-	Update only files that git already knows about. This is similar
+	Update only files that git already knows about, staging modified
+	content for commit and marking deleted files for removal. This
+	is similar
 	to what "git commit -a" does in preparation for making a commit,
 	except that the update is limited to paths specified on the
 	command line. If no paths are specified, all tracked files in the
-- 
1.5.5.1.274.g7b68b
