From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] version-gen: avoid messing the version
Date: Mon,  9 Sep 2013 00:01:29 -0500
Message-ID: <1378702889-21638-3-git-send-email-felipe.contreras@gmail.com>
References: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 07:06:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VItgX-0003Lj-VA
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 07:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab3IIFGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 01:06:43 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:59183 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab3IIFGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 01:06:42 -0400
Received: by mail-oa0-f54.google.com with SMTP id j10so6041225oah.41
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 22:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PAIm71vK8NWWmRfLJxK3pEK9z/t8ndND2nP6u4Q16SE=;
        b=p/6tlq5Tiqpsgbo3NbJ3hzPtCA/v8P13zzkZSdzpTylBaSBGX0U3WIWehm6pVE7a32
         LnmKbGYvHWMExDYVdA1oP2P3EizENwrHk24GXu6Ekr4hYF0AcMXop8x9w2bm2hxmgLoy
         twdUaBzQLpWuG3eWwvtiGHGda/QarlSEAILPJ2OLNkswSfN//KwqC3UNF21xk/W3B1kG
         5E748qEkdaV51uD36DO7XVOyxmMG4bG7r97g3lMPHtgLpxwvl5/rPRTmu6aroGPCRBZA
         yifc9/YLq+VBwHIuPxqHBmYjzL53ctIopVeL7fJ6+yH8vgODwagC98LZqTuhI1B/OiLK
         yBpA==
X-Received: by 10.182.129.201 with SMTP id ny9mr10170368obb.0.1378703200640;
        Sun, 08 Sep 2013 22:06:40 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm11815381oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 22:06:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234311>

If the version is 'v1.8.4-rc1' that is the version, and there's no need
to change it to anything else, like 'v1.8.4.rc1'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 1 -
 1 file changed, 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index b0db139..2b9fd2f 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -24,7 +24,6 @@ then
 		VN="$VN-dirty"
 		;;
 	esac
-	VN=$(echo "$VN" | sed -e 's/-/./g')
 else
 	VN="$DEF_VER"
 fi
-- 
1.8.4-338-gefd7fa6
