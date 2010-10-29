From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH] Fix a formatting error in git-merge.txt
Date: Fri, 29 Oct 2010 10:33:54 -0500
Message-ID: <4ccaebae.e91dec0a.1ac5.ffff8876@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 17:44:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBr7X-0008O7-4n
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 17:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934067Ab0J2Pnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 11:43:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42647 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511Ab0J2Pnn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 11:43:43 -0400
Received: by gyg4 with SMTP id 4so2038718gyg.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:date:subject
         :to;
        bh=8KKX+9f0mvEs8K+6pbjk8H33mCYYqxKG5X8bbJPuSfc=;
        b=kJd2+WTRkmd55p/GuPBgt13fRRGg+jSytCNwmiY6QbAU53ogelfEO6osUbs95EndEB
         1UuG0wwSCdw/eeramquGyxZ6CDJ3DSPqYqWidV2OLOZ2x5x6FEViG+LWkaSyTKkjuCid
         PZ/46KDmpyZNs4nZyER2dzPgK2wW7vdAmdBMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:subject:to;
        b=qJjb7lRRubksTOamNRMIpdXfjgB/jTiIMid7e59V9Nr3Kjage392rCqwidp0Ak9fEI
         dpLXRPhA834mtmlMnQDRmkvogGJkVSE7Q7QWwp0idQINLg4/FXODRaOCMerMgDoBuW9i
         rHeb/TW8qhvVrLIygwgVSb9pDVcfAG3IkOSAU=
Received: by 10.150.217.4 with SMTP id p4mr21251937ybg.167.1288367022773;
        Fri, 29 Oct 2010 08:43:42 -0700 (PDT)
Received: from localhost ([144.92.149.221])
        by mx.google.com with ESMTPS id i69sm1803150yha.8.2010.10.29.08.43.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 08:43:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160334>

Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
---
Without this patch, the lines below get set in typewriter mode, which
just looks wrong.

 Documentation/git-merge.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 84043cc..d43416d 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -59,13 +59,13 @@ include::merge-options.txt[]
 -m <msg>::
 	Set the commit message to be used for the merge commit (in
 	case one is created).
-
-	If `--log` is specified, a shortlog of the commits being merged
-	will be appended to the specified message.
-
-	The 'git fmt-merge-msg' command can be
-	used to give a good default for automated 'git merge'
-	invocations.
++
+If `--log` is specified, a shortlog of the commits being merged
+will be appended to the specified message.
++
+The 'git fmt-merge-msg' command can be
+used to give a good default for automated 'git merge'
+invocations.
 
 --rerere-autoupdate::
 --no-rerere-autoupdate::
-- 
1.7.3.2.148.g04a2.dirty
