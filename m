From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] pull: change the description to "integrate" changes
Date: Sun,  7 Jul 2013 20:02:15 +0100
Message-ID: <c13c6c4b15d1cfcaa140a8d71676ce330c32e9b9.1373223663.git.john@keeping.me.uk>
References: <cover.1373223663.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 21:02:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvuEa-0001Hg-1x
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 21:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab3GGTCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 15:02:53 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:52697 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab3GGTCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 15:02:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 090656064CE;
	Sun,  7 Jul 2013 20:02:52 +0100 (BST)
X-Quarantine-ID: <Pad+B0AlYxyy>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pad+B0AlYxyy; Sun,  7 Jul 2013 20:02:51 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 6117C6064F3;
	Sun,  7 Jul 2013 20:02:40 +0100 (BST)
X-Mailer: git-send-email 1.8.3.2.855.gbc9faed
In-Reply-To: <cover.1373223663.git.john@keeping.me.uk>
In-Reply-To: <cover.1373223663.git.john@keeping.me.uk>
References: <cover.1373223663.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229800>

Since git-pull learned the --rebase option it has not just been about
merging changes from a remote repository (where "merge" is in the sense
of "git merge").  Change the description to use "integrate" instead of
"merge" in order to reflect this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-pull.txt | 2 +-
 git-pull.sh                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 24ab07a..6ef8d59 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -3,7 +3,7 @@ git-pull(1)
 
 NAME
 ----
-git-pull - Fetch from and merge with another repository or a local branch
+git-pull - Fetch from and integrate with another repository or a local branch
 
 
 SYNOPSIS
diff --git a/git-pull.sh b/git-pull.sh
index 6828e2c..ecf0011 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -5,7 +5,7 @@
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
 USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
-LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
+LONG_USAGE='Fetch one or more remote refs and integrate it/them into the current HEAD.'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
-- 
1.8.3.2.855.gbc9faed
