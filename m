From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 08/10] Add a script to quickly run an interactive test session.
Date: Thu, 15 Mar 2007 01:27:10 +0100
Message-ID: <20070315002710.9094.91958.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdoL-0003GS-D8
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbXCOA1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbXCOA1N
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:27:13 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59038 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422773AbXCOA1L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:27:11 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DA805395B;
	Thu, 15 Mar 2007 01:27:10 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 749FA1F095;
	Thu, 15 Mar 2007 01:27:10 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42262>


This uses the capabilities of the test library to provide a throw-away
playground to test how the current stgit tree behaves.

To use it, run the following command:
	(cd t && ./interactive.sh)

You'll get a shell in a brand new git tree.  Exiting that shell will
get rid of this temporary directory.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/interactive.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/interactive.sh b/t/interactive.sh
new file mode 100755
index 0000000..e4eaef9
--- /dev/null
+++ b/t/interactive.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Yann Dirson
+#
+
+test_description='Get a test environment for interactive experimentation.'
+
+. ./test-lib.sh
+
+bash
+
+test_done
