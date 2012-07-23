From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/5] difftool: Call the temp directory "git-difftool"
Date: Sun, 22 Jul 2012 20:57:10 -0700
Message-ID: <1343015831-17498-5-git-send-email-davvid@gmail.com>
References: <1343015831-17498-1-git-send-email-davvid@gmail.com>
 <1343015831-17498-2-git-send-email-davvid@gmail.com>
 <1343015831-17498-3-git-send-email-davvid@gmail.com>
 <1343015831-17498-4-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:58:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St9mb-0000Tl-ES
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab2GWD5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 23:57:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36444 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab2GWD5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 23:57:15 -0400
Received: by yhmm54 with SMTP id m54so5054174yhm.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rsyDtYztCV3w+xV3eoDL3nRrw6yLes5qKSBuo1RVu68=;
        b=SQTcHW004OBgaDdRPnxHXoMlU7/nDen+pEEE1Qk/ddWTBKI+lU2CTofWDtfl2g36kx
         3qRCu9vtAesouEaJnTUpfOtUUxtaB9rpOtwjq8zgQ3/+6iv2TLUSAd6pJtAP0uQbMTqr
         EOdgv2B4JtwVmX6XbVvQRCrKk6aj/hpLt6NXPmal20Sn0rbHvb29BJ5FY+36Bfw0Cmpo
         96jhpF33Z5CQjqZs3z87aQXOusxzI0TUYkClnl1PpK5iIuMLv94xan+rGfr7vRNZ0d/J
         LICmsqxM61R01OZlbFPkeeBNXV1Fma3XDY93INy4P4jOb3YoNbVX/6EtfxAwZWy6Lpu5
         sL+A==
Received: by 10.66.74.69 with SMTP id r5mr27614602pav.56.1343015834651;
        Sun, 22 Jul 2012 20:57:14 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id iw10sm8485543pbc.55.2012.07.22.20.57.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 20:57:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.255.g5f133da
In-Reply-To: <1343015831-17498-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201888>

The "diffall" name was left over from when this functionality was part of
the "git-diffall" script in contrib/.  Make the naming consistent.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Reworded the commit message to get through gmail filters.

 git-difftool.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 0ce6168..2ae344c 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -104,7 +104,7 @@ sub setup_dir_diff
 	exit(0) if (length($diffrtn) == 0);
 
 	# Setup temp directories
-	my $tmpdir = tempdir('git-diffall.XXXXX', CLEANUP => 1, TMPDIR => 1);
+	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 1, TMPDIR => 1);
 	my $ldir = "$tmpdir/left";
 	my $rdir = "$tmpdir/right";
 	mkpath($ldir) or die $!;
-- 
1.7.11.2.255.g5f133da
