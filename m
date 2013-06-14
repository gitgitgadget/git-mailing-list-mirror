From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] stash doc: document short form -p in synopsis
Date: Fri, 14 Jun 2013 16:02:01 +0530
Message-ID: <1371205924-8982-3-git-send-email-artagnon@gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 12:30:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnRHN-0000Tc-RI
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 12:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab3FNKaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 06:30:35 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:46400 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab3FNKaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 06:30:16 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so437532pbc.24
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QaZUmBoMdGqVVMIQGdmkCQZddLjY49sSfooP1vKwETM=;
        b=wTL7iHYgdZ5c+77MejFO6OCBT4AEa8l7ODrbde4vQTaOr4w6dhub5q/7stHCAA97bY
         KZf/3AHx6j+f0orSgTr3D92rT28hcha2Iw//4c6mXbmT77FiKhwmnA55meQQ/XVw8dIR
         fs4bfWXiQTwwD70Ma65T9XqxPDQVOHEVBZzmFWsQAZi3VtAoCM7tanwivuwvDDXJ6lK1
         Au9DoTVt2LAdKKA1l0kfJf0htMw/BWuSSgz8ZNZPzfw9ehUM7Kd31qMZdcKZaqpXs2PM
         R0cTyJZp4SjxipFFfok/JEk6jvmdmF/oZdoDSEWLzkwQ34eQQCJPoIMZdjPWlZWl28Tj
         lc1w==
X-Received: by 10.68.108.163 with SMTP id hl3mr1861936pbb.160.1371205816308;
        Fri, 14 Jun 2013 03:30:16 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id xj9sm1809871pbc.16.2013.06.14.03.30.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 03:30:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.g0d5ad6b
In-Reply-To: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227805>

'git stash save' can take -p, the short form of --patch, as an option.
Document this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 83bb3db..08cdf2f 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message>]
-- 
1.8.3.1.383.g0d5ad6b
