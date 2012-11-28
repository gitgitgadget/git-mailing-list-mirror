From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] submodule update: document exisiting -r form for --rebase
Date: Wed, 28 Nov 2012 13:28:22 -0500
Message-ID: <0450c75cbab3119ea830e8e8e3484649062377d8.1354127227.git.wking@tremily.us>
Cc: "W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:29:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdmNQ-0004mU-23
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab2K1S2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:28:37 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:45523 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab2K1S2g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:28:36 -0500
Received: from odin.tremily.us ([unknown] [72.68.95.13])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME700B69NBGYB40@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Nov 2012 12:28:29 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id AC70C6E193F; Wed,
 28 Nov 2012 13:28:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354127308; bh=huYtg/1QAhtHPEi0+supbQ8vXqNWOcMkck226rzJwWI=;
	h=From:To:Cc:Subject:Date;
	b=i9C3inzohi/d9cT5h+q2+eW7drzx7wNr9byGweNs6onAp1LjYg1gaZHS7tffZ+1kJ
 /22FX/WcPWAMwAAnWIIDJfFJNT3WjMyq6S9yI9fU9ItXrxIxJp/lHHHCWjfkZ2pd1K
 i4J2kZ38T/mCzgswvcoNh0tqTYh03dUEr0LycAM0=
X-Mailer: git-send-email 1.7.8.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210756>

From: "W. Trevor King" <wking@tremily.us>

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 3 ++-
 git-submodule.sh                | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b4683bb..ec78fa7 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [-r|--rebase]
 	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
@@ -251,6 +251,7 @@ OPTIONS
 	If the key `submodule.$name.update` is set to `merge`, this option is
 	implicit.
 
+-r::
 --rebase::
 	This option is only valid for the update command.
 	Rebase the current branch onto the commit recorded in the
diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..f2e8026 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [-r|--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--] [<path>...]"
-- 
1.8.0.2.gcc766b6
