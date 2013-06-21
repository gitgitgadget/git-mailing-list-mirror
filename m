From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/16] ls-remote doc: fix example invocation on git.git
Date: Fri, 21 Jun 2013 16:42:33 +0530
Message-ID: <1371813160-4200-10-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKQ-0003cP-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403Ab3FULQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:25 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34752 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030379Ab3FULQR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:17 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so7534655pbb.8
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=U4AkLOO9CNS1H6Aag6oUmA6iRq1jwgmCuWCsHc39Tfo=;
        b=Tlk6k7QjvRHfAKxZqNVgjTuyGQJi5R8NziUSXqVHX7pKgiRxUydS5FKUrBQxSVSJ/U
         Paa9Oy5LSaQg9WzUMmOKHZoycSGJyUz2f4nCQoXcq3QsISc9r7c3sOxRd3v6U337caxb
         Jq1Un+6se6vAFkFC0y+aNiJCO3BAUcR6jT53FjI4B2TaKTUScsttRW+EGOG0u+VKY1o0
         kaW2CP3nZaGiKhWjsisnNEFTkOmgeIzzOz3dI90kzPPXLUm5ArWxuVSbpuMf8cKH23dj
         MdwLVWH1lFDmm/PXeCCbOK/PMchNJn9xT5s+m0WIRTPa2rU1DH2ddjDKTC3HE7wsRiI3
         xIlw==
X-Received: by 10.66.158.9 with SMTP id wq9mr15839558pab.189.1371813377136;
        Fri, 21 Jun 2013 04:16:17 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228603>

Under the EXAMPLES section, there is one invocation on the git.git
repository that attempts to list the refs master, pu, and rc.  The ref
rc does not exist in today's repository, so remove it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-ls-remote.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 774de5e..a24b8b6 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -67,10 +67,9 @@ EXAMPLES
 	7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
 	c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
 	0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
-	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
+	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu
 	5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
 	c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
-	b1d096f2926c4e37c9c0b6a7bf2119bedaa277cb	refs/heads/rc
 	$ echo http://www.kernel.org/pub/scm/git/git.git >.git/branches/public
 	$ git ls-remote --tags public v\*
 	d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
-- 
1.8.3.1.499.g7ad3486.dirty
