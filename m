From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] init-db: remove unused include
Date: Thu, 15 Jan 2015 17:47:31 +0600
Message-ID: <1421322451-1852-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 12:47:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBiu4-0007Z8-G9
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 12:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbbAOLrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 06:47:46 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:60167 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbbAOLro (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 06:47:44 -0500
Received: by mail-lb0-f172.google.com with SMTP id l4so85458lbv.3
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 03:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gDE8cEs/DxM3vrS83z3jDR35yQz9ApCjQ9Ky8Z6mHZM=;
        b=sVy8St4wAlDojIXbncZDW0LyZHmLHUwGJRRNOlGqIzViVqS8PVvy9tfAJcK4jh6qql
         cRujMjCHW5px2qnEUau8sd0sOXfPaaZ9VFsYLbkDqvuZXSYmwSW8NDKpWW06nRbAUjbA
         J2SN3LDzec9VmKQLHlSdYdmiKWxd/xaCaAIpiNhLUQ0gnt1AJ7zu6/ITBFOZfyVEfkQB
         qm8Me8YrivKYzckbJJSc8CnsqmLSRKleWjV11UfOcb1CjopT+WOzGj6cvF0pPsspvZ9c
         MoN0qQSOW9LEGjX1MfZkoEKWtnAL11kZ6rQDocUZxQsDmb6As0JiT0hEFgwa1NimBsZ+
         b8Sg==
X-Received: by 10.152.3.195 with SMTP id e3mr9432801lae.8.1421322462870;
        Thu, 15 Jan 2015 03:47:42 -0800 (PST)
Received: from localhost.localdomain ([95.59.100.94])
        by mx.google.com with ESMTPSA id dx2sm502517lbc.49.2015.01.15.03.47.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jan 2015 03:47:41 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.315.g7f5d251
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262476>

"cache.h" removed, because it's already included at "builtin.h"

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/init-db.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 280454a..8edef87 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
-- 
2.3.0.rc0.256.g2ad8601.dirty
