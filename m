From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/6] We're half-way there with the separate indexes
Date: Sun, 05 Oct 2008 18:01:46 +0200
Message-ID: <20081005160145.19886.65798.stgit@yoghurt>
References: <20081005155450.19886.43748.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 18:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmW4g-0006DS-Bg
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 18:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbYJEQBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2008 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbYJEQBu
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 12:01:50 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1875 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbYJEQBt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 12:01:49 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KmW3F-0007Xi-00; Sun, 05 Oct 2008 17:01:45 +0100
In-Reply-To: <20081005155450.19886.43748.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97517>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 TODO |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


diff --git a/TODO b/TODO
index 3570345..267e17e 100644
--- a/TODO
+++ b/TODO
@@ -1,8 +1,14 @@
 The TODO list before 1.0:
=20
 - more regression tests
+
 - use a separate index for some commands (refresh, fold etc.) so that
   files already added/removed are not automatically checked in
+
+    + This is easily done with the new infrastructure. refresh now
+      uses a separate index when appropriate. fold has not yet been
+      converted.
+
 - document the workflow on the StGIT wiki
 - release 1.0
=20
