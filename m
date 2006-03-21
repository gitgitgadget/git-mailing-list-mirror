From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Don't use merge labels in the ed scripts
Date: Tue, 21 Mar 2006 15:54:14 -0500
Message-ID: <20060321205414.8301.97041.stgit@dv.roinet.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 21:56:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLntk-00020K-Ph
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 21:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWCUU4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 15:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWCUU4I
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 15:56:08 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:40400 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965106AbWCUU4G
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 15:56:06 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FLntd-00021X-6H
	for git@vger.kernel.org; Tue, 21 Mar 2006 15:56:14 -0500
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FLnrq-0002AO-IT; Tue, 21 Mar 2006 15:54:14 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17788>

From: Pavel Roskin <proski@gnu.org>

Merge labels keep changing, and they are not required to identify
specific lines uniquely for the test purposes.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 .../tutorial-script/0010-alice-bob-fixup.ed        |    2 +-
 .../tutorial-script/0017-alice-bob-fixup.ed        |    4 ++--
 .../tutorial-script/0018-alice-charlie-fixup1.ed   |    4 ++--
 .../tutorial-script/0019-alice-charlie-fixup2.ed   |    4 ++--
 .../tutorial-script/0021-bob-alice-fixup1.ed       |    4 ++--
 .../tutorial-script/0022-bob-alice-fixup2.ed       |    2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/tutorial-script/0010-alice-bob-fixup.ed b/Documentation/tutorial-script/0010-alice-bob-fixup.ed
index 81b1360..35ba0c3 100644
--- a/Documentation/tutorial-script/0010-alice-bob-fixup.ed
+++ b/Documentation/tutorial-script/0010-alice-bob-fixup.ed
@@ -1,3 +1,3 @@
-/^<<<<<<< bob/,/^>>>>>>> bobswork/d
+/^<<<<<<< /,/^>>>>>>> /d
 w
 q
diff --git a/Documentation/tutorial-script/0017-alice-bob-fixup.ed b/Documentation/tutorial-script/0017-alice-bob-fixup.ed
index ad04eb7..00626e3 100644
--- a/Documentation/tutorial-script/0017-alice-bob-fixup.ed
+++ b/Documentation/tutorial-script/0017-alice-bob-fixup.ed
@@ -1,5 +1,5 @@
-/^<<<<<<< Makefile/d
+/^<<<<<<< /d
 /^=======/,/^=======/+1d
-/^>>>>>>> \.merge_file_/d
+/^>>>>>>> /d
 w
 q
diff --git a/Documentation/tutorial-script/0018-alice-charlie-fixup1.ed b/Documentation/tutorial-script/0018-alice-charlie-fixup1.ed
index 9682b4a..f73223c 100644
--- a/Documentation/tutorial-script/0018-alice-charlie-fixup1.ed
+++ b/Documentation/tutorial-script/0018-alice-charlie-fixup1.ed
@@ -1,7 +1,7 @@
-/^<<<<<<< master/d
+/^<<<<<<< /d
 /^rpn\.o:/s/\.h.*$/.h lexer.h/
 /^lexer\.o:/s/:.*$/: lexer.h/
-/^=======/,/^>>>>>>> charlie/d
+/^=======/,/^>>>>>>> /d
 w
 q
 
diff --git a/Documentation/tutorial-script/0019-alice-charlie-fixup2.ed b/Documentation/tutorial-script/0019-alice-charlie-fixup2.ed
index 5d531de..75832f1 100644
--- a/Documentation/tutorial-script/0019-alice-charlie-fixup2.ed
+++ b/Documentation/tutorial-script/0019-alice-charlie-fixup2.ed
@@ -1,5 +1,5 @@
-/^<<<<<<< master/,/^=======/d
-/^>>>>>>> charlie/d
+/^<<<<<<< /,/^=======/d
+/^>>>>>>> /d
 w
 q
 
diff --git a/Documentation/tutorial-script/0021-bob-alice-fixup1.ed b/Documentation/tutorial-script/0021-bob-alice-fixup1.ed
index df703d5..9950144 100644
--- a/Documentation/tutorial-script/0021-bob-alice-fixup1.ed
+++ b/Documentation/tutorial-script/0021-bob-alice-fixup1.ed
@@ -1,4 +1,4 @@
-/^<<<<<<< master/,/^=======/d
-/^>>>>>>> origin/d
+/^<<<<<<< /,/^=======/d
+/^>>>>>>> /d
 w
 q
diff --git a/Documentation/tutorial-script/0022-bob-alice-fixup2.ed b/Documentation/tutorial-script/0022-bob-alice-fixup2.ed
index d8c5746..df1c077 100644
--- a/Documentation/tutorial-script/0022-bob-alice-fixup2.ed
+++ b/Documentation/tutorial-script/0022-bob-alice-fixup2.ed
@@ -1,5 +1,5 @@
 /^#include "stack\.h"/+1d
 /^#include "lexer\.h"/+1,/^#include "stack\.h"/d
-/^<<<<<<< master/-1,/^>>>>>>> origin/d
+/^<<<<<<< /-1,/^>>>>>>> /d
 w
 q
