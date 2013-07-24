From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] docs: fix 'report-status' protocol capability thinko
Date: Wed, 24 Jul 2013 04:01:21 -0400
Message-ID: <20130724080120.GA4425@sigill.intra.peff.net>
References: <20130724080051.GA3890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 10:01:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1u0n-0001hl-7P
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 10:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab3GXIBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 04:01:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:36953 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3GXIBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 04:01:24 -0400
Received: (qmail 23314 invoked by uid 102); 24 Jul 2013 08:01:24 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 03:01:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 04:01:21 -0400
Content-Disposition: inline
In-Reply-To: <20130724080051.GA3890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231084>

The report-status capability is understood by receive-pack,
not upload-pack.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/protocol-capabilities.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index b15517f..11467ff 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -168,7 +168,7 @@ report-status
 report-status
 -------------
 
-The upload-pack process can receive a 'report-status' capability,
+The receive-pack process can receive a 'report-status' capability,
 which tells it that the client wants a report of what happened after
 a packfile upload and reference update.  If the pushing client requests
 this capability, after unpacking and updating references the server
-- 
1.8.3.rc1.30.gff0fb75
