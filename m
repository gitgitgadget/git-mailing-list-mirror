From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] completion: add options --single-branch and --branch to "git clone"
Date: Wed, 28 Nov 2012 19:27:02 +0100
Message-ID: <1354127222-5569-1-git-send-email-ralf.thielow@gmail.com>
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 28 19:27:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdmM8-0003Sf-4y
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab2K1S1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:27:17 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62073 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779Ab2K1S1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:27:16 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5882920bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=90I3bZNZY4g585n4oYZLW6RArk85tUhMLXpvXZha1fk=;
        b=Om1IBxcRP2eNcbJVRMZB9UQcci33mijaPKhVLh2EiXvroBCoFW7tdLo8eOmXszNPdv
         /RUL08N8Ix8W7L0aFyC8/HkpWyKZ2CcKpGZB+kHGiYT2JBe4RkTPaKOvc/ImXLaI70Rc
         SjhG7BldXHDUmT5Dvfg+OeoV3H0N+IkY4gq7W9CXi/ZGA8ZpQb+QJh/IjoIqyZ+pXWPe
         7jG+hB135Ng9g1kRdI90uIBO51PQN9NjjEwL9cwIqfaB/zhSi2ne1UXv8UPAIYAGI3fW
         2kz7Gba4vEJnAixQKMXbsPDDg1KQ1ClRPcZF+Xo46UC2r25kRhcmEaOmlzwjy4beu9HN
         Xr7Q==
Received: by 10.204.5.205 with SMTP id 13mr6193722bkw.111.1354127235041;
        Wed, 28 Nov 2012 10:27:15 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-147-091.pools.arcor-ip.net. [94.222.147.91])
        by mx.google.com with ESMTPS id hm8sm10481182bkc.10.2012.11.28.10.27.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 10:27:14 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210755>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 48c3abd..cda095d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -989,6 +989,8 @@ _git_clone ()
 			--upload-pack
 			--template=
 			--depth
+			--single-branch
+			--branch
 			"
 		return
 		;;
-- 
1.8.0
