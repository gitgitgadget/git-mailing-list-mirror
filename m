From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Regression test suite needs bash, that's OK.
Date: Thu, 14 Jun 2007 14:50:56 +0200
Message-ID: <11818254622701-git-send-email-madcoder@debian.org>
References: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyonS-0003Jt-Ii
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 14:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbXFNMvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 08:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXFNMvJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 08:51:09 -0400
Received: from pan.madism.org ([88.191.52.104]:60890 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbXFNMvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 08:51:04 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4A9D2DA67;
	Thu, 14 Jun 2007 14:51:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5E8869294D; Thu, 14 Jun 2007 14:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50197>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 regression/010-init.sh      |    1 +
 regression/011-no-repo.sh   |    1 +
 regression/020-push.sh      |    1 +
 regression/021-pop.sh       |    1 +
 regression/022-applied.sh   |    1 +
 regression/023-top.sh       |    1 +
 regression/024-unapplied.sh |    1 +
 regression/025-new.sh       |    1 +
 regression/026-delete.sh    |    1 +
 regression/027-refresh.sh   |    1 +
 regression/050-series.sh    |    1 +
 regression/060-files.sh     |    1 +
 regression/Makefile         |    2 +-
 13 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/regression/010-init.sh b/regression/010-init.sh
index 17c1c16..1553d0c 100755
--- a/regression/010-init.sh
+++ b/regression/010-init.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the init code
 #
diff --git a/regression/011-no-repo.sh b/regression/011-no-repo.sh
index b37a548..fd4f6a5 100755
--- a/regression/011-no-repo.sh
+++ b/regression/011-no-repo.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test that all commands that should fail do indeed fail if the branch was
 # not guilt-init'ed
diff --git a/regression/020-push.sh b/regression/020-push.sh
index 0d49a7e..6242529 100755
--- a/regression/020-push.sh
+++ b/regression/020-push.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the push code
 #
diff --git a/regression/021-pop.sh b/regression/021-pop.sh
index 418a054..e1af856 100755
--- a/regression/021-pop.sh
+++ b/regression/021-pop.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the pop code
 #
diff --git a/regression/022-applied.sh b/regression/022-applied.sh
index 78d00d9..f259bf4 100755
--- a/regression/022-applied.sh
+++ b/regression/022-applied.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the applied code
 #
diff --git a/regression/023-top.sh b/regression/023-top.sh
index d490f14..c486448 100755
--- a/regression/023-top.sh
+++ b/regression/023-top.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the top code
 #
diff --git a/regression/024-unapplied.sh b/regression/024-unapplied.sh
index 368b3cc..ecb0298 100755
--- a/regression/024-unapplied.sh
+++ b/regression/024-unapplied.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the unapplied code
 #
diff --git a/regression/025-new.sh b/regression/025-new.sh
index f17f20e..680f6da 100755
--- a/regression/025-new.sh
+++ b/regression/025-new.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the new code
 #
diff --git a/regression/026-delete.sh b/regression/026-delete.sh
index 7c16b38..07c969a 100755
--- a/regression/026-delete.sh
+++ b/regression/026-delete.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the delete code
 #
diff --git a/regression/027-refresh.sh b/regression/027-refresh.sh
index 4a3270e..704d0b5 100755
--- a/regression/027-refresh.sh
+++ b/regression/027-refresh.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the refresh code
 #
diff --git a/regression/050-series.sh b/regression/050-series.sh
index 437cd2f..eb23540 100755
--- a/regression/050-series.sh
+++ b/regression/050-series.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the series parsing code
 #
diff --git a/regression/060-files.sh b/regression/060-files.sh
index 875f991..915c73a 100755
--- a/regression/060-files.sh
+++ b/regression/060-files.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 #
 # Test the series parsing code
 #
diff --git a/regression/Makefile b/regression/Makefile
index c538029..3dd9d0e 100644
--- a/regression/Makefile
+++ b/regression/Makefile
@@ -1,3 +1,3 @@
 .PHONY: all
 all:
-	(for x in *.sh ; do sh $$x || exit $?; done)
+	set -e; $(foreach x,$(wildcard *.sh),./$x;)
-- 
1.5.2.1
