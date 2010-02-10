From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] Documentation: reword --thin description
Date: Tue,  9 Feb 2010 21:14:11 -0800
Message-ID: <1265778851-5397-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 06:14:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf4u5-0006X9-BI
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 06:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab0BJFOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 00:14:16 -0500
Received: from mail-yw0-f173.google.com ([209.85.211.173]:49014 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab0BJFOP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 00:14:15 -0500
Received: by ywh3 with SMTP id 3so7396528ywh.22
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 21:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sc1yi50emNMpp3N6qpyMoQSB2+wRb5/dBmeCxe6EYmc=;
        b=dscGvAE9Xe6Byq/MpsKYi5oKut1U5eC7VYujNnoJ9UUYpR5XwxJW5RGgAnFJ2S9JiJ
         yk66qZE9uA6MePkcq2Hro2owNRernL4p9MuyfhIihcn9B/xWGvE2jP3z5ffb99d7kTai
         wwD04pJvlfXoBDArWtWEpFdMV8qKncuAYEEWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Oas4qQO48QR8CXjEtmKE4ZZg0ZG1oSbL3pf3B2EGyH3R+xrShWggMiigKUkQX7dVaq
         qWlpNH08LkxZCVJBMdQJn29X7RbEw6ThYKC8WpYNyywx7SeNJSP4tUOtVwGNFDv/0PGj
         kdhCum02/j1B10bJCF2JOS4Xewy6N70WSMDRk=
Received: by 10.151.60.3 with SMTP id n3mr1598379ybk.32.1265778854654;
        Tue, 09 Feb 2010 21:14:14 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm322346yxe.36.2010.02.09.21.14.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 21:14:13 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139486>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Don't know if git-push needs to say that --thin is passed to send-pack.

 Documentation/git-fetch-pack.txt |    4 ++--
 Documentation/git-push.txt       |    6 +++---
 Documentation/git-send-pack.txt  |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index e9952e8..2b4e4dd 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -44,8 +44,8 @@ OPTIONS
 	locked against repacking.
 
 --thin::
-	Spend extra cycles to minimize the number of objects to be sent.
-	Use it on slower connection.
+	Spend extra cycles minimizing the number of sent objects.
+	Use it with a slow connection.
 
 --include-tag::
 	If the remote side supports it, annotated tags objects will
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index bd79119..a14bc9c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -141,9 +141,9 @@ useful if you write an alias or script around 'git push'.
 
 --thin::
 --no-thin::
-	These options are passed to 'git send-pack'.  Thin
-	transfer spends extra cycles to minimize the number of
-	objects to be sent and meant to be used on slower connection.
+	These options are passed to 'git send-pack'.  A thin
+	transfer spends extra cycles minimizing the number of
+	sent objects and is meant to be used with a slow connection.
 
 -v::
 --verbose::
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 8178d92..0a78dac 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -48,8 +48,8 @@ OPTIONS
 	Run verbosely.
 
 --thin::
-	Spend extra cycles to minimize the number of objects to be sent.
-	Use it on slower connection.
+	Spend extra cycles minimizing the number of sent objects.
+	Use it with a slow connection.
 
 <host>::
 	A remote host to house the repository.  When this
-- 
1.7.0.rc2
