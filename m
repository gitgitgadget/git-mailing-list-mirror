From: Bryan larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Thu, 21 Jul 2005 16:23:10 -0400
Message-ID: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
Cc: catalin.marinas@gmail.com, Bryan Larsen <bryan.larsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:24:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvhZf-0004Y8-TI
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 22:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVGUUXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 16:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVGUUXN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 16:23:13 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:56716 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261873AbVGUUXM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 16:23:12 -0400
Received: (qmail 78160 invoked from network); 21 Jul 2005 20:23:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Subject:Date:Message-Id;
  b=gC+01gUwHvjT+zS6fH9QlViAcCFr5/s5mDiblYAatBnbGdcVA12SWEe8GY5mrwlJ3iTtSl8JFreJkIwMx/wDPsk3oWer7HcgNjmNoI9sUt8sUCMGO1olyGjeqyH7zY5UYVn1xCqEtCFravcybHd92EPE97f2KyatE5leiIeey1c=  ;
Received: from unknown (HELO h164.c77.b0.tor.eicat.ca) (bryanlarsen@72.0.77.164 with plain)
  by smtp101.mail.sc5.yahoo.com with SMTP; 21 Jul 2005 20:23:11 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When invoking EDITOR, add some metadata to tell vim the textwidth is 75.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 stgit/stack.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -66,6 +66,8 @@ def edit_file(string, comment):
           % __comment_prefix
     print >> f, __comment_prefix, \
           'Trailing empty lines will be automatically removed.'
+    print >> f, __comment_prefix, \
+          'vim: textwidth=75'
     f.close()
 
     # the editor
