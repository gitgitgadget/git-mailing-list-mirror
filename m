From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 02/20] remote-hg: add missing config variable in doc
Date: Mon,  8 Apr 2013 12:13:16 -0500
Message-ID: <1365441214-21096-3-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Dusty Phillips <dusty@linux.ca>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:15:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFf3-0004EZ-E3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934756Ab3DHROr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:14:47 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:58522 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934710Ab3DHROq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:14:46 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so6429057oag.21
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=IRdlnoSYQjUg72E63/HMAOwHjomhZsyEAMNKdcOv1z0=;
        b=wXsCmxjSqkeUjUPQc6VAZ6UdAqlpK3DLfcmIvSRptS/5Zv/eii7l9jLxixP19k8IyD
         g+czCCDbzzGOp4393AS1zCAJConQhvAMB8he21+2V/B6/2jvOtgwQ4yTJ4bCRsCFU39j
         /AzulmGuMmcl4JUvfpZ3LKu0tPs619np7dOmb5ygVOMmwrq9dhJV5qD0x3Nzmc1UI1jv
         7+Ts8kFkBNbFfr6ytV6LtVh7lI0TJjwBxmxGqJ88fsAJOUjQLK4h+PoFjBFBKAHoQQWN
         E2OEVZqOxsaNTS+jW8cr6RA8U4hbo4APWwVz5XGHw402/9z9RC8urw2AVSqotjm+/tcM
         ksUg==
X-Received: by 10.182.64.74 with SMTP id m10mr15870980obs.61.1365441285640;
        Mon, 08 Apr 2013 10:14:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id s8sm4894492obf.2.2013.04.08.10.14.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:14:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220444>

From: Dusty Phillips <dusty@linux.ca>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d0dfb1e..844ec50 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -23,6 +23,10 @@ import urllib
 # If you want to switch to hg-git compatibility mode:
 # git config --global remote-hg.hg-git-compat true
 #
+# If you are not in hg-git-compat mode and want to disable the tracking of
+# named branches:
+# git config --global remote-hg.track-branches false
+#
 # git:
 # Sensible defaults for git.
 # hg bookmarks are exported as git branches, hg branches are prefixed
-- 
1.8.2
