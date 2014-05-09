From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/17] contrib: remove outdated README
Date: Fri,  9 May 2014 14:11:27 -0500
Message-ID: <1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDA-0000aT-8f
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400AbaEITLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:11:54 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:53167 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbaEITLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:11:53 -0400
Received: by mail-yk0-f172.google.com with SMTP id 79so3808007ykr.3
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vMcFH2C4CpTVaIjwMPUXEiwv8VPaK98d9mkMX3bTDz0=;
        b=grNkRZ/y9r91vt5E/e/7RZ6Ky8y3bFhKqhFY3v0tr0kdCattVIyRVGkOV+7KDeN+xP
         FgAnqst4if+g/ayzge3tFp76XN87tQmDVTa4DbkWdEK3j8TfvQGn0wBtqBUrp/bj8xh3
         kRY2gwknlhOZxH2ZtI0Mn+b4mivmCHrnXg/bDtQG3/rZ22nFuRkRGFUgW+WtY5E38ers
         QTMO5L/FldTlZWA0GxH/TMK1R3XGHrJiYg+v2qCiJb3bJXUvawgWOuuvbyjQyK9wrzji
         bcwtnm9wriu/X1EMuGcTPCpXLqt0R+azqMZ8WJzsAZ6to4pBReJ7gUeM0nAp/nk+zeTC
         YUHw==
X-Received: by 10.236.114.2 with SMTP id b2mr17553243yhh.92.1399662712954;
        Fri, 09 May 2014 12:11:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id u5sm7411754yhg.25.2014.05.09.12.11.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:11:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248614>

There is no guideline as for what should be part of contrib.

Some tools are actively maintained, others consist of a single commit.
Some tools have active user-base, some aren't used by anyone. Some tools
are on the path towards the core, others will never get there. Some
tools are already out-of-tree and simply mirrored, others probably
wouldn't survive out-of-tree. Some tools are production-ready, others
don't even run. Some tools have tests, most don't.

Junio has explained that he wrote this a long time ago, when Git was a
different beast, now this no longer applies.

The only way to find out if a tool belongs in contrib or not is to as
Junio.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/README | 43 -------------------------------------------
 1 file changed, 43 deletions(-)
 delete mode 100644 contrib/README

diff --git a/contrib/README b/contrib/README
deleted file mode 100644
index 05f291c..0000000
--- a/contrib/README
+++ /dev/null
@@ -1,43 +0,0 @@
-Contributed Software
-
-Although these pieces are available as part of the official git
-source tree, they are in somewhat different status.  The
-intention is to keep interesting tools around git here, maybe
-even experimental ones, to give users an easier access to them,
-and to give tools wider exposure, so that they can be improved
-faster.
-
-I am not expecting to touch these myself that much.  As far as
-my day-to-day operation is concerned, these subdirectories are
-owned by their respective primary authors.  I am willing to help
-if users of these components and the contrib/ subtree "owners"
-have technical/design issues to resolve, but the initiative to
-fix and/or enhance things _must_ be on the side of the subtree
-owners.  IOW, I won't be actively looking for bugs and rooms for
-enhancements in them as the git maintainer -- I may only do so
-just as one of the users when I want to scratch my own itch.  If
-you have patches to things in contrib/ area, the patch should be
-first sent to the primary author, and then the primary author
-should ack and forward it to me (git pull request is nicer).
-This is the same way as how I have been treating gitk, and to a
-lesser degree various foreign SCM interfaces, so you know the
-drill.
-
-I expect that things that start their life in the contrib/ area
-to graduate out of contrib/ once they mature, either by becoming
-projects on their own, or moving to the toplevel directory.  On
-the other hand, I expect I'll be proposing removal of disused
-and inactive ones from time to time.
-
-If you have new things to add to this area, please first propose
-it on the git mailing list, and after a list discussion proves
-there are some general interests (it does not have to be a
-list-wide consensus for a tool targeted to a relatively narrow
-audience -- for example I do not work with projects whose
-upstream is svn, so I have no use for git-svn myself, but it is
-of general interest for people who need to interoperate with SVN
-repositories in a way git-svn works better than git-svnimport),
-submit a patch to create a subdirectory of contrib/ and put your
-stuff there.
-
--jc
-- 
1.9.2+fc1.28.g12374c0
