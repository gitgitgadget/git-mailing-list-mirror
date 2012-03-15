From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] Documentation/difftool: add deltawalker to list of valid diff tools
Date: Thu, 15 Mar 2012 12:28:26 -0400
Message-ID: <1331828906-5943-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 15 17:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8DXw-0005bl-Fw
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 17:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031683Ab2COQ2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 12:28:55 -0400
Received: from mail-fa0-f46.google.com ([209.85.161.46]:32804 "EHLO
	mail-fa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031681Ab2COQ2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 12:28:54 -0400
Received: by faas1 with SMTP id s1so613903faa.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=UD+dJWr9PE5oaK1o2ZdGOvKHRVCuthRiVrvZ/V9jEmo=;
        b=aI6s/puCGCLtsqGIfb+232Ec2s3kEApVSgIniMILac/2JcycPecKp8OgMISv0D7hp/
         kA0LWHJIKMVi9HHuI2h6TVlyJzcxkuwCmxGVe1Lv0cTomdtmdaw+gVIDzeGbULtE5Ktp
         BIJb4r1jV619PtiwWADy5OzlhhWwnI8fXWbDpBcHQbMy48tztd0cWiNQzIzvlKzYSKnz
         qdIRM+l5SEFuX8T1y/Ic+1jhgXoXUvRVZcOTmkYG52Ut9Ph9EZNnLiF24xrjPwK0lViP
         yPJWYP9lQjAy+gMZ0ruhIoA38l4mBFwdyQeMBgIoRH4/y1jMrgGzRwc6YniyJIMze1oo
         9YHg==
Received: by 10.224.102.8 with SMTP id e8mr8544340qao.50.1331828932485;
        Thu, 15 Mar 2012 09:28:52 -0700 (PDT)
Received: from localhost ([99.38.69.118])
        by mx.google.com with ESMTPS id eo4sm4887954qab.16.2012.03.15.09.28.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Mar 2012 09:28:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193217>

deltawalker has been supported since 284a126c3ef3, but was not added
to the list of valid diff tools reported by 'git difftool --help'.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

The list of valid tools seems prone to error. Right now, there is nothing
that tells people to update this documentation when new config files are
added to 'mergetools'.  Should I add a README to 'mergetools' with
instructions to update this file?  Or would it be better to replace the
list in the help string with a more general statement like "<tool> must
match one of the files located in $(git --exec-path)/mergetools"?


 Documentation/git-difftool.txt |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 19d473c..fe38f66 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -32,8 +32,9 @@ OPTIONS
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
 	Valid diff tools are:
-	araxis, bc3, diffuse, emerge, ecmerge, gvimdiff, kdiff3,
-	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and xxdiff.
+	araxis, bc3, deltawalker, diffuse, emerge, ecmerge, gvimdiff,
+	kdiff3,	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and
+	xxdiff.
 +
 If a diff tool is not specified, 'git difftool'
 will use the configuration variable `diff.tool`.  If the
-- 
1.7.10.rc1
