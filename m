From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] completion: complete rebase --edit-todo
Date: Sat, 22 Jun 2013 13:33:21 +0530
Message-ID: <1371888201-23675-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIqL-0004nZ-Sl
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab3FVIGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:06:40 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48068 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab3FVIGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:06:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so8758536pbb.5
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=bojEsV0wbw5R6Z0oJ3YuT/oZcRCZMBvbZh85w1H9D4w=;
        b=zDvRC6oPKE5QkW2QqUMA5pqSL4CaJJQD/8dq01kzk7D3+xtpqXnZ1Jf62krDzy+ngM
         lj6cMtFDIJUXX21DLqu8qZAe7EUckHLMoXnVYPclycH1Mb8i6L8LP97Gv0aArcug3gLf
         pQ/Dj3nC0JE+FtKgWa+9/5SDZ6NfHkTRCdZDcGVDDzi5+QgmVL+reb+jngzo0Dgn/wlA
         4T9105X6yeCADpH3UfsYKhNg8qniJfn+0PgXlE8/TgWy3gr32GIg1G0fUXdyaSj+zdn1
         S/SoPF/xOY9mTcxTZLgREaIgl94ZxIgqI7H3Yi7NdOIxddG/Zec6Z8Qge8bzZg3O+/iM
         aLTw==
X-Received: by 10.66.144.104 with SMTP id sl8mr19744749pab.9.1371888398279;
        Sat, 22 Jun 2013 01:06:38 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id i16sm9382802pag.18.2013.06.22.01.06.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:06:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228692>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fd9a1d5..43c6226 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1624,7 +1624,7 @@ _git_rebase ()
 			--preserve-merges --stat --no-stat
 			--committer-date-is-author-date --ignore-date
 			--ignore-whitespace --whitespace=
-			--autosquash
+			--autosquash --edit-todo
 			"
 
 		return
-- 
1.8.3.1.487.gd3dfebf.dirty
