From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] Documentation/git: fix stale "MULTIPLE CHECKOUT MODE" reference
Date: Thu, 16 Jul 2015 20:17:02 -0400
Message-ID: <1437092222-11131-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 02:17:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFtLK-0006k9-Lr
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 02:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472AbbGQARa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 20:17:30 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34411 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbbGQAR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 20:17:29 -0400
Received: by iebmu5 with SMTP id mu5so66970024ieb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6V4gfISB4+vGUUznz9u/2i4gQjJ+cSx6xF8zmkKylFQ=;
        b=ZYeHxl+QPNStT0xA01GVe/s3HsSyEV1D8y36OKU8lw1jg5QclHg0vE53N0UE9QMrrW
         Hnf4Evy2KJagexeqOIs693HIkE3B4e4QkAOczdW8QkquVxOLVI2bIEt3a5e5EOHWiXwn
         PnHTa/n9BQukEspSTRvi3Nsm5PkTM15YIGWcYzJEUIriGZMuRBeK7DXXs9Z4xQLO9NAo
         q6cIQpZO8caJOkRSX4M8/RZtSmqBW7JsH5/FppJ8ihAI0S4mPUFkM/fC3mZZxHZjEf6a
         1oyYMe+ii1EAvgaD9ICuxNY3piMInz298zm1DWfecvrV9fbIGbviSdrlBlLythL0q08e
         Aoig==
X-Received: by 10.107.25.18 with SMTP id 18mr15172306ioz.39.1437092248831;
        Thu, 16 Jul 2015 17:17:28 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id n6sm2429686igv.17.2015.07.16.17.17.27
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 17:17:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274052>

This should have been changed by 93a3649 (Documentation: move linked
worktree description from checkout to worktree, 2015-07-06).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d4aa3f6..eb38027 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -845,7 +845,7 @@ Git so take care if using Cogito etc.
 	normally in $GIT_DIR will be taken from this path
 	instead. Worktree-specific files such as HEAD or index are
 	taken from $GIT_DIR. See linkgit:gitrepository-layout[5] and
-	the section 'MULTIPLE CHECKOUT MODE' in linkgit:checkout[1]
+	the linkgit:git-worktree[1] for
 	details. This variable has lower precedence than other path
 	variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
 
-- 
2.5.0.rc2.378.g0af52e8
