From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] Documentation/git-branch.txt: add long options to git branch synopsis
Date: Sat, 17 Jan 2015 22:36:00 +0600
Message-ID: <1421512560-3538-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 17:36:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCWMG-0003mU-Ge
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 17:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbbAQQgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 11:36:16 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:50366 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbAQQgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2015 11:36:15 -0500
Received: by mail-lb0-f179.google.com with SMTP id z11so22671420lbi.10
        for <git@vger.kernel.org>; Sat, 17 Jan 2015 08:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HVbJbg4XP1ykstEpE2hvAbJwSyciwit+RkG2TBpaL1k=;
        b=mAsmnYtPqRLxy4yz92NhOpJ9DPzZdkPAESIS30azQ6tAKQ/hgsPp1vNeuNrqrmAzZn
         sfsL3UsiPJ7FyTaVMK9dvPKpWJoSj3tFFiXzS346NjS9FKjhLhXL6Clf1IfN0HQa0JNz
         mfVI58ntzuW5NW+PCitwF8bLS2ULfZLAm8OkiwgWDzEaiQRdHdpvzrL7IEAoXzkbCLlt
         bhIv5a05EZbVI6eiJHtYgaQAfmr33uH9LhTvTDE69F17N5vQ7uMgGIayVC5DP7joXYET
         tERtI+BxuKrTl6Dnl63M68RKaihZNTwmsvf880e6D/S6ni7NtsAoR6a0lYTcpw6bABvO
         xyzg==
X-Received: by 10.112.167.136 with SMTP id zo8mr19046674lbb.17.1421512574073;
        Sat, 17 Jan 2015 08:36:14 -0800 (PST)
Received: from localhost.localdomain ([37.150.86.244])
        by mx.google.com with ESMTPSA id ji3sm1659563lbc.38.2015.01.17.08.36.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Jan 2015 08:36:13 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.286.ga3dc223.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262587>

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
