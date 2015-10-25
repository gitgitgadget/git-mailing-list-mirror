From: Xue Fuqiao <xfq.free@gmail.com>
Subject: [PATCH] user-manual: fix the description of fast-forward
Date: Sun, 25 Oct 2015 08:28:43 +0800
Message-ID: <1445732923-57550-1-git-send-email-xfq.free@gmail.com>
Cc: git@vger.kernel.org, Xue Fuqiao <xfq.free@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 25 02:30:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq9Cv-0000yh-Bo
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 02:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbbJYAaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 20:30:06 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36781 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbJYAaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 20:30:05 -0400
Received: by pacfv9 with SMTP id fv9so158001433pac.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Q/nC+grRmcCoL89rZ/WHGotjbNFJZmBrKJLyvl8xS5o=;
        b=qiwLaWKWZELtvb7VtFHEuZk4tJUaL9Wnku6B9+f9j/OnTceS2hs/1fi0aYi/WL9GTO
         SBIY6kq5RRXAQLllGznwEPFhOuaPawWXtsqhOzL0haiBTQVXI6MhECUmrfJw5enpxoN4
         uSKEQjouSB9KQzCeIKHiOKN6rvRR38EaAqYeJDKaIevzrSQoSuaSaRP3eqQee+m+gM+B
         dtzuRgF5bQkucpa1iHDiNV+E9QHAWq7/cVieQYqAAsXcMa2MTbEnkXtUhldH9GsN1gWV
         YlYkmaGJVxnR7uXMGTl20Alujx5zFmRJtIZ50ersGc9Y8csp0CqBXSYkl6PkETR7mcMv
         ypyg==
X-Received: by 10.66.161.35 with SMTP id xp3mr13731507pab.13.1445733003925;
        Sat, 24 Oct 2015 17:30:03 -0700 (PDT)
Received: from XFQ-Mac.vpn ([119.81.160.236])
        by smtp.gmail.com with ESMTPSA id d13sm26153713pbu.20.2015.10.24.17.30.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Oct 2015 17:30:03 -0700 (PDT)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280135>

Currently, the "Fast-forward merges" section of user-manual.txt says if the
current branch is a descendant of the other, Git will perform a fast-forward
merge, but it should the other way around.  Correct this issue and improve
wording.

Signed-off-by: Xue Fuqiao <xfq.free@gmail.com>
Thanks-to: Junio C Hamano <gitster@pobox.com>
---

Discussed in $gmane/280042.

 Documentation/user-manual.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1b7987e..d68df13 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1431,11 +1431,11 @@ differently.  Normally, a merge results in a merge commit, with two
 parents, one pointing at each of the two lines of development that
 were merged.
 
-However, if the current branch is a descendant of the other--so every
-commit present in the one is already contained in the other--then Git
-just performs a "fast-forward"; the head of the current branch is moved
-forward to point at the head of the merged-in branch, without any new
-commits being created.
+However, if the current branch is an ancestor of the other--so every commit
+present in the current branch is already contained in the other branch--then Git
+just performs a "fast-forward"; the head of the current branch is moved forward
+to point at the head of the merged-in branch, without any new commits being
+created.
 
 [[fixing-mistakes]]
 Fixing mistakes
-- 
2.6.2
