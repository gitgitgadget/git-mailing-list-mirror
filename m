From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 6/6] Mention to the user that they can reorder commits
Date: Thu, 19 Feb 2009 07:37:01 +0000
Message-ID: <200902190737.01121.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 08:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La3UR-00035k-4o
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 08:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbZBSHhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 02:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbZBSHhF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 02:37:05 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:20229 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbZBSHhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 02:37:04 -0500
Received: by wf-out-1314.google.com with SMTP id 28so363579wfa.4
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 23:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:date:to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ezuSHmlGWXap7xSL+QZd+ejPx0UH73kenLPvicurIxg=;
        b=nwoO+aYeUtexGlOaf/faJssz1pcR+DRAwiX4hZrVgeNpC/hNRkzfoT1pt+3h0zwRAv
         qu5Ow0SXkqxCKiVbM6BvkX987nfPTUltZVav1qWyhVCJ8FRBqd4zTXGMY2AZ+1xjr+nr
         I83gmL/GShhv3OIqdlfLBNUR9cEfPtsKCSigo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:date:to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=eH9bgei09ACWiTvXbkOL/AZ6/6cYwwSNdCj+mQ5j9QBAkvcqSeD4wFf1aH+sOAfVgQ
         qCBJaEfX/kMo/Dhh4w9yi6wt/4RXB20gMtrAXCn96zq0kh50QRfi/BPcXXd+yOdoDnC7
         YKPnD0ADMPKbs4wE3rNdf2T0HmJKV1HVODBRc=
Received: by 10.142.207.8 with SMTP id e8mr2428656wfg.278.1235029023671;
        Wed, 18 Feb 2009 23:37:03 -0800 (PST)
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id 28sm1160861wfd.5.2009.02.18.23.37.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 23:37:03 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110640>

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 git-rebase--interactive.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3dc659d..2f58922 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -733,6 +733,7 @@ first and then run 'git rebase --continue' again."
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
+# You can reorder the lines to reorder the commits.
 #
 EOF
 
-- 
1.6.2.rc1.3.g7d31b.dirty
