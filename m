From: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
Subject: [PATCH] git-svn.txt: advertise pushurl with dcommit
Date: Fri, 10 Oct 2014 00:49:59 +0200
Message-ID: <1412894999-5961-1-git-send-email-sveinung84@users.sourceforge.net>
Cc: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 00:54:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcMbe-0001Wo-Qg
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 00:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbaJIWyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 18:54:39 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:39951 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaJIWyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 18:54:37 -0400
Received: by mail-lb0-f180.google.com with SMTP id n15so2039389lbi.25
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JXlIJ96zoQlm4CqHtyyV+g7jNEoDq2gvByOjVj8AcCk=;
        b=HV5/qsksuBiXorPgIz6razv/m2MhwiY0afl7VdWRuEY9T1szyZsS8sh6v5BL9lStWg
         okYD30fZJQnhMmAxu2ipED4/+47EWqRWYCL8/qoirGpp0ZAlqoUticN4yeLzBXCpTTJa
         SDaB8CJ88Vb7uWoCvB1aFVQYlJZtdIwRdkfkL0+olRtqVTtLLvMg4p1zi4euz5asz8jd
         guLy0o7rDUbCTjE5+ng/1zjmFtCH9Y+18qz50WtIL4ZhEqi+cd2wMWdidM/hnKcN2GxR
         nh3vaweSrvpU7DnfcCLZBhZSCcQg9mDoEek83pLdb+uXFosZ419+Rie/VlkICaCGiwGp
         +VMA==
X-Received: by 10.112.34.239 with SMTP id c15mr491488lbj.64.1412895276297;
        Thu, 09 Oct 2014 15:54:36 -0700 (PDT)
Received: from localhost.localdomain ([217.118.50.150])
        by mx.google.com with ESMTPSA id l13sm1314051lbh.32.2014.10.09.15.54.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 15:54:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Advertise that the svn-remote.<name>.pushurl config key allows specifying
the commit URL for the entire SVN repository in the documenation of git
svn's dcommit command.

Signed-off-by: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
---
 Documentation/git-svn.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 44c970c..161ed29 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -252,6 +252,10 @@ Use of 'dcommit' is preferred to 'set-tree' (below).
 config key: svn-remote.<name>.commiturl
 config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
 +
+Note that the SVN URL of the commiturl config key includes the SVN branch.
+If you rather want to set the commit URL for an entire SVN repository use
+svn-remote.<name>.pushurl instead.
++
 Using this option for any other purpose (don't ask) is very strongly
 discouraged.
 
-- 
2.1.1
