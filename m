From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] cat-file: minor style fix in options list
Date: Mon, 22 Jun 2015 06:40:56 -0400
Message-ID: <20150622104056.GB14475@peff.net>
References: <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:41:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6zA0-00045J-6I
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 12:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbbFVKk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 06:40:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:49762 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752544AbbFVKk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 06:40:59 -0400
Received: (qmail 17198 invoked by uid 102); 22 Jun 2015 10:40:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 05:40:59 -0500
Received: (qmail 7459 invoked by uid 107); 22 Jun 2015 10:40:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:40:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 06:40:56 -0400
Content-Disposition: inline
In-Reply-To: <20150622103321.GB12584@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272325>

We do not put extra whitespace before the first macro
argument.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 049a95f..6cbcccc 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -412,7 +412,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_CMDMODE(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
-		OPT_BOOL( 0, "allow-unknown-type", &unknown_type,
+		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
-- 
2.4.4.719.g3984bc6
