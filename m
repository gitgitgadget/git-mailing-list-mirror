From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] Documentation/git-worktree: fix incorrect reference to file "locked"
Date: Mon, 20 Jul 2015 01:29:19 -0400
Message-ID: <1437370162-8031-3-git-send-email-sunshine@sunshineco.com>
References: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 07:29:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH3eG-0008Ex-0x
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 07:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbbGTF3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 01:29:48 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35296 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbbGTF3r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 01:29:47 -0400
Received: by igr7 with SMTP id 7so5982258igr.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mEaBfXEQ9mgPL0N0rrpnKDPxWZeR2eHQjd35h0zq0hs=;
        b=YGuUr4AFrXSPd11gqmr6ZwQr2/IATW1si0V6t/VRVc6hun7SxnFCEH+derr1SHVeP0
         SscMMmwc8izw7eVmS6bfNyjD5brlHkxtJBQ/PBNkoxIXXWdPbF5+6mcEbnZqE8IzjyrG
         8rkwVdQSibgci+27pceTNy3kaioUsgv2Gu3wMItLFxTop/ZM49GKt4l6f7sOFA4Ueu2d
         rK6Y/6Ek+cVOMjMbiyAxnKErxQvbbroqJT2Xp4HSjguSI9S5yETYUUxIPIpoHIB1kZzn
         5K3jc+ysvcms7Fv4EH+DemVGeLS3YBLWMTzM1IWcfNMTc/34KJQZxC2AxayrSVV5r9FG
         nQsQ==
X-Received: by 10.107.133.94 with SMTP id h91mr37116435iod.1.1437370186512;
        Sun, 19 Jul 2015 22:29:46 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm13104584iod.25.2015.07.19.22.29.45
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 22:29:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.386.g87d813d
In-Reply-To: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274307>

From: Michael Haggerty <mhagger@alum.mit.edu>

The administrative file to suppress pruning is named "locked", not "lock".

[es: don't touch unrelated "git worktree lock" command; reword commit
message]

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 60e5cf9..a6d8ad7 100644
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
2.5.0.rc2.386.g87d813d
