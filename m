From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 11/19] Add prune command to OPTS_SPEC
Date: Sat, 9 Mar 2013 19:27:31 +0000
Message-ID: <CALeLG_kPgNmS=kXrbPUEZXSzUZHjMK_K5STxTFpJG4BWKEAp1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:28:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPR0-0002mz-BB
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab3CIT1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:27:32 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:34837 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CIT1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:27:31 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so3298059oag.18
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=hGB6k+6L6MOsM2o7pGTWB0eFQOudKO9/ZdAt2A19594=;
        b=lU3GlU6JLKzu/Wz0jbW0Xt0VVSS//0awicouhU1l2mLQP/M9ZBQycGCeNRYoMpwq8/
         K2wDEtrJF3EqYO9Tp6FPxWyv2XX4MlgHGXHKsackWcnhJP9vOhQXqAgk2NB1u+cILdWi
         YZj4I1agHrHWxmB5eKNovvvR8Op+qAQtNAvDG2Ze7p0vMzzInoum6sYcCXxjMmJ1IDv7
         fLQbKFAgN6TgbMVtkAxzRukcUjwoyMyjqK6Fugwj8X7+R1oNAGWcPEFhCPbUmU15Ypln
         o5Muy4qtffxbdr92TprkoJuxVHBMHGCta5OPuydFdq1b2DlaLoIGppGBnxdn1XIltKf2
         WEfA==
X-Received: by 10.182.93.193 with SMTP id cw1mr5102226obb.93.1362857251357;
 Sat, 09 Mar 2013 11:27:31 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:27:31 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQlMm/5qcB6ReGYIYaLUSjdsD19uplSRuyyObvN/uU8ARRE6nONPzSQnkm9kIjrHhFmRDV6C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217748>

>From 48e77d62e05582e2aec4c634a913f28f3f804a37 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:33:50 +0000
Subject: [PATCH 11/19] Add prune command to OPTS_SPEC

Conflicts:
	git-subtree.sh

Original-Author: Herman van Rink <rink@initfour.nl>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 0c41383..d67fe5a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -18,6 +18,7 @@ git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
 git subtree diff  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree from-submodule --prefix=<prefix>
+git subtree prune
 --
 h,help        show the help
 q             quiet
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
