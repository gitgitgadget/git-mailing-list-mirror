From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 24/40] whitespace: remediate t7403-submodule-sync.sh
Date: Sat,  6 Aug 2011 18:44:38 +1000
Message-ID: <1312620294-18616-24-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWT-0005FS-ET
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab1HFIqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:07 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab1HFIqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:01 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DseVLi1fC7rj+YXriMCo5HTj3qONyAmYUMSDLXHzgDM=;
        b=PUpc1iI3QPhhFk9hBZ8bUGTorRhKqLp7ihIeiVUgCKyntZYmrfqaBDsL04rV5uZAQe
         Ur9XFzRYe9RXYwzZcx4niFNPMVyywr1gkjaG8GWy5W26VQFg5m4+3/CwG3eAeLrNjHuL
         vE1N/DxZGHjLXduf+sARK9/HH8UlAgwwxDKdM=
Received: by 10.42.18.5 with SMTP id v5mr3129585ica.317.1312620361577;
        Sat, 06 Aug 2011 01:46:01 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178849>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7403-submodule-sync.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 95ffe34..13ca668 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -57,7 +57,7 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	 git submodule sync
 	) &&
 	test -d "$(git config -f super-clone/submodule/.git/config \
-	                        remote.origin.url)" &&
+				remote.origin.url)" &&
 	(cd super-clone/submodule &&
 	 git checkout master &&
 	 git pull
-- 
1.7.6.362.gf0e6
