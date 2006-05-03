From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/2] Add .gitignore files, list generated files there
Date: Wed, 03 May 2006 04:29:31 -0400
Message-ID: <20060503082931.1548.14118.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed May 03 10:31:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbCl4-0002iz-Jj
	for gcvg-git@gmane.org; Wed, 03 May 2006 10:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWECIav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 04:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWECIav
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 04:30:51 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:20933 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965119AbWECIau
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 May 2006 04:30:50 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FbCkU-0001tR-S3
	for git@vger.kernel.org; Wed, 03 May 2006 04:30:21 -0400
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.61)
	(envelope-from <proski@gnu.org>)
	id 1FbCjj-0000P5-Ha; Wed, 03 May 2006 04:29:31 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19460>

From: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 .gitignore       |    1 +
 doc/.gitignore   |    2 ++
 stgit/.gitignore |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..378eac2
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1 @@
+build
diff --git a/doc/.gitignore b/doc/.gitignore
new file mode 100644
index 0000000..15ba6af
--- /dev/null
+++ b/doc/.gitignore
@@ -0,0 +1,2 @@
+tutorial.html
+tutorial.pdf
diff --git a/stgit/.gitignore b/stgit/.gitignore
new file mode 100644
index 0000000..0d20b64
--- /dev/null
+++ b/stgit/.gitignore
@@ -0,0 +1 @@
+*.pyc
