From: Jeff King <peff@peff.net>
Subject: [PATCH] relnotes: minor tweaks to 1.7.6 release notes
Date: Wed, 1 Jun 2011 22:28:04 -0400
Message-ID: <20110602022804.GA15955@sigill.intra.peff.net>
References: <7v39jtf93i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 04:28:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRxdw-0002QA-67
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 04:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759246Ab1FBC2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 22:28:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36529
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758966Ab1FBC2I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 22:28:08 -0400
Received: (qmail 21061 invoked by uid 107); 2 Jun 2011 02:28:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 22:28:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 22:28:04 -0400
Content-Disposition: inline
In-Reply-To: <7v39jtf93i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174921>

A topic worth mentioning, and an unrelated typo fix.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/RelNotes/1.7.6.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes/1.7.6.txt b/Documentation/RelNotes/1.7.6.txt
index 6ab3252..2e52815 100644
--- a/Documentation/RelNotes/1.7.6.txt
+++ b/Documentation/RelNotes/1.7.6.txt
@@ -48,7 +48,7 @@ Updates since v1.7.5
    easier to parse.
 
  * Aborting "git commit --interactive" discards updates to the index
-   made during the interctive session.
+   made during the interactive session.
 
  * "git commit" learned a "--patch" option to directly jump to the
    per-hunk selection UI of the interactive mode.
@@ -114,6 +114,9 @@ Updates since v1.7.5
    still in a conflicted state during a merge, to avoid using information
    that is not final and possibly corrupt with conflict markers.
 
+ * "git revert" learned to revert root commits. "git cherry-pick"
+   can now handle root commits using external merge strategies.
+
 Also contains various documentation updates and minor miscellaneous
 changes.
 
-- 
1.7.6.rc0.2.g2582
