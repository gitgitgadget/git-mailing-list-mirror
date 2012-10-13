From: Richard Fearn <richardfearn@gmail.com>
Subject: [PATCH] Fix spelling error in post-receive-email hook
Date: Sat, 13 Oct 2012 23:32:50 +0100
Message-ID: <1350167570-11370-1-git-send-email-richardfearn@gmail.com>
Cc: Richard Fearn <richardfearn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 00:33:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNAGY-0001fB-Dq
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 00:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab2JMWcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 18:32:55 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64930 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab2JMWcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 18:32:55 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so754349wib.1
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8afZgAbFbxg9W/6AwSkmURAHjCrjpM5Uj3AOLufGOCE=;
        b=O/miaL+m16tQbRThNH4gozSiOewAoBE7tE0duKm7/g0rtNHe4y+mvaMacIJZyAxqPV
         skvO29tSOrA+2dMw4Ur3Tl+iqIirmi2zTh2t3x8E1X782d4jCbITLSyaRNceQFtMob5C
         22LY+weyfBWFj3Z++iG9UPAjb+fDjXHv97dl96+7tzMF9DZBTR84+Cz4qjYlAgjAcwmB
         teuEdToeAAymWdPT9kR8lGPIF3nHwH7tFEzc56YYFnLz/cviUmAd9fLbuS1xmgHzJBrZ
         IDLuFreqFgMbJ3/QJ9qhHhmLI9xLonDAt6FtHGuHoZ1ggypLwl3NpIlST9+BC6fvy9K5
         rUHw==
Received: by 10.216.226.216 with SMTP id b66mr4847405weq.155.1350167573360;
        Sat, 13 Oct 2012 15:32:53 -0700 (PDT)
Received: from e6500.home.rdf (gateway.richardfearn.co.uk. [82.152.120.206])
        by mx.google.com with ESMTPS id v3sm5448748wiw.7.2012.10.13.15.32.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 15:32:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207583>

Signed-off-by: Richard Fearn <richardfearn@gmail.com>
---
 contrib/hooks/post-receive-email | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 01af9df..b2171a0 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -403,7 +403,7 @@ generate_update_branch_email()
 			echo "            \\"
 			echo "             O -- O -- O ($oldrev)"
 			echo ""
-			echo "The removed revisions are not necessarilly gone - if another reference"
+			echo "The removed revisions are not necessarily gone - if another reference"
 			echo "still refers to them they will stay in the repository."
 			rewind_only=1
 		else
-- 
1.7.11.7
