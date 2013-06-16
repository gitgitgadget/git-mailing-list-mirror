From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] Documentation/Makefile: move infodir to be with other '*dir's
Date: Sun, 16 Jun 2013 18:13:01 +0100
Message-ID: <ffea107da7b3b7d5e390d27397d3a72155e942b4.1371402684.git.john@keeping.me.uk>
References: <4857ab4f4097c582063f064f657a8e5dfbfee232.1371402684.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 19:13:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoGW7-00038D-Vt
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 19:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab3FPRNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 13:13:24 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:54391 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab3FPRNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 13:13:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id CBCD8CDA599;
	Sun, 16 Jun 2013 18:13:22 +0100 (BST)
X-Quarantine-ID: <MdG3kc+AwRG1>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MdG3kc+AwRG1; Sun, 16 Jun 2013 18:13:20 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id A59C0CDA48A;
	Sun, 16 Jun 2013 18:13:20 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 9B80C161E3B1;
	Sun, 16 Jun 2013 18:13:20 +0100 (BST)
X-Quarantine-ID: <JAnDpRsE3-x8>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAnDpRsE3-x8; Sun, 16 Jun 2013 18:13:18 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 923CD161E1F3;
	Sun, 16 Jun 2013 18:13:12 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
In-Reply-To: <4857ab4f4097c582063f064f657a8e5dfbfee232.1371402684.git.john@keeping.me.uk>
In-Reply-To: <4857ab4f4097c582063f064f657a8e5dfbfee232.1371402684.git.john@keeping.me.uk>
References: <4857ab4f4097c582063f064f657a8e5dfbfee232.1371402684.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228016>

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
1.8.3.779.g691e267
