From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Add default values for --window and --depth to the docs
Date: Fri, 06 Oct 2006 11:15:03 +0200
Message-ID: <20061006091503.16069.36227.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Oct 06 11:15:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVlnT-0003Rd-Nu
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 11:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWJFJPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 05:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWJFJPH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 05:15:07 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:56960 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S932112AbWJFJPF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 05:15:05 -0400
Received: from leonov.stosberg.net (localhost [127.0.0.1])
	by kleekamp.stosberg.net (Postfix) with ESMTP id 9732A108A12
	for <git@vger.kernel.org>; Fri,  6 Oct 2006 11:15:03 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28394>

Currently, you actually have to read the source to find out the
default values. While at it, fix two typos and suggest that these
options actually take a parameter in git-pack-objects.txt.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 Documentation/git-pack-objects.txt |    7 ++++---
 Documentation/git-repack.txt       |    3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d4661dd..f52e8fa 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -71,11 +71,11 @@ base-name::
 --all::
 	This implies `--revs`.  In addition to the list of
 	revision arguments read from the standard input, pretend
-	as if all refs under `$GIT_DIR/refs` are specifed to be
+	as if all refs under `$GIT_DIR/refs` are specified to be
 	included.
 
---window and --depth::
-	These two options affects how the objects contained in
+--window=[N], --depth=[N]::
+	These two options affect how the objects contained in
 	the pack are stored using delta compression.  The
 	objects are first internally sorted by type, size and
 	optionally names and compared against the other objects
@@ -84,6 +84,7 @@ base-name::
 	it too deep affects the performance on the unpacker
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
+	The default value for both --window and --depth is 10.
 
 --incremental::
 	This flag causes an object already in a pack ignored
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 49f7e0a..d2eaa09 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -57,13 +57,14 @@ OPTIONS
         `git update-server-info`.
 
 --window=[N], --depth=[N]::
-	These two options affects how the objects contained in the pack are
+	These two options affect how the objects contained in the pack are
 	stored using delta compression. The objects are first internally
 	sorted by type, size and optionally names and compared against the
 	other objects within `--window` to see if using delta compression saves
 	space. `--depth` limits the maximum delta depth; making it too deep
 	affects the performance on the unpacker side, because delta data needs
 	to be applied that many times to get to the necessary object.
+	The default value for both --window and --depth is 10.
 
 
 Author
