From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] merge: Fix English grammar in please-commit-before-merge message.
Date: Thu,  1 Oct 2015 22:25:33 -0600
Message-ID: <1443759933-10263-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: pyokagan@gmail.com, avarab@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 06:25:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhruj-0003sK-B3
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 06:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbbJBEZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 00:25:40 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34132 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbJBEZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 00:25:40 -0400
Received: by padhy16 with SMTP id hy16so95447984pad.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2015 21:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UE1WhnQbbYJlzw2TbJ5VQXeaFOQs0bAwP6IiKaFeO8A=;
        b=vBmGGA2yCjCbFj2E4I3g9pMoPZyqwnlvQndJWvGdQ2mT1YjDYJzWHcYPMbdbiO3K4e
         KAwXwL9w5mZDV7Piz3PdiizDjxSXsQDQafOHsI1wKqd49IZTJ2o+eG9QXMS1YEEKYw2/
         n0kZ8bXrECWEE7UNCJpNVMSJ6XKhvgPDkyav6n4q7DGZbPOTVw79lZvJmJWEmcCx7+Uh
         ZFP+Sr5dqXMH2kyCEHtyhwwmfbUJNays+VFaYHKHECuwV27O6UzXxElXUi2iOC+ksnuw
         KZ+FGKBbd5B7gJ+6uuzLic/aDei/bIpPZoeMyrOZ28h38PvVCwtV9+f3QUBYBOXD1muf
         tvRw==
X-Received: by 10.66.124.198 with SMTP id mk6mr17044730pab.114.1443759939745;
        Thu, 01 Oct 2015 21:25:39 -0700 (PDT)
Received: from alex-wolverine.lan ([2601:681:4d04:75d8:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id k10sm9617223pbq.78.2015.10.01.21.25.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Oct 2015 21:25:38 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278907>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 advice.c                     | 2 +-
 contrib/examples/git-pull.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index 4965686..4dc5cf1 100644
--- a/advice.c
+++ b/advice.c
@@ -100,7 +100,7 @@ void NORETURN die_conclude_merge(void)
 {
 	error(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	if (advice_resolve_conflict)
-		advise(_("Please, commit your changes before you can merge."));
+		advise(_("Please, commit your changes before merging."));
 	die(_("Exiting because of unfinished merge."));
 }
 
diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
index e8dc2e0..6b3a03f 100755
--- a/contrib/examples/git-pull.sh
+++ b/contrib/examples/git-pull.sh
@@ -69,7 +69,7 @@ as appropriate to mark resolution and make a commit.")"
 die_merge () {
     if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
 	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).
-Please, commit your changes before you can merge.")"
+Please, commit your changes before merging.")"
     else
 	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).")"
     fi
-- 
2.6.0
