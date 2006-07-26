From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/5] git-instaweb: If firefox was not found, just print the
 URL
Date: Wed, 26 Jul 2006 16:34:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261634200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 16:35:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5kT6-0006WE-Cg
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 16:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWGZOed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 10:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWGZOed
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 10:34:33 -0400
Received: from mail.gmx.de ([213.165.64.21]:1157 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751654AbWGZOed (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 10:34:33 -0400
Received: (qmail invoked by alias); 26 Jul 2006 14:34:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 26 Jul 2006 16:34:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Eric Wong <normalperson@yhbt.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24218>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-instaweb.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 242b55e..340ab98 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -245,4 +245,5 @@ esac
 
 start_httpd
 test -z "$browser" && browser=echo
+which "$browser" >/dev/null 2>&1 || browser=echo
 $browser http://127.0.0.1:$port
-- 
1.4.2.rc2.g6a4e
