From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation/git-push: document that 'simple' is the default
Date: Tue, 23 Feb 2016 22:04:41 +0100
Message-ID: <1456261481-23468-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqegc3f8bd.fsf@anie.imag.fr>
Cc: philipoakley@iee.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 22:04:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYK8b-0003jD-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbcBWVEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:04:50 -0500
Received: from mx2.imag.fr ([129.88.30.17]:50426 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279AbcBWVEt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:04:49 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NL4en9005127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 22:04:40 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NL4hCo014906;
	Tue, 23 Feb 2016 22:04:43 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <vpqegc3f8bd.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 22:04:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NL4en9005127
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456866284.34124@Ek3j0+xcyB//Xm6bag1tWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287121>

The default behavior is well documented already in git-config(1), but
git-push(1) itself did not mention it at all. For users willing to learn
how "git push" works but not how to configure it, this makes the
documentation cumbersome to read.

Make the git-push(1) page self-contained by adding a short summary of
what 'push.default=simple' does, early in the page.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-push.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 32482ce..a992793 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -37,6 +37,13 @@ the default `<refspec>` by consulting `remote.*.push` configuration,
 and if it is not found, honors `push.default` configuration to decide
 what to push (See linkgit:git-config[1] for the meaning of `push.default`).
 
+When neither the command-line nor the configuration specify what to
+push, the default behavior is used, which corresponds to the `simple`
+value for `push.default`: the current branch is pushed to the
+corresponding upstream branch, but as a safety measure, the push is
+aborted if the upstream branch does not have the same name as the
+local one.
+
 
 OPTIONS[[OPTIONS]]
 ------------------
-- 
2.7.2.334.g35ed2ae.dirty
