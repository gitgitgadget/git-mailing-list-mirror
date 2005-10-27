From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 2/2] Ask vim to avoid backup copies of .stgit.msg
Date: Thu, 27 Oct 2005 10:56:34 +0200
Message-ID: <20051027085634.2482.34870.stgit@zion.home.lan>
References: <20051027085622.2482.22005.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 11:02:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV3dc-0007Rp-8D
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 11:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVJ0JB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 05:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVJ0JB2
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 05:01:28 -0400
Received: from [151.97.230.9] ([151.97.230.9]:33219 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S965010AbVJ0JB2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 05:01:28 -0400
Received: (qmail 31813 invoked by uid 508); 27 Oct 2005 11:01:24 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 27 Oct 2005 11:01:24 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id C88F121D84A;
	Thu, 27 Oct 2005 10:56:35 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20051027085622.2482.22005.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10704>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Do this by adding nobackup to the modeline.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/stack.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -88,7 +88,7 @@ def edit_file(series, string, comment, s
        git.diff([], series.get_patch(series.get_current()).get_bottom(), None, f)
 
     #Vim modeline must be near the end.
-    print >> f, __comment_prefix, 'vi: set textwidth=75 filetype=diff:'
+    print >> f, __comment_prefix, 'vi: set textwidth=75 filetype=diff nobackup:'
     f.close()
 
     # the editor
