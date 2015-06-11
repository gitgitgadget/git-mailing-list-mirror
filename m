From: "Simon A. Eugster" <simon.eu@gmail.com>
Subject: [PATCH] Documentation clarification on git-checkout regarding ours/theirs
Date: Thu, 11 Jun 2015 13:39:26 +0200
Message-ID: <1434022766-45397-1-git-send-email-simon.eu@gmail.com>
Cc: "Simon A. Eugster" <simon.eugster@eps.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 13:39:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z30pg-0006Bf-On
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 13:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbbFKLjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 07:39:37 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33330 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbFKLjf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 07:39:35 -0400
Received: by wiwd19 with SMTP id d19so72548803wiw.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=blBtmeXnvCdyn0EAU05zQh+yLKhzLQtcgIrrWAcaWnc=;
        b=eNzE8xgJYR4q/sCbqX3iGuOveNsEw03mnDFYkOEImeehKrD77x3LGFD82ZkGoONA0A
         nSEIGaN79GLF8JaO9MQ14/9xEle5fPTHdD0FWbgbv7X4sSc8O+P5yRjUEDGAjHkpoCKP
         LC3u2ds9+QJJioeP9c9pm+4vaUQ2hZoSoP/gqkdyVFHBR6pB+CSQww948FxzgpxQsYUD
         LhZasV5BiGv++eZY4SxKlWsMHAkaYyDxHRffrQnJxqtMLuiq9oWF2db40mwMiRz5lOHZ
         nyG2koyEZYD1WBFzkrtl6UohknhXfbi0hbS/V6G64cJeIINCQII1jFef8bcHWWQat4ee
         WtaQ==
X-Received: by 10.194.175.65 with SMTP id by1mr16178277wjc.152.1434022774510;
        Thu, 11 Jun 2015 04:39:34 -0700 (PDT)
Received: from sie-matemint.localdomain ([194.9.120.21])
        by mx.google.com with ESMTPSA id fa8sm1243069wib.14.2015.06.11.04.39.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 04:39:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271402>

From: "Simon A. Eugster" <simon.eugster@eps.ch>

Signed-off-by: Simon A. Eugster <simon.eugster@eps.ch>
---
 Documentation/git-checkout.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d263a56..5c3ef86 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -115,7 +115,11 @@ entries; instead, unmerged entries are ignored.
 --ours::
 --theirs::
 	When checking out paths from the index, check out stage #2
-	('ours') or #3 ('theirs') for unmerged paths.
+	('ours', HEAD) or #3 ('theirs', MERGE_HEAD) for unmerged paths.
++
+After a `git pull --rebase`, for example, 'ours' points to the remote
+version and 'theirs' points to the local version. See linkgit:git-merge[1]
+for details about stages #2 and #3.
 
 -b <new_branch>::
 	Create a new branch named <new_branch> and start it at
-- 
1.8.5.1
