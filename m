From: Tim Harper <timcharper@gmail.com>
Subject: [PATCH] I don't known anyone who understands what it means when they do a merge and see "file.txt: needs update".  "file.txt: has changes" is much clearer.
Date: Sat,  3 May 2008 01:08:42 -0600
Message-ID: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
Cc: Tim Harper <timcharper@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 09:09:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsBsG-0000e9-5J
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 09:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757654AbYECHIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 03:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757465AbYECHIr
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 03:08:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:39561 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbYECHIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 03:08:47 -0400
Received: by wf-out-1314.google.com with SMTP id 27so291832wfd.4
        for <git@vger.kernel.org>; Sat, 03 May 2008 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/Vom2y4EmrmyNvnhutci479ML0aP+FjDxS+Y+f0hw5k=;
        b=Z3RmIbmrG6ZmDcchHy27aofzEyBNwq5M+Xpb1g8rG7Yo4oGCQSOL5sgh1y2kQwXcTUDzLQ44b4ygiZngJCShisC+W902YdQGAj8Q8Qzhp7d/sHLW9YkLAiusTPr7VQlVgG62mfFcCNR6qj+PocGjIkCJfe2YniegnHak16jELrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rNxNd7zOPLpdbgT1UxvCQaUvHBfcYmAv9FKanJysUfM83lT1SMzY8FYl19s2KJEhAnM/qAu8aj1t+FtKNiX0dYqIlM8ygS76NpYkXmTdAjfm5Nq+O9D+kDFDIu+SUVX6PaMAKMoU6hAQLsn1RhOaoP0W2HHLCOUF48vgwWALCw8=
Received: by 10.142.232.20 with SMTP id e20mr1587294wfh.160.1209798526144;
        Sat, 03 May 2008 00:08:46 -0700 (PDT)
Received: from localhost ( [208.186.134.104])
        by mx.google.com with ESMTPS id 24sm9737212wff.12.2008.05.03.00.08.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 May 2008 00:08:45 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81060>

---
 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a92b25b..971667d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -999,7 +999,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			printf("%s: needs update\n", ce->name);
+			printf("%s: has changes\n", ce->name);
 			has_errors = 1;
 			continue;
 		}
-- 
1.5.5.1
