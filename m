From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] cat-file: Remove unused includes
Date: Fri,  9 Jan 2015 00:56:06 +0600
Message-ID: <1420743366-14926-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 19:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9IG0-0008FH-Lp
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 19:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbbAHS42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 13:56:28 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:65215 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbAHS41 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 13:56:27 -0500
Received: by mail-la0-f50.google.com with SMTP id pn19so11207609lab.9
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=74qZnYRKtYo6yzkm8lR6IrmAkqtS4mhxRspac4CwMBs=;
        b=DzfWpv8bUSoSKZzkSas8juOI22RIKK2NMkYdJC4Zfbrr3jr13Tw4YnNNRxymSCEmkO
         94pxb+2m1QKECXEals8INFOZWK7KlFJhMPrFsRzsRSucbOTjIUoLSDKOnmCfHFu6KTNW
         Bhouj0ePZhBjDz+0EIZQCPSKEd/VSA123RtoizJHLxPs8JcqmYLp2jvRd1b4f5CLi9bl
         Ao8YKdj75I1PS5AIUL9ggor3gSj5N0KMWGMsIPLqq0w9BGVb6eiCleFQkeX8FzXvPcFd
         KpgvOMaI+RTENSAmu2fdxJoDgF8sf6ac+zJ+KEjGjeE1OmLfbaO3GI/J7krbN8t6+huu
         ssew==
X-Received: by 10.112.89.232 with SMTP id br8mr16493012lbb.69.1420743380827;
        Thu, 08 Jan 2015 10:56:20 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.28])
        by mx.google.com with ESMTPSA id fb5sm1316397lbc.34.2015.01.08.10.56.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 10:56:19 -0800 (PST)
X-Mailer: git-send-email 2.2.1.269.g787aadb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262206>

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
2.2.1.269.g787aadb.dirty
