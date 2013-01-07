From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Documentation on depth option in git clone.
Date: Mon,  7 Jan 2013 19:06:36 +0100
Message-ID: <1357581996-17505-2-git-send-email-stefanbeller@googlemail.com>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: schlotter@users.sourceforge.net, gitster@pobox.com,
	Ralf.Wildenhues@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 19:07:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsH6p-0002pv-1P
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 19:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab3AGSHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 13:07:18 -0500
Received: from mail-ea0-f178.google.com ([209.85.215.178]:48832 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab3AGSHR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 13:07:17 -0500
Received: by mail-ea0-f178.google.com with SMTP id k11so8055881eaa.23
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=m1Pb7xB7uUmSD6JOLxtCzUpBr3yVJK6Um5gwp3BwQVY=;
        b=d5UM8mrq2U1jmZ9dpD125nZ9IQeFjIBRfh9XVYnRXLTwG2Noo87AghG7KsPPPZLmac
         adEdPkXkxGUBGo8XYNB2bflxC2fiXYwXwK8RTbA69FK0iYkwZt3nEmHJ5DWuzS4Zy9Yz
         rm7GMe6qcmOJU92X4aNHcuFZY5ds08gUU9GTE3Kl95UD2WBGzbG7KpdB0DGx5iuiFvig
         9y/R01djsNJsgl65kA5Hy6huZcB72Mmqh1ZufheqMfkyjm+KNfq5UPHBccqK4qAYy/5m
         lwsLg2cdIR7iOrxjWsf+OG/BKs8w6GGdfxbY0JwhHrjQ/csX1EPdPF4KAHXRW+euI555
         CixQ==
X-Received: by 10.14.205.199 with SMTP id j47mr166478696eeo.26.1357582036092;
        Mon, 07 Jan 2013 10:07:16 -0800 (PST)
Received: from localhost (ip-109-91-111-92.unitymediagroup.de. [109.91.111.92])
        by mx.google.com with ESMTPS id v46sm130435614eep.1.2013.01.07.10.07.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Jan 2013 10:07:15 -0800 (PST)
X-Mailer: git-send-email 1.8.1.80.g3e293fb.dirty
In-Reply-To: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212908>

---
 Documentation/git-clone.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7fefdb0..e76aa50 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -186,7 +186,8 @@ objects from the source repository into a pack in the cloned repository.
 	it, nor push from nor into it), but is adequate if you
 	are only interested in the recent history of a large project
 	with a long history, and would want to send in fixes
-	as patches.
+	as patches. The depth should be at least 1. If it is 0 or
+	below, the cloned repository will not be shallow.
 
 --single-branch::
 	Clone only the history leading to the tip of a single branch,
-- 
1.8.1.80.g3e293fb.dirty
