From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/23] Documentation/git-checkout: fix incorrect worktree prune command
Date: Fri,  3 Jul 2015 20:17:10 -0400
Message-ID: <1435969052-540-2-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:18:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAL-00004v-4M
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbbGDASa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:18:30 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35989 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645AbbGDAS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:28 -0400
Received: by iecvh10 with SMTP id vh10so84539380iec.3
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o/wXB0uj9/2yxI1YkvVoTbR07tokJpN4Qa/2OZQY6ZA=;
        b=BH3oEazgwqqVb5dAENCU5TLlzmpsMaoeyxCE+XKXk5Fi38KsTaOW2Jd8knuK93RFlB
         SBBPIEc314ZM8FuVc++3CVlmWb/rCLDoNNgO1o1rzlgDt1fYH0PAMM5vXHRF+hrPUyN5
         qu+/1EVLh2zG9KMd1BPDart/ekVG/axLX2QAGoFXeWKm/fLx8Yw7+nFW6lGY/5Ovtpt6
         0jj8Ry+r45T1xZIgP8I56hUiCVY1J8pRYRJ/0seO+jF/OXXLEpjps6OLFnKTpSe7oUQX
         JpcODWic2q9/V/wQlNsayxTyIHZiPGN3SZMMepA2aPaQH96W5FdkWv5aNiEqA3mEKcqf
         /IhQ==
X-Received: by 10.42.198.145 with SMTP id eo17mr20015291icb.19.1435969107472;
        Fri, 03 Jul 2015 17:18:27 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.26
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273314>

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
