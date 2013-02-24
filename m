From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 10/16] contrib/fast-import: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:18 -0800
Message-ID: <1361667024-49776-11-git-send-email-davvid@gmail.com>
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
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoV-0008WV-Tc
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab3BXAvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:51:01 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:59091 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab3BXAu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:59 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so935961dad.10
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=a+pAtZjFr7neh/S13bsq+qFfKCPVRDQsPRJi5cOIqRg=;
        b=Ni2BMCRZwGHIaBjkp1e3fVARKbMhMVqvYxURXzpKOCRlWPFveRVrqfohJhXDA0DOEg
         oiXaOb64JREQxz/Oa0HbiDlYebxD8mcec1o0WmWkMwRJ5wgiHjQMtvk3iaJfV8KozDH4
         RbQ2Vo2uCEBgtp1DBDP28QNYcYoyN/By2523wwFYziP5CBiiEsshtCKhz60SyTLDNCLW
         tlfKvUDjU/qZC59IplSqrgDH/nO3c9Mpoyeqw7HaqT8Jgjn0do/ffBWgPhjicfe8HbZU
         tn63ChR/aGcQ0GqLoLBT6YF2XN95Iob7OLDN3qPNFO1nZIkpFhqK8F4z+Y9CH/IKQmpE
         BO/g==
X-Received: by 10.66.160.70 with SMTP id xi6mr11592418pab.109.1361667059414;
        Sat, 23 Feb 2013 16:50:59 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:58 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-10-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216971>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/fast-import/git-import.perl | 2 +-
 contrib/fast-import/git-import.sh   | 2 +-
 contrib/fast-import/import-zips.py  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-import.perl b/contrib/fast-import/git-import.perl
index f9fef6d..0891b9e 100755
--- a/contrib/fast-import/git-import.perl
+++ b/contrib/fast-import/git-import.perl
@@ -7,7 +7,7 @@
 use strict;
 use File::Find;
 
-my $USAGE = 'Usage: git-import branch import-message';
+my $USAGE = 'usage: git-import branch import-message';
 my $branch = shift or die "$USAGE\n";
 my $message = shift or die "$USAGE\n";
 
diff --git a/contrib/fast-import/git-import.sh b/contrib/fast-import/git-import.sh
index 0ca7718..f8d803c 100755
--- a/contrib/fast-import/git-import.sh
+++ b/contrib/fast-import/git-import.sh
@@ -5,7 +5,7 @@
 # but is meant to be a simple fast-import example.
 
 if [ -z "$1" -o -z "$2" ]; then
-	echo "Usage: git-import branch import-message"
+	echo "usage: git-import branch import-message"
 	exit 1
 fi
 
diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
index 5cec9b0..f54c65b 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -19,7 +19,7 @@ if hexversion < 0x01060000:
         sys.exit(1)
 
 if len(argv) < 2:
-	print 'Usage:', argv[0], '<zipfile>...'
+	print 'usage:', argv[0], '<zipfile>...'
 	exit(1)
 
 branch_ref = 'refs/heads/import-zips'
-- 
1.8.2.rc0.263.g20d9441
