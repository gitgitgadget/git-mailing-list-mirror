From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sat, 20 Apr 2013 17:15:12 +0530
Message-ID: <1366458313-7186-5-git-send-email-artagnon@gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 13:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTWEp-0000g4-Jg
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 13:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069Ab3DTLph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 07:45:37 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:36689 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab3DTLpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 07:45:30 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so2330135dan.33
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5JP8Rh3QJuz3gt98imccETcQEfny/VM0x4efwIW3+oM=;
        b=qtcNWTUUgwbaJQYibVDw0ZmX8mVzlN0eFBYfSNJULVK8UqGrcrZYI30yULsNDu8anM
         fGiXF857YQzb/rR94ki4+q0b6VvzXV2sMIAkn929ZKNnlcfFBoKnZmUyn6UsdsZWWzj/
         jGTcBsdhQH8vSPpSmBLWcoXsl0udr3c5nljP207W8Gkqq/ifTJWROo6/T76wPusrMbts
         /lkY19fUuM/e9bw+Dko3ZJ5uUKDv8cWQAW8xf2gETAVmV7YMOw1U2zWoc7U9+r1Tcopg
         Rou30TsXS+JLFTqrIx5nTVa6G2uL6DydEBm61z+Mcxrb43+UZorlhm4whiFmpBBhjch6
         BIcw==
X-Received: by 10.68.232.234 with SMTP id tr10mr17869111pbc.11.1366458330425;
        Sat, 20 Apr 2013 04:45:30 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id ag4sm629048pbc.20.2013.04.20.04.45.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 04:45:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.506.gbce9ff0
In-Reply-To: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221850>

In its current form, the note talks about separating options from
"branch names" and "refnames" in the same sentence.  This is entirely
inaccurate, as the rev spec need not be a set of branch names or ref
names.  Rewrite it to use the word "revisions".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-log.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index f03ae74..1a9c3ca 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -75,8 +75,8 @@ produced by --stat etc.
 	Simplification" below for details and other simplification
 	modes.
 +
-To prevent confusion with options and branch names, paths may need to
-be prefixed with "\-- " to separate them from options or refnames.
+Paths may need to be prefixed with "\-- " to separate them from
+options or revisions, when confusion arises.
 
 include::rev-list-options.txt[]
 
-- 
1.8.2.1.506.gbce9ff0
