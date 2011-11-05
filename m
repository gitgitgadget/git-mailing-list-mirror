From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] completion: Update rebase completion
Date: Sat,  5 Nov 2011 01:07:05 -0700
Message-ID: <1320480425-31066-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 05 09:11:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMbM1-000255-25
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 09:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab1KEIHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 04:07:12 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36449 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1KEIHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 04:07:09 -0400
Received: by ggnb2 with SMTP id b2so3313738ggn.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=kY1+M043VXhWUSbM1DPR6GD25SaBwdDktNp6AeG6a60=;
        b=Q6HNmtivIQyufTXSrT/7qX3XirLXrrnfuL2lCvI2Q89jYTM/j6LXh8QOv4uUsz7YfF
         6vpx+YgoxMPyQTs+V8lVmGQGLsYsa+jq45/dv148xLEp4R1VoWu0yYL/r5joVeDcwFi6
         OiVMz966QGDyt/MdOxBRikp7h7a7WcKPIOxnw=
Received: by 10.50.207.38 with SMTP id lt6mr19109522igc.43.1320480428136;
        Sat, 05 Nov 2011 01:07:08 -0700 (PDT)
Received: from earth (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id g1sm16703956pbv.2.2011.11.05.01.07.06
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 01:07:07 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 05 Nov 2011 01:07:05 -0700
X-Mailer: git-send-email 1.7.7.1.431.g10b2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184835>

--no-autosquash is missing in addition to a few others.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 98af8f5..5aa8b91 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1764,7 +1764,8 @@ _git_rebase ()
 			--preserve-merges --stat --no-stat
 			--committer-date-is-author-date --ignore-date
 			--ignore-whitespace --whitespace=
-			--autosquash
+			--autosquash --no-autosquash --no-ff
+			--rerere-autoupdate --root
 			"
 
 		return
-- 
1.7.7.1.431.g10b2a
