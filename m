From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 1/3] Document the -n command-line option to git-unpack-objects
Date: Tue, 15 Nov 2005 00:20:01 +0100
Message-ID: <11320104011582-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11320104011696-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Tue Nov 15 00:21:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbncM-0008EQ-Cv
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 00:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVKNXUB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 18:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVKNXUA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 18:20:00 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:62166 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751303AbVKNXT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 18:19:59 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051114231958.SCJT21433.mxfep01.bredband.com@puritan.petwork>;
          Tue, 15 Nov 2005 00:19:58 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 472BFADFE8;
	Tue, 15 Nov 2005 00:20:01 +0100 (CET)
In-Reply-To: <11320104011696-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11866>

This patch documents the -n command-line option to git-unpack-objects,
as it was previously undocumented.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-unpack-objects.txt |    6 +++++-
 unpack-objects.c                     |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

applies-to: 963d67921d6f65c08d51a8c93811f03274c34703
0d2b0b51463fe0fed667a7169b94d7ee52677e69
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index b716ba1..31ea34d 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -8,7 +8,7 @@ git-unpack-objects - Unpack objects from
 
 SYNOPSIS
 --------
-'git-unpack-objects' [-q] <pack-file
+'git-unpack-objects' [-n] [-q] <pack-file
 
 
 DESCRIPTION
@@ -19,6 +19,10 @@ one-object" format in $GIT_OBJECT_DIRECT
 
 OPTIONS
 -------
+-n::
+        Only list the objects that would be unpacked, don't actually unpack
+        them.
+
 -q::
 	The command usually shows percentage progress.  This
 	flag suppresses it.
diff --git a/unpack-objects.c b/unpack-objects.c
index 8ae1a1c..8490895 100644
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -6,7 +6,7 @@
 #include <sys/time.h>
 
 static int dry_run, quiet;
-static const char unpack_usage[] = "git-unpack-objects [-q] < pack-file";
+static const char unpack_usage[] = "git-unpack-objects [-n] [-q] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
---
0.99.9g
