From: pangyanhan@gmail.com
Subject: [PATCH] update-ref: whitespace fix
Date: Thu, 25 Aug 2011 23:40:50 +0800
Message-ID: <1314286850-11080-1-git-send-email-pangyanhan@gmail.com>
Cc: Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 17:42:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwc4L-0007Do-1T
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 17:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab1HYPmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 11:42:07 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56092 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab1HYPmG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 11:42:06 -0400
Received: by vxi9 with SMTP id 9so1788332vxi.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dKsU8C+G0cXC/tZiw0ec8tS20bRZLlVEu5E1veGD6Mk=;
        b=TLtVtPUjjamjGn/3XVfhaURxJtpQvkajv946iCgTSGGGQN12qYeC6uEXKsr8gT1nlu
         MaeqHpl8eleHox2G14yQ3iWJBZ66MJBkF+8fWwoPeZhicWQp30tkMl2XAwf5DcAt+991
         vXnoPmMhex1ExI3XOuUS9vQmBXVi9JX0Jxfeo=
Received: by 10.52.65.46 with SMTP id u14mr6996611vds.45.1314286924491;
        Thu, 25 Aug 2011 08:42:04 -0700 (PDT)
Received: from localhost (bb121-6-22-12.singnet.com.sg [121.6.22.12])
        by mx.google.com with ESMTPS id k10sm401232vdi.31.2011.08.25.08.42.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Aug 2011 08:42:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.1.385.gb7fcd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180083>

From: Pang Yan Han <pangyanhan@gmail.com>

Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
 builtin/update-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 76ba1d5..835c62a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -11,7 +11,7 @@ static const char * const git_update_ref_usage[] = {
 
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
-	const char *refname, *oldval, *msg=NULL;
+	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, flags = 0;
 	struct option options[] = {
-- 
1.7.6.1.385.gb7fcd0
