From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] git-diff.txt: reorder the <commit> <commit> form
Date: Wed, 24 Apr 2013 22:03:32 +0530
Message-ID: <1366821216-20868-2-git-send-email-artagnon@gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:33:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2dj-0007d0-CZ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846Ab3DXQdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:33:40 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:57339 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab3DXQdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:33:39 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so507914pbc.31
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=c9eqW/JHQUele4m586Qi0sSaQGS/B096N0zgYVB3XS4=;
        b=wQqz6Lz70BKF8sElq2bNGOAkcGoCKA5K6c/BBE+0pIvbIRVF5HVSMDVBnOQQeK9BPV
         lxqHEEBDdxqbP5q7NNy2eY2rbcVbf6JcwGYUqmt2WR+aMsEjNhLF52kihWlEe/+t/ViN
         IkBQVyTAnmM7utrH7EDHO8aVURqMi7qPwrxNCM/OniMk9jiU3cFX+VsP4nimkwddh//H
         prAi3PaUKYHycXDDnLE2MiCV1jUEDV9o6p3bHL/AhUKiy7yV/W9hHuU2DhQ54Enb7pTL
         HlG9ie9LNJjYUpE5Xq5OBt+CiFPk/IxH1Mntyy18zL1qaFCUhNiO5WEgkmHaYVdUHspC
         MlIA==
X-Received: by 10.66.151.46 with SMTP id un14mr20828724pab.14.1366821218706;
        Wed, 24 Apr 2013 09:33:38 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.124])
        by mx.google.com with ESMTPSA id dr4sm3646798pbb.19.2013.04.24.09.33.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 09:33:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.502.g2d60b5c
In-Reply-To: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222261>

In DESCRIPTION, the '<commit>..<commit>' form refers to "the previous
form", namely the '<commit> <commit>' form.  However, bd52900
(Documentation: Describe "git diff <blob> <blob>" separately,
2012-12-18) broke this by inserting a form in between these two forms.
Fix this by reordering a form.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-diff.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index a7b4620..8623867 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 [verse]
 'git diff' [options] [<commit>] [--] [<path>...]
 'git diff' [options] --cached [<commit>] [--] [<path>...]
-'git diff' [options] <commit> <commit> [--] [<path>...]
 'git diff' [options] <blob> <blob>
+'git diff' [options] <commit> <commit> [--] [<path>...]
 'git diff' [options] [--no-index] [--] <path> <path>
 
 DESCRIPTION
@@ -51,16 +51,16 @@ directories. This behavior can be forced by --no-index.
 	branch name to compare with the tip of a different
 	branch.
 
-'git diff' [--options] <commit> <commit> [--] [<path>...]::
-
-	This is to view the changes between two arbitrary
-	<commit>.
-
 'git diff' [options] <blob> <blob>::
 
 	This form is to view the differences between the raw
 	contents of two blob objects.
 
+'git diff' [--options] <commit> <commit> [--] [<path>...]::
+
+	This is to view the changes between two arbitrary
+	<commit>.
+
 'git diff' [--options] <commit>..<commit> [--] [<path>...]::
 
 	This is synonymous to the previous form.  If <commit> on
-- 
1.8.2.1.502.g2d60b5c
