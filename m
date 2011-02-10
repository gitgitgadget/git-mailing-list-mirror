From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v4 2/5] merge: update the usage information to be more modern
Date: Thu, 10 Feb 2011 18:40:04 -0500
Message-ID: <1297381209-6377-5-git-send-email-jaredhance@gmail.com>
References: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:42:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Png9i-0006eN-CX
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434Ab1BJXk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:40:29 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50690 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421Ab1BJXk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:40:27 -0500
Received: by mail-vx0-f174.google.com with SMTP id 37so1028081vxb.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OX8BKaucr1meAhevhQONFB3eCQWxTAAU7IF/GVENj4A=;
        b=Y2wL4pJDuDSVmHxkE+eU9xzfIcPFXlgRCnndxKCYmeHmvZDr7pHEyL29PKz1Xd2YpZ
         C80uDla+r/a60nrITWbQgF77cMusRCmOWrcpknZxM51BdnSn24RazT0DLR59fjSm0GYN
         XGiu92EoI0TsU2n/eWI9dnWBuhuYjSrzRq7SA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lR+099iSWMTkUGu6tTfmUENzNy3gczNTukiLv1kwGFgXTLwViLOqX3BHX2VcljbkxR
         LoQcK235bkrt8Amb+BBCHr2ADFOlIj10e8T5WGpzKGQmXN7tB8Y6QaM5u5tLkDolETNA
         0vzBosju2c13g9NzWVGY5MN3qJIRIHwVrg5Lk=
Received: by 10.220.188.4 with SMTP id cy4mr2208989vcb.43.1297381227035;
        Thu, 10 Feb 2011 15:40:27 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id r7sm126736vbx.19.2011.02.10.15.40.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:40:26 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166520>

Apparantly, merge's usage information was outdated and used old terminology.
Fix it.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/merge.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..439d2c7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,8 +37,8 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	"git merge [options] <remote>...",
-	"git merge [options] <msg> HEAD <remote>",
+	"git merge [options] <branch>...",
+	"git merge [options] <msg> HEAD <branch>",
 	NULL
 };
 
-- 
1.7.4
