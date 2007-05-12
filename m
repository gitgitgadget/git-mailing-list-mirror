From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Fix an unmatched comment end in arm/sha1_arm.S
Date: Sat, 12 May 2007 12:35:29 +0200
Message-ID: <e5bfff550705120335t6728ef82u234bb77d4f9e3d77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 12:35:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmowq-0007tx-OU
	for gcvg-git@gmane.org; Sat, 12 May 2007 12:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbXELKfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 06:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbXELKfb
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 06:35:31 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:18244 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717AbXELKfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 06:35:30 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1277109nzf
        for <git@vger.kernel.org>; Sat, 12 May 2007 03:35:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LkT/idm4LFCagoioeyYiNyMLzdwzWwkkItmvYvRtcAd+m9G5yYocU1IVq1ZR89r8ZSCjanHzPdpozL2B9uJz7GlR1WxilL4QvyKzgZestHcWgAGJk86i6NsLNy7ByidNeo2ZDuvioGzmoshFvBT0VFdae+6OCSiEPuDcBAMZbnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ggedUOKAvpmcGVX3CN+UR+R1pHEzHQwml11+jIlWAb7PnSvuWyR3G98CkKtUfp1vWA3Un9ttP9xVDB2xOhRoPp6gXC3aNO1uObXtNqKdNiF2ad6Z7U3s6xRLcKeSuLtes1ZAbU22C4GCzST5s4ZXlWQ3bMH7laX/6LXIFy1G2AM=
Received: by 10.114.110.1 with SMTP id i1mr203273wac.1178966129616;
        Sat, 12 May 2007 03:35:29 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 12 May 2007 03:35:29 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47031>

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 arm/sha1_arm.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arm/sha1_arm.S b/arm/sha1_arm.S
index da92d20..a328b73 100644
--- a/arm/sha1_arm.S
+++ b/arm/sha1_arm.S
@@ -23,7 +23,7 @@ sha_transform:
 	stmfd	sp!, {r4 - r8, lr}

 	@ for (i = 0; i < 16; i++)
-	@         W[i] = ntohl(((uint32_t *)data)[i]); */
+	@         W[i] = ntohl(((uint32_t *)data)[i]);

 #ifdef __ARMEB__
 	mov	r4, r0
-- 
1.5.2.rc3
