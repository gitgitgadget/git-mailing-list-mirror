From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] fetch: add missing documentation
Date: Sat, 21 Sep 2013 09:09:22 -0500
Message-ID: <1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 16:15:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNxr-0000sy-Or
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 16:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab3IUOO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 10:14:57 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:39943 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab3IUOOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 10:14:52 -0400
Received: by mail-ob0-f171.google.com with SMTP id wm4so1954251obc.30
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q9gk2WT+yW0xltBZ1/pXdMyjbdDSEFHs5R8cDh2PvLI=;
        b=y41yXxTCD1S1GE0Gm42UY4QO/OR5q3ba5aoR/lM7T0yVI3sK6NjZ8W39CNIoxDE5b3
         Ct0TquSfN1BzuPH8G9TIC1Wb/OX5oYW9Zpmtz5mWK39fRwCIQLIiUx731KcfXO+C5Ked
         tffWL+9pGlB6JG3ZXkp3nqMkNYfbcPfgMZBPuc1/HnemG04LEAnCXzYhJ10LyzPDIY4T
         zoZ20ifMs9qOL4RjtReW1YVganeV10mn3z7xQLGuwwRvuaeC1jdFpM5LWQEM5Hz3l+98
         JzD6YDsjq2pXsU4/vQ6qA4BXk1pn9hW2OI5zwqSda5qOAP3Wo5Ey6cWpIbbKcEbiEBc1
         JIhg==
X-Received: by 10.60.131.41 with SMTP id oj9mr60284oeb.40.1379772891098;
        Sat, 21 Sep 2013 07:14:51 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm8331236obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 07:14:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2.gac946cf.dirty
In-Reply-To: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235120>

There's no mention of the 'origin' default, or the fact that the
upstream tracking branch remote is used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fetch.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e08a028..7e75dc4 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -37,6 +37,9 @@ or from several repositories at once if <group> is given and
 there is a remotes.<group> entry in the configuration file.
 (See linkgit:git-config[1]).
 
+When no remote is specified, by the default the `origin` remote will be used,
+unless there's an upstream branch configured for the current branch.
+
 OPTIONS
 -------
 include::fetch-options.txt[]
-- 
1.8.4.2.gac946cf.dirty
