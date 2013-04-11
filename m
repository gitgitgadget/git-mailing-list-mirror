From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 02/21] remote-hg: add missing config variable in doc
Date: Thu, 11 Apr 2013 07:22:58 -0500
Message-ID: <1365682997-11329-3-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Dusty Phillips <dusty@linux.ca>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:24:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYM-0006qb-2V
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118Ab3DKMYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:31 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:54197 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935175Ab3DKMY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:29 -0400
Received: by mail-qa0-f42.google.com with SMTP id bv4so233478qab.8
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=RnIilAwXlcn6B/3GErBEE/T8hhZII54vky9Yby1NeOc=;
        b=WECgf5/0dimZCpuuyh2J704cgK1yDqgtXVyQ54jkK57qQYI5+mjwCzxguNgMCNktqv
         0vVZv2yeWQ30aTCQilFC39xtzHazvH/erv9UmE4CtjwONGwNlzZIzo/kTBiONy5gdmTw
         dnDvplTwZI/Jnle9t6Mbq34jqEPrYxH83+lSp+rOSOKGJx+ZYWv1bu2vLBCTig5b7T+m
         JjW+zBORal79z2b0dDrhfgYR5l+KY3kSwkpUe0A4Ia/vIQbX8KW89tfT3cDr0AzFEPjP
         xiPkXSWgwL/q6Ghc3Tl1uYP3SRud4H4BwDVgCEGMtGtTr2sp4sEY5LwHRShIDyraQz8r
         XM5A==
X-Received: by 10.224.39.206 with SMTP id h14mr6777233qae.79.1365683068257;
        Thu, 11 Apr 2013 05:24:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id h5sm6966074qai.9.2013.04.11.05.24.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220855>

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
1.8.2.1
