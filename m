From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH v2 1/7] Documentation: git-init: typographical fixes
Date: Fri,  8 Aug 2014 10:29:14 -0700
Message-ID: <1407518960-6203-2-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 19:30:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnzx-0002iO-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbaHHRab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 13:30:31 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:49636 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaHHRaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 13:30:30 -0400
Received: by mail-yh0-f44.google.com with SMTP id f73so4356952yha.17
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f/WkGw10pHoM4ScCoDC2Cf3Dl1XpQJb3ISroUKsrR6g=;
        b=ChLRGDidnNPbiaC6XCuUExSEd+LULvZrKlgH1d1bSx8OkfEiUaryuES5ImzXbi1FdC
         oSZgwiKp8Dc0MIAhsTfe5DfwDTZKlYSRUd+9W6wapWYHyjwMZZNfahx3iVXQFzm7//6t
         ujzkSnKnGwxfYrfwW/xiRgt/emvI4FaKIDEfCU2BIJ+qMkaHAR+Nke4np+0YrTumFR/b
         UsJ37etG32HQCj7VgQxJPQhy0Hm7IOGU2FGY04AwXr6rfnbWljFVoESrwNL4m3TdU5zW
         sWw1eeNf7ZPbQsCjipexWF25m/dEuTsVlHG2PXcDkUlZRQYtDRdBXNuj8jjinMRTOCgc
         eUiQ==
X-Received: by 10.236.116.66 with SMTP id f42mr16980695yhh.108.1407519029159;
        Fri, 08 Aug 2014 10:30:29 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id u47sm6776458yhm.35.2014.08.08.10.30.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 10:30:28 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255051>

Use backticks when we quote something that the user should literally
use.

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index afd721e..f1f920e 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -43,7 +43,7 @@ OPTIONS
 -q::
 --quiet::
 
-Only print error and warning messages, all other output will be suppressed.
+Only print error and warning messages; all other output will be suppressed.
 
 --bare::
 
@@ -97,7 +97,7 @@ is given:
    create a repo that is readable and writable to the current user and group,
    but inaccessible to others.
 
-By default, the configuration flag receive.denyNonFastForwards is enabled
+By default, the configuration flag `receive.denyNonFastForwards` is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
@@ -106,14 +106,13 @@ line, the command is run inside the directory (possibly after creating it).
 
 --
 
-
 TEMPLATE DIRECTORY
 ------------------
 
 The template directory contains files and directories that will be copied to
 the `$GIT_DIR` after it is created.
 
-The template directory used will (in order):
+The template directory used will be (in order):
 
  - The argument given with the `--template` option.
 
@@ -138,8 +137,8 @@ $ git init      <1>
 $ git add .     <2>
 ----------------
 +
-<1> prepare /path/to/my/codebase/.git directory
-<2> add all existing file to the index
+<1> Create a /path/to/my/codebase/.git directory.
+<2> Add all existing files to the index.
 
 GIT
 ---
-- 
2.0.4
