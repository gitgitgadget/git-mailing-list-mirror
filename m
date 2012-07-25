From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 4/5] difftool: Call the temp directory "git-difftool"
Date: Tue, 24 Jul 2012 19:59:32 -0700
Message-ID: <1343185173-48278-5-git-send-email-davvid@gmail.com>
References: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 04:59:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StrpD-00024D-8G
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 04:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927Ab2GYC7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 22:59:42 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58200 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab2GYC7k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 22:59:40 -0400
Received: by yenl2 with SMTP id l2so253114yen.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hRjB8gfYjpAOmtcgcETRx9OJg9ilZjQjLhemhdk1wCc=;
        b=jh87d9mTdeGVud7A4bOJuB/6+6qspNGNGzHFZI9CrCV5ocTlBGWidMSRE/FEfFnd/6
         CVm57RwCv5650so8t2wmYfJ1XsWl9mKXEYa0TZZ+cBY9lOm28bSJY2eNZj/5aVOJ2gyr
         WDg35F4JtftiiMfN4+b5Dz9Z9FcGQgKofxJzzOD+13uhi6OWHCUhJf3s8FUQXfawPBlU
         6rKX04T0QOIUlFADH6m8l8A9jWCxSDsAq3ah7ItgIc4q7RcthvKJRnji3cmUnqSake0+
         z+agMaZUNEy8NPIiEO5KLxMOjQPAvDzA9lyEPtnXdEbwsZWvC38PF3U7LQMMPSYNrPhh
         etjA==
Received: by 10.66.81.3 with SMTP id v3mr9208931pax.62.1343185179332;
        Tue, 24 Jul 2012 19:59:39 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kh1sm13382996pbc.23.2012.07.24.19.59.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 19:59:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
In-Reply-To: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202097>

The "diffall" name was left over from when this functionality was part of
the "git-diffall" script in contrib/.  Make the naming consistent.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Same as last time, rebased

 git-difftool.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 685887d..b4f2fc6 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -119,7 +119,7 @@ sub setup_dir_diff
 	exit(0) if (length($diffrtn) == 0);
 
 	# Setup temp directories
-	my $tmpdir = tempdir('git-diffall.XXXXX', CLEANUP => 1, TMPDIR => 1);
+	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 1, TMPDIR => 1);
 	my $ldir = "$tmpdir/left";
 	my $rdir = "$tmpdir/right";
 	mkpath($ldir) or die $!;
-- 
1.7.12.rc0.15.g8157c39
