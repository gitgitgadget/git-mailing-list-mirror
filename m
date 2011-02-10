From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v4 1/4] merge: update the usage information to be more modern
Date: Thu, 10 Feb 2011 18:40:01 -0500
Message-ID: <1297381209-6377-2-git-send-email-jaredhance@gmail.com>
References: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:40:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Png7z-0005G9-IP
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab1BJXkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:40:31 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50690 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304Ab1BJXkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:40:21 -0500
Received: by mail-vx0-f174.google.com with SMTP id 37so1028081vxb.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OX8BKaucr1meAhevhQONFB3eCQWxTAAU7IF/GVENj4A=;
        b=KgyAfU9xt84Z9nYsTScx87LR7Gy5GYnhWe/lJwTxG6MA64HDs9Y1puW7Dz5YsYmU8T
         IYuqzdKtXzC0F0tc+l26iHjWsdYaes5N0cRVcIMsJ/lBUtcZMBs/mbgbE4axjLsrLlj7
         PbTcviD095ooNjXrPtLMPa5NLw3ah5kzk2SLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LdLZEJzA9+9VYK4aixFYk/AjsqmPSfFOseWKlinL/XND7DxkTjqJ1aam7npRmofoeB
         U2V3fw0qG4l01RYLeUwTercqJNLIVOeN7Ao3fwTADxJQuzdd6zXSv8ccQB9820Fknrve
         sWrltpj3PMGbCMRtQp9d4xQ6n02sTB+IM3ltQ=
Received: by 10.220.201.2 with SMTP id ey2mr5904185vcb.29.1297381221533;
        Thu, 10 Feb 2011 15:40:21 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id r7sm126736vbx.19.2011.02.10.15.40.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:40:21 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166516>

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
