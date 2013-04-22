From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/7] git-log.txt: rewrite note on why "--" may be required
Date: Mon, 22 Apr 2013 11:00:29 +0530
Message-ID: <1366608631-21734-6-git-send-email-artagnon@gmail.com>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 07:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU9L3-0005j7-Hb
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 07:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab3DVFas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 01:30:48 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:38386 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3DVFar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 01:30:47 -0400
Received: by mail-pd0-f171.google.com with SMTP id t12so1211445pdi.16
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XvisRwre2retXvAHM9uGVrvzL5KyDxwwXkGqMx1k8FY=;
        b=BahFWTg0yxkkuw6PBFXMZZvwImWLBfjJMUKgKDUKE7eSlnCxOtCzfO1RoHRnjKHTnC
         4mPT0upBYEZXc7/QGGSvMD0RwE5rGJwvA8g4m0t3YFG6PyD18n6ZIPZgqHzz4ASqIus0
         UVcs9lxfBDPAkxPMdA3Oq3ykOiOlxPFehuzHi3skd0v2BfcAcWhCZca70PdFxzv1PLWs
         6nMySzAUFlmphlu6w2GfYrPJNah/srw1jlZObnqpNMkyIJQ2fCSxfQXQR4ZIFtHw75n1
         3x6Wfx9e5qaeXVhYVNSXCS7vTidjJEHwgkKMexSWzp8bNoEJlBQai9VeAejji15RmndJ
         UoWw==
X-Received: by 10.66.241.41 with SMTP id wf9mr8387376pac.144.1366608646582;
        Sun, 21 Apr 2013 22:30:46 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id em2sm11144653pbb.0.2013.04.21.22.30.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 22:30:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221989>

In its current form, the note talks about separating options from
"branch names" and "refnames" in the same sentence.  This is entirely
inaccurate, as <revision range> need not be a set of branch names or
ref names.  Rewrite it to use the word "revision range", to be
consistent with the SYNOPSIS.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-log.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 9576695..a976534 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -77,8 +77,8 @@ produced by --stat etc.
 	Simplification" below for details and other simplification
 	modes.
 +
-To prevent confusion with options and branch names, paths may need to
-be prefixed with "\-- " to separate them from options or refnames.
+Paths may need to be prefixed with "\-- " to separate them from
+options or the revision range, when confusion arises.
 
 include::rev-list-options.txt[]
 
-- 
1.8.2.1.501.gd2949c7
