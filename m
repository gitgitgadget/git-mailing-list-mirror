From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] INSTALL: update asciidoc recommendation
Date: Wed, 30 May 2012 06:18:29 -0400
Message-ID: <20120530101829.GA13341@sigill.intra.peff.net>
References: <20120530101758.GA13285@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 12:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZfzB-000608-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 12:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab2E3KSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 06:18:33 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36171
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab2E3KSd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 06:18:33 -0400
Received: (qmail 2851 invoked by uid 107); 30 May 2012 10:18:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 06:18:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 06:18:29 -0400
Content-Disposition: inline
In-Reply-To: <20120530101758.GA13285@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198790>

Since commit 6cf378f (docs: stop using asciidoc no-inline-literal),
we no longer support asciidoc versions less than 8.4.1,
which introduced inline literals. Note this in the INSTALL
document.

Signed-off-by: Jeff King <peff@peff.net>
---
 INSTALL | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/INSTALL b/INSTALL
index 87e03bb..28f34bd 100644
--- a/INSTALL
+++ b/INSTALL
@@ -161,11 +161,9 @@ Issues of note:
    makeinfo and docbook2X.  Version 0.8.3 is known to work.
 
    Building and installing the pdf file additionally requires
-   dblatex.  Version 0.2.7 with asciidoc >= 8.2.7 is known to work.
+   dblatex.  Version >= 0.2.7 is known to work.
 
-   The documentation is written for AsciiDoc 7, but by default
-   uses some compatibility wrappers to work on AsciiDoc 8. If you have
-   AsciiDoc 7, try "make ASCIIDOC7=YesPlease".
+   All formats require at least asciidoc 8.4.1.
 
    There are also "make quick-install-doc", "make quick-install-man"
    and "make quick-install-html" which install preformatted man pages
-- 
1.7.11.rc0.12.g6048c92
