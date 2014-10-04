From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] completion: add --show-signature for log and show
Date: Sat,  4 Oct 2014 16:20:38 -0700
Message-ID: <1412464838-72028-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Michal Privoznik <mprivozn@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 01:20:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaYcu-0004hx-LT
	for gcvg-git-2@plane.gmane.org; Sun, 05 Oct 2014 01:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbaJDXUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2014 19:20:22 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:59729 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaJDXUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2014 19:20:22 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so3336059pab.2
        for <git@vger.kernel.org>; Sat, 04 Oct 2014 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8YGqwqs5JE2x6PQ/u4mT7/wpJGw/3kT69GxMACP7K78=;
        b=WmBTukv8NJjavGP5OAW3xggr1bXA6otpozZz/5DMLC0GGjeQ5/Q2lAfzECyxwatNjL
         8eJ69BPUiO0x2XSptaew2CAQLMj3dGO2j0DwR3kdFXVCSTTR3eAsRMO49m48F1rOuVxR
         onP55cXL2JdDU5z6f/S0MfBbF8meLNxwbvG+cpKWsmY0ykEewMwapDGbX3HZs6BwFlOb
         fPgzcobLBVssetJ1ISzQDxJiuh+rNFpO4LKl+qfYTIbcrrg0AQnA9K2VSwvnPrjfUWsG
         dhs0e0vz34FF4zoyrRMdIX2dpuV3uS+G3+JLNoJjmZNEb9BAMOZkTqyq2cfdsh2CEk+e
         4s3g==
X-Received: by 10.68.241.138 with SMTP id wi10mr43109pbc.126.1412464821628;
        Sat, 04 Oct 2014 16:20:21 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id hs8sm9637807pbc.35.2014.10.04.16.20.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 04 Oct 2014 16:20:20 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.331.gf8f34bb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257894>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5ea5b82..2ed230a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1467,6 +1467,7 @@ _git_log ()
 			--abbrev-commit --abbrev=
 			--relative-date --date=
 			--pretty= --format= --oneline
+			--show-signature
 			--cherry-pick
 			--graph
 			--decorate --decorate=
@@ -2344,6 +2345,7 @@ _git_show ()
 		;;
 	--*)
 		__gitcomp "--pretty= --format= --abbrev-commit --oneline
+			--show-signature
 			$__git_diff_common_options
 			"
 		return
-- 
2.1.2.331.gf8f34bb
