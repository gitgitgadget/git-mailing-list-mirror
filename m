From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH] user-manual: be consistent in illustrations to 'git rebase'
Date: Tue, 28 Sep 2010 12:20:24 +0400
Message-ID: <1285662024-4992-1-git-send-email-kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 10:36:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0VfX-0002pD-3s
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 10:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759680Ab0I1Ift (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 04:35:49 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:37516 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759609Ab0I1Ifs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 04:35:48 -0400
X-Greylist: delayed 1055 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2010 04:35:48 EDT
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1P0VO3-0000Ga-UV; Tue, 28 Sep 2010 12:18:08 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1P0VQI-0001J2-68; Tue, 28 Sep 2010 12:20:26 +0400
X-Mailer: git-send-email 1.7.3.6.g64005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157395>

Since we use a-b-c for mywork commits in one place, I think it would be
logical to also use a-b-c too in other illustration on this topic.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fecc4eb..87ca1a7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2424,41 +2424,41 @@ Keeping a patch series up to date using git rebase
 --------------------------------------------------
 
 Suppose that you create a branch "mywork" on a remote-tracking branch
 "origin", and create some commits on top of it:
 
 -------------------------------------------------
 $ git checkout -b mywork origin
 $ vi file.txt
 $ git commit
 $ vi otherfile.txt
 $ git commit
 ...
 -------------------------------------------------
 
 You have performed no merges into mywork, so it is just a simple linear
 sequence of patches on top of "origin":
 
 ................................................
  o--o--o <-- origin
         \
-         o--o--o <-- mywork
+         a--b--c <-- mywork
 ................................................
 
 Some more interesting work has been done in the upstream project, and
 "origin" has advanced:
 
 ................................................
  o--o--O--o--o--o <-- origin
         \
          a--b--c <-- mywork
 ................................................
 
 At this point, you could use "pull" to merge your changes back in;
 the result would create a new merge commit, like this:
 
 ................................................
  o--o--O--o--o--o <-- origin
         \        \
          a--b--c--m <-- mywork
 ................................................
 
-- 
1.7.3.6.g64005
