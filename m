From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] Documentation/git-worktree: fix stale "git checkout --to" references
Date: Thu, 16 Jul 2015 18:09:43 -0400
Message-ID: <1437084583-6382-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 00:10:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFrMC-0007eI-1B
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 00:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbbGPWKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 18:10:14 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36476 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbbGPWKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 18:10:13 -0400
Received: by igbij6 with SMTP id ij6so24817871igb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=YJCHuxyuenP+knOuUAqz4rrx2KLgb0/4G4hYNBn5714=;
        b=sZ1BY8eqRpzc9N6xw1KuGQxfGBzLAjxeSiNCuIWZdnYLiDQGo3V18UPoBqewbIsmBz
         Lk1M1AxtsJj9zeWmQyFF63zwbqQ5oK6aRj4Hq52T95lY50xlayyVygFio24M0hJ2Hia8
         0sPDLZOmcJZl85iS/Y/do/ViDv8ZT44mDHCa6NLDPbcaclUhKRl7KyAcE8QJtePrZ1ps
         MsmiIuwJXcB2BBrR7oUUKFW5tFhaN49e6HoPrBlMg0YtEMgo7MphwjfkodEFc/SZ8mr4
         Q1iAfx5PRSKjyQvIOB6sup6FAuz6m6FjWu65OgBuGNvqj9Disfg+Ng/i/Dyv+sw1/IJo
         1NrA==
X-Received: by 10.107.150.145 with SMTP id y139mr10024533iod.128.1437084612716;
        Thu, 16 Jul 2015 15:10:12 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id qs10sm2222741igb.14.2015.07.16.15.10.10
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 15:10:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274048>

These should have been changed to "git worktree add" by fc56361
(worktree: introduce "add" command, 2015-07-06.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1[1]: Reference the correct commit (fc56361, not b979d95)
in the commit message. Sorry for the noise.

[1]: http://article.gmane.org/gmane.comp.version-control.git/274046

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
