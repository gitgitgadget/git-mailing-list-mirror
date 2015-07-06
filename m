From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/23] Documentation/git-worktree: add BUGS section
Date: Mon,  6 Jul 2015 13:30:41 -0400
Message-ID: <1436203860-846-5-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:33:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAGm-0000Hv-MJ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbbGFRbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:37 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36049 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbbGFRbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:33 -0400
Received: by iecvh10 with SMTP id vh10so118194464iec.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R3dOjlWHzJ+nCLF6huTQ/eTo1V6FEAiTcAeHeXrDgfY=;
        b=EGBfR4l7wBY8I1coe1G+DD6bDCVOfPfFr/AxyarRuW4rgUnOEmE8XUsbaG1UJOM916
         Y4QSWiULJLeYOWBlJHZBpEpPwL7dp7f2UIVUrN7WccxGeUnvdAxWCulmgZDmDWRIRzzv
         DA4w1P9HOehOFDg7IGhI9BdqbKMqSQgDinAcl8LJ4owRCsB7Sc0ul8NfRni1rJoBLn1m
         9SY5M0fsXEdmsy6I5TPc2qoDWokj3ePOqDYsIkkVS4CQ+AKRs6oB0hs5EZI+jJRXw4aa
         qjb7Noah9SpMS5yaxctKE2nRZuBLvph88437u42u+vYdckO2/C+1n0TGBrgkU6KuW26B
         SsSA==
X-Received: by 10.50.2.3 with SMTP id 3mr71706820igq.34.1436203892696;
        Mon, 06 Jul 2015 10:31:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.31
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273431>

Relocate submodule warning to BUGS and enumerate missing commands.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3d28896..bf6a1e2 100644
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
@@ -100,6 +97,22 @@ OPTIONS
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
+- `list` to list linked worktrees
+- `lock` to prevent automatic pruning of administrative files (for instance,
+  for a worktree on a portable device)
+
 SEE ALSO
 --------
 
-- 
2.5.0.rc1.197.g417e668
