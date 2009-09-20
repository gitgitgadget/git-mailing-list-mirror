From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Remove '< >' from [<options>] since it's not necessary.
Date: Sun, 20 Sep 2009 15:48:36 -0400
Message-ID: <1253476116-24284-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 21:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpSWM-0001y3-8z
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 21:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbZITT4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 15:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbZITT4U
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 15:56:20 -0400
Received: from mail-qy0-f176.google.com ([209.85.221.176]:50816 "EHLO
	mail-qy0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbZITT4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 15:56:19 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2009 15:56:19 EDT
Received: by qyk6 with SMTP id 6so153051qyk.33
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+Mpmb1byUFJ8bFkqhRPKAncuSm1DvWCZ9AVYdzoPTbY=;
        b=eFMfOXnXDo2kvbZwos8cQs7p3GiGeBXzzNELP5e++QoUAWdzlTECRnK9YedAtDt+Wm
         hMleXYIjZ9AmkM3RvqQPIEE/C47xi3+IOX7YdUkixbr7FmzxVZHexsZMI0abCjPY1Vgf
         yviFWtO/qNIAIRXYSRHwj244UpUxxBI8X76Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=U7nw+deeG+aydPLOTzHooVsPQyJAImRYE7tJDfAg+1bMQkVis8Kmfu0cGa66hq1jDj
         //J4giauogny783JAlL+MJNoRViqn8ufOGEqgSbLrIyMPAuMz8CeNM8BsDnBPQom/rPX
         /TB5X3Nu/51aDUc7tXL+goFFACsy0GESNXCYU=
Received: by 10.224.78.221 with SMTP id m29mr2983514qak.20.1253476146713;
        Sun, 20 Sep 2009 12:49:06 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 4sm4964784qwe.45.2009.09.20.12.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Sep 2009 12:49:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.37.gf5c31.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128859>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin-log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 25e21ed..1685546 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -28,7 +28,7 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage =
-	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
+	"git log [options] [<since>..<until>] [[--] <path>...]\n"
 	"   or: git show [options] <object>...";
 
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
-- 
1.6.5.rc1.37.gf5c31.dirty
