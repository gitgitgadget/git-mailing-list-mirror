From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 3/3] Makefile: Add cache-tree.h to the public headers list
Date: Thu, 6 Sep 2007 03:22:51 +0400
Message-ID: <20070905232251.GC331@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 01:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT4eW-00033R-Kt
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 01:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164AbXIEXvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 19:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757140AbXIEXvN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 19:51:13 -0400
Received: from vhq.altlinux.org ([194.107.17.3]:47150 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757079AbXIEXvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 19:51:11 -0400
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id 1E83D1B58157;
	Thu,  6 Sep 2007 03:22:38 +0400 (MSD)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id 22651170DB; Thu,  6 Sep 2007 03:22:51 +0400 (MSD)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57776>

Some external projects (e.g. parsecvs) need cache-tree.h file.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index d50e30b..2b04829 100644
--- a/Makefile
+++ b/Makefile
@@ -283,7 +283,7 @@ LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
 
 LIB_H = \
-	archive.h blob.h cache.h commit.h csum-file.h delta.h grep.h \
+	archive.h blob.h cache.h cache-tree.h commit.h csum-file.h delta.h grep.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-- 
ldv
