From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/6] Documentation/git-tools: improve discoverability of Git wiki
Date: Fri, 24 Jul 2015 00:00:55 -0400
Message-ID: <1437710457-38592-5-git-send-email-sunshine@sunshineco.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 06:01:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUBA-0004MA-1l
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbbGXEBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:01:45 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37253 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbbGXEBh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:01:37 -0400
Received: by igbpg9 with SMTP id pg9so7284040igb.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7w2RadwfpwBkyLLnP9rulq1GWMmbKF6j1nO2YBHWoY=;
        b=CXWeTmh8dY9xfh8n6WyX88srSpznKwgTD5yrLYqfBPelfjzRgVjcQ9E9lYiFar/x+K
         yxfP/I6vKFCN3IxcsvfgozbbT5DCFD8S8F612DaLTpc+l7XEOR3lRV84mhXzqkvg22U9
         puM7q5AmVTBPyE3ZwQ11HlYMhKQM126s1bboRUFRcAO5tOnEOoLv0EmJPohrZm5cb/FD
         o9ck39iNmqCkNjLf7hb+pwaJmltKQH1ILk9fMu7d4q4yPlo2MP6BT48ZpVowaXJTog6S
         MQqUsHwqAwcmw+xDCO1YSCfrGAqijsep4BQgutIUyfyGsq5LA+IQxncBI7BjrZJVLXk1
         XESg==
X-Received: by 10.50.13.34 with SMTP id e2mr2865395igc.23.1437710496904;
        Thu, 23 Jul 2015 21:01:36 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j2sm4370288ioo.43.2015.07.23.21.01.35
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:01:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.407.g68aafd0
In-Reply-To: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274542>

These days, the best way to find Git-related tools is via a search
engine. Second best may be the Git wiki. git-tools.txt falls in last
place. Therefore, promote the Git wiki reference to the top of
git-tools.txt so the reader will encounter it first, rather than
hiding it away at the very bottom.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I sneaked in a minor grammatical fix.

 Documentation/git-tools.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 78a0d95..129b8c0 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -6,10 +6,11 @@ Introduction
 ------------
 
 Apart from Git contrib/ area there are some others third-party tools
-you may want to look.
-
+you may want to look at.
 This document presents a brief summary of each tool and the corresponding
 link.
+For a more comprehensive list, see:
+http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
 
 
 Alternative/Augmentative Porcelains
@@ -112,7 +113,3 @@ Others
    This is an Emacs interface for Git. The user interface is modelled on
    pcl-cvs. It has been developed on Emacs 21 and will probably need some
    tweaking to work on XEmacs.
-
-
-http://git.or.cz/gitwiki/InterfacesFrontendsAndTools has more
-comprehensive list.
-- 
2.5.0.rc3.407.g68aafd0
