From: bin0515@gmail.com
Subject: [PATCH] typofix for Documentation/git-cherry-pick.txt
Date: Wed, 25 Nov 2015 20:05:11 +0800
Message-ID: <1448453111-32195-1-git-send-email-bin0515@gmail.com>
Cc: Bin Chen <chenbin0515@thundersoft.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 13:12:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1YvZ-0003e5-O8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 13:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbbKYMLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 07:11:19 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35255 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbbKYMLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 07:11:18 -0500
Received: by pacej9 with SMTP id ej9so56102929pac.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 04:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NrgunIOE4plbLnyi3ER/APthRafAS1Ub4gWsEbqxMiY=;
        b=HzmnBu5WOO7vFGo5rzkJ3O8cYvaslZBKu+J4cp4X4eNIMXsz8KpkKvi4H6ML6rXHfa
         pP5kcJ4JQWsdui3WFXIngis6IGC8CTbshMz0hYxo2+vRD3/NfFFxNh4ZQ7yTdynSFQzZ
         84CFn8zVLFmjTC9c4KOR8QbU1rn9ZR7fICA6K8em5QpDrR2w18KS9LAa2b8KiLZXgEBG
         xzOIcc0hiIR7v3Lb5eymL4IETfSAINKktYtiTc2ZcISo4uQEmaOIHIBuaKSC4TUbOL2l
         5u0pvL+wC3RHhkNf/8yOhZ38Vl+6jT95OjsZVzRTEswNbdHmlQ1p327ba/pEelfn9ByH
         0JvA==
X-Received: by 10.98.66.80 with SMTP id p77mr30898587pfa.100.1448453477584;
        Wed, 25 Nov 2015 04:11:17 -0800 (PST)
Received: from localhost.localdomain ([58.240.115.182])
        by smtp.gmail.com with ESMTPSA id m70sm20558626pfi.65.2015.11.25.04.11.15
        (version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Nov 2015 04:11:16 -0800 (PST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281704>

From: Bin Chen <chenbin0515@thundersoft.com>

Signed-off-by: Bin Chen <chenbin0515@thundersoft.com>
---
 Documentation/git-cherry-pick.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 77da29a..3f44fe0 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -155,7 +155,7 @@ EXAMPLES
 --------
 `git cherry-pick master`::
 
-	Apply the change introduced by the commit at the tip of the
+	Apply the change introduced by the commit at the top of the
 	master branch and create a new commit with this change.
 
 `git cherry-pick ..master`::
-- 
2.5.2
