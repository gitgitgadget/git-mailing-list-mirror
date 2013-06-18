From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] name-rev doc: rewrite --stdin paragraph
Date: Tue, 18 Jun 2013 22:43:28 +0530
Message-ID: <1371575608-9980-6-git-send-email-artagnon@gmail.com>
References: <1371575608-9980-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:17:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozWb-0003FH-6c
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019Ab3FRRQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:16:50 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:50481 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932951Ab3FRRQs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:16:48 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so4125070pbc.32
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fp9mmzJhW9Stayhy0ekjmvfE1e0ItjaDaIkkocjEQSQ=;
        b=epAhBHBENTfynmF7gF4JqUDk1SB+zydy5e4F1l2XhHQz9WMdb32LIotIw0Yt1zGmdR
         usKeMc5FHsAaKmjSI7V07rgZIUsE2Op1s2glhHNo/4iv/rW6a+Wl8WZHgWqZ/cFHlzDC
         v8pEuH1G9DluI2bauuTByN3tTr1D1HqRXiIxIssUI2DFiD3ytdJkoztgjW32xrPa/yxN
         EmUa9IibsXpO1p+j1OWXgejf3dhFaGIfy+beAt9pgAiW6qml1Q+RWpWPHEDm+SvM/l+X
         m+7iytOvokPNUX5X4DqgjaYbqNGIU6GHQYnw29R4rpKVJ724vmcfxngieD1xudtlqh0B
         hiYA==
X-Received: by 10.68.251.234 with SMTP id zn10mr17945961pbc.188.1371575808110;
        Tue, 18 Jun 2013 10:16:48 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm20498303pac.20.2013.06.18.10.16.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 10:16:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6.dirty
In-Reply-To: <1371575608-9980-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228283>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-name-rev.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 5cd0d0d..67f0487 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -31,8 +31,10 @@ OPTIONS
 	List all commits reachable from all refs
 
 --stdin::
-	Read from stdin, append "(<rev_name>)" to all sha1's of nameable
-	commits, and pass to stdout
+	Transform stdin by substituting all the 40-character SHA-1
+	hexes (say $hex) with "$hex ($rev_name)".  When used with
+	--name-only, substitute with "$rev_name", omitting $hex
+	altogether.  Intended for the scripter's use.
 
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
-- 
1.8.3.1.456.gb7f4cb6.dirty
