From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] diff_filespec: drop funcname_pattern_ident field
Date: Thu, 16 Jan 2014 20:20:11 -0500
Message-ID: <20140117012011.GB7249@sigill.intra.peff.net>
References: <20140117011844.GA6870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 02:20:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3y6b-0000Ln-OX
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 02:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbaAQBUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 20:20:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:33880 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750937AbaAQBUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 20:20:13 -0500
Received: (qmail 5928 invoked by uid 102); 17 Jan 2014 01:20:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 19:20:13 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 20:20:11 -0500
Content-Disposition: inline
In-Reply-To: <20140117011844.GA6870@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240552>

This struct field was obsoleted by be58e70 (diff: unify
external diff and funcname parsing code, 2008-10-05), but we
forgot to remove it.

Signed-off-by: Jeff King <peff@peff.net>
---
8 bytes of our size savings come here...

 diffcore.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/diffcore.h b/diffcore.h
index f822f9e..92e4d48 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -29,7 +29,6 @@ struct diff_filespec {
 	char *path;
 	void *data;
 	void *cnt_data;
-	const char *funcname_pattern_ident;
 	unsigned long size;
 	int count;               /* Reference count */
 	int xfrm_flags;		 /* for use by the xfrm */
-- 
1.8.5.2.500.g8060133
