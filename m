Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB78D20281
	for <e@80x24.org>; Sun,  5 Nov 2017 16:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbdKEQ26 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 11:28:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:51483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdKEQ25 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 11:28:57 -0500
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MBFgr-1e1AdG04Kz-00ABkp; Sun, 05 Nov 2017 17:28:23 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: [PATCH 2/3] Documentation: user-manual: limit potentially confusing usage of 3dots (and 2dots)
Date:   Sun,  5 Nov 2017 17:27:29 +0100
Message-Id: <20171105162730.31405-2-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171105162730.31405-1-bedhanger@gmx.de>
References: <20171105162730.31405-1-bedhanger@gmx.de>
X-Provags-ID: V03:K0:dfwtLhfoY0eOZe1Z6Y/Di2xJ6v0oiut1DgW/RToeaGXuca2yKkV
 6+koZzTy1An8/sla9OMaMuL8AfhCmxRyMMmoi8LbTCWi0n52E1dkA0sKpGyf1qzQ9eqhRjD
 nw9aNdWHGu+qBhER31pPPor/M69CvvCjBmNxCLEPuoLhBa3qmKAsxJy/X5+KKeMsUjvegfO
 rM/yVel2U35/MQ79PbTBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JABhHowYytY=:yS5hpIBc3fdGMSlwgYReJL
 OFcR4xNgKIrtcUsOG4Ci8TI8CumGvDxxYdwunDM7yP7yvjLvan+oVrYdmt9zfVdZNN0+r4dy0
 wHFAr3sPMUcHejv6fZq0v18Xo3X3qXV6A0Pa5b8UI2S7jNqlS+fxuVi+S138ptczCW96+iofQ
 1idoxL6bOjYfNDxvrNRoVGvwZyPuBmRK7rt0ajkastBMD38HnH+SxrRps9Kx4mJJBiHeTsHt4
 YmOcP3ygQgXgQNGV2P8p+DrowH3a7vOw3DBmcLpoLZJPTBOMRy5AgYjL9hiWP00Rvea5wFENk
 Ptz4hUCmNZ3KH43pVT7FPgSjVTTaGG/Sw0puoxmydrsx+s+mRKClD9OUbBXu1fqkKlrwZuGD7
 dkQZLZoVPdyCDLHvstOGzBJFlsgEcv4B1UKdaz56rhu/A3zc9Tqflh8d4kKeaP+hL+bDMg1bQ
 U0rJQpqCd7daRedBUd1yq+/durPIuqxwzOFCCAlCMRtfLJ9Q9GUyyQxKL8EOntlcEycvPAfRE
 fzW6b8EYWuD0Qmmc/jy80sLN5nyiFYotLlD91Y4Ls3GaJEBQG3TkwAWA3Gd9ZzR7W3NEVKxmJ
 4Pd8S/ZZ3wD3Bc/kOgy7R2mKI18QzHakmZV16hP15Rzx+NrUCycUcHg8CFc5T7gx5EbiHPAIM
 +Se9xguwBOJTI2lQxo8CnlsmHl6Jq3MSKENrj0nvCiHj1pHkbDWmyIqJRDOeK503VnryIm5mM
 mU8koR+a2mhficoMhg+PKHq8MF3HgJ3PQadoY29SPPMMapgpdJdMDf6Z5msCjog+AnzpZthbQ
 GS9kj1JxZEd0RcgSEUQ+KFXr9lGrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using them as continuation indications for abbreviated SHA-1 values
bears the risk that they are mistaken for the dotted range operators.

Commands which expect a single commit will fail when given a range of
commits.

Also, add a note that sometimes, 3dots are just continuation
indications.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
 Documentation/user-manual.txt | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b4d88af133e8..bdb44b067399 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -319,7 +319,7 @@ do so (now or later) by using -b with the checkout command again. Example:
 
   git checkout -b new_branch_name
 
-HEAD is now at 427abfa... Linux v2.6.17
+HEAD is now at 427abfa Linux v2.6.17
 ------------------------------------------------
 
 The HEAD then refers to the SHA-1 of the commit instead of to a branch,
@@ -508,7 +508,7 @@ Bisecting: 3537 revisions left to test after this
 
 If you run `git branch` at this point, you'll see that Git has
 temporarily moved you in "(no branch)". HEAD is now detached from any
-branch and points directly to a commit (with commit id 65934...) that
+branch and points directly to a commit (with commit id 65934) that
 is reachable from "master" but not from v2.6.18. Compile and test it,
 and see whether it crashes. Assume it does crash. Then:
 
@@ -549,14 +549,14 @@ says "bisect".  Choose a safe-looking commit nearby, note its commit
 id, and check it out with:
 
 -------------------------------------------------
-$ git reset --hard fb47ddb2db...
+$ git reset --hard fb47ddb2db
 -------------------------------------------------
 
 then test, run `bisect good` or `bisect bad` as appropriate, and
 continue.
 
 Instead of `git bisect visualize` and then `git reset --hard
-fb47ddb2db...`, you might just want to tell Git that you want to skip
+fb47ddb2db`, you might just want to tell Git that you want to skip
 the current commit:
 
 -------------------------------------------------
@@ -3426,6 +3426,8 @@ Date:
 ...
 :100644 100644 oldsha... 4b9458b... M somedirectory/myfile
 ------------------------------------------------
+(Note that in the above, the "..." are used as continuation
+indications, not as symmetric difference operators!)
 
 This tells you that the immediately following version of the file was
 "newsha", and that the immediately preceding version was "oldsha".
@@ -3449,7 +3451,7 @@ and your repository is good again!
 $ git log --raw --all
 ------------------------------------------------
 
-and just looked for the sha of the missing object (4b9458b..) in that
+and just looked for the sha of the missing object (4b9458b) in that
 whole thing. It's up to you--Git does *have* a lot of information, it is
 just missing one particular blob version.
 
@@ -4114,9 +4116,9 @@ program, e.g.  `diff3`, `merge`, or Git's own merge-file, on
 the blob objects from these three stages yourself, like this:
 
 ------------------------------------------------
-$ git cat-file blob 263414f... >hello.c~1
-$ git cat-file blob 06fa6a2... >hello.c~2
-$ git cat-file blob cc44c73... >hello.c~3
+$ git cat-file blob 263414f >hello.c~1
+$ git cat-file blob 06fa6a2 >hello.c~2
+$ git cat-file blob cc44c73 >hello.c~3
 $ git merge-file hello.c~2 hello.c~1 hello.c~3
 ------------------------------------------------
 
@@ -4374,7 +4376,7 @@ $ git log --no-merges t/
 ------------------------
 
 In the pager (`less`), just search for "bundle", go a few lines back,
-and see that it is in commit 18449ab0...  Now just copy this object name,
+and see that it is in commit 18449ab0.  Now just copy this object name,
 and paste it into the command line
 
 -------------------
-- 
2.13.6

