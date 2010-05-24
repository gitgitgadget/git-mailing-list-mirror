From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] show-branch: use DEFAULT_ABBREV instead of 7
Date: Mon, 24 May 2010 16:50:44 +0800
Message-ID: <1274691044-5516-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 24 10:51:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGTNM-00047O-Bk
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 10:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab0EXIvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 04:51:01 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42735 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab0EXIvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 04:51:00 -0400
Received: by pvg4 with SMTP id 4so698464pvg.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=E10e2yQ3jJ6KmR0keg5Q9rkiijlWtAiLNxqV5JnKpLM=;
        b=SEDrafN7+Pdh2JpMeMw6wVYxZld3Tal85jFQJjja2y+LD+U3A/UgcVHdEpqKMpIycF
         UslGu0wyxsmTU/zyVTNqwvBnzjDTON41lHuTl9M7vJ+UjBDe1u/UP9SlxGlGnlng1WlY
         WGq6DyON++y7OKpVpB28/QRs86/HJjjk5cyM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Sf7OUx58O5JxpIYgxwKnOR6YFZiTvCIcMjAm3NZHRc2uVM0GHAeB+DcfHCsCYfls3C
         VUeSGNPT8kSfx1FxqRE+qhxbeVW93c5/qPXDgLsIBclMSxIrZNulcdV7IHxegIVY/8Jv
         wt3JD/vMkcrmrwD3ZCrXQcXcfaCsnRT/7hDaE=
Received: by 10.114.97.17 with SMTP id u17mr4589081wab.145.1274691059887;
        Mon, 24 May 2010 01:50:59 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id d16sm36640712wam.12.2010.05.24.01.50.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 01:50:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.259.g405af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147612>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/show-branch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e20fcf3..e8719aa 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -313,7 +313,8 @@ static void show_one_commit(struct commit *commit, int no_name)
 		}
 		else
 			printf("[%s] ",
-			       find_unique_abbrev(commit->object.sha1, 7));
+			       find_unique_abbrev(commit->object.sha1,
+						  DEFAULT_ABBREV));
 	}
 	puts(pretty_str);
 	strbuf_release(&pretty);
--
1.7.1.189.g07419
