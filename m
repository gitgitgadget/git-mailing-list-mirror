From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] Documentation: Add filter.<driver>.* to config
Date: Wed,  6 Apr 2011 15:27:31 +0530
Message-ID: <1302083854-2448-2-git-send-email-artagnon@gmail.com>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 11:59:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7PW6-00062s-HM
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 11:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496Ab1DFJ65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 05:58:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56041 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab1DFJ6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 05:58:47 -0400
Received: by iwn34 with SMTP id 34so1276921iwn.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=lvgnsRzH4XXdc4B3aXUIDrFD1GH2aUEcd3qiQx42aHk=;
        b=CIWk2jgGlJul6QapRcKSLAnMqXifwFrwjscvsT9KjoBcMrhi06dkcMvbg01qA6N+AE
         cZ8B1E2kj0lpZ60cboURqxyXSh0Ot0/bHVRvrEr08INjHOv7OPeDKFxXmeKIYWcrAjmm
         RED1XYdjXmHrspYFM19RJeFL8PjFbFTwsYNBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QstQpYAYJ4rRvaRXbM2v6DoYimfHqi72D2FCnKVZxQN+CiUjrz5XdgOFsxZMJMrw3w
         MOc14fN4Gf+frKRFS+kshlpUmSyw/AN1MX0OtITTBYCkYiTvDgeVbzjBrcSkBn8KPADz
         NLIYjoHDYZKQAbYsgKfGt8fGrU+qaq2u1UBqg=
Received: by 10.43.62.13 with SMTP id wy13mr1126682icb.360.1302083927286;
        Wed, 06 Apr 2011 02:58:47 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id c1sm318477ibe.51.2011.04.06.02.58.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 02:58:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170961>

Although the gitattributes page contains comprehensive information
about these configuration options, they should be included in the
config documentation for completeness.

Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8ea55d4..654a3b8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -973,6 +973,15 @@ format.signoff::
     the rights to submit this work under the same open source license.
     Please see the 'SubmittingPatches' document for further discussion.
 
+filter.<driver>.clean::
+	The command which is used to convert the contents of worktree
+	file upon checkin.  See linkgit:gitattributes[5] for details.
+
+filter.<driver>.smudge::
+	The command which is used to convert the blob object to
+	worktree file upon checkout.  See linkgit:gitattributes[5] for
+	details.
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-- 
1.7.4.rc1.7.g2cf08.dirty
