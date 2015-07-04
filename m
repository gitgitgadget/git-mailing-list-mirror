From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/23] Documentation/git-worktree: associate options with commands
Date: Fri,  3 Jul 2015 20:17:11 -0400
Message-ID: <1435969052-540-3-git-send-email-sunshine@sunshineco.com>
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
	id 1ZBBAL-00004v-PQ
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbbGDASe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:18:34 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34264 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbbGDAS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:28 -0400
Received: by igcsj18 with SMTP id sj18so196948478igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ieT6INk6wOuTZsOdC5y2UYRDq1J3RYXe1UJBukKVHso=;
        b=cpcwDIIy87IqBVim2kvEHAWA8zmf+KRTQqDyBElxm65+QondiC/CL+fcWAUfk8jgkm
         RSCUOxew7U5UZ7Su12ATe9yKMEarUXUOseKGW4DG1ZhFK8cxI6aRUzKBL06YDXvmGC63
         JTYhZyHnJYyLao8BICf4XKxmtYFK4gE6jYGeEsujwlP2/SoBmy78KcSor6W6t3ecZRBy
         pEJy+PapBN65kS/O0vIEDrU9ZAe+UmEC4shPTrtzJsLUTurP5tDchGdtkseZTn+41hHr
         VDEQjCbet/uC8DKc4idsQOjRxBi7Fu7vzxVnmTueZjLCPOsWJOvuLiDscVDwxX60oVa/
         xZ+g==
X-Received: by 10.42.48.83 with SMTP id r19mr21516442icf.3.1435969108325;
        Fri, 03 Jul 2015 17:18:28 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.27
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273317>

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
