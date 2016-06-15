From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] Documentation/config.txt: document mailinfo.scissor
Date: Fri, 20 Feb 2015 11:09:06 +0100
Message-ID: <1424426947-26441-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 20 11:09:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkWW-0000eI-DS
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbbBTKJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:09:24 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42867 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245AbbBTKJX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:09:23 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1KA99rn020008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2015 11:09:09 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KA9AJD031100;
	Fri, 20 Feb 2015 11:09:10 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YOkWE-0006yo-A4; Fri, 20 Feb 2015 11:09:10 +0100
X-Mailer: git-send-email 2.3.0.157.g79e124b
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Feb 2015 11:09:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1KA99rn020008
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1425031752.41609@WRj7JxF9z/NMFbP3YfkzNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264146>

The variale was documented in git-mailinfo.txt, but not in config.txt.
The detailed documentation is still the one of --scissors in
git-mailinfo.txt, but we give enough information here to let the user
understand what it is about, and to make it easy to find it (e.g.
searching ">8" and "8<" finds it).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..4a2a078 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1740,6 +1740,13 @@ log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`.
 
+mailinfo.scissor::
+	If true, makes linkgit:git-mailinfo[1] (and therefore
+	linkgit:git-am[1]) act by default as if the --scissors option
+	was provided on the command-line. When active, this features
+	removes everything from the message body before a scissors
+	line (i.e. consisting mainly of ">8", "8<" and "-").
+
 mailmap.file::
 	The location of an augmenting mailmap file. The default
 	mailmap, located in the root of the repository, is loaded
-- 
2.3.0.157.g79e124b
