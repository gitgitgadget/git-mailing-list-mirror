From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] docs: drop antique comment from Makefile
Date: Wed, 30 May 2012 06:22:58 -0400
Message-ID: <20120530102258.GC13341@sigill.intra.peff.net>
References: <20120530101758.GA13285@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 12:23:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZg3Y-00009l-3v
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 12:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab2E3KXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 06:23:03 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36190
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab2E3KXC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 06:23:02 -0400
Received: (qmail 2930 invoked by uid 107); 30 May 2012 10:23:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 06:23:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 06:22:58 -0400
Content-Disposition: inline
In-Reply-To: <20120530101758.GA13285@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198792>

This comment warns about a bug in asciidoc 6, and points to
a patch from 2005. Since we don't even support versions of
asciidoc that old, we can safely get rid of the warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 030e2c8..eb1b6ad 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -125,15 +125,6 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
 ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
 endif
 
-#
-# Please note that there is a minor bug in asciidoc.
-# The version after 6.0.3 _will_ include the patch found here:
-#   http://marc.theaimsgroup.com/?l=git&m=111558757202243&w=2
-#
-# Until that version is released you may have to apply the patch
-# yourself - yes, all 6 characters of it!
-#
-
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
-- 
1.7.11.rc0.12.g6048c92
