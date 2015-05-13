From: Jeff King <peff@peff.net>
Subject: [PATCH 3/8] doc: fix hanging "+"-continuation
Date: Wed, 13 May 2015 00:58:16 -0400
Message-ID: <20150513045816.GC6821@peff.net>
References: <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 06:58:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOkR-0007UN-7d
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbbEME6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:58:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:57605 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750787AbbEME6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:58:18 -0400
Received: (qmail 1831 invoked by uid 102); 13 May 2015 04:58:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 23:58:19 -0500
Received: (qmail 6920 invoked by uid 107); 13 May 2015 04:58:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:58:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 00:58:16 -0400
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268929>

In list content that wants to continue to a second
paragraph, the "+" continuation and subsequent paragraph
need to be left-aligned. Otherwise AsciiDoc seems to insert
only a linebreak.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-svn.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 39e9a18..1377008 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -279,9 +279,9 @@ first have already been pushed into SVN.
 	Ask the user to confirm that a patch set should actually be sent to SVN.
 	For each patch, one may answer "yes" (accept this patch), "no" (discard this
 	patch), "all" (accept all patches), or "quit".
-	+
-	'git svn dcommit' returns immediately if answer is "no" or "quit", without
-	committing anything to SVN.
++
+'git svn dcommit' returns immediately if answer is "no" or "quit", without
+committing anything to SVN.
 
 'branch'::
 	Create a branch in the SVN repository.
-- 
2.4.0.192.g5f8138b
