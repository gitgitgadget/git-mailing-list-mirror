From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v3] cat-file: Remove unused includes
Date: Fri,  9 Jan 2015 14:27:03 +0600
Message-ID: <1420792023-25327-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 09:34:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Uua-0001xZ-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 09:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbbAII1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 03:27:12 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:59220 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbbAII1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 03:27:11 -0500
Received: by mail-lb0-f172.google.com with SMTP id z12so6959605lbi.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 00:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aSGmav4t3GGuSOgRsRpVFdFM8F2yNTE8G9XNXxc+Saw=;
        b=s5075Jd/ikyroeikS4MNW5yQ+WqU4vXr2C692jcg/Ijkh//ZwPht6ItAZDy80Bj9Qb
         sSjGWTk5SJAxJHYFTPxtcULNibxqrNjH+JFHdds+k0f9+zv5VhFroW3bRxxEavZGLU/n
         j4TbX18in0aV117LANPnBKaSLNgJj5fvL80vhGd1Yzm9FTgwCU9+UFqtvnB94yYSTL7v
         KbJm/ZQeEwSjp0U3JNZmxS2AzNoDkPir2WO9xsQ2nv/q/v2n+Q6lGXFnMn90poVXe2iE
         xt5udPJpUW6MjLqAzWgRtMOJENFtx1wKCbYxaqwt7seHo1WvqjjBXQA5Rph6XythkjCD
         cZyA==
X-Received: by 10.152.87.46 with SMTP id u14mr20205235laz.36.1420792030047;
        Fri, 09 Jan 2015 00:27:10 -0800 (PST)
Received: from localhost.localdomain ([92.46.69.16])
        by mx.google.com with ESMTPSA id 10sm1697569lar.24.2015.01.09.00.27.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jan 2015 00:27:09 -0800 (PST)
X-Mailer: git-send-email 2.2.1.523.ged4e81b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262234>

* <exec_cmd.h> became unnecessary at b931aa5a (Call builtin ls-tree
in git-cat-file -p, 2006-05-26).

* <tag.h> and "tree.h" became unnecessary at 21666f1a (convert
object type handling from a string to a number, 2007-02-26).

* <diff.h> was added at e5fba602 (textconv: support for cat_file,
2010-06-15).

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/cat-file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f8d8129..750b5a2 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -4,12 +4,8 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
-#include "exec_cmd.h"
-#include "tag.h"
-#include "tree.h"
 #include "builtin.h"
 #include "parse-options.h"
-#include "diff.h"
 #include "userdiff.h"
 #include "streaming.h"
 
-- 
2.2.1.522.g2561c04.dirty
