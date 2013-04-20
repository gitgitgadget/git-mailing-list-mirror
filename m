From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] git-log.txt: fix description of <since>..<until>
Date: Sat, 20 Apr 2013 17:15:11 +0530
Message-ID: <1366458313-7186-4-git-send-email-artagnon@gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 13:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTWEo-0000g4-4Y
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 13:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065Ab3DTLpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 07:45:36 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32979 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074Ab3DTLp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 07:45:28 -0400
Received: by mail-pd0-f169.google.com with SMTP id 14so880482pdc.14
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EddFUJ/M1ZmmZx2Cdg2LCNVdJzn0KLClyrioOpYiSS0=;
        b=L8O8yxnwkdNjCRcbgwlxLJYGY5jOYIB+ID5qEvag1iBYaj9rIGjoVazkD/QkUf6UDr
         CxgUMUIE6J4W7BP6HMo+hZ2sU4II7tSoYRr0ukDkZfhz1a6rqzx53NvFmD/Bu59sYiTA
         TzbgbDX87wtQvIbZWKStzjgkuYJaA7vZ3ac8deP85lPMFWpxZmaaI97N+2YdETHycq8T
         GRzErN8GmS7H5rWV8nDfotPALWXViCobpV1UvLXLE+haQOrV+O6bMmCHPq9kYA1phRAn
         ZjjaCmqy52+irUYWrS6ok8CgMHQiiDkKuI8Z3dEkNSBR91LSEWC53Kdv7XB50BO+i/J3
         69SQ==
X-Received: by 10.66.50.138 with SMTP id c10mr3511825pao.220.1366458328185;
        Sat, 20 Apr 2013 04:45:28 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id ag4sm629048pbc.20.2013.04.20.04.45.25
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 04:45:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.506.gbce9ff0
In-Reply-To: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221848>

First, <since> and <until> are ways to specify "revisions", not
"commits", as gitrevisions.txt would indicate.  Second,
'<since>..<until>' is simply indicative of how users would normally
want to specify the rev spec: it need not conform to this form, and
can take any form that gitrevisions.txt lists.  A 'git log :/quuxery'
is perfectly valid, for instance.  Make these two corrections to the
description of '<since>..<until>' under OPTIONS.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-log.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 69db578..f03ae74 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -25,11 +25,11 @@ OPTIONS
 -------
 
 <since>..<until>::
-	Show only commits between the named two commits.  When
+	Show only commits between the named two revisions.  When
 	either <since> or <until> is omitted, it defaults to
 	`HEAD`, i.e. the tip of the current branch.
-	For a more complete list of ways to spell <since>
-	and <until>, see linkgit:gitrevisions[7].
+	For a more complete list of ways to spell <since>..<until>,
+	see linkgit:gitrevisions[7].
 
 --follow::
 	Continue listing the history of a file beyond renames
-- 
1.8.2.1.506.gbce9ff0
