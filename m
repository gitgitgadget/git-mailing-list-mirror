From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 2/7] pack-protocol.txt: Mark LF in command-list as optional
Date: Wed,  1 Jul 2015 11:08:14 -0700
Message-ID: <1435774099-21260-3-git-send-email-dborowitz@google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:09:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMS0-00050U-8d
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbbGASJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:09:24 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35744 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbbGASIs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:08:48 -0400
Received: by igblr2 with SMTP id lr2so103516641igb.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z4nnJMAmZRn2YTDly+8e9v9HCtDGFvizt6M8OzsUiIA=;
        b=TeqSYn7hU1shD7sBaaGXYOKp0MBVKV75w0Mudyfr/zeiD6zgdLQfqCshgVfs9q6ADs
         lMBXSD3vPg+kG3up2SNFzSiE3FXq96zp+KrDZwYiGPo93r4K8N4UM9ihezMlTeonHlRY
         y6bJ9l5o4uwlMwsNVqCJH9R943eAS8kPD6xS0DMJV+aFqTv0/1R+DHAu1fHSfY/kfMXa
         McheDUeCcQtqU2Tm0CCTks8k0g25wEmNudJEKLjhNsXDfzSZLdMXRMBcit5t+Y5P+jTR
         QxvzgR6NxlbkL5fgRdRDtCljjDG99OqLNVmi6eLnAeZocXBi1dPr1mUnVxVTOceJO1Pr
         BqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z4nnJMAmZRn2YTDly+8e9v9HCtDGFvizt6M8OzsUiIA=;
        b=Qu/AzTmtBdDfduU9B7caQVf92tvmTZFAG6b+7k78Zgv/dIh4Kgzsk6WDgxOQ0DOkNQ
         mc6idjdrjbCcI5CVikRtf81DzrAYOVDvcfBwpSpkyeTgH7eM6gitpoM0QxR5MvobVUOK
         FqhSgnf6oOt+4yHrXvOq2gvyATobq4EDd9YS3v25XNcHOdMKjiQavHxwoKFkcMgWD1T5
         PjPgso02ryG/1OrfDY1U/GaPkH4eXaDYHCTc7AME/LLl2aorsupNyxrO69+5Kj3q3z3G
         LXdLEMxYduyY4fwS2h6/geOXF8sxsNS2UwBIf2tGU+OQCeTIGa4OkzLqcuvL3Hzuzr3N
         smZA==
X-Gm-Message-State: ALoCoQk0K3y3UaDTkFOUdOJLmtcl4YzbbfHVPS5Knsz9AVcfs2SXXrt7oDn5hm9Ykk7hDCEtYPNo
X-Received: by 10.107.47.26 with SMTP id j26mr40258559ioo.17.1435774127865;
        Wed, 01 Jul 2015 11:08:47 -0700 (PDT)
Received: from serval.mtv.corp.google.com ([172.27.69.27])
        by smtp.gmail.com with ESMTPSA id k2sm2782076ige.1.2015.07.01.11.08.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 11:08:47 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.573.g4eafbef
In-Reply-To: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273170>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/technical/pack-protocol.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 66d2d95..1386840 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -481,7 +481,7 @@ references.
   shallow           =  PKT-LINE("shallow" SP obj-id LF)
 
   command-list      =  PKT-LINE(command NUL capability-list LF)
-		       *PKT-LINE(command LF)
+		       *PKT-LINE(command LF?)
 		       flush-pkt
 
   command           =  create / delete / update
-- 
2.4.3.573.g4eafbef
