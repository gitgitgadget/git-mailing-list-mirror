From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH] bash completion: remove unused function _git_diff_tree
Date: Fri,  1 Aug 2008 22:47:09 -0600
Message-ID: <1217652429-58511-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 06:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP95H-0005dG-CF
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 06:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbYHBErN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 00:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbYHBErN
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 00:47:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:15543 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbYHBErM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 00:47:12 -0400
Received: by wa-out-1112.google.com with SMTP id j37so852255waf.23
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=h2YRuRNIbj9zgNawEcLcGaQ5e+CKuG6byyJv+uJ3A5o=;
        b=fmKe6Hy9/NodFfpDrNI0fZ+1VAc5pb81qVQK53eL71iXj81irI7WV07UBJ2MVCbswg
         CezazQfyfcIaC6taBupbEK0XGhuvHfNbEpCQ1Bis0XPZR46vnfDmO0aO5Xkn+2oYS2Es
         OaAXIbdLJGTc2b9e/SwQmSrgioJfjMW/XsShQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CKQvuFuhib43/O1cg/j6HqL9DZXCr4Jb6QRXsYuy0XJh6OXsCRO7Hhwdm9m9DVooJI
         wACFvOQ3gviavxD9Mmwwm4zsYZo2wdm/aK6xgRY8H5b0x8qdn9omK3bq6YvVBVwQ7VGT
         TGbP6OEz6XkT1YnbNZSOIYjabPJTDdFm6reOk=
Received: by 10.114.103.4 with SMTP id a4mr12449128wac.172.1217652431788;
        Fri, 01 Aug 2008 21:47:11 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id m28sm4685635poh.10.2008.08.01.21.47.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 21:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.27.g9b6bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91131>

completion for git diff-tree was removed in 5cfb4fe

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 30d8701..e32c1f1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -721,11 +721,6 @@ _git_diff ()
 	__git_complete_file
 }
 
-_git_diff_tree ()
-{
-	__gitcomp "$(__git_refs)"
-}
-
 _git_fetch ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-- 
1.6.0.rc1.27.g9b6bf
