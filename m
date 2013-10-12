From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/20] pull: cleanup documentation
Date: Sat, 12 Oct 2013 02:06:58 -0500
Message-ID: <1381561636-20717-3-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOH-0005bT-Hk
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab3JLHNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:24 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:60993 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab3JLHNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:22 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so3462719obc.17
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3D4SwudxwshGRYfJRLvNJA6+T+OlHBTY0xvZVUhgKRw=;
        b=Ge6VEwfrzhQZh2NlBRb1X+Wt8zJYHf81bbRNl/WHCYNPVvNJjw3q4bS2vAiY30Kvv8
         iAoRfQiDGpzFwUM+l38fzETlZ1+OKRWqIbhZgtvJz1N9C6MDJWANKmSUM9PKzC4IUGTa
         x6nvy/eoY5f6UTCyoyS+TJQmSt8eFLgXRZjN2P96KD1OK9Ll3TDZHci2cDVwbzdLfFjw
         LEWXL1IqvEbO/pKTFTxtKLbJGaZGFCUMiHo6rWP5Gl4uNM0c8vILtyfWAiQGbS6IcdYI
         fpxZakBwnlB7wVx3ejOHHZMLx0wCUg28DqCoSrW1vw+owxYDY5PgrXeVccsdQGrN+G2R
         iBRw==
X-Received: by 10.60.68.135 with SMTP id w7mr18238504oet.9.1381562002209;
        Sat, 12 Oct 2013 00:13:22 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm28646817obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236012>

'origin/master' is very clear, no need to specify the 'remotes/' prefix,
or babysit the user.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index beea10b..03a39bc 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -39,7 +39,7 @@ Assume the following history exists and the current branch is
 "`master`":
 
 ------------
-	  A---B---C master on origin
+	  A---B---C origin/master
 	 /
     D---E---F---G master
 ------------
@@ -51,7 +51,7 @@ result in a new commit along with the names of the two parent commits
 and a log message from the user describing the changes.
 
 ------------
-	  A---B---C remotes/origin/master
+	  A---B---C origin/master
 	 /         \
     D---E---F---G---H master
 ------------
-- 
1.8.4-fc
