From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH] Documentation: Typo / spelling / formatting fixes
Date: Tue,  3 Mar 2009 19:29:22 +0000
Message-ID: <1236108562-31469-3-git-send-email-mike@abacus.co.uk>
References: <1236108562-31469-1-git-send-email-mike@abacus.co.uk>
 <1236108562-31469-2-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:52:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeafZ-0007zo-P5
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbZCCTvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 14:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbZCCTvR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:51:17 -0500
Received: from [82.109.193.99] ([82.109.193.99]:21426 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752583AbZCCTvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:51:13 -0500
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id B9AA1195DEB; Tue,  3 Mar 2009 19:29:22 +0000 (GMT)
X-Mailer: git-send-email 1.6.0.2.229.g1293c
In-Reply-To: <1236108562-31469-2-git-send-email-mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112159>

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 Documentation/howto/revert-a-faulty-merge.txt      |    4 ++--
 Documentation/howto/setup-git-server-over-http.txt |    2 +-
 Documentation/technical/api-strbuf.txt             |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 39b1da4..3b4a390 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -39,7 +39,7 @@ Such a "revert" of a merge can be made with:
 
     $ git revert -m 1 M
 
-After the develpers of the side branch fixes their mistakes, the history
+After the developers of the side branch fix their mistakes, the history
 may look like this:
 
  ---o---o---o---M---x---x---W---x
@@ -116,7 +116,7 @@ If you reverted the revert in such a case as in the previous example:
 	       /                 \         /
        ---A---B                   A'--B'--C'
 
-where Y is the revert of W, A' and B'are rerolled A and B, and there may
+where Y is the revert of W, A' and B' are rerolled A and B, and there may
 also be a further fix-up C' on the side branch.  "diff Y^..Y" is similar
 to "diff -R W^..W" (which in turn means it is similar to "diff M^..M"),
 and "diff A'^..C'" by definition would be similar but different from that,
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 4032748..622ee5c 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -143,7 +143,7 @@ Then, add something like this to your httpd.conf
        Require valid-user
     </Location>
 
-    Debian automatically reads all files under /etc/apach2/conf.d.
+    Debian automatically reads all files under /etc/apache2/conf.d.
 
 The password file can be somewhere else, but it has to be readable by
 Apache and preferably not readable by the world.
diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index ac56d1c..7438149 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -222,7 +222,7 @@ which can be used by the programmer of the callback as she sees fit.
 
 	Read a given size of data from a FILE* pointer to the buffer.
 +
-NOTE: The buffer is rewinded if the read fails. If -1 is returned,
+NOTE: The buffer is rewound if the read fails. If -1 is returned,
 `errno` must be consulted, like you would do for `read(3)`.
 `strbuf_read()`, `strbuf_read_file()` and `strbuf_getline()` has the
 same behaviour as well.
-- 
1.6.0.2.229.g1293c.dirty
