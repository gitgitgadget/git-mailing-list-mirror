From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/8] remote-bzr: change global repo
Date: Fri, 24 May 2013 21:24:23 -0500
Message-ID: <1369448666-17515-6-git-send-email-felipe.contreras@gmail.com>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:26:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Bj-0006XS-SE
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab3EYC0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:26:21 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:40621 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab3EYC0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:26:19 -0400
Received: by mail-ob0-f179.google.com with SMTP id wo10so2796644obc.38
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kArYKa6KDJghJVxbbc7j1fu0BCT/jPEY8cWMYvE1JqY=;
        b=qfcQ0hSRhR/Nv23ckJbpThBm5yKeZaaW9PUc8lLbToMbt5j55YbVN7LylQTKTbO3Vh
         vSEU0mqQ/hH5R3XGu49mCmpoWmOj6PYQ84DXqtlO/zbWVuhPLUi9RuUrfKxF45HEluRQ
         T/P6pDPrQd4nBYtBf2AmMMaAKt34a4sSbrS4xx3NWIJCNMvpV6IUSsrnVb0eK0DtaoXZ
         UZrQgHPkQ+GnlRd3L1G77XjZWLRNuH27kf5EoPoCedqAhUiE2JjeUvUYkl+86QkySVeJ
         oZnvu8qLJVi+J20PqBnzj5RVZRKzuPPWUVODmYtbHzls9q1+GPEoQNTsnDfKjg2JYP3p
         k59A==
X-Received: by 10.60.35.201 with SMTP id k9mr5356106oej.102.1369448779028;
        Fri, 24 May 2013 19:26:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm20055443obc.6.2013.05.24.19.26.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:26:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225412>

It's not used anyway.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 202a4f7..80ed59f 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -864,7 +864,7 @@ def get_repo(url, alias):
 
         branches[name] = remote_branch.base
 
-        return remote_branch.repository
+        return origin
     else:
         # repository
 
@@ -879,7 +879,7 @@ def get_repo(url, alias):
 
             branches[name] = remote_branch.base
 
-        return repo
+        return origin
 
 def fix_path(alias, orig_url):
     url = urlparse.urlparse(orig_url, 'file')
-- 
1.8.3.rc3.312.g47657de
