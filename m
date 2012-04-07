From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] gitk: avoid Meta1-F5
Date: Sat,  7 Apr 2012 03:29:38 +0300
Message-ID: <1333758578-9334-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Daniel A. Steffen" <das@users.sourceforge.net>,
	"Paul Mackerras" <paulus@samba.org>,
	"Alexander Gavrilov" <angavrilov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 02:30:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGJXV-0008Qm-Ok
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 02:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758227Ab2DGA34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 20:29:56 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40405 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755025Ab2DGA3z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 20:29:55 -0400
Received: by lahj13 with SMTP id j13so2415299lah.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 17:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PljOa/vKnJYk9hGhvrHrn3lkzzVKWziPNfITTFLxGXc=;
        b=z2jXBH4bNK9NAvEaRFuY97QukzfZzpHRE7e4m4t5LoVv1Kx6YWI6XEELI3R6sX74Fp
         gYDHAeXTrnDtQgtpb9IWEDOGSEt0hg2MS8UX68SywziGYqxuYPj09Q1pr2ZbDT6Y6VbM
         LnqL4Di+k/4Ru5dGHMYad/eVjbg5mSjnq+w6UkAzgRzOVXKWndDwHqlkFBtED7GTHr9n
         G4EwzSSXAtJHK0Ul7OwtnpgANkZv1G9iulG73+ytDDWbIbP2Qzvk+UVg05LJqvRlgwq+
         NwA85P5BIaiacAA0S3CMtDRPq+pH0TEAKNTd9h38KVpjEglyaWjFI3bXuhUXWihtk1xj
         Xr1w==
Received: by 10.152.132.4 with SMTP id oq4mr4018954lab.40.1333758594230;
        Fri, 06 Apr 2012 17:29:54 -0700 (PDT)
Received: from localhost (80-186-93-53.elisa-mobile.fi. [80.186.93.53])
        by mx.google.com with ESMTPS id uc6sm10911857lbb.3.2012.04.06.17.29.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 17:29:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194929>

This is commonly mapped by window managers and what not. Use Shift-F5
instead.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 gitk-git/gitk |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 22270ce..9bba9aa 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2038,7 +2038,7 @@ proc makewindow {} {
     set file {
 	mc "File" cascade {
 	    {mc "Update" command updatecommits -accelerator F5}
-	    {mc "Reload" command reloadcommits -accelerator Meta1-F5}
+	    {mc "Reload" command reloadcommits -accelerator Shift-F5}
 	    {mc "Reread references" command rereadrefs}
 	    {mc "List references" command showrefs -accelerator F2}
 	    {xx "" separator}
@@ -2495,7 +2495,7 @@ proc makewindow {} {
     bindkey ? {dofind -1 1}
     bindkey f nextfile
     bind . <F5> updatecommits
-    bind . <$M1B-F5> reloadcommits
+    bind . <Shift-F5> reloadcommits
     bind . <F2> showrefs
     bind . <Shift-F4> {newview 0}
     catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }
-- 
1.7.10
