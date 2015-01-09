From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] cat-file: Remove unused includes
Date: Fri,  9 Jan 2015 14:23:10 +0600
Message-ID: <1420791790-20248-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 09:27:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Uqs-0005gu-AQ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 09:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162AbbAIIXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 03:23:22 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:38763 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbbAIIXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 03:23:21 -0500
Received: by mail-la0-f54.google.com with SMTP id pv20so13264815lab.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 00:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ON/7VNgrPaEI9rl2VrSAS4YkSylx67iQ7r+AHlQ8RCM=;
        b=PyVjXKbDWIk0hbwNCf41N+qRRY7m1b724foqynZCJAvEK04yCA8OVPNtOTUW8TKiWB
         ZFPWyF8eBuzSelhxHkx9imwTNnY4d6f68/Wdh81+J1/YfOjz60J+a51E5//hTpZvK5hP
         GpV8FDF4Qqlb9IxGtgEypP4/8/hfPNP370IBEoY7FvsrdM7/+izimjfuQk8Cd3VQCm2X
         PHMhvT6Rw+i6CgZklNzq2wZ3sjPplFtYMWCt/1elrgUxVXytd8qXp/Cpfb/maizLIz7s
         bGQovO9RvfIr5bCsQyIjdUzr4ZyRU6o2WPlCzQoBXPGbqL2GuDGr7A69910GdXBdmIot
         Kv4w==
X-Received: by 10.153.7.100 with SMTP id db4mr20086475lad.79.1420791800352;
        Fri, 09 Jan 2015 00:23:20 -0800 (PST)
Received: from localhost.localdomain ([92.46.69.16])
        by mx.google.com with ESMTPSA id zo3sm1706446lbb.10.2015.01.09.00.23.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jan 2015 00:23:19 -0800 (PST)
X-Mailer: git-send-email 2.2.1.522.g2561c04.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262233>

* <exec_cmd.h> became unnecessary at b931aa5a (Call builtin ls-tree
in git-cat-file -p, 2006-05-26).

* <tag.h> and "tree.h" became unnecessary at 21666f1a (convert
object type handling from a string to a number, 2007-02-26).

* <diff.h> was added at e5fba602 (textconv: support for cat_file,
2010-06-15).

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
ndrivers 0
ndrivers 0
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
