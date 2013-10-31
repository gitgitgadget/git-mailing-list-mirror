From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 03:25:34 -0600
Message-ID: <1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:32:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbocP-00087Y-PI
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab3JaJci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:38 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:61496 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3JaJch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:37 -0400
Received: by mail-oa0-f45.google.com with SMTP id i4so2793407oah.32
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D90XLhWMk2WGOkNmYvBjm4M4D09HWBDaLNnqH9LrM3I=;
        b=j4yvnMqFw10FflWaVNBNLNKdh9EZ1xdG3Xar9yCsJvwoTgJILwI1q0AAuxOseire31
         8A4Jh49FDNJYghxgKbwxkJId0K6/T2AY2gSiiu9VEdm1QHLbWewAYPyezie8vw1POWEt
         htOwYNd7Na8zI6gWqK9YjqzDZTVuymAsiSzJqBmzTx6+L/JBV8abeq2xrNCApDTq2PgT
         2/Sojsnfm8xEfBnNp6m1e1PBEaNvBRTqnGjYdmdztM7BeHOmkGhZbLrcXdzD1T0dr+Gs
         hybTfGPrU7FCYFei3FhJhtJQqB9TPGm6EJ0D2sonrSYZjGubYvrWKSMMMj90b81nbATv
         R86g==
X-Received: by 10.60.45.227 with SMTP id q3mr1899862oem.10.1383211956552;
        Thu, 31 Oct 2013 02:32:36 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id j9sm5393298oef.8.2013.10.31.02.32.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237087>

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
1.8.4.2+fc1
