From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] microprojects: tweaks after discussion with Peff
Date: Fri, 20 Feb 2015 11:31:55 +0100
Message-ID: <1424428317-1682-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20150220020022.GC16124@peff.net>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 20 11:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOksb-0003Yc-6t
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbbBTKcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:32:10 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47978 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478AbbBTKcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:32:08 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAW1P6017688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2015 11:32:01 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAW2n7031729;
	Fri, 20 Feb 2015 11:32:02 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YOksM-0000TN-56; Fri, 20 Feb 2015 11:32:02 +0100
X-Mailer: git-send-email 2.3.0.157.g79e124b
In-Reply-To: <20150220020022.GC16124@peff.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Feb 2015 11:32:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1KAW1P6017688
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1425033121.43429@r32G10ama/1m/SkQS8SzYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264154>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 SoC-2015-Microprojects.md | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/SoC-2015-Microprojects.md b/SoC-2015-Microprojects.md
index e49cb07..c6123bb 100644
--- a/SoC-2015-Microprojects.md
+++ b/SoC-2015-Microprojects.md
@@ -158,14 +158,16 @@ approach is:
 
 * Update the documentation
 
+Even though the amount of code to write is small, these projects
+involve a lot of prior work to understand the specification and deal
+with all potential corner-cases.
+
 ### Add configuration options for some commonly used command-line options
 
 This includes:
 
 * git am -3
 
-* git am -c
-
 Some people always run the command with these options, and would
 prefer to be able to activate them by default in ~/.gitconfig.
 
@@ -177,3 +179,5 @@ the way to find the function name is built-in Git's source code as
 regular expressions (see userdiff.c). A few languages are common
 enough to deserve a built-in driver, but are not yet recognized. For
 example, CSS, shell.
+
+This project requires a very good knowledge of regular expressions.
-- 
2.3.0.157.g79e124b
