From: Britto <jabcalves@gmail.com>
Subject: [PATCH] Remove duplicated "is a"
Date: Thu,  5 May 2011 13:57:14 -0300
Message-ID: <1304614634-46181-1-git-send-email-jabcalves@gmail.com>
Cc: Britto <jabcalves@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 18:59:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI1tH-0000HS-K2
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 18:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab1EEQ67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 12:58:59 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43322 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab1EEQ66 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 12:58:58 -0400
Received: by gwaa18 with SMTP id a18so826740gwa.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=QzbysgA/GFo6s/PufREDA6nqOaB61FBYBGD5W6meuXo=;
        b=b/7V6pggJzkDm0lfDb9ceihdlzv2E6d3l1wUxYOrAu+8b3QNSuRUc53FcH966p1IoO
         DogqPp3sgSrR/i7w1FLZRgsLx9Y3XI9q5w8Rius6Eu71Um6b7AR8x5tHIoKTQiYw7sEd
         xO+4HavfGYz637BWqARIEUIGXgXDM/JITRvT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=D6w51pQWThUK45CGvMv/YD8ydMEsezfieNv0tNDLhGyD5IP/9Uw1gscykfO7bmDqhv
         /Ka2CrDBPm9xTC6ej7QhaH8KtWrPpucfA+ZIxPUFE2dLjSU/PfKkqt86/x4ZRZkm9rIa
         zNJ5hpZqOrGQy35c77EUDYy31xHI1jMZ6aDd0=
Received: by 10.236.186.106 with SMTP id v70mr3366314yhm.207.1304614737535;
        Thu, 05 May 2011 09:58:57 -0700 (PDT)
Received: from localhost.localdomain ([189.125.221.200])
        by mx.google.com with ESMTPS id u50sm1069136yhn.50.2011.05.05.09.58.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 09:58:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172850>

Signed-off-by: Britto <jabcalves@gmail.com>
---
 Documentation/diff-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 34f0145..23b605f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -243,7 +243,7 @@ ifdef::git-log[]
 	For following files across renames while traversing history, see
 	`--follow`.
 endif::git-log[]
-	If `n` is specified, it is a is a threshold on the similarity
+	If `n` is specified, it is a threshold on the similarity
 	index (i.e. amount of addition/deletions compared to the
 	file's size). For example, `-M90%` means git should consider a
 	delete/add pair to be a rename if more than 90% of the file
-- 
1.7.5
