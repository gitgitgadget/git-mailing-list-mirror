From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/4] git-svn: use a lowercase "usage:" string
Date: Sun, 24 Feb 2013 14:48:38 -0800
Message-ID: <1361746121-56921-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9kNT-0001WS-HU
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651Ab3BXWsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:48:38 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:56905 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757901Ab3BXWsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 17:48:38 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so1315370pbc.38
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 14:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=SLPi2eCOIk7Uzla6YuIiYft8SjaKS4OGZ4RZvlnOdF4=;
        b=OLJTfK+tVFXAtZJ89tfWMo8W570RywtFiPtKZ4uXDpac7t314cP4qJp2ZZbBQHpABt
         c0RY1PWik0PsKPDS7A2VSXhHZ6a3eehdeMqTAeAVMBgqWLDdYPpMtn/qhuscpqNEOXGO
         eV+p43GoZxizWC1eD+foXJiDQ7BYtQe/DZq3osADyHxUEQGJNkfLWJ+y3whSmwcPQD2+
         pfJKJBwXJHnaQEaGXVkJAXGPdPyS+ogzkJRmc4pISAZogLlGF+I2DcI4+gAe1QlQmCD0
         XtjcuEh+c5sNGbXc3lIwNo6cg+ynQSKg7qMRHS4lizewRMR8VWMwRGSPNVrDZwJr+pCX
         nfnQ==
X-Received: by 10.66.160.70 with SMTP id xi6mr15675713pab.109.1361746117674;
        Sun, 24 Feb 2013 14:48:37 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kb3sm10427967pbc.21.2013.02.24.14.48.35
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Feb 2013 14:48:36 -0800 (PST)
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217014>

Make the usage string consistent with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
I'm not sure why this wasn't caught in my first round.
It should probably be squashed into the 02/16 from v2.

 git-svn.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a93166f..6c7bd95 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -534,7 +534,7 @@ sub cmd_fetch {
 	}
 	my ($remote) = @_;
 	if (@_ > 1) {
-		die "Usage: $0 fetch [--all] [--parent] [svn-remote]\n";
+		die "usage: $0 fetch [--all] [--parent] [svn-remote]\n";
 	}
 	$Git::SVN::no_reuse_existing = undef;
 	if ($_fetch_parent) {
@@ -1404,7 +1404,7 @@ sub cmd_multi_fetch {
 # this command is special because it requires no metadata
 sub cmd_commit_diff {
 	my ($ta, $tb, $url) = @_;
-	my $usage = "Usage: $0 commit-diff -r<revision> ".
+	my $usage = "usage: $0 commit-diff -r<revision> ".
 	            "<tree-ish> <tree-ish> [<URL>]";
 	fatal($usage) if (!defined $ta || !defined $tb);
 	my $svn_path = '';
-- 
1.7.12.4 (Apple Git-37)
