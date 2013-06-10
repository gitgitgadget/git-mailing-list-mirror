From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 6/6] template: Fix comment indentation in pre-rebase hook
Date: Mon, 10 Jun 2013 20:36:05 +0200
Message-ID: <1370889365-6239-7-git-send-email-richih.mailinglist@gmail.com>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 20:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6xA-00059Y-52
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab3FJSgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:36:24 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:43335 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab3FJSgU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:36:20 -0400
Received: by mail-ee0-f49.google.com with SMTP id b57so3187773eek.22
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 11:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MvE2OoLtpgFKsRs0PAJiC6neUbbCOQtqr0WID3071U0=;
        b=EfzRpW3L7GpKtC1xRCVZjJDuhV7Unfe8J8pgsHaqln0kQmdNT68peLOG452iCYShxP
         3OPQfWvgIeZA/R/wuIDcTzFIEPnbjvU7rKK3jS/vrX0D0ecKk9SzwSrRSkVSYgM6j6TV
         iOfngXTQVDbe/n45kMK0exTjlFjZ1ywEYMHv3f5yK4drqm822LxJGmsnS4LNjxGEZZtP
         X1QgRy2A4N8LgdfG9M+jbV4qSMCOpv6mt8lFJa3Sz4fLhYgQJJmQLu61UoEdB7MXEVHR
         4QItwZ51Vr2xrE/3eK2DTWJnfg17ZCVRoQl//yhhqQ58vvP4oG1r+C9tWFBU5biufraU
         dPFw==
X-Received: by 10.14.6.134 with SMTP id 6mr12539907een.40.1370889379509;
        Mon, 10 Jun 2013 11:36:19 -0700 (PDT)
Received: from rockhopper.fritz.box (p54998111.dip0.t-ipconnect.de. [84.153.129.17])
        by mx.google.com with ESMTPSA id ba7sm24960845eeb.0.2013.06.10.11.36.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 11:36:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227351>

The other hooks use two whitespace for indentation instead of tabs
to signify code in the example/echo output.
Follow the same layout in templates/hooks--pre-rebase.sample

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 templates/hooks--pre-rebase.sample |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index b74cd1d..43426e0 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -157,13 +157,13 @@ B to be deleted.
 
 To compute (1):
 
-	git rev-list ^master ^topic next
-	git rev-list ^master        next
+  git rev-list ^master ^topic next
+  git rev-list ^master        next
 
-	if these match, topic has not merged in next at all.
+  if these match, topic has not merged in next at all.
 
 To compute (2):
 
-	git rev-list master..topic
+  git rev-list master..topic
 
-	if this is empty, it is fully merged to "master".
+  if this is empty, it is fully merged to "master".
-- 
1.7.10.4
