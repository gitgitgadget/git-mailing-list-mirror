From: Jeff King <peff@peff.net>
Subject: [PATCH] git-branch: remove mention of non-existent '-b' option
Date: Sun, 11 Nov 2007 23:07:05 -0500
Message-ID: <20071112040704.GA12550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 05:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrQaC-0006mr-C1
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 05:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbXKLEHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 23:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754341AbXKLEHM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 23:07:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1818 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbXKLEHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 23:07:11 -0500
Received: (qmail 4520 invoked by uid 111); 12 Nov 2007 04:07:09 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 11 Nov 2007 23:07:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 23:07:05 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64556>

This looks like a cut and paste error from the git-checkout
explanation of --no-track.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 5e81aa4..5ce905d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -105,7 +105,7 @@ OPTIONS
 	'--track' were given.
 
 --no-track::
-	When -b is given and a branch is created off a remote branch,
+	When a branch is created off a remote branch,
 	set up configuration so that git-pull will not retrieve data
 	from the remote branch, ignoring the branch.autosetupmerge
 	configuration variable.
-- 
1.5.3.5.1664.gcd60
