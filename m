From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] New test: make sure tha we can run "stg help"
Date: Mon, 24 Sep 2007 01:51:45 +0200
Message-ID: <20070923235023.26316.68392.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 01:52:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZbFA-0005zA-6p
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 01:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbXIWXwC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2007 19:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534AbXIWXwB
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 19:52:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1772 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbXIWXwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 19:52:00 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IZbEu-0006Ir-00; Mon, 24 Sep 2007 00:51:52 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59003>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

David K=C3=A5gedal pointed out that "stg help" was broken in my
experimental branch. But nothing can be expected to work if it's not
in the test suite ...

 t/t0100-help.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)
 create mode 100755 t/t0100-help.sh


diff --git a/t/t0100-help.sh b/t/t0100-help.sh
new file mode 100755
index 0000000..d1550ba
--- /dev/null
+++ b/t/t0100-help.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_description=3D'Run "stg help"'
+
+. ./test-lib.sh
+
+test_expect_success 'Run "stg help"' '
+    stg help
+    '
+
+test_expect_success 'Run "stg --help"' '
+    stg --help
+    '
+
+test_done
