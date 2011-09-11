From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] SubmittingPathces: remove Cogito reference
Date: Sun, 11 Sep 2011 14:38:10 +0200
Message-ID: <1315744690-6477-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 14:39:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2jJf-00056C-UZ
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 14:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760064Ab1IKMjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 08:39:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46852 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab1IKMjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 08:39:01 -0400
Received: by eyx24 with SMTP id 24so2018952eyx.19
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=DYWlzl7aertyQ3rhk9SnwPQwRNlAd8RC3EKEKsPXoXI=;
        b=CclfUk6A3gEBq8GZFT/POnEibS/uz7JnKIuTPdikFpRfQfntp3V/lhXTzsltS3YGYH
         eHe5/krUbp21fPZ8I7qXuCCwQMvFSNGvNO8tVEIPNFajsFc7z4szjRDxQygVan+UVInK
         q2Iyqutkl7VXI1tdYI+ZmOwLggMu3/YzEf5eQ=
Received: by 10.14.11.39 with SMTP id 39mr1302575eew.35.1315744740248;
        Sun, 11 Sep 2011 05:39:00 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q50sm15840820eef.9.2011.09.11.05.38.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Sep 2011 05:38:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.1.724.g9519c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181172>

Removing Cogito leaves just git and StGit, which is a rather
incomplete list of git diff tools available. Sidestep the problem
of deciding what tools to mention by not mentioning any.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Reading `git log -p --reverse Documentation/SubmittingPatches` [0]
  I noticed the Cogito reference was never removed. In the light of
  the recent discussion about removing Cogito from the GitSurvey I
  figured now might be a good time to remove this reference as well.

  [0] https://plus.google.com/115991361267198418069/posts/NPa7vQYeMnm

 Documentation/SubmittingPatches |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 938eccf..0dbf2c9 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -134,8 +134,7 @@ Another thing: NULL pointers shall be written as NULL, not as 0.
 
 (2) Generate your patch using git tools out of your commits.
 
-git based diff tools (git, Cogito, and StGIT included) generate
-unidiff which is the preferred format.
+git based diff tools generate unidiff which is the preferred format.
 
 You do not have to be afraid to use -M option to "git diff" or
 "git format-patch", if your patch involves file renames.  The
-- 
1.7.6.1.724.g9519c
