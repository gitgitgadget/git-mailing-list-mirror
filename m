From: Julien Danjou <julien@danjou.info>
Subject: [PATCH] git submodule: fix usage line
Date: Tue, 31 Mar 2009 17:50:12 +0200
Message-ID: <1238514612-22123-1-git-send-email-julien@danjou.info>
References: <1238513459-21813-1-git-send-email-julien@danjou.info>
Cc: Julien Danjou <julien@danjou.info>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 17:52:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LogFn-0002gn-7d
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 17:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993AbZCaPuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 11:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbZCaPuQ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 11:50:16 -0400
Received: from coquelicot-sdsl.easter-eggs.com ([213.215.37.94]:42388 "EHLO
	coquelicot-sdsl.easter-eggs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753425AbZCaPuQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 11:50:16 -0400
Received: from cigue.easter-eggs.fr (cigue.easter-eggs.fr [10.0.0.33])
	by rose.easter-eggs.fr (Postfix) with ESMTPS id 5866614178;
	Tue, 31 Mar 2009 17:50:07 +0200 (CEST)
Received: from jdanjou by cigue.easter-eggs.fr with local (Exim 4.69)
	(envelope-from <jdanjou@cigue.easter-eggs.fr>)
	id 1LogE8-0005lM-Mg; Tue, 31 Mar 2009 17:50:12 +0200
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1238513459-21813-1-git-send-email-julien@danjou.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115270>

Actually, you have to set the -b option after the add command.

[This cancel my previous patch]

Signed-off-by: Julien Danjou <julien@danjou.info>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 0a27232..7c2e060 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch] <path>]|[status|init|update [-i|--init] [-N|--no-fetch]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add [-b branch] <repo> <path>]|[status|init|update [-i|--init] [-N|--no-fetch]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
-- 
1.6.2.1
