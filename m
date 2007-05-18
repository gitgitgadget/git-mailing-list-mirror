From: skimo@liacs.nl
Subject: [PATCH 11/16] git-fetch: skip empty arguments
Date: Fri, 18 May 2007 21:25:00 +0200
Message-ID: <117951630747-git-send-email-skimo@liacs.nl>
References: <11795163053812-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp853-0002MY-53
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502AbXERTZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758077AbXERTZ3
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:25:29 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:55758 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757502AbXERTZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:25:23 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4IJPDZh005205;
	Fri, 18 May 2007 21:25:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 49F847DDAA; Fri, 18 May 2007 21:25:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11795163053812-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47649>

From: Sven Verdoolaege <skimo@kotnet.org>

This makes it easier for scripts to call git-fetch with options
that may or may not be set.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 git-fetch.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 0e05cf1..dbeca14 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -76,6 +76,8 @@ do
 	-*)
 		usage
 		;;
+	'')
+		;;
 	*)
 		break
 		;;
-- 
1.5.2.rc3.783.gc7476-dirty
