From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] gitk: Fix bad English grammar "Matches none Commit Info"
Date: Thu,  2 Apr 2015 15:05:06 -0600
Message-ID: <1428008706-10894-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: paulus@samba.org, ottxor@gentoo.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 23:05:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdmIq-00020H-1v
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 23:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbbDBVFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 17:05:23 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35849 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbDBVFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 17:05:22 -0400
Received: by pdea3 with SMTP id a3so49431577pde.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=z2yTNWlX5+Qh6mtr3tOL3wb9rFOkFRPU6sggdQSlw7w=;
        b=Hbi+itct860XCeiEr57i/223R+mkflAilhExlZDFl9S+THwYOHRlrPHeiEoGefwhv5
         yyeGAxhFWO/j3thumBO0tPLq0IVU0ROmGwySAPYYcWiPwqEo+55e/I4Go2kdYUfzCtzs
         wLexb2bdbmveOJc8ytzrsrzWeEYl11/2nkgUg1aqLfVZ4Q+YGy0RwoMIXxBUvNcLCfr5
         rAndiXGLPU5WXHQ0f1sxXRhgLVrnd1Vbo36ZSHnB+JY+8SAByAZnoZS105t0cmPG+05Y
         TYCJb07m7XpD+ZYFFpwqAw+h1+w87CGTrUYfjGd0x8q51u1DiAhKqWleGVGogJwDjTg3
         8Xbg==
X-Received: by 10.68.248.8 with SMTP id yi8mr91379771pbc.56.1428008722229;
        Thu, 02 Apr 2015 14:05:22 -0700 (PDT)
Received: from alex-wolverine.uconnect.utah.edu ([155.99.227.128])
        by mx.google.com with ESMTPSA id cd3sm6140904pad.38.2015.04.02.14.05.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 14:05:21 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266676>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 9a2daf3..30fcd30 100755
--- a/gitk
+++ b/gitk
@@ -4066,7 +4066,7 @@ set known_view_options {
     {committer t15  .  "--committer=*"  {mc "Committer:"}}
     {loginfo   t15  .. "--grep=*"       {mc "Commit Message:"}}
     {allmatch  b    .. "--all-match"    {mc "Matches all Commit Info criteria"}}
-    {igrep     b    .. "--invert-grep"  {mc "Matches none Commit Info criteria"}}
+    {igrep     b    .. "--invert-grep"  {mc "Matches no Commit Info criteria"}}
     {changes_l l    +  {}               {mc "Changes to Files:"}}
     {pickaxe_s r0   .  {}               {mc "Fixed String"}}
     {pickaxe_t r1   .  "--pickaxe-regex"  {mc "Regular Expression"}}
-- 
2.3.5
