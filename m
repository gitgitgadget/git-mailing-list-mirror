From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH] diff: Document --staged over --cached
Date: Fri,  7 Feb 2014 21:42:08 -0800
Message-ID: <1391838128-13382-1-git-send-email-soren.brinkmann@xilinx.com>
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 06:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC0go-0000nx-02
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 06:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbaBHFmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 00:42:24 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:55242 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbaBHFmX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 00:42:23 -0500
Received: by mail-wg0-f51.google.com with SMTP id z12so2866207wgg.30
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 21:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1KFj13OT2A/I+Nl7Oe4xpIT3gf+U7dd1zhICPnM0bVg=;
        b=MYKkqNO9IikL2h8TigfO0UH29m2qQBxg57kg8BsyJXCLRGhw4dQddXmvnWJBPK3qaz
         OjIPcQutI0CpRiLQ062ivEOTfxjpJhkqOPw7DuHWp2Xbl1x9iUho/dTPQOgyjOUXsZeS
         Bsxspah1pPefMt3SndB9lASbCXAPAci4Tqwau1WhyRmZuAf37HN8/VzrDDJchO2v/W+V
         7C2xCkpdBoBRxjEdpu1ltjH7nmSt+MnAYRbnUIWBvKpUM+aKGdEVOY930nMjjKRXHNfF
         FgKiVnvXS9tLvLr+2KKWbdYlnTbj4cc+ESxVg7FcV4NipdGczSkcZjdYLvUmHoSBsB93
         nA2Q==
X-Received: by 10.180.38.41 with SMTP id d9mr2477596wik.9.1391838142276;
        Fri, 07 Feb 2014 21:42:22 -0800 (PST)
Received: from localhost ([149.199.62.254])
        by mx.google.com with ESMTPSA id jw4sm16134990wjc.20.2014.02.07.21.42.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 21:42:21 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241819>

Since recent documentation uses terms like 'staged' and 'staging area',
--staged is more in line with other documentation and to be pfeferred
over --cached.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 Documentation/git-diff.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 33fbd8c56f91..12d5b62e71f9 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git diff' [options] [<commit>] [--] [<path>...]
-'git diff' [options] --cached [<commit>] [--] [<path>...]
+'git diff' [options] --staged [<commit>] [--] [<path>...]
 'git diff' [options] <commit> <commit> [--] [<path>...]
 'git diff' [options] <blob> <blob>
 'git diff' [options] [--no-index] [--] <path> <path>
@@ -38,7 +38,7 @@ two blob objects, or changes between two files on disk.
 	or when running the command outside a working tree
 	controlled by Git.
 
-'git diff' [--options] --cached [<commit>] [--] [<path>...]::
+'git diff' [--options] --staged [<commit>] [--] [<path>...]::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
@@ -46,7 +46,7 @@ two blob objects, or changes between two files on disk.
 	do not give <commit>, it defaults to HEAD.
 	If HEAD does not exist (e.g. unborned branches) and
 	<commit> is not given, it shows all staged changes.
-	--staged is a synonym of --cached.
+	--cached is a synonym of --staged.
 
 'git diff' [--options] <commit> [--] [<path>...]::
 
-- 
1.8.5.4
