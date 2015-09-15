From: Jeff King <peff@peff.net>
Subject: [PATCH 03/67] archive-tar: fix minor indentation violation
Date: Tue, 15 Sep 2015 11:23:40 -0400
Message-ID: <20150915152340.GC29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:23:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbs5E-0006GI-LZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbbIOPXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:23:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:59270 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752546AbbIOPXm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:23:42 -0400
Received: (qmail 11071 invoked by uid 102); 15 Sep 2015 15:23:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:23:42 -0500
Received: (qmail 6753 invoked by uid 107); 15 Sep 2015 15:23:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:23:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:23:40 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277903>

This looks like a simple omission from 8539070 (archive-tar:
unindent write_tar_entry by one level, 2012-05-03).

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index 0d1e6bd..b6b30bb 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -233,7 +233,7 @@ static int write_tar_entry(struct archiver_args *args,
 		size_t rest = pathlen - plen - 1;
 		if (plen > 0 && rest <= sizeof(header.name)) {
 			memcpy(header.prefix, path, plen);
-				memcpy(header.name, path + plen + 1, rest);
+			memcpy(header.name, path + plen + 1, rest);
 		} else {
 			sprintf(header.name, "%s.data",
 				sha1_to_hex(sha1));
-- 
2.6.0.rc2.408.ga2926b9
