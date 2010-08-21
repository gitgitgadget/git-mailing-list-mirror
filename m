From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] format-patch: Update the `-3` example
Date: Sat, 21 Aug 2010 14:56:59 +0530
Message-ID: <1282382819-25097-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 11:29:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmkNw-00047v-HU
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 11:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381Ab0HUJ3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 05:29:03 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54523 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab0HUJ3C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 05:29:02 -0400
Received: by pwi7 with SMTP id 7so1376900pwi.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=zIvl32f36rqvsicXF/kVPHDeub6EsoHQfStpNX27yM4=;
        b=A+eiNxAr94lCbPXlSvcmgcuCEHHXx1KaR+BbBU3UYt5y6vR0EcI4zE3gnk0A0+k8/z
         FLM9E6akSX00axgl0Pexa0s4jcD9n0l0wmj3eFqpAxAvKSEoQmxpRwhdtTQFanOW4wuT
         aVNl1EAhExvfRXU56+9pk5+dWTXJigWouNOes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WEqIXbT+Zf8+7bd4/yOt/xQMZEyaej0+VxxfStGQDe2OmXsvyT29q/S3Jc6a6QylmU
         ohenKvzG408LhWTyxa0+PFYYQQ5SlLVFZuQKRpEgHjhexssnIfGV86p/5ScDtZZobIGD
         MCSYW/x/14MA8s4rguB6wZ7MJzGzlOoj28evw=
Received: by 10.142.103.14 with SMTP id a14mr1996711wfc.245.1282382941464;
        Sat, 21 Aug 2010 02:29:01 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id q27sm4598053wfc.6.2010.08.21.02.28.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 02:29:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154127>

In the EXAMPLES section, `git-format-patch -3` doesn't work
anymore. Update it to read `git format-patch HEAD~3`. The example was
introduced in 7c49628 and had not been updated since.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-format-patch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 4b3f5ba..2a44472 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -271,7 +271,7 @@ use it only when you know the recipient uses git to apply your patch.
 as e-mailable patches:
 +
 ------------
-$ git format-patch -3
+$ git format-patch HEAD~3
 ------------
 
 SEE ALSO
-- 
1.7.2.2.409.gdbb11.dirty
