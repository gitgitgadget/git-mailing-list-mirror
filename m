From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 3/3] git-submodule: Motivate --record with an example use
 case
Date: Thu, 08 Nov 2012 22:35:14 -0500
Message-ID: <ca0fc739741b72b50641e382a6162a829447237f.1352431675.git.wking@tremily.us>
References: <cover.1352431674.git.wking@tremily.us>
Cc: Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 04:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWfUa-0003hh-2j
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 04:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab2KIDmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 22:42:39 -0500
Received: from vms173009pub.verizon.net ([206.46.173.9]:17051 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757501Ab2KIDmi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 22:42:38 -0500
Received: from odin.tremily.us ([unknown] [72.68.90.158])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MD700AI6BMJ6Y00@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 08 Nov 2012 21:42:20 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 1929B68EDC8; Thu,
 08 Nov 2012 22:42:19 -0500 (EST)
X-Mailer: git-send-email 1.8.0.3.gc2eb43a
In-reply-to: <cover.1352431674.git.wking@tremily.us>
In-reply-to: <cover.1352431674.git.wking@tremily.us>
References: <20121029222759.GI20513@sigill.intra.peff.net>
 <cover.1352431674.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209201>

From: "W. Trevor King" <wking@tremily.us>

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 9a99826..d4e993f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -220,6 +220,14 @@ OPTIONS
 	is not set either, `HEAD` will be recorded.  Because the branch name
 	is optional, you must use the equal-sign form (`-r=<branch>`), not
 	`-r <branch>`.
++
+The recorded setting is not actually used by git; however, some
+external tools and workflows may make use of it.  For example, if the
+upstream branches still exist and you have a recorded branch setting
+for each of your submodules, you can update all of the submodules to
+the current branch tips with:
++
+	git submodule foreach 'git checkout $submodule_branch && git pull'
 
 -f::
 --force::
-- 
1.8.0.3.gc2eb43a
