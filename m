From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] Document .git/modules
Date: Sun,  9 Jun 2013 12:37:49 +0200
Message-ID: <1370774269-3258-1-git-send-email-iveqy@iveqy.com>
Cc: iveqy@iveqy.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 12:35:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlcyP-0008WS-SW
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 12:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769Ab3FIKfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 06:35:41 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:59708 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab3FIKfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 06:35:40 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so4895797lab.29
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=SiR79TMh3/g1KgJEi3cm2g+DZfDev+UFBXLuLw7Puug=;
        b=L+YLgnkbK+/aAtx595OaCn46M+Wu6eMcRSwDfE12yxQyWIrvEaBoWF7egOMM0l4Tda
         CL4yGVApleGxf3fwj+mA/qT7aO1Ayetem47YZgmUyLemNWs/0u0AyxG1dCeCWVonVho+
         OKb/+pzHDGsIlzr7SFkVH28pCuzXCZPU3Gy8nGgsEK4ifzALw/Zi/HsdfSvrVChv/fdE
         Oe7KG38C8uCJFaePYXMmq9nd5WYZRSqpOf5QJaOkbdcOLARBLK/6I/NO5lUjN7QIo/5b
         6+aMtIyf+ig4ZRuxJhQTvoQXEvD5+avJcCRj1dQQzBziu8U3rpVLiiFxqQkWpoOWgstv
         kG6w==
X-Received: by 10.152.18.162 with SMTP id x2mr2824652lad.26.1370774138451;
        Sun, 09 Jun 2013 03:35:38 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id oi3sm3815217lbb.6.2013.06.09.03.35.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 03:35:37 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Uld0r-0000rC-GN; Sun, 09 Jun 2013 12:38:17 +0200
X-Mailer: git-send-email 1.8.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226950>

A note in the begging of this document describe the behavior already.
This patch just add where to find the repositories.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 Documentation/gitrepository-layout.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index d6f3393..aa03882 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -211,6 +211,9 @@ shallow::
 	and maintained by shallow clone mechanism.  See `--depth`
 	option to linkgit:git-clone[1] and linkgit:git-fetch[1].
 
+modules::
+	Contains the git-repositories of the submodules.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
-- 
1.8.1.5
