From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Remove more debugging from builtin-fetch
Date: Sun, 16 Sep 2007 02:32:17 -0400
Message-ID: <20070916063217.GC6487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 08:32:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWngC-00086Z-Ng
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 08:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbXIPGcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 02:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbXIPGcW
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 02:32:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44723 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbXIPGcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 02:32:21 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWng1-0005d9-V0; Sun, 16 Sep 2007 02:32:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 908C620FBAE; Sun, 16 Sep 2007 02:32:17 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58300>

Older git-fetch.sh doesn't print "ref: X" when invoked as
`git fetch $url X" so we shouldn't do that now in the new
builtin version.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index d9272ed..20926e0 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -530,8 +530,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 		refs[j] = NULL;
 		ref_nr = j;
-		for (j = 0; refs[j]; j++)
-			printf("ref: %s\n", refs[j]);
 	}
 
 	signal(SIGINT, unlock_pack_on_signal);
-- 
1.5.3.1.1000.g7319b
