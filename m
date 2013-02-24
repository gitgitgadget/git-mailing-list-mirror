From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 13/16] contrib/examples: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:21 -0800
Message-ID: <1361667024-49776-14-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
 <1361667024-49776-6-git-send-email-davvid@gmail.com>
 <1361667024-49776-7-git-send-email-davvid@gmail.com>
 <1361667024-49776-8-git-send-email-davvid@gmail.com>
 <1361667024-49776-9-git-send-email-davvid@gmail.com>
 <1361667024-49776-10-git-send-email-davvid@gmail.com>
 <1361667024-49776-11-git-send-email-davvid@gmail.com>
 <1361667024-49776-12-git-send-email-davvid@gmail.com>
 <1361667024-49776-13-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoX-0008WV-2Z
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759435Ab3BXAvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:51:10 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:65482 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135Ab3BXAvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:51:07 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so941399dak.28
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=JrCrYqP06Oip8PHA+f33fS6KPJ4Cmqo7clsy4FmssEk=;
        b=HQWZ80PigLJG9lB/qmV0tOP+iZQQfHahqA8Cn4Vc10AJtN8w1dZlerd4mRe269QSs7
         OvA6NtGNfZzu4lWr2gftRWK9yKkb7tvCJhrPqd7VDldE1REUSSatPCuj6ITcPJ70mgkr
         DkCkJM0aJlyB79R2qKsHLYQppQVsAG3fX7R1dEhWd7hl5IACuSQ423Y+h3yQxRnozVyI
         IgzKY7QTgU3JNzhlzO0uZhuuJXwsi+ZBjpyiIxhJBzXFFkE6sEAxIX0J7GVqCygd96Zm
         81O7KR+8Sdle+h03qC/mJKkznCkLpxK3z8HTRIa8O5456S0WyXVIcSwrIkcQoh/Y590f
         M/4w==
X-Received: by 10.66.251.227 with SMTP id zn3mr11518516pac.178.1361667067380;
        Sat, 23 Feb 2013 16:51:07 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.51.05
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:51:06 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-13-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216972>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/examples/git-remote.perl    | 2 +-
 contrib/examples/git-svnimport.perl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-remote.perl b/contrib/examples/git-remote.perl
index b17952a..b549a3c 100755
--- a/contrib/examples/git-remote.perl
+++ b/contrib/examples/git-remote.perl
@@ -347,7 +347,7 @@ sub rm_remote {
 }
 
 sub add_usage {
-	print STDERR "Usage: git remote add [-f] [-t track]* [-m master] <name> <url>\n";
+	print STDERR "usage: git remote add [-f] [-t track]* [-m master] <name> <url>\n";
 	exit(1);
 }
 
diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git-svnimport.perl
index b09ff8f..c414f0d 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -36,7 +36,7 @@ our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
 
 sub usage() {
 	print STDERR <<END;
-Usage: ${\basename $0}     # fetch/update GIT from SVN
+usage: ${\basename $0}     # fetch/update GIT from SVN
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev] [-R repack_each_revs]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-- 
1.8.2.rc0.263.g20d9441
