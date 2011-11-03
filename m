From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH] completion: add --interactive option to git svn dcommit
Date: Thu,  3 Nov 2011 19:33:30 +0100
Message-ID: <1320345210-18205-1-git-send-email-frederic.heitzmann@gmail.com>
Cc: normalperson@yhbt.net,
	Frederic Heitzmann <frederic.heitzmann@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 03 19:33:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM26o-0004RL-4m
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 19:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934347Ab1KCSdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 14:33:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50966 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933865Ab1KCSdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 14:33:45 -0400
Received: by wwi36 with SMTP id 36so2293170wwi.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Ggwa/XTrBClPGAt5UMpTfa246EznOo3H4sfCug0UR6c=;
        b=H118qU871GACPXFme4jKs+2twbDJgjDL7y6AtcPBS6S8uUnjkDZRn/ceIm3kd7r0aN
         zyWhJU1YgWtCMZ7xvFk8wJcikbcPCea6bqjqd7wK8byF0dQz6LEHyu1+Vv8XHjVTZzGr
         DrUeb2w3OZLobg+knkWvr438GZXqcrud03W+E=
Received: by 10.227.57.67 with SMTP id b3mr13637585wbh.9.1320345223962;
        Thu, 03 Nov 2011 11:33:43 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net. [88.179.84.80])
        by mx.google.com with ESMTPS id ei16sm11650019wbb.21.2011.11.03.11.33.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Nov 2011 11:33:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.4.g5ec82.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184734>

From: Frederic Heitzmann <frederic.heitzmann@gmail.com>

see afd7f1e for more details on git svn dcommit --interactive

Signed-off-by: Frederic Heitzmann <frederic.heitzmann@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 98af8f5..d919baa 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2508,7 +2508,7 @@ _git_svn ()
 			__gitcomp "
 				--merge --strategy= --verbose --dry-run
 				--fetch-all --no-rebase --commit-url
-				--revision $cmt_opts $fc_opts
+				--revision --interactive $cmt_opts $fc_opts
 				"
 			;;
 		set-tree,--*)
-- 
1.7.7.rc2.4.g5ec82.dirty
