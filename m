From: Jeff King <peff@peff.net>
Subject: [PATCH] doc/git-daemon: s/uploadarchive/uploadarch/
Date: Mon, 19 May 2008 16:08:33 -0400
Message-ID: <20080519200832.GA23239@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: lionel@over-blog.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 22:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyBgD-0002Bg-LD
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 22:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761185AbYESUIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 16:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761203AbYESUIh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 16:08:37 -0400
Received: from peff.net ([208.65.91.99]:3488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761185AbYESUIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 16:08:35 -0400
Received: (qmail 4005 invoked by uid 111); 19 May 2008 20:08:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 19 May 2008 16:08:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2008 16:08:33 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82443>

The git-daemon upload-archive feature has always used the
config directive 'daemon.uploadarch'; the documentation
which came later seems to have just mistakenly used the
wrong name.

Noticed by lionel@over-blog.com.

Signed-off-by: Jeff King <peff@peff.net>
---
Personally, I think uploadarchive is much more readable, but it is too
late to tweak at this point.

 Documentation/git-daemon.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index fd83bc7..cf261dd 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -174,7 +174,7 @@ upload-pack::
 upload-archive::
 	This serves `git-archive --remote`.  It is disabled by
 	default, but a repository can enable it by setting
-	`daemon.uploadarchive` configuration item to `true`.
+	`daemon.uploadarch` configuration item to `true`.
 
 receive-pack::
 	This serves `git-send-pack` clients, allowing anonymous
@@ -257,7 +257,7 @@ selectively enable/disable services per repository::
 ----------------------------------------------------------------
 	[daemon]
 		uploadpack = false
-		uploadarchive = true
+		uploadarch = true
 ----------------------------------------------------------------
 
 
-- 
1.5.5.1.447.g3a459
