From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/23] Documentation/git-worktree: add BUGS section
Date: Fri,  3 Jul 2015 20:17:13 -0400
Message-ID: <1435969052-540-5-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:18:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAN-00004v-9i
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676AbbGDASm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:18:42 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34274 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbbGDASa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:30 -0400
Received: by igcsj18 with SMTP id sj18so196948736igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KKK8li3GC05V2UtdT0vWUDn1Mh96FsmOUaF2qc2hVQQ=;
        b=nioNQWVWtXnCOQUKE5tmj6LNW+4ji65TY2LXGkRDQe9p0q+aKx/f8S1F+5jazYeL7V
         TwdbrZI1+p8F5oImeu3y7MulowDs+MwsuQylnt3G3bdZ9jgK/8UABgGXS1WMikeDyfWN
         YaeH7ATTv4P7G3m5iqBNjrBS0XMlOhTCaGCGyUTkc/y8SowUSudPMOFVSdaKswNkqu5F
         ul/IQjAYzJtmw8Z8Soo1qi8jHAT+bTwG7aDbycsHedvnjuSLozEAQH9unoIV3TeG4Zku
         WG5MSPgsCW1+tsu0hLkpMMbqYgrZwHwy1Us+PeTnZ3NL3MYNY4KCOTixYPnlHdrgxGlS
         AhCw==
X-Received: by 10.50.137.100 with SMTP id qh4mr24416781igb.1.1435969110103;
        Fri, 03 Jul 2015 17:18:30 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.29
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273315>

Relocate submodule warning to BUGS and enumerate missing commands.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3d28896..4fbcdd2 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -76,9 +76,6 @@ to `/path/main/.git/worktrees/test-next` then a file named
 `test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
 
-Multiple checkout support for submodules is incomplete. It is NOT
-recommended to make multiple checkouts of a superproject.
-
 COMMANDS
 --------
 prune::
@@ -100,6 +97,21 @@ OPTIONS
 --expire <time>::
 	With `prune`, only expire unused worktrees older than <time>.
 
+BUGS
+----
+Multiple checkout support for submodules is incomplete. It is NOT
+recommended to make multiple checkouts of a superproject.
+
+git-worktree could provide more automation for tasks currently
+performed manually or via other commands, such as:
+
+- `add` to create a new linked worktree
+- `remove` to remove a linked worktree and its administrative files (and
+  warn if the worktree is dirty)
+- `mv` to move or rename a worktree and update its administrative files
+- `lock` to prevent automatic pruning of administrative files (for instance,
+  for a worktree on a portable device)
+
 SEE ALSO
 --------
 
-- 
2.5.0.rc1.197.g417e668
