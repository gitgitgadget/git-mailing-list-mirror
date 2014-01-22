From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] Add cross-references between docs for for-each-ref and show-ref
Date: Wed, 22 Jan 2014 12:23:20 +0100
Message-ID: <1390389800-26769-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 12:23:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5vuR-0002Mk-Ge
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 12:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbaAVLXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 06:23:48 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:44204 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755277AbaAVLXr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 06:23:47 -0500
X-AuditID: 12074412-b7fc96d0000023d5-ea-52dfaa42b40e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 25.5C.09173.24AAFD25; Wed, 22 Jan 2014 06:23:46 -0500 (EST)
Received: from michael.fritz.box (p57A248A5.dip0.t-ipconnect.de [87.162.72.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0MBNOGj007606
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 22 Jan 2014 06:23:45 -0500
X-Mailer: git-send-email 1.8.5.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsUixO6iqOu06n6QwccWFYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M440/mLteAGV8X9YxNZGhib
	OLsYOTkkBEwkbp+YzQphi0lcuLeerYuRi0NI4DKjRO/EiewgCSGBE0wSs78IgthsAroSi3qa
	mUBsEQE1iYlth1hAbGYBB4nNnxsZQWxhgQCJaRM/gtWwCKhKnGqbzwZi8wq4SCz7thtoGQfQ
	MgWJ1deFJjByL2BkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokR4nmhHYzr
	T8odYhTgYFTi4Q3YdS9IiDWxrLgy9xCjJAeTkijvpqX3g4T4kvJTKjMSizPii0pzUosPMUpw
	MCuJ8EatBMrxpiRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnwsoM0Chal
	pqdWpGXmlCCkmTg4QQQXyAYeoA3qYBuKCxJzizPTIYpOMSpKifP6gyQEQBIZpXlwA2Ax+opR
	HOgfYV4LkCoeYHzDdb8CGswENDh6yz2QwSWJCCmpBkbHJY0pTy8+29i+fkub5qmj0zj3OHlv
	zD9sfSFp56Hzj0+KLdN0Yuj5zBeZOaN1SiSH3UMtBomCX9ylK6UNrqx7tjJm8Z6Ium2i2Swf
	zsxauD53h9HBSj5/mQx75n9K02LfvSmy9lMN6M5IE+8s+LMxpK5f8qbf+7YJpWvFTk1aN61S
	9MRiPTMlluKMREMt5qLiRACUv57GrAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240821>

Add cross-references between the manpages for git-for-each-ref(1) and
git-show-ref(1).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
There is a lot of overlap between the functionality of these two
commands.  It might be handy to give the user some hints about when to
use one command vs. the other, but honestly I don't have a gut feeling
for this myself.  Maybe long-term the commands should converge into
one?

 Documentation/git-for-each-ref.txt | 4 ++++
 Documentation/git-show-ref.txt     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 94f5c46..d639abe 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -227,6 +227,10 @@ Documentation
 -------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+SEE ALSO
+--------
+linkgit:git-show-ref[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index b0a309b..ffd1b03 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -175,6 +175,7 @@ FILES
 
 SEE ALSO
 --------
+linkgit:git-for-each-ref[1],
 linkgit:git-ls-remote[1],
 linkgit:git-update-ref[1],
 linkgit:gitrepository-layout[5]
-- 
1.8.5.2
