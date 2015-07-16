From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] Documentation/git-worktree: fix stale "git checkout --to" references
Date: Thu, 16 Jul 2015 18:02:45 -0400
Message-ID: <1437084165-6174-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 00:03:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFrFb-00059u-Nw
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 00:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbbGPWDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 18:03:05 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33849 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbbGPWDE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 18:03:04 -0400
Received: by igvi1 with SMTP id i1so23319516igv.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=TwTvn7eR8yXZAamTM+ih3bDHJjTsALOq8cHCTuOJ9oc=;
        b=zBRsFXhATuqpndCPnfCeSi/bi3X82mzcBe82Xk+ygrJ6+8M1yYNLUPfoUvDTqaS6KT
         0ijAOI3M6x8v8glv1hnt5tlee8gx92dRKnxh9wIutXGsNuFBrnjJgiCtxXEo9qgJh6t6
         EWX26PYR98EFQ9HY3s0maSCzLobyHkqVs4XxyvOu+kNJxuzNtEKaVgi+jhI8F/RYglvZ
         cu+/6T7OI2aO0I51U9lOq9+CIXhrpaiqaxy4h76+u0TpZac6JlhWm4cZjlwk0SHjIGfX
         l8FD27XjbDuhxl8Mdoe7ts4szX4zeh1thMFu1LP6g71LbtVQszj5rQ2e4cSNRaLcTsBS
         ZYew==
X-Received: by 10.50.61.130 with SMTP id p2mr7457777igr.9.1437084183446;
        Thu, 16 Jul 2015 15:03:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g1sm5891708iog.4.2015.07.16.15.03.02
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 15:03:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274046>

These should have been changed to "git worktree add" by b979d95
(checkout: retire --to option, 2015-07-06).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Atop what is already in 'master'...

 Documentation/git-worktree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index da71f50..44619f2 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -18,7 +18,7 @@ DESCRIPTION
 Manage multiple worktrees attached to the same repository.
 
 A git repository can support multiple working trees, allowing you to check
-out more than one branch at a time.  With `git checkout --to` a new working
+out more than one branch at a time.  With `git worktree add` a new working
 tree is associated with the repository.  This new working tree is called a
 "linked working tree" as opposed to the "main working tree" prepared by "git
 init" or "git clone".  A repository has one main working tree (if it's not a
@@ -99,7 +99,7 @@ Each linked working tree has a private sub-directory in the repository's
 $GIT_DIR/worktrees directory.  The private sub-directory's name is usually
 the base name of the linked working tree's path, possibly appended with a
 number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
-command `git checkout --to /path/other/test-next next` creates the linked
+command `git worktree add /path/other/test-next next` creates the linked
 working tree in `/path/other/test-next` and also creates a
 `$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
 if `test-next` is already taken).
-- 
2.5.0.rc2.378.g0af52e8
