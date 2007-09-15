From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/5] Add transport.h to LIB_H as transport.o is in LIB_OBJS
Date: Sat, 15 Sep 2007 03:23:10 -0400
Message-ID: <20070915072310.GD20346@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 09:23:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWS05-0003fr-KC
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 09:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbXIOHXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 03:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbXIOHXP
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 03:23:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35947 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbXIOHXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 03:23:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWRzj-0006i1-1e; Sat, 15 Sep 2007 03:23:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0196020FBAE; Sat, 15 Sep 2007 03:23:11 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58227>

Any changes to transport.h probably will require rebuilding a
number of object files so we should make sure it is included
in our set of headers.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ac17510..9c7fba7 100644
--- a/Makefile
+++ b/Makefile
@@ -284,7 +284,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h
+	mailmap.h remote.h transport.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
-- 
1.5.3.1.84.gaf82-dirty
