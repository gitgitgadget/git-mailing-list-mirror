From: Jeff King <peff@peff.net>
Subject: [PATCH 5/8] doc/add: reformat `--edit` option
Date: Wed, 13 May 2015 00:58:51 -0400
Message-ID: <20150513045851.GE6821@peff.net>
References: <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 06:59:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOl0-0007f9-MF
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbbEME6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:58:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:57615 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751932AbbEME6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:58:54 -0400
Received: (qmail 1921 invoked by uid 102); 13 May 2015 04:58:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 23:58:54 -0500
Received: (qmail 6957 invoked by uid 107); 13 May 2015 04:58:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:58:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 00:58:51 -0400
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268931>

All of the other options in the list put short and long as
two separate headings.

We can also drop the backslashing of `--`. It isn't used
elsewhere and is unnecessary for modern asciidoc (plus it
confuses asciidoctor).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-add.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index f2eb907..fe5282f 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -93,7 +93,8 @@ This effectively runs `add --interactive`, but bypasses the
 initial command menu and directly jumps to the `patch` subcommand.
 See ``Interactive mode'' for details.
 
--e, \--edit::
+-e::
+--edit::
 	Open the diff vs. the index in an editor and let the user
 	edit it.  After the editor was closed, adjust the hunk headers
 	and apply the patch to the index.
-- 
2.4.0.192.g5f8138b
