From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] Documentation/stash: document short form -p in synopsis
Date: Mon, 13 May 2013 18:15:50 +0530
Message-ID: <1368449154-21882-3-git-send-email-artagnon@gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 14:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubs7F-0003rq-6B
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 14:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab3EMMoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 08:44:21 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:48930 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab3EMMoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 08:44:20 -0400
Received: by mail-pb0-f51.google.com with SMTP id wy7so4430111pbc.10
        for <git@vger.kernel.org>; Mon, 13 May 2013 05:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0v/1gBRo1lmrx5Dji5RXxZkMAuDQsjpcMrVAH3ccFYo=;
        b=OVE6AIU/rg5bOAdCacfqgKwWkqpbWm/xeLTWDvQSVBF2iZwpKsGQX1HlMxB596DmKt
         8+n5nyrJBo2sJRjqa8USdTgtzz+x2PAwOyWBul4xpqnr9M2WIyYKmDWRECW9MIXtNRiv
         QbY/ebFML7I6PbFXJdKeTCCvjHN9G5+CSL6jtYp6BVa+IJQBvyjaFKhKH2DRvf/pzr05
         zW/XL9HTFdA/BrtGXdQS03bletDX2WvhpmFqfy73g90V4dkat2sxgNiijxc6M18XQt8k
         EljFXpISIvkcmiS/YoenfG3vKdN8FNk8HUDVUI54TGHh9eFf+nGY4d8jMLgnhX1xj8MJ
         I+3w==
X-Received: by 10.68.176.197 with SMTP id ck5mr28433922pbc.165.1368449059997;
        Mon, 13 May 2013 05:44:19 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm3050227pbc.12.2013.05.13.05.44.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 05:44:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
In-Reply-To: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224131>

'git stash save' can take -p, the short form of --patch, as an
optional.  Document this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 35a0134..05e462b 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message> [<include-untracked-p>]]
-- 
1.8.3.rc1.57.g4ac1522
