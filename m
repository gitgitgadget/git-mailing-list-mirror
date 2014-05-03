From: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
Subject: [PATCH] RelNotes/2.0.0: Grammar and typo fixes
Date: Sat,  3 May 2014 21:08:50 +0200
Message-ID: <1399144130-5640-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 03 21:14:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgfOS-0002L1-6o
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 21:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbaECTOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 May 2014 15:14:36 -0400
Received: from smtp.domeneshop.no ([194.63.252.54]:45313 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbaECTOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 15:14:35 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 May 2014 15:14:35 EDT
Received: from sunbase.org ([178.79.142.16]:59220 helo=linode.members.linode.com)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <sunny@sunbase.org>)
	id 1WgfJB-0001gj-DF; Sat, 03 May 2014 21:09:13 +0200
X-Mailer: git-send-email 2.0.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248045>

Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
---
 Documentation/RelNotes/2.0.0.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes/2.0.0.txt b/Documentation/RelNotes/=
2.0.0.txt
index e6911ac..35e353e 100644
--- a/Documentation/RelNotes/2.0.0.txt
+++ b/Documentation/RelNotes/2.0.0.txt
@@ -68,7 +68,7 @@ UI, Workflows & Features
    e.g. "key-id" in "--gpg-sign=3D<key-id>").
=20
  * The pattern to find where the function begins in C/C++ used in
-   "diff" and "grep -p" have been updated to help C++ source better.
+   "diff" and "grep -p" has been updated to help C++ source better.
=20
  * "git rebase" learned to interpret a lone "-" as "@{-1}", the
    branch that we were previously on.
@@ -98,7 +98,7 @@ UI, Workflows & Features
    tree-wide operation even when run inside a subdirectory of a
    working tree.
=20
- * "git add <path> is the same as "git add -A <path>" now.
+ * "git add <path>" is the same as "git add -A <path>" now.
=20
  * "core.statinfo" configuration variable, which is a
    never-advertised synonym to "core.checkstat", has been removed.
@@ -137,7 +137,7 @@ UI, Workflows & Features
  * "git pull" can be told to only accept fast-forward by setting the
    new "pull.ff" configuration.
=20
- * "git reset" learned "-N" option, which does not reset the index
+ * "git reset" learned the "-N" option, which does not reset the index
    fully for paths the index knows about but the tree-ish the command
    resets to does not (these paths are kept as intend-to-add entries).
=20
@@ -156,11 +156,11 @@ Performance, Internal Implementation, etc.
    "easy" interface.
=20
  * The bitmap-index feature from JGit has been ported, which should
-   significantly improve performance when serving objects form a
+   significantly improve performance when serving objects from a
    repository that uses it.
=20
  * The way "git log --cc" shows a combined diff against multiple
-   parents have been optimized.
+   parents has been optimized.
=20
  * The prefixcmp() and suffixcmp() functions are gone.  Use
    starts_with() and ends_with(), and also consider if skip_prefix()
--=20
2.0.0.rc2
