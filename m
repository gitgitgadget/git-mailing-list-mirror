From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-helpers: trivial cleanup
Date: Tue,  7 May 2013 18:45:15 -0500
Message-ID: <1367970315-5053-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 01:46:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZrap-0002Vh-RL
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 01:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab3EGXql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 19:46:41 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:44758 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229Ab3EGXqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 19:46:40 -0400
Received: by mail-yh0-f48.google.com with SMTP id f35so295584yha.35
        for <git@vger.kernel.org>; Tue, 07 May 2013 16:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=WTTa8t3DRxoFAiMBUX5XMlsYvZHC+rTaMpPtPezPg6g=;
        b=m4F0Ua2n//9joZZtG3kKnfvfvla96nwLLAwMSCIYSCfT6ygy78VmPSHQpFrMIPbnSE
         GEZJXv66IgnIIBsq+u+qzTP6a5WEtIDgufKoXwli2w3vdjWgWPu4ZNH6iG+UNX9W7Dj+
         V0GbCGBl4qj0DzCMpJl75lckmlwO51fVom57P8VmX8DxXSKKyNWPGy9ZOellPcq7LVWD
         aIm3M8DT4Ps++0jqS77ZqUOgbLT6GZE64cJdUOnNp5fE8BNqRMmAg6PMQa96mPQe/VUk
         gFzDKrPJhfLx6TIA/BA7A0SLZetQZCMYoJrCvnZ0NKQxEjWdQM1CFuA1AWCJFajKdnl0
         TJfQ==
X-Received: by 10.236.202.143 with SMTP id d15mr4218781yho.16.1367970399928;
        Tue, 07 May 2013 16:46:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d51sm10010170yho.14.2013.05.07.16.46.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 16:46:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223631>

The comment was copied from hg-fast-export, not used anymore.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 1 -
 contrib/remote-helpers/git-remote-hg  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index c19ed0e..3604c7d 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -323,7 +323,6 @@ def export_branch(branch, name):
         count += 1
         if (count % 100 == 0):
             print "progress revision %s (%d/%d)" % (revid, count, len(revs))
-            print "#############################################################"
 
     repo.unlock()
 
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 06920f2..96ad30d 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -453,7 +453,6 @@ def export_ref(repo, name, kind, head):
         count += 1
         if (count % 100 == 0):
             print "progress revision %d '%s' (%d/%d)" % (rev, name, count, len(revs))
-            print "#############################################################"
 
     # make sure the ref is updated
     print "reset %s/%s" % (prefix, ename)
-- 
1.8.3.rc1.553.gac13664
