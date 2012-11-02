From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Document 'git commit --no-edit' explicitly
Date: Fri,  2 Nov 2012 11:39:30 +0100
Message-ID: <1351852770-13897-1-git-send-email-Matthieu.Moy@imag.fr>
References: <nnpq3wiaha.fsf@stalhein.lysator.liu.se>
Cc: peff@peff.net, nisse@lysator.liu.se,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 11:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUEfb-0002ay-3S
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 11:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab2KBKjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 06:39:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51691 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806Ab2KBKjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 06:39:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qA2AWfAL025688
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2012 11:32:41 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1TUEf6-00023b-8l; Fri, 02 Nov 2012 11:39:40 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1TUEf6-0003ct-5C; Fri, 02 Nov 2012 11:39:40 +0100
X-Mailer: git-send-email 1.8.0.319.g8abfee4
In-Reply-To: <nnpq3wiaha.fsf@stalhein.lysator.liu.se>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 02 Nov 2012 11:32:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qA2AWfAL025688
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1352457164.85355@ZPluIYADl2RmNoTgRSZtaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208919>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I was tempted to merge the paragraph with --edit::, but I thought this
may add confusion. The use-cases for --edit and --no-edit are really
different so I went for a separate paragraph, right below the --edit one.

 Documentation/git-commit.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 3acf2e7..44b4347 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -188,6 +188,11 @@ OPTIONS
 	commit log message unmodified.  This option lets you
 	further edit the message taken from these sources.
 
+--no-edit::
+	Use the selected commit message without launching an editor.
+	For example, `git commit --amend --no-edit` amends a commit
+	without changing its commit message.
+
 --amend::
 	Used to amend the tip of the current branch. Prepare the tree
 	object you would want to replace the latest commit as usual
-- 
1.8.0.319.g8abfee4
