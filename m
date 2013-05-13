From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] Documentation/stash: correct synopsis for create
Date: Mon, 13 May 2013 18:15:49 +0530
Message-ID: <1368449154-21882-2-git-send-email-artagnon@gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 14:44:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubs7E-0003rq-6R
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 14:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab3EMMoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 08:44:19 -0400
Received: from mail-da0-f47.google.com ([209.85.210.47]:56545 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab3EMMoS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 08:44:18 -0400
Received: by mail-da0-f47.google.com with SMTP id k13so1299997dae.6
        for <git@vger.kernel.org>; Mon, 13 May 2013 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=U9eIR0/fXomC0i7gi3/JL9HfKPEFQMGrWiCdJm2ClFs=;
        b=jxl7mGpA1RHiPYZFZN4WCgYes1EG7z1BCRXc2fxKmoUAVktU8dZl0MRKJhX6d2SPmr
         A2eJwANHpZ6uV2tUe2aqUvo7C/TEqf2oqgsXVIcZxlgZnOlQlpXCbZXbXvqenuf3q2W3
         tf1kIjUX0JI6FMg4GRv1lrb3JbNshlb39SksPdOuN1Y9t9qJKnvJhMpi+AjUFa5ili/+
         4A2IOq4O4F1j3eyuaMIo5WfmuInGdjNOM9j0eKP0CtNy3ree3aTNG+i98H/lAIMWgQmE
         UB4IwTXnXc8tk1SDh1MAAaRfynK5oeBw/sodsCqEoocT9aL5/NRL9CoAbDtzCLghMQWj
         E4xA==
X-Received: by 10.68.90.197 with SMTP id by5mr28973190pbb.196.1368449057771;
        Mon, 13 May 2013 05:44:17 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm3050227pbc.12.2013.05.13.05.44.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 05:44:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
In-Reply-To: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224130>

'git stash create' can optionally take one or two arguments.  Document
this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 711ffe1..35a0134 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
-'git stash' create
+'git stash' create [<message> [<include-untracked-p>]]
 
 DESCRIPTION
 -----------
-- 
1.8.3.rc1.57.g4ac1522
