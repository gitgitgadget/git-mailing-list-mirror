From: "Albert L. Lash, IV" <albert.lash@gmail.com>
Subject: [PATCH 1/4] docs/merge-strategies: remove hyphen from mis-merges
Date: Sat,  8 Feb 2014 15:41:34 -0500
Message-ID: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
Cc: "Albert L. Lash, IV" <alash3@bloomberg.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 21:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCErx-00054c-1q
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 21:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbaBHUuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 15:50:50 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61694 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbaBHUuu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 15:50:50 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so7291872qab.19
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xnWfKLr+s3F4iBN2ymZfm/+xkcRZ3KB6vN/IH2JVWnc=;
        b=jnAYzXOC2nAnKS/KvqkrsKNmDsEkcHBHFeEdwOM12Syg+vg1C+0zok8K6hcwEGmw70
         BNZGnLu8nOO4reQOfD6raf07dmyokdQXNgD5nsKg+nfkVbqgzLl6j2KOjOLM8w1fPb1w
         A6KC98Vc5XVC1rpKPhKDsKQaVorcvP8A5wW8LygGa8WwngEx4xEJBlnRZJuujjprY9UH
         jU8uT5ZqIjwHXbA6a8n+wZ7pJl+ni9xq45rqJj/t1dqQVnisa6H3tA8rbFbOVqeahgEU
         4Ajkcfp3EuaIN1W1mYaWdAf73JUOVJqsyN8Kj0RVyo2UZeWzw6F3vNGlHaG5byboetto
         cqVw==
X-Received: by 10.224.61.2 with SMTP id r2mr11614282qah.49.1391892649580;
        Sat, 08 Feb 2014 12:50:49 -0800 (PST)
Received: from osday-ubuntu.bloomberg.com ([65.115.226.27])
        by mx.google.com with ESMTPSA id o75sm15994005qgd.11.2014.02.08.12.50.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 12:50:48 -0800 (PST)
X-Mailer: git-send-email 1.9.0.rc3.4.g9111436
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241856>

The term mismerges without hyphen is used a few other
places in the documentation. Let's update this to
be consistent.

Signed-off-by: Albert L. Lash, IV <alash3@bloomberg.net>
---
 Documentation/merge-strategies.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index fb6e593..3509498 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -20,7 +20,7 @@ recursive::
 	merged tree of the common ancestors and uses that as
 	the reference tree for the 3-way merge.  This has been
 	reported to result in fewer merge conflicts without
-	causing mis-merges by tests done on actual merge commits
+	causing mismerges by tests done on actual merge commits
 	taken from Linux 2.6 kernel development history.
 	Additionally this can detect and handle merges involving
 	renames.  This is the default merge strategy when
-- 
1.8.3.2
