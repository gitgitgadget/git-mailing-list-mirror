From: pasky@suse.cz
Subject: [PATCH 2/5] git-gui: Make input boxes in init/clone/open dialogs consistent
Date: Thu, 25 Sep 2008 00:12:51 +0200
Message-ID: <20080924221731.737523976@suse.cz>
References: <20080924221249.037449176@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 00:19:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KichU-0008KG-9P
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 00:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbYIXWRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYIXWRq
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:17:46 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:49863 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752259AbYIXWRn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:17:43 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 3C0EF2AC8FD; Thu, 25 Sep 2008 00:17:32 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/ldialogs-consistent.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96700>

Before, the input boxes would not be sunken and would have larger border,
which is inconsistent with the rest of the inputboxes for repository
locations in the git-gui UI.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/lib/choose_repository.tcl |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index f54d88a..9091316 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -381,7 +381,8 @@ method _do_new {} {
 	label $w_body.where.l -text [mc "Directory:"]
 	entry $w_body.where.t \
 		-textvariable @local_path \
-		-font font_diff \
+		-borderwidth 1 \
+		-relief sunken \
 		-width 50
 	button $w_body.where.b \
 		-text [mc "Browse"] \
@@ -466,7 +467,8 @@ method _do_clone {} {
 	label $args.origin_l -text [mc "Source Location:"]
 	entry $args.origin_t \
 		-textvariable @origin_url \
-		-font font_diff \
+		-borderwidth 1 \
+		-relief sunken \
 		-width 50
 	button $args.origin_b \
 		-text [mc "Browse"] \
@@ -476,7 +478,8 @@ method _do_clone {} {
 	label $args.where_l -text [mc "Target Directory:"]
 	entry $args.where_t \
 		-textvariable @local_path \
-		-font font_diff \
+		-borderwidth 1 \
+		-relief sunken \
 		-width 50
 	button $args.where_b \
 		-text [mc "Browse"] \
@@ -979,7 +982,8 @@ method _do_open {} {
 	label $w_body.where.l -text [mc "Repository:"]
 	entry $w_body.where.t \
 		-textvariable @local_path \
-		-font font_diff \
+		-borderwidth 1 \
+		-relief sunken \
 		-width 50
 	button $w_body.where.b \
 		-text [mc "Browse"] \
-- 
tg: (cdbf2d1..) t/git-gui/ldialogs-consistent (depends on: t/git-gui/avoid-url)
