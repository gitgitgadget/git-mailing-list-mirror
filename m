From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 01/23] Documentation/git-checkout: fix incorrect worktree prune command
Date: Mon,  6 Jul 2015 13:30:38 -0400
Message-ID: <1436203860-846-2-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:33:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAGm-0000Hv-32
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbbGFRbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:36 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37289 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbbGFRba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:30 -0400
Received: by igau2 with SMTP id u2so16956973iga.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o/wXB0uj9/2yxI1YkvVoTbR07tokJpN4Qa/2OZQY6ZA=;
        b=BylemSrG1wcSp/RYQ5bZptdpKR+qYZY59Q5oHapYGgQHoGEUT0ezMUTolO6XE2kO3g
         88i6JVJdjrItdfsGkZYX4HqS7JSS265mO3oLUKbhY+XhY9fOu7CE7dctp1hZf2a83d2k
         Wu9AHhKhSC1sAIKk2mxL3pLIwbd2oA3SH/tIq8PWHT7iZttMrsdB/qT5cVsTj1GFI3H5
         /dYEA2mkhLyfyM+wXq6FhssOf7Q7AN2aC7SfKKknvbJJhjMdSmEMX0uMUfcpMmyiVoWe
         +OBR1Qp1+rx8Lvu1K6Kb3MGuFLl4hwb/Iz4Xm82B2YlQ0L7nK+ga5caQDPem/Jjs6dxs
         4g4w==
X-Received: by 10.107.36.140 with SMTP id k134mr27287917iok.5.1436203889798;
        Mon, 06 Jul 2015 10:31:29 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.28
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273433>

This was missed when "git prune --worktrees" became "git worktree prune".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 72def5b..ce223e6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -444,7 +444,7 @@ When you are done with a linked working tree you can simply delete it.
 The working tree's entry in the repository's $GIT_DIR/worktrees
 directory will eventually be removed automatically (see
 `gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
-`git prune --worktrees` in the main or any linked working tree to
+`git worktree prune` in the main or any linked working tree to
 clean up any stale entries in $GIT_DIR/worktrees.
 
 If you move a linked working directory to another file system, or
-- 
2.5.0.rc1.197.g417e668
