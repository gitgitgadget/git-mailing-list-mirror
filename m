From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] gitk: Fix bad English grammar "Matches none Commit Info"
Date: Fri,  1 May 2015 21:13:06 -0600
Message-ID: <1430536386-21959-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: paulus@samba.org, ottxor@gentoo.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 05:13:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoNri-0002Qk-Bz
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 05:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbbEBDNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 23:13:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36334 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbEBDNN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 23:13:13 -0400
Received: by iebrs15 with SMTP id rs15so100426360ieb.3
        for <git@vger.kernel.org>; Fri, 01 May 2015 20:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Tdp8olLdzCnoVJHtmJK8kUZ6GOyNFb3N1j4I2vYHY9U=;
        b=xxRZqM1TKUjB/DiTVgWsTPWizdbnc2reA4PE+v9CuHxoBosQ1QpW6t8k0k3xXJ83tB
         4UgiYzpQCkQ2oge0QB9PBBqiKDf0yErcv5MIKnGLoCOmjXn+Gim/5Ivhkf3SUNSdnDNU
         WbLzrtZ7zgIFWNhFynDd+BylD4ELXmBsgfP6P4L1nlU8uDZdzXwg11ZI1dl00uoyId3g
         ZpwFDIsI3yutlx1gQC7gsMvfZQyAu7+xSxBKQSAyHkWh99TaL20zD+894pjsHF0H8Grj
         DC/R7+n90ToJiAJvgaiHi67NwkHoGF2W8LU7BvmO6dtMHHCCfsa9Z+FmNV4O6hRBKXJa
         3O2g==
X-Received: by 10.50.6.37 with SMTP id x5mr1214172igx.45.1430536392325;
        Fri, 01 May 2015 20:13:12 -0700 (PDT)
Received: from localhost.localdomain (c-98-202-141-117.hsd1.ut.comcast.net. [98.202.141.117])
        by mx.google.com with ESMTPSA id n6sm348826igx.10.2015.05.01.20.13.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 May 2015 20:13:11 -0700 (PDT)
X-Mailer: git-send-email 2.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268215>

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
2.3.7
