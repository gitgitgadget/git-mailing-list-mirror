From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/6] completion: bash: remove old wrappers
Date: Wed, 30 Apr 2014 06:07:40 -0500
Message-ID: <1398856065-2982-2-git-send-email-felipe.contreras@gmail.com>
References: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 13:18:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfSX2-0003IN-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761AbaD3LS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:18:26 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:39840 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758693AbaD3LSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:18:25 -0400
Received: by mail-yk0-f182.google.com with SMTP id 142so1322509ykq.13
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9hAmhMz402JqCofzbdkzocbsz58gfnF2wNRVeEeh/Jk=;
        b=e8LJUL4FkRa2hyXzRuQpauJ2Nw6JKxyCQ+9NT1q6tGSlevptuzg5SYWUjdABwmkBRP
         OLIVav0ecz5A9x7WFuWnTB/cuYIH4zE6N/MbBR9+J1mCXc2v4Q2mHnZmgCVeEWa39J/C
         OUuGevzaluYMa65XCtxorLC8NpN4677DwZGlhvTGEDJz8Kk6oyLaxwiDuc2N1TU488Wp
         2MNfq1gQ4jdpO8zDyt8GhfkfqQKSlRESYv0Fq5I1Ed8yLX0F7UWf1jPOEvaF0fS9ivZc
         9lssqPoIC1XETO+eMGf12GxurSDyyiO5S/q7uJR7kWSwthyu+v0UbMokRvuoH1NkC1Cz
         xLDw==
X-Received: by 10.236.115.198 with SMTP id e46mr4864180yhh.24.1398856704611;
        Wed, 30 Apr 2014 04:18:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b45sm42275736yhl.31.2014.04.30.04.18.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 04:18:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.11.g71fb719
In-Reply-To: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247700>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9525343..6e331d2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2656,18 +2656,6 @@ __git_complete ()
 		|| complete -o default -o nospace -F $wrapper $1
 }
 
-# wrapper for backwards compatibility
-_git ()
-{
-	__git_wrap__git_main
-}
-
-# wrapper for backwards compatibility
-_gitk ()
-{
-	__git_wrap__gitk_main
-}
-
 __git_complete git __git_main
 __git_complete gitk __gitk_main
 
-- 
1.9.2+fc1.11.g71fb719
