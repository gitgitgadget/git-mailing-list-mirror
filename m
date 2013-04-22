From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/7] builtin/shortlog.c: make usage string consistent with log
Date: Mon, 22 Apr 2013 11:00:31 +0530
Message-ID: <1366608631-21734-8-git-send-email-artagnon@gmail.com>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 07:31:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU9LE-0005ug-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 07:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab3DVFaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 01:30:52 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35663 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3DVFav (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 01:30:51 -0400
Received: by mail-pd0-f171.google.com with SMTP id t12so1205640pdi.30
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 22:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hmaoLGKmEw6x/N4bBEkWVkQxHxGT2s4AjiDoDqUQ1Zs=;
        b=tFO7in86Y4Btc/WDeyn0uCCBbV3MGf20mCIu4in5bEKMmDi3eyLHl/WbakfHmVPnGi
         pL93+ooUjzz1Gd3J7JOsTHR5jlu7RbYqeS2tPfOPMufhaOM6D8Z0E68oqqDe1N3E9MSK
         +pLNAV8TctA5tNmnLTMYniAb2e1cRydMxAwqKrhj0t9KRdLrS8UDm5r2MEhjkae7ny/2
         Z5dQUln6unztR1c9jK1NEgsUE296aY2rsEB4QA9ps1u8U4tZUbRJOjemdd9H+32tvZpm
         tt2vAI7XSuqLSBl6nAX3OkUxaOFKYvKmDmJV//9053nJDEl5XHfw/DJvRNnmMrzG2LB6
         k69A==
X-Received: by 10.66.248.6 with SMTP id yi6mr27130964pac.20.1366608650846;
        Sun, 21 Apr 2013 22:30:50 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id em2sm11144653pbb.0.2013.04.21.22.30.49
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 22:30:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221995>

"--" is used to separate pathspecs from the rev specs, and not rev
specs from the options, as the shortlog_usage string currently
indicates.  In correcting this usage string, make it consistent with
the log_usage string.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/shortlog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 240bff3..1fd6f8a 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -10,9 +10,7 @@
 #include "parse-options.h"
 
 static char const * const shortlog_usage[] = {
-	N_("git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>... ]"),
-	"",
-	N_("[rev-opts] are documented in git-rev-list(1)"),
+	N_("git shortlog [<options>] [<revision range>] [[--] [<path>...]]"),
 	NULL
 };
 
-- 
1.8.2.1.501.gd2949c7
