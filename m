From: Dmitry Medvinsky <dmedvinsky@gmail.com>
Subject: [PATCH] Add "--set-upstream" option to bash completion
Date: Fri, 29 Apr 2011 19:57:01 +0400
Message-ID: <1304092621-554-1-git-send-email-dmedvinsky@gmail.com>
Cc: Dmitry Medvinsky <dmedvinsky@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 29 17:59:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFq6C-0003Dh-Jb
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 17:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954Ab1D2P7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 11:59:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49686 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab1D2P7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 11:59:14 -0400
Received: by bwz15 with SMTP id 15so3210285bwz.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=vZ/SUAUbBLGMBepneOFzxSidHV9GNN+vPkoWq5kei/k=;
        b=pXMrxqOrU1kvurLOgFwHjTQ80dQyCzKksRPyJbfulnFmfnNEr6iFiowLmZXDxBInTR
         SmWnGb7E94x3x0vgMtVNWj8g2vgvk0EeD+VgWocA9fvA/sZP0P2FRp/H2HXNTIug2WUP
         jAHPWUILiZ5/031zMvlrONzchOetaV0aTC80A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wyQOK1llNo/NLMkoOwTqnd6+JhosSDu8sNXl4vH9+NW9cMBvgPSKpmvH5XutANm48w
         r4XweB9NEUN9ZjFAEyOCOXrUQbiK6lHYOU4DIW+RxXW5xdMaW0y1RvhpJZPaOFDRvpqk
         mUKBuLeYEXsZMweGhLUydabVEXGLVkfbqY474=
Received: by 10.205.81.76 with SMTP id zx12mr3369987bkb.82.1304092753061;
        Fri, 29 Apr 2011 08:59:13 -0700 (PDT)
Received: from localhost.localdomain ([81.95.28.126])
        by mx.google.com with ESMTPS id q18sm1705044bka.15.2011.04.29.08.59.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 08:59:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172459>

Since version 1.7.5 there is a new help message when pushing a branch with no
upstream telling about the ability to use "--set-upstream" option. That option
should be tab-completed for git push command.

Signed-off-by: Dmitry Medvinsky <dmedvinsky@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9150ea6..cc90e43 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1796,7 +1796,7 @@ _git_push ()
 	--*)
 		__gitcomp "
 			--all --mirror --tags --dry-run --force --verbose
-			--receive-pack= --repo=
+			--receive-pack= --repo= --set-upstream
 		"
 		return
 		;;
-- 
1.7.5
