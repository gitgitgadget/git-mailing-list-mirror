From: "Albert L. Lash, IV" <albert.lash@gmail.com>
Subject: [PATCH 4/4] docs/git-blame: explain more clearly the example pickaxe use
Date: Sat,  8 Feb 2014 15:41:37 -0500
Message-ID: <1391892097-16169-4-git-send-email-alash3@bloomberg.net>
References: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
Cc: "Albert L. Lash, IV" <alash3@bloomberg.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 21:51:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCEs3-00058Z-4Q
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 21:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbaBHUvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 15:51:21 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:48617 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbaBHUvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 15:51:07 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so7441063qaq.15
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 12:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tHpfd44HpSlGWQ5THwKWcTfGLKUdeJk14m1Z7dqNFh8=;
        b=z13MamQsDtYYRes0VnpjB4RYw312uLNGcuxRC4Mfs2BpmuYlfgfYT35RT/DBggPizY
         /evv5DjsAY01xtoyZmjZqBEoxfASGvdQyoyFYWd969mhtMQNvp4aat3G0mqaWgi/BYL2
         BYtBypu7tSbmpbtrZEJE19H0KFTlvp6Zbv3HwVtS7jK63sj9/cVHtwjVpcWy8TFtc3Fl
         1HIIYhdbG4aJxtRvNJ+yjKRTJf6hsMP8U/R+vlD0a2khg5CFkq4phov75w+H06gAvY8h
         uShplhbYsqcjJ4dfrvzvmljHXxyrfNi4ke895DVtj8moYt4hqGcPsuFzEB3AiwHTDrvK
         mAPg==
X-Received: by 10.224.53.198 with SMTP id n6mr33828597qag.41.1391892666888;
        Sat, 08 Feb 2014 12:51:06 -0800 (PST)
Received: from osday-ubuntu.bloomberg.com ([65.115.226.27])
        by mx.google.com with ESMTPSA id o75sm15994005qgd.11.2014.02.08.12.51.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 12:51:06 -0800 (PST)
X-Mailer: git-send-email 1.9.0.rc3.4.g9111436
In-Reply-To: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241858>

We state that the following paragraph mentions the pickaxe
interface, but the term pickaxe is not then used. This
change clarifies that the example command uses the pickaxe
interface and what it is searching for.

Signed-off-by: Albert L. Lash, IV <alash3@bloomberg.net>
---
 Documentation/git-blame.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 8e70a61..ddb88d0 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -35,7 +35,8 @@ Apart from supporting file annotation, Git also supports searching the
 development history for when a code snippet occurred in a change. This makes it
 possible to track when a code snippet was added to a file, moved or copied
 between files, and eventually deleted or replaced. It works by searching for
-a text string in the diff. A small example:
+a text string in the diff. A small example of the pickaxe interface 
+that searches for `blame_usage`:
 
 -----------------------------------------------------------------------------
 $ git log --pretty=oneline -S'blame_usage'
-- 
1.8.3.2
