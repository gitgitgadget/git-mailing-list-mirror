From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 02/23] Documentation/git-worktree: associate options with commands
Date: Mon,  6 Jul 2015 13:30:39 -0400
Message-ID: <1436203860-846-3-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:33:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAGz-0000PK-Go
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbbGFRbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:34 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34337 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbGFRbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:31 -0400
Received: by igcsj18 with SMTP id sj18so240286722igc.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ieT6INk6wOuTZsOdC5y2UYRDq1J3RYXe1UJBukKVHso=;
        b=pgTAieveDJYb+cvi7K1OlZbh2H1eDI9flDdckj3vaqZSIBjbcX8c9JZTZW5S0iVMTO
         JBOkWKgPJ0gx9qPTjGmarazJm/vDLFmauZ8SyQ28oLGMKU7oxcKcVPqeovPrVCzV627h
         jMFa9XFVCXkj5fVrkv6j9Xz7BeXLjbT0QtjYmpV+eaYLh2+XVU2dDQsU+Pi+o1ZKRlEP
         jUF6hHYuGkwodbYMiO4Q54rwpHyT+fd4MQS6V1pee6grFipIS/YpYydG3PyfLQpZo12j
         zOkN8ZDndTNeFXRrKSDydvIoOGtx+nClw+ec0OxlPeSHd+wia1SQWzxb1nJCmNmB/EWN
         mMEw==
X-Received: by 10.107.35.203 with SMTP id j194mr76596463ioj.45.1436203890928;
        Mon, 06 Jul 2015 10:31:30 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.29
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273434>

git-worktree options affect some worktree commands but not others, but
this is not necessarily obvious from the option descriptions. Make this
clear by indicating explicitly which commands are affected by which
options.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41103e5..1ac1217 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -28,15 +28,15 @@ OPTIONS
 
 -n::
 --dry-run::
-	Do not remove anything; just report what it would
+	With `prune`, do not remove anything; just report what it would
 	remove.
 
 -v::
 --verbose::
-	Report all removals.
+	With `prune`, report all removals.
 
 --expire <time>::
-	Only expire unused worktrees older than <time>.
+	With `prune`, only expire unused worktrees older than <time>.
 
 SEE ALSO
 --------
-- 
2.5.0.rc1.197.g417e668
