From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/3] Documentation/Makefile: fix spaces around assignments
Date: Tue, 12 Feb 2013 20:17:48 +0000
Message-ID: <48645e424b932536e8cd877962a29b9cfa8bdebd.1360700102.git.john@keeping.me.uk>
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
	id 1U5MPN-0000p0-TA
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab3BLUYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:24:19 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:47149 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab3BLUYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:24:18 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2013 15:24:18 EST
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 38DF6161E510;
	Tue, 12 Feb 2013 20:18:23 +0000 (GMT)
X-Quarantine-ID: <kw-2+Qd7Ndzy>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kw-2+Qd7Ndzy; Tue, 12 Feb 2013 20:18:20 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id B1E68161E4EA;
	Tue, 12 Feb 2013 20:18:13 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1360700102.git.john@keeping.me.uk>
In-Reply-To: <cover.1360700102.git.john@keeping.me.uk>
References: <cover.1360700102.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216190>

A simple style fix; no functional change.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/Makefile | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 62dbd9a..af3d8a4 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -31,11 +31,11 @@ MAN7_TXT += gittutorial.txt
 MAN7_TXT += gitworkflows.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
-MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
-MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
+MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
+MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
 
 OBSOLETE_HTML = git-remote-helpers.html
-DOC_HTML=$(MAN_HTML) $(OBSOLETE_HTML)
+DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
 
 ARTICLES = howto-index
 ARTICLES += everyday
@@ -74,35 +74,35 @@ SP_ARTICLES += technical/api-index
 
 DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
 
-DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
-DOC_MAN5=$(patsubst %.txt,%.5,$(MAN5_TXT))
-DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
+DOC_MAN1 = $(patsubst %.txt,%.1,$(MAN1_TXT))
+DOC_MAN5 = $(patsubst %.txt,%.5,$(MAN5_TXT))
+DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
 
-prefix?=$(HOME)
-bindir?=$(prefix)/bin
-htmldir?=$(prefix)/share/doc/git-doc
-pdfdir?=$(prefix)/share/doc/git-doc
-mandir?=$(prefix)/share/man
-man1dir=$(mandir)/man1
-man5dir=$(mandir)/man5
-man7dir=$(mandir)/man7
-# DESTDIR=
+prefix ?= $(HOME)
+bindir ?= $(prefix)/bin
+htmldir ?= $(prefix)/share/doc/git-doc
+pdfdir ?= $(prefix)/share/doc/git-doc
+mandir ?= $(prefix)/share/man
+man1dir = $(mandir)/man1
+man5dir = $(mandir)/man5
+man7dir = $(mandir)/man7
+# DESTDIR =
 
 ASCIIDOC = asciidoc
 ASCIIDOC_EXTRA =
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO = xmlto
 XMLTO_EXTRA =
-INSTALL?=install
+INSTALL ?= install
 RM ?= rm -f
 MAN_REPO = ../../git-manpages
 HTML_REPO = ../../git-htmldocs
 
-infodir?=$(prefix)/share/info
-MAKEINFO=makeinfo
-INSTALL_INFO=install-info
-DOCBOOK2X_TEXI=docbook2x-texi
-DBLATEX=dblatex
+infodir ?= $(prefix)/share/info
+MAKEINFO = makeinfo
+INSTALL_INFO = install-info
+DOCBOOK2X_TEXI = docbook2x-texi
+DBLATEX = dblatex
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
-- 
1.8.1.2
