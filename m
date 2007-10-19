From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] Documentation/git-gc: explain --auto in description
Date: Thu, 18 Oct 2007 22:01:11 -0400
Message-ID: <20071019020111.GA7711@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Grimm <koreth@midwinter.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:01:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihB2-0005Aw-Ik
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933498AbXJSCBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933421AbXJSCBP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:01:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3549 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932890AbXJSCBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:01:13 -0400
Received: (qmail 7007 invoked by uid 111); 19 Oct 2007 02:01:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 22:01:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 22:01:11 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61598>

Now that git-gc --auto tells the user to look at the man
page, it makes sense to mention the auto behavior near the
top (since this is likely to be most users' first exposure
to git-gc).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-gc.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index b9d5660..83843a5 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -19,7 +19,8 @@ created from prior invocations of gitlink:git-add[1].
 
 Users are encouraged to run this task on a regular basis within
 each repository to maintain good disk space utilization and good
-operating performance.
+operating performance. Some git commands may automatically run
+`git-gc`; see the `--auto` flag below for details.
 
 OPTIONS
 -------
-- 
1.5.3.4.1249.g895be-dirty
