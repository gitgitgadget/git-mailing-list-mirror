From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 12/40] whitespace: remediate t5301-sliding-window.sh
Date: Sat,  6 Aug 2011 18:44:26 +1000
Message-ID: <1312620294-18616-12-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWR-0005FS-1H
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab1HFIph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:37 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1HFIpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:33 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AXrennoJhz8ynJ/KKopaAouoNh4mtfY9OauUX7CO32w=;
        b=t+Agr8wFSC037AL8u84HKj4TQ/2Eu6wRHauzf9z8V2SjTAgQSM9jKLryrZn+mDdImD
         7bCit6cTZZEWrPQArxSbPMENbxfGf2D5JsXy80taDZUjY6xWBxM1BQdodtgLdkxesm+G
         1v8ZC7ssmLOBENm8oIgow1ar6csaEhueKTmHE=
Received: by 10.231.25.217 with SMTP id a25mr903786ibc.52.1312620332972;
        Sat, 06 Aug 2011 01:45:32 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178845>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t5301-sliding-window.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 2fc5af6..72ba567 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -11,9 +11,9 @@ test_expect_success \
     'rm -f .git/index* &&
      for i in a b c
      do
-         echo $i >$i &&
-         test-genrandom "$i" 32768 >>$i &&
-         git update-index --add $i || return 1
+	 echo $i >$i &&
+	 test-genrandom "$i" 32768 >>$i &&
+	 git update-index --add $i || return 1
      done &&
      echo d >d && cat c >>d && git update-index --add d &&
      tree=`git write-tree` &&
-- 
1.7.6.362.gf0e6
