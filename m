From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] Documentation/Makefile: fix spaces around assignments
Date: Sun, 16 Jun 2013 18:13:00 +0100
Message-ID: <4857ab4f4097c582063f064f657a8e5dfbfee232.1371402684.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 19:13:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoGVz-0002wm-Vt
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 19:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab3FPRNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 13:13:16 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:55139 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab3FPRNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 13:13:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D4DB46064D5;
	Sun, 16 Jun 2013 18:13:14 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BwicZzYP243Z; Sun, 16 Jun 2013 18:13:14 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 391F46064C8;
	Sun, 16 Jun 2013 18:13:12 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 086E7161E2DC;
	Sun, 16 Jun 2013 18:13:12 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CCX8H-ReYFT2; Sun, 16 Jun 2013 18:13:11 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 44824161E03F;
	Sun, 16 Jun 2013 18:13:05 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228015>

A simple style fix; no functional change.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Nothing in maint..pu is touching this at the moment, so hopefully this
is a good time to fix the whitespace here.

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
1.8.3.779.g691e267
