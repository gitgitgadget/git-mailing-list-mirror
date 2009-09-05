From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 1/6] status: typo fix in usage
Date: Sat, 5 Sep 2009 04:50:26 -0400
Message-ID: <20090905085026.GA13157@coredump.intra.peff.net>
References: <20090905084809.GA13073@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:50:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjqyj-0001eW-OP
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbZIEIu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbZIEIu1
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:50:27 -0400
Received: from peff.net ([208.65.91.99]:38064 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbZIEIu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:50:27 -0400
Received: (qmail 26023 invoked by uid 107); 5 Sep 2009 08:50:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 04:50:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:50:26 -0400
Content-Disposition: inline
In-Reply-To: <20090905084809.GA13073@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127799>


Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 6cb0e40..812470e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -975,7 +975,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose),
 		OPT_BOOLEAN('s', "short", &shortstatus,
-			    "show status concicely"),
+			    "show status concisely"),
 		OPT_BOOLEAN('z', "null", &null_termination,
 			    "terminate entries with NUL"),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
-- 
1.6.4.2.418.g1a1d3.dirty
