From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] commit: suggest --amend --reset-author to fix commiter identity
Date: Fri,  7 Jan 2011 15:14:31 +0100
Message-ID: <1294409671-5479-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 07 15:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbDd2-000787-Fo
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 15:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab1AGOtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 09:49:15 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54967 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab1AGOtO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 09:49:14 -0500
X-Greylist: delayed 2014 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jan 2011 09:49:14 EST
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p07EEWeb021228
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Jan 2011 15:14:32 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PbD5N-0003H2-3f; Fri, 07 Jan 2011 15:14:33 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PbD5N-0001Qx-05; Fri, 07 Jan 2011 15:14:33 +0100
X-Mailer: git-send-email 1.7.4.rc0.1.g6944b.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 07 Jan 2011 15:14:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p07EEWeb021228
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1295014473.20848@Bu/sG+v05L4A51c5TmHd2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164714>

The advantage of this command is that it is cut-and-paste ready, while
using --author='...' requires the user to type his name and email a
second time.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/commit.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 22ba54f..440223c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -47,7 +47,11 @@ static const char implicit_ident_advice[] =
 "\n"
 "If the identity used for this commit is wrong, you can fix it with:\n"
 "\n"
-"    git commit --amend --author='Your Name <you@example.com>'\n";
+"    git commit --amend --author='Your Name <you@example.com>'\n"
+"\n"
+"or\n"
+"\n"
+"    git commit --amend --reset-author\n";
 
 static const char empty_amend_advice[] =
 "You asked to amend the most recent commit, but doing so would make\n"
-- 
1.7.4.rc0.1.g6944b.dirty
