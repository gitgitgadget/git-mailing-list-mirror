From: Jeff King <peff@peff.net>
Subject: [PATCH 4/8] doc: fix length of underlined section-title
Date: Wed, 13 May 2015 00:58:29 -0400
Message-ID: <20150513045828.GD6821@peff.net>
References: <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 06:58:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOke-0007Xb-3J
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbbEME6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:58:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:57610 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751072AbbEME6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:58:31 -0400
Received: (qmail 1897 invoked by uid 102); 13 May 2015 04:58:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 23:58:31 -0500
Received: (qmail 6939 invoked by uid 107); 13 May 2015 04:58:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:58:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 00:58:29 -0400
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268930>

In AsciiDoc, it is OK to say:

   this is my title
   -------------------------

but AsciiDoctor is more strict. Let's match the underline to
the title (which also makes the source prettier to read).
The output from AsciiDoc is the same either way.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fast-import.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 690fed3..bf7fbd4 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -600,7 +600,7 @@ be removed from the branch.
 See `filemodify` above for a detailed description of `<path>`.
 
 `filecopy`
-^^^^^^^^^^^^
+^^^^^^^^^^
 Recursively copies an existing file or subdirectory to a different
 location within the branch.  The existing file or directory must
 exist.  If the destination exists it will be completely replaced
-- 
2.4.0.192.g5f8138b
