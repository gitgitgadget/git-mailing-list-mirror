From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 33/40] whitespace: remediate t9118-git-svn-funky-branch-names.sh
Date: Sat,  6 Aug 2011 18:44:47 +1000
Message-ID: <1312620294-18616-33-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWy-0005WP-Mp
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab1HFIq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:26 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab1HFIqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:22 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oJcGkbSLngo6rvD/kBsqgfXTXqhpooalwA6B0fh0q7o=;
        b=ogpDuHlvuvzyZGbqCcDdlyhi65HBh1V5efgmd4nHbhiIjw7xfc4Y2Oya9XEw/YcPun
         2jy7ZomwAmuK64S5SXKP0FvOk+VDPKkiP5ircwqovXp3xSGg9SuuTQlWwBUmHBj6XKns
         wgquT9qO/GHNuyl/KNvY2Q+nyMZjGz9ctWISo=
Received: by 10.42.80.84 with SMTP id u20mr3181144ick.39.1312620382117;
        Sat, 06 Aug 2011 01:46:22 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178863>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9118-git-svn-funky-branch-names.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 63fc982..52c7436 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -16,11 +16,11 @@ test_expect_success 'setup svnrepo' '
 	svn_cmd import -m "$test_description" project "$svnrepo/pr ject" &&
 	rm -rf project &&
 	svn_cmd cp -m "fun" "$svnrepo/pr ject/trunk" \
-	                "$svnrepo/pr ject/branches/fun plugin" &&
+			"$svnrepo/pr ject/branches/fun plugin" &&
 	svn_cmd cp -m "more fun!" "$svnrepo/pr ject/branches/fun plugin" \
-	                      "$svnrepo/pr ject/branches/more fun plugin!" &&
+			      "$svnrepo/pr ject/branches/more fun plugin!" &&
 	svn_cmd cp -m "scary" "$svnrepo/pr ject/branches/fun plugin" \
-	              "$svnrepo/pr ject/branches/$scary_uri" &&
+		      "$svnrepo/pr ject/branches/$scary_uri" &&
 	svn_cmd cp -m "leading dot" "$svnrepo/pr ject/trunk" \
 			"$svnrepo/pr ject/branches/.leading_dot" &&
 	svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
-- 
1.7.6.362.gf0e6
