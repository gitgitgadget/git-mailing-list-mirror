From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/8] Add contrib/stg-show-old: show old version of a patch.
Date: Fri, 02 Mar 2007 00:03:45 +0100
Message-ID: <20070301230345.32459.79608.stgit@gandelf.nowhere.earth>
References: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:04:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuJd-0003th-43
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbXCAXD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbXCAXD4
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:03:56 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:49826 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161209AbXCAXDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:03:55 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2788F38F2;
	Fri,  2 Mar 2007 00:03:54 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 2654E1F084;
	Fri,  2 Mar 2007 00:03:45 +0100 (CET)
In-Reply-To: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41144>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-show-old |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-show-old b/contrib/stg-show-old
new file mode 100755
index 0000000..acf4e7c
--- /dev/null
+++ b/contrib/stg-show-old
@@ -0,0 +1,13 @@
+#!/bin/sh
+set -e
+
+# stg-show-old - mini helper to look at the previous version of a
+# patch (current one by default)
+
+# Copyright (c) 2006-2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+[ "$#" -le 1 ] || { echo >&2 "Usage: $(basename $0) [<patch>]"; exit 1; }
+patch="$1"
+
+stg show "${patch}//top.old"
