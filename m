From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Deprecate git-lost-found
Date: Wed, 7 Nov 2007 22:54:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711072253580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 23:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptnN-0006vE-LK
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759182AbXKGWyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759201AbXKGWyd
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:54:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:59193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759127AbXKGWyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:54:32 -0500
Received: (qmail invoked by alias); 07 Nov 2007 22:54:30 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp021) with SMTP; 07 Nov 2007 23:54:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uQh1/vdSuMqFovyQqpeYESIGumMddLBYPBKqPHA
	gkxOX5GsiycxXc
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63884>


"git fsck" learnt the option "--lost-found" in v1.5.3-rc0~5, to make
"git lost-found" obsolete.  It is time to deprecate "git lost-found".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Maybe we can remove it in another 5 months...

 git-lost-found.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-lost-found.sh b/git-lost-found.sh
index a5a32e7..9cedaf8 100755
--- a/git-lost-found.sh
+++ b/git-lost-found.sh
@@ -5,6 +5,8 @@ SUBDIRECTORY_OK='Yes'
 OPTIONS_SPEC=
 . git-sh-setup
 
+echo "WARNING: '$0' is deprecated in favor of 'git fsck --lost-found'" >&2
+
 if [ "$#" != "0" ]
 then
     usage
-- 
1.5.3.5.1597.g7191
