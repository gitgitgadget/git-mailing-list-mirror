From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH] minor error in user-manual.txt
Date: Fri, 29 Jun 2007 14:41:54 +0100
Message-ID: <E1I4GjS-0001lf-Sb@mercury.localnet>
Reply-To: bill.pursell@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 15:32:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Gaj-0001iz-0L
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 15:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764210AbXF2Ncu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 09:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763782AbXF2Ncu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 09:32:50 -0400
Received: from hu-out-0506.google.com ([72.14.214.227]:57351 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763470AbXF2Nct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 09:32:49 -0400
Received: by hu-out-0506.google.com with SMTP id 19so479911hue
        for <git@vger.kernel.org>; Fri, 29 Jun 2007 06:32:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:subject:reply-to:message-id:date:from;
        b=OyFL1y297lZME0piipj0wVDSVTuxN/hNTrg9P0sejZZe3y+TeRbm6Tu2PyD565k4/Ub9rrUbNvaYM2P0Xf00Ve6bLZTXDE8jIQRSsxuKkxKQ9/FTqqpH/h86iSk6Gy8ad8EiYB75GbL8ibUooOJfjf0BLVALg9aFru3DUZZW85w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:reply-to:message-id:date:from;
        b=ROHOr335epmCy6u7W155iI4rAeCJBEvuepZzjceMmDwVNREujijklpM6DYA3WwVqd7MbXynuvVq8JtlePq2YMIPw1giqiNVMqjX8tYEoeDrDASwoYPw4nyyUHtG3159v4fyAzRXHFp0w1mdLtBsIfbxXe92A8Of3S0euKnKi5CE=
Received: by 10.66.242.20 with SMTP id p20mr2734307ugh.1183123967173;
        Fri, 29 Jun 2007 06:32:47 -0700 (PDT)
Received: from mercury.localnet ( [82.17.45.135])
        by mx.google.com with ESMTP id k28sm6997973ugd.2007.06.29.06.32.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jun 2007 06:32:46 -0700 (PDT)
Received: from wrp by mercury.localnet with local (Exim 4.63)
	(envelope-from <wrp@mercury.localnet>)
	id 1I4GjS-0001lf-Sb
	for git@vger.kernel.org; Fri, 29 Jun 2007 14:41:54 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51176>

From: William Pursell <bill.pursell@gmail.com>
Date: Fri, 29 Jun 2007 14:08:29 +0100
Subject: [PATCH] minor error in user-manual.txt

---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0bfa21b..b0b49c8 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -890,7 +890,7 @@ $ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
 -------------------------------------------------
 
 will use HEAD to produce a tar archive in which each filename is
-preceded by "prefix/".
+preceded by "project/".
 
 If you're releasing a new version of a software project, you may want
 to simultaneously make a changelog to include in the release
-- 
1.4.4.4
