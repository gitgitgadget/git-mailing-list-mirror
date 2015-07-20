From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/5] Documentation/config: fix stale "git prune --worktree" reference
Date: Mon, 20 Jul 2015 01:29:20 -0400
Message-ID: <1437370162-8031-4-git-send-email-sunshine@sunshineco.com>
References: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 07:30:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH3eQ-0008Ky-JU
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 07:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbbGTF3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 01:29:52 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35976 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbbGTF3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 01:29:48 -0400
Received: by igbij6 with SMTP id ij6so74640955igb.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 22:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cOLKLRMSCi0LP00t+24c0ef4JIdFlHwjEHhVb8Bxl14=;
        b=wmWm1yRe+lduhnE2BSzA+d4xu59s6hQunKCPehHSASYlzdJRp5X57l7HvBMzb7tawf
         wu39FvNXA0Z2sq03FHmmz0Hg6j0rlDNETFyu5BqsLCHiCrcaWnAOJvxkOLX+RbNpwNs9
         JqqlKuJlOHAT4kCuywmvrMMP0HNRMD+jw2Q1xYfeKzHXaQrB10tBi3PUEsuq7eY/fRJr
         o7toAHrggy5/bmE9RLuNdGQEFogK+umR4BYJwuITMoX2wg6e1OzDNf+0xoH7KPxrazSe
         5NORwDHf2itCdtv+bIcf1nKUIZZnoQ6Z5P/ji1t5yitWjDa0kTK/1NJe1aCoz8eQEUIT
         IkVQ==
X-Received: by 10.107.30.209 with SMTP id e200mr31825920ioe.57.1437370187881;
        Sun, 19 Jul 2015 22:29:47 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm13104584iod.25.2015.07.19.22.29.46
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 22:29:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.386.g87d813d
In-Reply-To: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274311>

From: Michael Haggerty <mhagger@alum.mit.edu>

This should have been changed to "git worktree prune" by df0b6cf
(worktree: new place for "git prune --worktrees", 2015-06-29)

[es: reword commit message]

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e37b93..7f65dbb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1293,7 +1293,7 @@ gc.pruneExpire::
 
 gc.pruneWorktreesExpire::
 	When 'git gc' is run, it will call
-	'prune --worktrees --expire 3.months.ago'.
+	'git worktree prune --expire 3.months.ago'.
 	Override the grace period with this config variable. The value
 	"now" may be used to disable the grace period and prune
 	$GIT_DIR/worktrees immediately.
-- 
2.5.0.rc2.386.g87d813d
