From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 4/5] Add --window-bytes option to git-repack
Date: Wed, 11 Jul 2007 22:14:17 -0500
Message-ID: <11842100582743-git-send-email-bdowning@lavos.net>
References: <11842100581060-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 05:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8p8L-0005sZ-TP
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 05:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765354AbXGLDOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 23:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934421AbXGLDOW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 23:14:22 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:63044 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1765354AbXGLDOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 23:14:17 -0400
Received: by silvara (Postfix, from userid 1000)
	id 36E9E52138; Wed, 11 Jul 2007 22:14:18 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <11842100581060-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52240>

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 git-repack.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index b5c6671..4cff812 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--depth=N]'
+USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-bytes=N] [--depth=N]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
@@ -20,6 +20,7 @@ do
 	-l)	local=--local ;;
 	--max-pack-size=*) extra="$extra $1" ;;
 	--window=*) extra="$extra $1" ;;
+	--window-bytes=*) extra="$extra $1" ;;
 	--depth=*) extra="$extra $1" ;;
 	*)	usage ;;
 	esac
-- 
1.5.2.GIT
