From: Johan Sageryd <j@1616.se>
Subject: [PATCH] worktree: Correct typo in documentation
Date: Thu, 30 Jul 2015 01:03:48 +0200
Message-ID: <1438211028-22403-1-git-send-email-j@1616.se>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Johan Sageryd <j@1616.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 01:04:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKaOy-0000y4-HK
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 01:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbbG2XEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 19:04:40 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33734 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbbG2XEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 19:04:40 -0400
Received: by lbbyj8 with SMTP id yj8so16455868lbb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 16:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RfBZsZXZNwesqU1bqYcWDqaEf+dbELJrTcMNVqlcgCI=;
        b=ETXj7DbebDdlV0pu4zmGry3aUI//efqru066xl8zn+ArF9e+5NvMoX7d6SnbZI9tbe
         hfucdUvtoMuV5b+LgE1U2HumyU6fwAkQhFGkdle5VBITe2lTMsIzQ3dEYmdiaWte3nWx
         qgWmlLeYbTw3Ax/FAHDEE21FTRUgIuBnkBvyqTv0qDVIq5j8R7dOGf8tsJIxPjHKt3EL
         AzQ1AjlJPtpp3mx8yGyw00ubUVlMNX5fyVRrp/FATsrMrgtswR4hkK1/INUHeythvfXj
         2oxFViVw2Qz4QcuW6jUI60DuEhh4FwsHkWOjww0qjfqaTSZWMJCOawerlCyDFZwKWPwu
         uznQ==
X-Gm-Message-State: ALoCoQlm0eD+WfyaGKWt5AC78Q5Fu6CoEu+q0E5nolNtKsPoHHAcAUxIBfrR9G8WSXzwEOawh2nz
X-Received: by 10.153.4.40 with SMTP id cb8mr40595470lad.39.1438211078575;
        Wed, 29 Jul 2015 16:04:38 -0700 (PDT)
Received: from fu.lan (h40n11-jak-a12.ias.bredband.telia.com. [217.209.53.40])
        by smtp.googlemail.com with ESMTPSA id k9sm5603573lbp.13.2015.07.29.16.04.37
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Jul 2015 16:04:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274963>

Signed-off-by: Johan Sageryd <j@1616.se>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3387e2f..d9d90b5 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -39,7 +39,7 @@ repository so that they do not get automatically pruned.
 
 If a linked working tree is stored on a portable device or network share
 which is not always mounted, you can prevent its administrative files from
-being pruned by creating a file named 'lock' alongside the other
+being pruned by creating a file named 'locked' alongside the other
 administrative files, optionally containing a plain text reason that
 pruning should be suppressed. See section "DETAILS" for more information.
 
-- 
2.5.0
