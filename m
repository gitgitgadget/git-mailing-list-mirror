From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/8] remote-bzr: change global repo
Date: Thu, 16 May 2013 03:36:44 -0500
Message-ID: <1368693407-21267-6-git-send-email-felipe.contreras@gmail.com>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 10:38:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucti9-0000W1-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801Ab3EPIin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:38:43 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55577 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab3EPIil (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:38:41 -0400
Received: by mail-ob0-f174.google.com with SMTP id un3so3100530obb.5
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UJYkQytdZWuDOaXd2SrmSwHoPR50+jCVTAkwjsha2E0=;
        b=M5cV0xHdUfwlLOjb10Ng/AEp1sUV0fHKXUngzS2cXulT1Mp4QZZPlrvdO8D8SRvEzg
         najJ+fmXJYEz9+W5EfAlIIruyhL1Thd1niwBZE/p4JqF5aVwypyrQFgMkEDXzkViQ3Fa
         EmmLvLWNmg6LcUmzwRxLseeu1zFgDgFZFCLxQS2qpJ+9yBPcrhQEHq8S0OACNb4xxMaE
         +Fza/CbAjRoqqc+FFLewxyGEYQwUgI1IwGVzBieQTvYcAfCh5U0lIDXrVtoa4n2o9ZlR
         R6NVeAQy+P1sXzvUtd1WQMhit5welqlYONBi49XLluSeA+RY/XwtVeAlDJXJoHgX9dzH
         H0dg==
X-Received: by 10.182.33.40 with SMTP id o8mr19213382obi.39.1368693520783;
        Thu, 16 May 2013 01:38:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ri8sm7167621oeb.0.2013.05.16.01.38.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 01:38:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224506>

It's not used anyway.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 2ba49ff..fdc2e69 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -858,7 +858,7 @@ def get_repo(url, alias):
 
         branches[name] = remote_branch.base
 
-        return remote_branch.repository
+        return origin
     else:
         # repository
 
@@ -873,7 +873,7 @@ def get_repo(url, alias):
 
             branches[name] = remote_branch.base
 
-        return repo
+        return origin
 
 def fix_path(alias, orig_url):
     url = urlparse.urlparse(orig_url, 'file')
-- 
1.8.3.rc2.542.g24820ba
