From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-cvsexportcommit.perl: fix typo
Date: Sat, 17 Jun 2006 19:46:40 +0200
Message-ID: <20060617174640.GG1325MdfPADPa@greensroom.kotnet.org>
References: <20060527163641.474.93575.stgit@gandelf.nowhere.earth>
 <20060527163935.474.22794.stgit@gandelf.nowhere.earth>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 19:46:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FresI-0002vG-60
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 19:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWFQRqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 13:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWFQRqN
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 13:46:13 -0400
Received: from smtp16.wxs.nl ([195.121.247.7]:5306 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S1750750AbWFQRqM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 13:46:12 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0J10004KTMOJY1@smtp16.wxs.nl> for git@vger.kernel.org; Sat,
 17 Jun 2006 19:45:56 +0200 (CEST)
Received: (qmail 6596 invoked by uid 500); Sat, 17 Jun 2006 17:46:40 +0000
In-reply-to: <20060527163935.474.22794.stgit@gandelf.nowhere.earth>
To: Yann Dirson <ydirson@altern.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22024>

---
 git-cvsexportcommit.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 57088c3..d1051d0 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -134,7 +134,7 @@ foreach my $f (@afiles) {
 	and $status[0] !~ m/^File: no file /) {
  	$dirty = 1;
 	warn "File $f is already known in your CVS checkout -- perhaps it has been added by another user. Or this may indicate that it exists on a different branch. If this is the case, use -f to force the merge.\n";
-	warn "Status was: $status\n";
+	warn "Status was: $status[0]\n";
     }
 }
 foreach my $f (@mfiles, @dfiles) {
-- 
1.4.0-dirty
