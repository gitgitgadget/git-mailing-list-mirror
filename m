From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] git-am: remove dash from help message
Date: Mon, 21 Jul 2008 16:12:20 +0200
Message-ID: <48849944.7070904@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 16:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKw8g-0005zX-AB
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 16:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbYGUOMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 10:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbYGUOMW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 10:12:22 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:39931 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbYGUOMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 10:12:22 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 7EB5E12B6AB;
	Mon, 21 Jul 2008 16:12:21 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 2140B12B72E;
	Mon, 21 Jul 2008 16:12:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89359>

From: Olivier Marin <dkr@freesurf.fr>

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 864c77e..c0a1583 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -44,7 +44,7 @@ stop_here_user_resolve () {
            printf '%s\n' "$resolvemsg"
            stop_here $1
     fi
-    cmdline=$(basename $0)
+    cmdline="git am"
     if test '' != "$interactive"
     then
         cmdline="$cmdline -i"
-- 
1.5.6.4.570.g052e.dirty
