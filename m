From: "Shun Kei Leung" <kevinlsk@gmail.com>
Subject: [PATCH] git-p4: Fix typo in --detect-labels
Date: Wed, 21 Nov 2007 11:01:19 +0800
Message-ID: <e66701d40711201901n712e17e6x6018a4dc16e75cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, shausman@trolltech.com
To: "Git ML" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 04:01:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IufqO-0006OC-Sk
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 04:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbXKUDBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 22:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbXKUDBV
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 22:01:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:61373 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXKUDBU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 22:01:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so17851ugc
        for <git@vger.kernel.org>; Tue, 20 Nov 2007 19:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=D9vxfeYGXA+7apoV9iGbg1k2VMsESeuwI0zbtG/DsZs=;
        b=UyfJ4C72yEszoIxXtZ+ZBnvsd+EWEwucTvnj42bvb/KQotaC4rJeqjaCH/8vfjgcPrA3P6Lm+PhAPxtYBHzmmI8rjzuMAY26OpnXa0UqN1K1ybwIg1RBOqSjgl4qPh/Ru5aFzkkoqPUBJ6LqNPXrdVZ+e1x7QPA0kuXyPhwGWxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IPVzx/8Mt6rqXJ7eP5bmFbhZJg3irY/L8wzFlRre5tJ2yHYSlTtQyEDOcgv8N1SVDPTgiJH5povDTsn4BpdbdQ3k7F024wsRe7OdQZjEN+wCO8igPd+M549SZiBjXa7Y0nrF6LwuCaiSWoPCxl5tQZS7mJRmyypHQ7AqTqST0yQ=
Received: by 10.78.181.13 with SMTP id d13mr7660024huf.1195614079132;
        Tue, 20 Nov 2007 19:01:19 -0800 (PST)
Received: by 10.78.43.4 with HTTP; Tue, 20 Nov 2007 19:01:19 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65586>

Signed-off-by: Kevin Leung <kevinlsk@gmail.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 65c57ac..66b79b6 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1026,7 +1026,7 @@ class P4Sync(Command):

         l = p4CmdList("labels %s..." % ' '.join (self.depotPaths))
         if len(l) > 0 and not self.silent:
-            print "Finding files belonging to labels in %s" % `self.depotPath`
+            print "Finding files belonging to labels in %s" % `self.depotPaths`

         for output in l:
             label = output["label"]
-- 
1.5.3.6.5.g154c7
