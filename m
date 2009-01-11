From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] Makefile: clean up TEST_PROGRAMS definition
Date: Sun, 11 Jan 2009 06:25:06 -0500
Message-ID: <20090111112506.GA29791@coredump.intra.peff.net>
References: <20090111112222.GA29656@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Jan 11 12:26:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLySe-0008WF-Uj
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 12:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbZAKLZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 06:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbZAKLZJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 06:25:09 -0500
Received: from peff.net ([208.65.91.99]:53038 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbZAKLZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 06:25:08 -0500
Received: (qmail 22602 invoked by uid 107); 11 Jan 2009 11:25:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Jan 2009 06:25:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Jan 2009 06:25:06 -0500
Content-Disposition: inline
In-Reply-To: <20090111112222.GA29656@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105167>

We try to keep lines under 80 characters, not to mention
that sticking a bunch of stuff on one line makes diffs
messier.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup I noticed while working on 2/4.

 Makefile |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index dee97c1..2b873fa 100644
--- a/Makefile
+++ b/Makefile
@@ -1356,7 +1356,14 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-parse-options$X test-path-utils$X
+TEST_PROGRAMS += test-chmtime$X
+TEST_PROGRAMS += test-date$X
+TEST_PROGRAMS += test-delta$X
+TEST_PROGRAMS += test-genrandom$X
+TEST_PROGRAMS += test-match-trees$X
+TEST_PROGRAMS += test-parse-options$X
+TEST_PROGRAMS += test-path-utils$X
+TEST_PROGRAMS += test-sha1$X
 
 all:: $(TEST_PROGRAMS)
 
-- 
1.6.1.84.g8150
