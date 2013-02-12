From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/3] Documentation/Makefile: move infodir to be with other '*dir's
Date: Tue, 12 Feb 2013 20:17:49 +0000
Message-ID: <dcc4f597f26531b79bd9f097c73f6f186b73c81d.1360700102.git.john@keeping.me.uk>
References: <cover.1360700102.git.john@keeping.me.uk>
Cc: Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 21:24:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MPO-0000p0-Dt
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab3BLUYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:24:20 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:47150 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab3BLUYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:24:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 35214161E3CF;
	Tue, 12 Feb 2013 20:18:30 +0000 (GMT)
X-Quarantine-ID: <kZVqniHPXRU5>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZVqniHPXRU5; Tue, 12 Feb 2013 20:18:29 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id CD124161E515;
	Tue, 12 Feb 2013 20:18:22 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1360700102.git.john@keeping.me.uk>
In-Reply-To: <cover.1360700102.git.john@keeping.me.uk>
References: <cover.1360700102.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216191>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index af3d8a4..0cfdc36 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -81,6 +81,7 @@ DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
 htmldir ?= $(prefix)/share/doc/git-doc
+infodir ?= $(prefix)/share/info
 pdfdir ?= $(prefix)/share/doc/git-doc
 mandir ?= $(prefix)/share/man
 man1dir = $(mandir)/man1
@@ -98,7 +99,6 @@ RM ?= rm -f
 MAN_REPO = ../../git-manpages
 HTML_REPO = ../../git-htmldocs
 
-infodir ?= $(prefix)/share/info
 MAKEINFO = makeinfo
 INSTALL_INFO = install-info
 DOCBOOK2X_TEXI = docbook2x-texi
-- 
1.8.1.2
