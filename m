From: Jeff King <peff@peff.net>
Subject: [PATCH] fetch: document that pruning happens before fetching
Date: Mon, 13 Jun 2016 19:58:51 -0400
Message-ID: <20160613235850.GA8009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 01:58:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCbkx-0005dP-5U
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 01:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbcFMX6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 19:58:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:54310 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422736AbcFMX6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 19:58:54 -0400
Received: (qmail 24653 invoked by uid 102); 13 Jun 2016 23:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 19:58:53 -0400
Received: (qmail 22970 invoked by uid 107); 13 Jun 2016 23:59:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 19:59:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 19:58:51 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297259>

This was changed in 10a6cc8 (fetch --prune: Run prune before
fetching, 2014-01-02), but it seems that nobody in that
discussion realized we were advertising the "after"
explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
I include myself in that "nobody" of course. :)

 Documentation/fetch-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 036edfb..b05a834 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -52,7 +52,7 @@ ifndef::git-pull[]
 
 -p::
 --prune::
-	After fetching, remove any remote-tracking references that no
+	Before fetching, remove any remote-tracking references that no
 	longer exist on the remote.  Tags are not subject to pruning
 	if they are fetched only because of the default tag
 	auto-following or due to a --tags option.  However, if tags
-- 
2.9.0.150.g8bd4cf6
