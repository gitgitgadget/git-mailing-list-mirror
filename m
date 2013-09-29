From: Keshav Kini <keshav.kini@gmail.com>
Subject: [PATCH v2 1/4] git-svn.txt: fix AsciiDoc formatting error
Date: Sun, 29 Sep 2013 18:45:57 -0500
Message-ID: <1380498360-18387-2-git-send-email-keshav.kini@gmail.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
 <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>,
	Keshav Kini <keshav.kini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 30 01:46:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQQh8-0000Jl-U6
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 01:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab3I2Xqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 19:46:31 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:64510 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab3I2Xqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 19:46:30 -0400
Received: by mail-oa0-f43.google.com with SMTP id f4so3479561oah.30
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 16:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LGQi5UJ/fpeas1mKADdeXNdJdRGbz4w4wzWd1g0Vmt0=;
        b=xig2fImRwBiQQ+aCWg0LJgNV/wHN5wkbIPPzLUcKOwkrU/tx0G2DR7g/s5GMef3TG7
         dd803svjNM664pvKdYoG8LnO/5ncO1KVVfIMlu/TAKjcaZY2HWNwl5mLoiIAQerr2wpU
         C6QS1Ea+bW49Ruj3ypdc8Av7eE+qyosTMh9xZ2GqIf0yoQb9EqI8tJQSStNu2JNncO17
         L2i+0F9y8XoUcKz6+y2k6ltxnVrZRCVXa5FNbi8kghixV0UDLDRIZWsZBEw7QEXjLC0I
         kG5KPHaLfzQwj6EWhiZdkHQdhkjC39XVIsfJHdZSuU/vnaWUZ1ONDS3zP0+nCh+Gpphd
         bj2A==
X-Received: by 10.60.96.169 with SMTP id dt9mr17052565oeb.27.1380498390027;
        Sun, 29 Sep 2013 16:46:30 -0700 (PDT)
Received: from localhost (cpe-72-179-6-119.austin.res.rr.com. [72.179.6.119])
        by mx.google.com with ESMTPSA id d8sm33234824oeu.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 16:46:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235609>

As asterisks are used to indicate bold text in AsciiDoc, shell glob
expressions must be escaped appropriately.

Signed-off-by: Keshav Kini <keshav.kini@gmail.com>
---
 Documentation/git-svn.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4dd3bcb..239c33c 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -684,7 +684,7 @@ svn-remote.<name>.noMetadata::
 +
 This option can only be used for one-shot imports as 'git svn'
 will not be able to fetch again without metadata. Additionally,
-if you lose your .git/svn/**/.rev_map.* files, 'git svn' will not
+if you lose your .git/svn/\*\*/.rev_map.* files, 'git svn' will not
 be able to rebuild them.
 +
 The 'git svn log' command will not work on repositories using
-- 
1.8.3.2
