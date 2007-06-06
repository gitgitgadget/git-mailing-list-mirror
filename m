From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/3] Fixed typo in contrib/stg-whatchanged.
Date: Thu, 07 Jun 2007 00:01:52 +0200
Message-ID: <20070606220152.18635.43506.stgit@gandelf.nowhere.earth>
References: <20070606215922.18635.38379.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw3Zx-00085m-He
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbXFFWBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935215AbXFFWBv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:01:51 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60917 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbXFFWBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:01:51 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5E2BE5A16C;
	Thu,  7 Jun 2007 00:01:50 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id ADADD1F019;
	Thu,  7 Jun 2007 00:01:52 +0200 (CEST)
In-Reply-To: <20070606215922.18635.38379.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49324>


Signed-off-by: Yann Dirson <ydirson@altern.org>

---

 contrib/stg-whatchanged |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/stg-whatchanged b/contrib/stg-whatchanged
index f80d0a1..d5b6965 100755
--- a/contrib/stg-whatchanged
+++ b/contrib/stg-whatchanged
@@ -23,7 +23,7 @@ fi
 
 # Merges via "push" leave top=bottom so we must look at old patch
 # in this case (unlike, eg., "pick --fold")
-patchdir="$(git-rev-parse --git-dir)/patches/$(stg branch)/$(stg top)"
+patchdir="$(git-rev-parse --git-dir)/patches/$(stg branch)/patches/$(stg top)"
 if [ $(cat "$patchdir/bottom") = $(cat "$patchdir/top") ];
 then
     current_cmd="stg show //top.old"
