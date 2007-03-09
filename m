From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/3] Do not link to docs that will never be written.
Date: Sat, 10 Mar 2007 00:18:43 +0100
Message-ID: <20070309231843.30705.24604.stgit@gandelf.nowhere.earth>
References: <20070309231444.30705.72292.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:19:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPoMr-0008M9-5M
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 00:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767639AbXCIXTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 18:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767638AbXCIXTM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 18:19:12 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44246 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767639AbXCIXTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 18:19:09 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DFDD738B1;
	Sat, 10 Mar 2007 00:19:07 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 55A4A1F095;
	Sat, 10 Mar 2007 00:18:43 +0100 (CET)
In-Reply-To: <20070309231444.30705.72292.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41821>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index 002606f..60a6f9c 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -65,11 +65,11 @@ Generic commands
 
 User-support commands not touching the repository.
 
-stglink:help[]::
+stg help::
 	stgdesc:help[]
-stglink:version[]::
+stg version::
 	stgdesc:version[]
-stglink:copyright[]::
+stg copyright::
 	stgdesc:copyright[]
 
 Repository commands
