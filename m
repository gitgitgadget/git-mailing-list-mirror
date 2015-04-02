From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] branch: fix funny-sounding error message
Date: Thu,  2 Apr 2015 15:27:12 -0600
Message-ID: <1428010032-13015-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 23:27:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydme5-0000hT-Mh
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 23:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbbDBV1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 17:27:21 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35773 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbbDBV1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 17:27:21 -0400
Received: by patj18 with SMTP id j18so95848899pat.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BSQIYzPiKStBGznAl9Jv5SpTN2j7zFfSRr5VS6elufw=;
        b=gi0p9Jj/CChLcFzWi0xnEIuEKdVkIW/GL4ytQjAn/3QJLcOumFfUX0mIZTIt45uFS9
         f676EaUfOH6Qb+gUWqKPL/C/T/MP+JH3/9AvWzz3kYIUDSsVXyohjxKs8LrU4bSdks7l
         ILc1mntBAuKIvCGHHA7EcQ4l6SHb9478NunqWl7Jw2s3x3NAyEsi2SMShz/Zla8WhbYC
         4Dmp/CYoeMvWU/1EmzokAamv7pZvEgMc0LkdLifYsYo1rdTFjQ7HoVjjOiFgqY2nmPX3
         PqlN0hxRF9wgP40Usw22MgfJBSu3rGWT7BJgbrCoAQX6iFw7my8yQGN30cDQc/3O1xq1
         QAPQ==
X-Received: by 10.66.149.163 with SMTP id ub3mr89174283pab.125.1428010040636;
        Thu, 02 Apr 2015 14:27:20 -0700 (PDT)
Received: from alex-wolverine.uconnect.utah.edu ([155.99.227.128])
        by mx.google.com with ESMTPSA id bz3sm6169397pab.2.2015.04.02.14.27.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 14:27:19 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266681>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1d15037..c0b4bae 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -972,7 +972,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
-				die(_("could not set upstream of HEAD to %s when "
+				die(_("could not set upstream of HEAD to %s because "
 				      "it does not point to any branch."),
 				    new_upstream);
 			die(_("no such branch '%s'"), argv[0]);
-- 
2.3.5
