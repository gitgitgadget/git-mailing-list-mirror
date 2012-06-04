From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/4] doc: fix xref link from api docs to manual pages
Date: Mon,  4 Jun 2012 22:17:41 +0200
Message-ID: <1338841064-32294-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 04 22:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbdjC-0006yr-K9
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab2FDUSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:18:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47615 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172Ab2FDUSI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:18:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q54K9ToA022879
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 22:09:30 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sbdj1-0000dy-7T; Mon, 04 Jun 2012 22:18:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sbdj1-0008Q1-2q; Mon, 04 Jun 2012 22:18:03 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jun 2012 22:09:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54K9ToA022879
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1339445372.10425@G8tlc1yb5/p+rDgyLhA/Tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199178>

From: Junio C Hamano <gitster@pobox.com>

They are one-level above, so refer them as linkgit:../git-foo[n] with "../"

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
That's Junio's patch unmodified (I took it at the beginning of the
serie so that my linkgit:../ isn't the fist to appear)

 Documentation/technical/api-config.txt | 2 +-
 Documentation/technical/api-merge.txt  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index edf8dfb..bd4d8b8 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -2,7 +2,7 @@ config API
 ==========
 
 The config API gives callers a way to access git configuration files
-(and files which have the same syntax). See linkgit:git-config[1] for a
+(and files which have the same syntax). See linkgit:../git-config[1] for a
 discussion of the config file syntax.
 
 General Usage
diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
index 9dc1bed..25158b8 100644
--- a/Documentation/technical/api-merge.txt
+++ b/Documentation/technical/api-merge.txt
@@ -36,7 +36,7 @@ the operation of a low-level (single file) merge.  Some options:
 	ancestors in a recursive merge.
 	If a helper program is specified by the
 	`[merge "<driver>"] recursive` configuration, it will
-	be used (see linkgit:gitattributes[5]).
+	be used (see linkgit:../gitattributes[5]).
 
 `variant`::
 	Resolve local conflicts automatically in favor
-- 
1.7.11.rc0.57.g84a04c7
