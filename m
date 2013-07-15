From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 5/6] Documentation: move description of -s, --no-patch to diff-options.txt
Date: Mon, 15 Jul 2013 19:55:24 +0200
Message-ID: <1373910925-18422-6-git-send-email-Matthieu.Moy@imag.fr>
References: <20130715173536.GB14690@google.com>
 <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: jrnieder@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 19:57:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyn1p-0005FD-0q
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718Ab3GOR5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:57:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45526 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688Ab3GOR5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:57:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6FHtu7s010132
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 19:55:56 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uyn0A-00043o-PJ; Mon, 15 Jul 2013 19:55:58 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Uyn0A-0004oW-FD; Mon, 15 Jul 2013 19:55:58 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jul 2013 19:55:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FHtu7s010132
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374515761.27905@dk5rKxHCbbKBzIzjkfwS7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230509>

Technically, "-s, --no-patch" is implemented in diff.c ("git diff
--no-patch" is essentially useless, but valid). From the user point of
view, this allows the documentation to show up in "git show --help",
which is one of the most useful use of the option.

While we're there, add a sentence explaining why the option can be
useful.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/diff-options.txt     | 5 +++++
 Documentation/rev-list-options.txt | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 87e92d6..bbed2cd 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -26,6 +26,11 @@ ifndef::git-format-patch[]
 	{git-diff? This is the default.}
 endif::git-format-patch[]
 
+-s::
+--no-patch::
+	Suppress diff output. Useful for commands like `git show` that
+	show the patch by default, or to cancel the effect of `--patch`.
+
 -U<n>::
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index c128a85..e632e85 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -849,8 +849,4 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 -t::
 
 	Show the tree objects in the diff output. This implies '-r'.
-
--s::
---no-patch::
-	Suppress diff output.
 endif::git-rev-list[]
-- 
1.8.3.1.495.g13f33cf.dirty
