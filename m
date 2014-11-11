From: Max Horn <max@quendi.de>
Subject: [PATCH] doc: add some crossrefs between manual pages
Date: Tue, 11 Nov 2014 21:17:07 +0100
Message-ID: <1415737027-44589-1-git-send-email-max@quendi.de>
Cc: spearce@spearce.org, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 21:36:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoIBI-00030K-Ar
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 21:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbaKKUgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 15:36:48 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53089 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbaKKUgr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2014 15:36:47 -0500
X-Greylist: delayed 1178 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Nov 2014 15:36:47 EST
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1XoHsB-0006j6-NY; Tue, 11 Nov 2014 21:17:07 +0100
X-Mailer: git-send-email 2.1.3.dirty
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1415738207;b39df5d6;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular, git-fast-import and -export link to each
other, and gitremote-helpers links to existing remote
helpers, and vice versa. Also link to fast-import from the
remote helper spec, as this is relevant for remote helpers
using the fast-import format.

Signed-off-by: Max Horn <max@quendi.de>
---
I did this because I was browsing the remote helper docs online quite a bit,
and was wishing for some more direct links between the pages. While I can
manyally edit the URL, it seems logical to offer these links directly.

 Documentation/git-fast-export.txt   | 4 ++++
 Documentation/git-fast-import.txt   | 4 ++++
 Documentation/git-remote-ext.txt    | 5 ++++-
 Documentation/git-remote-fd.txt     | 4 ++++
 Documentation/gitremote-helpers.txt | 6 ++++++
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 221506b..769689d 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -148,6 +148,10 @@ Since 'git fast-import' cannot tag trees, you will not be
 able to export the linux.git repository completely, as it contains
 a tag referencing a tree instead of a commit.
 
+SEE ALSO
+--------
+linkgit:git-fast-import[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 377eeaa..f71fb01 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1441,6 +1441,10 @@ operator can use this facility to peek at the objects and refs from an
 import in progress, at the cost of some added running time and worse
 compression.
 
+SEE ALSO
+--------
+linkgit:git-fast-export[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index cd0bb77..74817b0 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -72,7 +72,6 @@ GIT_EXT_SERVICE_NOPREFIX::
 	Set to long name (upload-pack, etc...) of service helper needs
 	to invoke.
 
-
 EXAMPLES:
 ---------
 This remote helper is transparently used by Git when
@@ -116,6 +115,10 @@ begins with `ext::`.  Examples:
 	determined by the helper using environment variables (see
 	above).
 
+SEE ALSO
+--------
+linkgit:gitremote-helpers[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index bcd3766..e700baf 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -50,6 +50,10 @@ EXAMPLES
 `git push fd::7,8/bar master`::
 	Same as above.
 
+SEE ALSO
+--------
+linkgit:gitremote-helpers[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 64f7ad2..8edf72c 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -452,8 +452,14 @@ SEE ALSO
 --------
 linkgit:git-remote[1]
 
+linkgit:git-remote-ext[1]
+
+linkgit:git-remote-fd[1]
+
 linkgit:git-remote-testgit[1]
 
+linkgit:git-fast-import[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.1.3.dirty
