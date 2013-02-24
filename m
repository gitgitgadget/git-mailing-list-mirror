From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 10/16] contrib/fast-import: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:48 -0800
Message-ID: <1361665254-42866-11-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
 <1361665254-42866-7-git-send-email-davvid@gmail.com>
 <1361665254-42866-8-git-send-email-davvid@gmail.com>
 <1361665254-42866-9-git-send-email-davvid@gmail.com>
 <1361665254-42866-10-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PM2-0002nz-3y
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759278Ab3BXAVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:23 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:64390 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759357Ab3BXAVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:21 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so933540dae.17
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4/FmwJLwVQKnqGsvEl4FIeULmOAVx4PSwokmOVSjobU=;
        b=wl58TR6tRfA+kgUwkvb4PXuMBBJtKY/euVP6EfJnijEN8kBexk0WnIV+QKbdRNkE7t
         ToDWS98ZVOs9XU/ozCpomuz5KjwIcBSX4bwtdLxiw6o3kbp/oEvr3CnuRfiSD0ePbtIr
         ALsibdOSYRXUzNaa8/bMEimHKpdpnxIe4kmLt4X94hsWYsb0kKKhl2UnnaLvspYbWhmU
         j69AKepSjfWrcS7K3GzcM3zDqD3USMwE2HBfbrEqnJONceTurdh8rDE6kNemduQlGxkL
         zgG6mCMI/yZpb2PMXPggA9wUsgMj7snjFNFcq/CNfAQrXtZwgTROyV5Ghv5Xncx/X0n2
         jSKA==
X-Received: by 10.66.158.201 with SMTP id ww9mr11753888pab.102.1361665280597;
        Sat, 23 Feb 2013 16:21:20 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.18
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:19 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-10-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216954>

Use a lowercase "usage:" string for consistency with Git.

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
1.8.2.rc0.247.g811e0c0
