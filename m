From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 06/10] Remove debugging output from contrib/stg-sink
Date: Thu, 15 Mar 2007 01:27:00 +0100
Message-ID: <20070315002700.9094.84569.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:27:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdoC-0003Bq-8t
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbXCOA1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbXCOA1E
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:27:04 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59027 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422770AbXCOA1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:27:03 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A2C9E81D6;
	Thu, 15 Mar 2007 01:27:00 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 3CEFD1F095;
	Thu, 15 Mar 2007 01:27:00 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42261>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-sink |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/stg-sink b/contrib/stg-sink
index e63eb93..cb6e25d 100755
--- a/contrib/stg-sink
+++ b/contrib/stg-sink
@@ -3,7 +3,7 @@ use strict;
 use warnings;
 
 sub _run {
-  print(' >> ', @_, "\n");# and 0;
+  #print(' >> ', @_, "\n");# and 0;
   system(@_);
 }
 
