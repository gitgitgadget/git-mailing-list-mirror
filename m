From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] fixup! pack v4: move packv4-create.c to libgit.a
Date: Sat, 14 Sep 2013 05:53:53 -0400
Message-ID: <1379152433-53432-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 11:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKmYh-00009P-D5
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 11:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab3INJyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 05:54:19 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:55627 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab3INJyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 05:54:18 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so2113153oag.30
        for <git@vger.kernel.org>; Sat, 14 Sep 2013 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=K9NRq3f8shZGdDhd3xTRve5yvQDUWSviqlTrGe/sCDo=;
        b=TI/KRYOCbrMW/SCh3K7st3COa9uXhllS91LBy6k+AC3ddYQyqQf5swiHxu7BxZeAhE
         mXEGm5/gTxSx7cJC7lX+5AvOpNBgPcAy57+Tkd6R+W9fw8YAkSnUpWt5/uTBHSLFup4X
         zRZKfh1n4lWopFV9uAneXuMeyqrMyUC3P1nAR1flVqNtCtskEwDZtU+H8e6j0l+Or0Tb
         +cma6ToGDPlFDaO7gCsPrt2vAmXhvA0qTOi571NGY31fvlRic44Z63v+R3d156EcGrCa
         q6s4IQDdO/tVpO877dqNDY3MsS6f0tNCvnLa8644/sAMjEEVkui0oLE9lo/loBm+uAxf
         Sb5w==
X-Received: by 10.182.130.131 with SMTP id oe3mr16558276obb.34.1379152457686;
        Sat, 14 Sep 2013 02:54:17 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id u3sm21950067oeq.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 14 Sep 2013 02:54:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234804>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

For squashing onto np/pack-v4 in 'pu'.

 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 66199ed..878618b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -190,6 +190,7 @@
 /test-match-trees
 /test-mergesort
 /test-mktemp
+/test-packv4
 /test-parse-options
 /test-path-utils
 /test-prio-queue
-- 
1.8.4.535.g7b94f8e
