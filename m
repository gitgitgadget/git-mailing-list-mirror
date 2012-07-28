From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 5/7] Remove irrelevant comment.
Date: Sat, 28 Jul 2012 02:38:30 -0700
Message-ID: <1343468312-72024-6-git-send-email-schwern@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:39:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3Uy-0007ho-J4
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab2G1Jjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:39:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50635 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab2G1JjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:39:00 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6493452pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=L5RYoYBLkdZ9T+HYuEEMr9eiVNO+eKYbNfHCWJUIlU0=;
        b=HULABpElAEl8MITb3vUCUl82cKgajt0ERwZYZOVgh4p2iBxEGxRUruRoEidvCQFFoa
         mHrm68B6T7pTH8vD6mHW0Mocd8/74KdFtq9pC2R1DSmJXmnE7DjzmvpiqXt3CM78zA5c
         7rDYvujcIuSu9erVOda/kULvvZvnAed5UxkAcM1YF3Cjm0QgMcPkiPjCVfhag+FPI37I
         gb1Bw2NfGQdYcGolNQk/ugR9WS7EworlP9numFyLE+6zegpl84eoyMg+T4mLgBt33GUe
         75DQrVvDyheIr7xI80A58G84mQJ9goARKAPJB+1lkQPa0aOM8tOrEAnwADt07YlDPl8y
         8QHg==
Received: by 10.66.75.229 with SMTP id f5mr11142118paw.47.1343468340131;
        Sat, 28 Jul 2012 02:39:00 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id rs4sm3689907pbc.0.2012.07.28.02.38.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:38:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202415>

From: "Michael G. Schwern" <schwern@pobox.com>

The code doesn't use File::Spec.
---
 perl/Git/SVN/Utils.pm | 2 --
 1 file changed, 2 deletions(-)

diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index deade07..6c8ae53 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -92,8 +92,6 @@ sub canonicalize_path {
 		$path = "./" . $path;
 		$dot_slash_added = 1;
 	}
-	# File::Spec->canonpath doesn't collapse x/../y into y (for a
-	# good reason), so let's do this manually.
 	$path =~ s#/+#/#g;
 	$path =~ s#/\.(?:/|$)#/#g;
 	$path = _collapse_dotdot($path);
-- 
1.7.11.3
