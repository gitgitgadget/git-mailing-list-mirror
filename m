From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 25/40] whitespace: remediate t7500-commit.sh
Date: Sat,  6 Aug 2011 18:44:39 +1000
Message-ID: <1312620294-18616-25-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcXO-0005kJ-LD
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab1HFIqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:06 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1HFIqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:04 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lgMf0quPG9qdUqF7t2r439w3NTryW88ebKBJ/gC7Vjc=;
        b=cia9kRNrUx1iMdt70LyVEdht/7BNpH+3GgGSL6CDNrY2f9WLmZZOKU6uumW2zvPADI
         +sqgmyRqde3lwSE6XBpS8dvqnEx3hNNnIjs2XGDaBqfaJY8oeVSV/bBZwAdjRfPN0taT
         nND7U/BIGI5Wmwk/1xwKECaPKxzKPz28A9mDE=
Received: by 10.42.132.10 with SMTP id b10mr3269351ict.76.1312620363851;
        Sat, 06 Aug 2011 01:46:03 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178867>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7500-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 1c908f4..ac64632 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -142,7 +142,7 @@ test_expect_success 'using alternate GIT_INDEX_FILE (1)' '
 	cp .git/index saved-index &&
 	(
 		echo some new content >file &&
-	        GIT_INDEX_FILE=.git/another_index &&
+		GIT_INDEX_FILE=.git/another_index &&
 		export GIT_INDEX_FILE &&
 		git add file &&
 		git commit -m "commit using another index" &&
-- 
1.7.6.362.gf0e6
