From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 2/6] docs: note that status configuration affects only
 long format
Date: Sat, 5 Sep 2009 04:52:18 -0400
Message-ID: <20090905085218.GB13157@coredump.intra.peff.net>
References: <20090905084809.GA13073@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjr0W-00025x-J8
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbZIEIwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbZIEIwT
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:52:19 -0400
Received: from peff.net ([208.65.91.99]:38071 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbZIEIwS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:52:18 -0400
Received: (qmail 26050 invoked by uid 107); 5 Sep 2009 08:52:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 04:52:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:52:18 -0400
Content-Disposition: inline
In-Reply-To: <20090905084809.GA13073@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127800>

The short format does not respect any of the usual status.*
configuration.

Signed-off-by: Jeff King <peff@peff.net>
---
Combined with the --short/--porcelain distinction introduced later in
the series, should short perhaps respect status.relativePaths and
status.submoduleSummary? Which would mean replacing this patch with ones
to make those things work. :)

 Documentation/git-status.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index b5939d6..fd71a7a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -109,13 +109,13 @@ compatibility) and `color.status.<slot>` configuration variables
 to colorize its output.
 
 If the config variable `status.relativePaths` is set to false, then all
-paths shown are relative to the repository root, not to the current
-directory.
+paths shown in the long format are relative to the repository root, not
+to the current directory.
 
 If `status.submodulesummary` is set to a non zero number or true (identical
-to -1 or an unlimited number), the submodule summary will be enabled and a
-summary of commits for modified submodules will be shown (see --summary-limit
-option of linkgit:git-submodule[1]).
+to -1 or an unlimited number), the submodule summary will be enabled for
+the long format and a summary of commits for modified submodules will be
+shown (see --summary-limit option of linkgit:git-submodule[1]).
 
 SEE ALSO
 --------
-- 
1.6.4.2.418.g1a1d3.dirty
