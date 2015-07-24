From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/6] Documentation/git-worktree: fix broken 'linkgit' invocation
Date: Fri, 24 Jul 2015 00:00:52 -0400
Message-ID: <1437710457-38592-2-git-send-email-sunshine@sunshineco.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 06:01:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUB1-0004GR-OU
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbbGXEBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:01:35 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35345 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbGXEBd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:01:33 -0400
Received: by iecri3 with SMTP id ri3so9644364iec.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rLkuWszA1Xkyk56doJtzUvfkV9evaksU21Gx2Qo0Ngc=;
        b=qCUT1kgaS6wbcnALANrMYZCWj+A1/ukHGFUOcAWygh/DBqLhC2sbzo/eQRDBYjD/dj
         rT8XBw1RuWHnjJksSEfv8kP5RYgjew9J825YHWjMUwRdgCwYYiT8Zs/0WaY3uWjizC1z
         mM8IGHT7/Bl4djoTwwc/kKqMteDSr3hOqRjZWWI67PkJfsm8tzvVtt3hSfzx4hTaym4C
         t47dpNYyFdQhX4jHKaNJAZL7iGKxb68nHrGLIhMN8fa0Qcj3356x/H5kxjfp3/CwFQSd
         unstzW8kyRUxfX3G09+TfXafrgI8/KknZmYq598pnrNEdS2TzpFGj7cT5GMdwO7K9ZXL
         tnHg==
X-Received: by 10.50.102.7 with SMTP id fk7mr2909763igb.49.1437710492908;
        Thu, 23 Jul 2015 21:01:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j2sm4370288ioo.43.2015.07.23.21.01.31
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:01:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.407.g68aafd0
In-Reply-To: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274541>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 332dd77..400b313 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -27,7 +27,7 @@ bare repository) and zero or more linked working trees.
 When you are done with a linked working tree you can simply delete it.
 The working tree's administrative files in the repository (see
 "DETAILS" below) will eventually be removed automatically (see
-`gc.worktreePruneExpire` in linkgit::git-config[1]), or you can run
+`gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
 
-- 
2.5.0.rc3.407.g68aafd0
