From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 6/6] template: Fix comment indentation in pre-rebase hook
Date: Sun, 14 Jul 2013 18:21:19 +0200
Message-ID: <1373818879-1698-7-git-send-email-richih.mailinglist@gmail.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 18:21:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyP3G-0006sj-5V
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 18:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab3GNQVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 12:21:32 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:45637 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3GNQVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 12:21:30 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so4321543bkh.25
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Roy1neImaD5pHbxd5WmvdjRTuLgU/HmMmz7uKjQ1GgM=;
        b=S6diRdMoizPdWXKF9NDyeKwlzf4tj93PPJprucK1CrEUF7fPE0Si07e7B22LHqVe+v
         iY6ST4WkqW11+C6heTQt+5BCbAEnmnTOPCn+3h18WckOoS6ykt4L7Oy0S9xRvxSCfDAk
         AI/eK9eIwyAbFNAWRhKxpzPIARb1CdwQPYQ6C18elAUVGcwCzTa9zbYk6h5fFp9hvzri
         spjjwqa8aFrrVEPmmWKBI1V7L7CwaEIAZRrqVw7Xt69CzpTl4Z4fN9WQIdmOgfDewukW
         2607ybhN33FVkPBGxvvuxYHxmlW6chZUeU0342hq6oUHIOAPWExhL1Pco4qLzUnUdKxX
         TeDA==
X-Received: by 10.204.61.193 with SMTP id u1mr1859914bkh.119.1373818889087;
        Sun, 14 Jul 2013 09:21:29 -0700 (PDT)
Received: from rockhopper.fritz.box (p5499AB9B.dip0.t-ipconnect.de. [84.153.171.155])
        by mx.google.com with ESMTPSA id ct12sm496595bkb.12.2013.07.14.09.21.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 09:21:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230373>

The other hooks use two whitespace for indentation instead of tabs
to signify code in the example/echo output.
Follow the same layout in templates/hooks--pre-rebase.sample

Based on d153a68bebfabc1db5241d02ee75fa5cb4538ab0 in original patch
series from 2013-06-10.

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 templates/hooks--pre-rebase.sample |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index b74cd1d..cec3474 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -157,13 +157,13 @@ B to be deleted.
 
 To compute (1):
 
-	git rev-list ^master ^topic next
-	git rev-list ^master        next
+  git rev-list ^master ^topic next
+  git rev-list ^master        next
 
-	if these match, topic has not merged in next at all.
+if these match, topic has not merged in next at all.
 
 To compute (2):
 
-	git rev-list master..topic
+  git rev-list master..topic
 
-	if this is empty, it is fully merged to "master".
+if this is empty, it is fully merged to "master".
-- 
1.7.10.4
