From: "Christoph J. Thompson" <cjsthompson@gmail.com>
Subject: [PATCH] Honor configure's htmldir switch
Date: Sat, 2 Feb 2013 22:25:11 +0100
Message-ID: <20130202212504.GA16412@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 22:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1kal-00007h-Da
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 22:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab3BBVZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 16:25:09 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:43337 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab3BBVZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 16:25:07 -0500
Received: by mail-we0-f174.google.com with SMTP id r6so3876701wey.19
        for <git@vger.kernel.org>; Sat, 02 Feb 2013 13:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=C6Lao3M3i+FuEWBZw+8GwCEVH44yL/zs/Xfj7l11E7I=;
        b=roKrqazutikofc6vImLgrVMwwtbN10kmmkAiPFnQdMo+cXSx16OrAbqE2ojF1B7FIH
         pVPG2hbCEg1kISz8d4+MO2TrsiTTWQma40jeTMeon3QQeGT9GY7u9jPGLxgcCaCt78TD
         KngU3GlcyxyufkKl7dM2Y9LSB5tDbBrPOrMvrsduJzB4/LzmllEYV3qlwR1YRM5V6pNG
         LGuUTYQs4HUCAOwL+rofHVQTRtPpo5tWikT7Pam4nGvMz/9enqKDgDBs1KYtDSfoZxSH
         aqjNYaDlA5qtva9oEnPKcv9C0Ak5g7Us7CrQZW8i2NpfksM0KQWIBIqZyu0tm+hO3RFB
         W9JQ==
X-Received: by 10.180.82.41 with SMTP id f9mr3692859wiy.25.1359840304491;
        Sat, 02 Feb 2013 13:25:04 -0800 (PST)
Received: from gmail.com (ANancy-258-1-87-193.w90-13.abo.wanadoo.fr. [90.13.22.193])
        by mx.google.com with ESMTPS id j9sm4769994wia.5.2013.02.02.13.25.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 02 Feb 2013 13:25:03 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215293>

Honor autoconf's --htmldir switch. This allows relocating HTML docs 
straight from the configure script.


Signed-off-by: Christoph J. Thompson <cjsthompson@gmail.com>
---
 config.mak.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.in b/config.mak.in
index e8a9bb4..d7c49cd 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -19,6 +19,7 @@ template_dir = @datadir@/git-core/templates
 sysconfdir = @sysconfdir@
 
 mandir = @mandir@
+htmldir = @htmldir@
 
 srcdir = @srcdir@
 VPATH = @srcdir@
-- 
1.8.1.2
