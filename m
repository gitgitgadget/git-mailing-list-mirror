From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] commit: suggest --amend --reset-author to fix commiter identity
Date: Wed, 12 Jan 2011 19:29:14 +0100
Message-ID: <1294856954-26841-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1294754860-17701-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 12 19:30:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd5SN-0000Jh-Eg
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 19:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab1ALS3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 13:29:55 -0500
Received: from mx1.imag.fr ([129.88.30.5]:39445 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722Ab1ALS3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 13:29:54 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p0CITFwS016815
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Jan 2011 19:29:15 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Pd5Rd-0006gq-7a; Wed, 12 Jan 2011 19:29:17 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Pd5Rd-0006zo-22; Wed, 12 Jan 2011 19:29:17 +0100
X-Mailer: git-send-email 1.7.4.rc0.2.g3e22c.dirty
In-Reply-To: <1294754860-17701-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jan 2011 19:29:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p0CITFwS016815
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1295461757.47001@FUYD3WQDsIPKxQO+qFFuhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165025>

Since the message advise to fix the configuration first, the advantage
of this command is that it is cut-and-paste ready, while using
--author='...' requires the user to type his name and email a second
time.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Sorry, I did a resend the other day, which was plain wrong (I had the
changes in my tree, but sent before commit--amend-ing).

This one should be OK.

 builtin/commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 22ba54f..03cff5a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -45,9 +45,9 @@ static const char implicit_ident_advice[] =
 "    git config --global user.name \"Your Name\"\n"
 "    git config --global user.email you@example.com\n"
 "\n"
-"If the identity used for this commit is wrong, you can fix it with:\n"
+"After doing this, you may fix the identity used for this commit with:\n"
 "\n"
-"    git commit --amend --author='Your Name <you@example.com>'\n";
+"    git commit --amend --reset-author\n";
 
 static const char empty_amend_advice[] =
 "You asked to amend the most recent commit, but doing so would make\n"
-- 
1.7.4.rc0.2.g3e22c.dirty
