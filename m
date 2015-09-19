From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/3] Documentation/grep: fix documentation of -O
Date: Sat, 19 Sep 2015 09:47:49 +0200
Message-ID: <1442648870-22511-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
 <1442648870-22511-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Alastair McGowan-Douglas <altreus@altre.us>,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 19 09:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdCsl-0008NY-Dg
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 09:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbbISHsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2015 03:48:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60972 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbbISHsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2015 03:48:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8J7lr58004104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 19 Sep 2015 09:47:54 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8J7lsQd023791;
	Sat, 19 Sep 2015 09:47:54 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZdCsE-0005vf-Iz; Sat, 19 Sep 2015 09:47:54 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
In-Reply-To: <1442648870-22511-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 19 Sep 2015 09:47:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8J7lr58004104
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1443253674.36058@ddkmEIMWryuVwlQBgj4Oxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278236>

Since the argument of -O, --open-file-in-pager is optional, it must be
stuck to the command. Reflect this in the documentation.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-grep.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 31811f1..1c07c7f 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -160,8 +160,8 @@ OPTIONS
 	For better compatibility with 'git diff', `--name-only` is a
 	synonym for `--files-with-matches`.
 
--O [<pager>]::
---open-files-in-pager [<pager>]::
+-O[<pager>]::
+--open-files-in-pager[=<pager>]::
 	Open the matching files in the pager (not the output of 'grep').
 	If the pager happens to be "less" or "vi", and the user
 	specified only one pattern, the first file is positioned at
-- 
2.5.0.402.g8854c44
