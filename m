From: Ori Avtalion <ori@avtalion.name>
Subject: [PATCH] Fix typo in filter-branch example
Date: Thu, 13 Aug 2009 19:16:17 +0300
Message-ID: <4a843cdf.1608c00a.504c.0eed@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 18:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbd0s-0003gZ-FK
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 18:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbZHMQSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 12:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZHMQSm
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 12:18:42 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:37311 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZHMQSm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 12:18:42 -0400
Received: by qyk34 with SMTP id 34so690672qyk.33
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:sender:from:to
         :date:subject;
        bh=N+bSi9o/lDvXsgWfxkcpLDL3xM2CIGEO8ueg49BTteY=;
        b=Wy1baG8cBZJeKFOPx2EJooEsiczrGsIKEdfxgGcL7KoU4ZT65Uqbc4gfZmHG25EwHw
         agDVokLcQm5dQBMMmk4harq8mYHrJCUauUOXXPhIDaEwIxRn1Q6QsuoEit/Uec0FtKw0
         yiSoRfSj9YmR9aDjphVZ0Yj30T2+cnYE3L+T0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:sender:from:to:date:subject;
        b=K7NT52B/jyLtmJiZl/DUtIYvYf18+FJ3x0hUEejMDdH5j1BpOzzQr23S2qafVCDBd2
         pMxn5AUfcMUJF/ew3fMXuegmlliMEmhCPvxGtj6xhNXt9UJDmm47D7S2enZFV2DfK+26
         uGdfWwRYT/eg/Y8VH/nGC4AN8NIm7d37TKiIA=
Received: by 10.224.87.3 with SMTP id u3mr1425457qal.235.1250180320533;
        Thu, 13 Aug 2009 09:18:40 -0700 (PDT)
Received: from ?127.0.1.1? ([72.14.241.6])
        by mx.google.com with ESMTPS id 22sm242377ywh.4.2009.08.13.09.18.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 09:18:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125829>

---
 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index ab527b5..8cda87c 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -336,7 +336,7 @@ To move the whole tree into a subdirectory, or remove it from there:
 
 ---------------------------------------------------------------
 git filter-branch --index-filter \
-	'git ls-files -s | sed "s-\t-&newsubdir/-" |
+	'git ls-files -s | sed "s-\t-\tnewsubdir/-" |
 		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
-- 
1.6.4.114.gefd1.dirty
