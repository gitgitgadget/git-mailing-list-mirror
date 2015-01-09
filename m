From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] git.c: remove unused includes
Date: Fri,  9 Jan 2015 16:12:33 +0600
Message-ID: <1420798353-12316-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 11:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9WYh-0000Uw-Pk
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 11:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbbAIKMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 05:12:43 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:56022 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbbAIKMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 05:12:42 -0500
Received: by mail-la0-f49.google.com with SMTP id hs14so13717049lab.8
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 02:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0NWLtXQjrlnZGa00aSPFKXClDIF/0Eul1G4lH/wKrBM=;
        b=eF05ZH9tdMJu0dFHzEWDkFfPwbCf6S7qKiWwSRVwfiBxhUfiJDIQw8k3ChgTkSmhAD
         8PL3DtuTwC15Q2hEDufz6Zua+Y5a9KdgiIgwQNCbL3+8Obixlvqo5Yuyw7NjrBcNJABM
         WgWtRIWpcCO3sEgVhUd1FodvfaXSXl8SkP+FWBgXulZMcuRKhoa2rfWDR8I2HatuOVxb
         ayumZ4NGYxumORac0DGmK4QoSzBfU7u3g0bRZ5PaFZ9+s1iHCE1fQ7X7g6875lJXnprR
         lQp+FPwzEiWhDmgSJjsePxgcIEfPO02cgFf8lX4EgztauudCBLZcnK2jAceN+0jkFQsu
         zoXA==
X-Received: by 10.152.234.9 with SMTP id ua9mr20508457lac.44.1420798361247;
        Fri, 09 Jan 2015 02:12:41 -0800 (PST)
Received: from localhost.localdomain ([92.46.69.16])
        by mx.google.com with ESMTPSA id an8sm1763209lac.7.2015.01.09.02.12.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jan 2015 02:12:40 -0800 (PST)
X-Mailer: git-send-email 2.2.1.522.g2561c04.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262238>

* <cache.h> and <commit.h> already included in <builtin.h>

* <quote.h> was appeared in (6035d6aa GIT_TRACE: show which
built-in/external commands are executed  25 Jun 2006) and sq_quote_print
was removed at (82aae5c quote: remove sq_quote_print() Jul 30 2013)

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git.c b/git.c
index 09b3bcf..c9bec99 100644
--- a/git.c
+++ b/git.c
@@ -1,10 +1,7 @@
 #include "builtin.h"
-#include "cache.h"
 #include "exec_cmd.h"
 #include "help.h"
-#include "quote.h"
 #include "run-command.h"
-#include "commit.h"
 
 const char git_usage_string[] =
 	"git [--version] [--help] [-C <path>] [-c name=value]\n"
-- 
2.2.1.522.g2561c04.dirty
