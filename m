From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/4] contrib/examples/git-remote.perl: use a lowercase "usage:" string
Date: Sun, 24 Feb 2013 14:48:40 -0800
Message-ID: <1361746121-56921-3-git-send-email-davvid@gmail.com>
References: <1361746121-56921-1-git-send-email-davvid@gmail.com>
 <1361746121-56921-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:49:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9kNy-0001sp-PE
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759173Ab3BXWsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:48:46 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45999 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758953Ab3BXWsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 17:48:43 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so1384782pad.35
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 14:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2yaEzzJfiESBsP5/WdlNo8NM0WW3QSXJLI1IsYVFpCU=;
        b=baWcTJFqFiLuKzZ1uVMvROjzmTGu/rk1hTe/33koeXR/XBJzb2xMDFW7o6mtBUfYt+
         f3qwZ5SVAP8b1QLa8x54Hb5CGjbXzz7ZbALanOZXa1pZloIYWTQKL40LAXZ8XiwcEv/E
         WC69GlvYO9COUd84Ve/AKKCDQ1iIerO6YAkQnee8lktb17mfNdbF/BqF8nl8Wtjw31jX
         Hi5tZsstOAeeIxNaNl/W6lbNQzOsYR6UVHnCOnOF9pXj/gPebXRzLBBIgPz2iQCA9nbd
         F/H0vYL51BKeLP4FZREr9nBYQFmd8BtgMkM03+db+D0ronMH2IOMsY8COhPwz/CS+jYE
         sf0Q==
X-Received: by 10.66.122.38 with SMTP id lp6mr13595955pab.44.1361746122705;
        Sun, 24 Feb 2013 14:48:42 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kb3sm10427967pbc.21.2013.02.24.14.48.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Feb 2013 14:48:41 -0800 (PST)
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1361746121-56921-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217016>

Make the usage string consistent with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/examples/git-remote.perl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/examples/git-remote.perl b/contrib/examples/git-remote.perl
index b549a3c..d42df7b 100755
--- a/contrib/examples/git-remote.perl
+++ b/contrib/examples/git-remote.perl
@@ -380,7 +380,7 @@ elsif ($ARGV[0] eq 'show') {
 		}
 	}
 	if ($i >= @ARGV) {
-		print STDERR "Usage: git remote show <remote>\n";
+		print STDERR "usage: git remote show <remote>\n";
 		exit(1);
 	}
 	my $status = 0;
@@ -410,7 +410,7 @@ elsif ($ARGV[0] eq 'prune') {
 		}
 	}
 	if ($i >= @ARGV) {
-		print STDERR "Usage: git remote prune <remote>\n";
+		print STDERR "usage: git remote prune <remote>\n";
 		exit(1);
 	}
 	my $status = 0;
@@ -458,13 +458,13 @@ elsif ($ARGV[0] eq 'add') {
 }
 elsif ($ARGV[0] eq 'rm') {
 	if (@ARGV <= 1) {
-		print STDERR "Usage: git remote rm <remote>\n";
+		print STDERR "usage: git remote rm <remote>\n";
 		exit(1);
 	}
 	exit(rm_remote($ARGV[1]));
 }
 else {
-	print STDERR "Usage: git remote\n";
+	print STDERR "usage: git remote\n";
 	print STDERR "       git remote add <name> <url>\n";
 	print STDERR "       git remote rm <name>\n";
 	print STDERR "       git remote show <name>\n";
-- 
1.7.12.4 (Apple Git-37)
