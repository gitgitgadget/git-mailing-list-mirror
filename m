From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 5/6] Add --window-memory option to git-repack
Date: Thu, 12 Jul 2007 07:55:51 -0500
Message-ID: <11842449523248-git-send-email-bdowning@lavos.net>
References: <1184244952554-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 14:56:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yDX-0005TH-Fi
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 14:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763421AbXGLMz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 08:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbXGLMz5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 08:55:57 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:52383 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763255AbXGLMzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 08:55:51 -0400
Received: by silvara (Postfix, from userid 1000)
	id A8C7F52139; Thu, 12 Jul 2007 07:55:52 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <1184244952554-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52277>

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 git-repack.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index b5c6671..156c5e8 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--depth=N]'
+USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
@@ -20,6 +20,7 @@ do
 	-l)	local=--local ;;
 	--max-pack-size=*) extra="$extra $1" ;;
 	--window=*) extra="$extra $1" ;;
+	--window-memory=*) extra="$extra $1" ;;
 	--depth=*) extra="$extra $1" ;;
 	*)	usage ;;
 	esac
-- 
1.5.2.GIT
