From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] Documentation/git-branch.txt: add short option to git branch synopsis
Date: Sat, 17 Jan 2015 13:36:17 +0600
Message-ID: <1421480177-4903-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 08:36:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCNvp-0000hz-JL
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 08:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbbAQHgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 02:36:25 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:40060 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbAQHgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2015 02:36:24 -0500
Received: by mail-la0-f48.google.com with SMTP id gf13so22231221lab.7
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 23:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HVbJbg4XP1ykstEpE2hvAbJwSyciwit+RkG2TBpaL1k=;
        b=iZUdvvskKcDcxmhGe/t0RW+l/68WARRLRnOLdu4zp0ZAS7IhzQI5srrnPSPrijWj7Q
         chzmicYy/wd1OyJ1XPaWdYJhbGKQ6/R2blk+FTamS1d9+fgYWRUZ64TsVBCQ5MeICJtj
         3vSwnq3Qhgy9wdZjOSLzPrtxzowGs1D9DNn1VE5sRZ+0pWw5NFWjL4eGO954an+ES8fI
         PAIv7/llZxqExwkXFChhSYNHAu+nIaYOU2BZoK/74ikOvlWYJxLS7BQDnoFwDps8ApAI
         BgGoYDxvVwnPeAoOppT48LPN3+P0uK57KRgAxlkXUpJlXQ7nWxJIXRROAPbQkYZg7GWe
         0c4g==
X-Received: by 10.112.167.228 with SMTP id zr4mr19680817lbb.20.1421480183212;
        Fri, 16 Jan 2015 23:36:23 -0800 (PST)
Received: from localhost.localdomain ([37.151.216.146])
        by mx.google.com with ESMTPSA id aq4sm1358311lbc.46.2015.01.16.23.36.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jan 2015 23:36:22 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.286.ga3dc223.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262581>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 311b336..722f865 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git branch' [--color[=<when>] | --no-color] [-r | -a]
+'git branch' [--color[=<when>] | --no-color] [(-r|--remotes) | (-a|--all)]
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column]
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
-- 
2.3.0.rc0.286.ga3dc223.dirty
