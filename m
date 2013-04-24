From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] git-diff.txt: strip the leading "--" from options template
Date: Wed, 24 Apr 2013 22:03:33 +0530
Message-ID: <1366821216-20868-3-git-send-email-artagnon@gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2dj-0007d0-SE
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756852Ab3DXQdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:33:43 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:46259 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab3DXQdl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:33:41 -0400
Received: by mail-da0-f46.google.com with SMTP id x4so423230daj.5
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=NGWkNr0mFEnQdvjdM0IAQoYr4pBJ4q+O8KEkxvrNc1w=;
        b=iUqW68jjE+uYFMLWqVdTVf8HMSDZOlUlQln11YxVRElsLBjcWxpnMO+f/5IY+ow2PB
         HqE8xsTUF5F8XKnoSfi1hE5xI5/JVWV6BG641PFgzCKtTseZrdHktvNksgZhnr0IT5rL
         wdELq3W26n8efH0lemuvOG+W+PFEwXFrlg1RFLp3PqPgROZXugpte2hKE39NMXrjLvZ+
         EItFRqemTjlRIFzAnTX875bu7tla69qIAGHzPHkkdMLMbDppg/wDWSQv5Z1ah8nCKetC
         dBmW7XfL/Mf65gT9aKhuTWmUiQHECM/1RWYLUvDLxohNr8fZ9+mq5xIxgXugolf2Yqhe
         CPMA==
X-Received: by 10.66.145.134 with SMTP id su6mr19891295pab.198.1366821220857;
        Wed, 24 Apr 2013 09:33:40 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.124])
        by mx.google.com with ESMTPSA id dr4sm3646798pbb.19.2013.04.24.09.33.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 09:33:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.502.g2d60b5c
In-Reply-To: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222262>

It is imperative to specify options with the [options] template.
[--options] is inconsistent as well as misleading (as there are short
options which can be specified with a single "-").  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-diff.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 8623867..47aa3fc 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -21,7 +21,7 @@ Show changes between the working tree and the index or a tree, changes
 between the index and a tree, changes between two trees, or changes
 between two files on disk.
 
-'git diff' [--options] [--] [<path>...]::
+'git diff' [options] [--] [<path>...]::
 
 	This form is to view the changes you made relative to
 	the index (staging area for the next commit).  In other
@@ -33,7 +33,7 @@ If exactly two paths are given and at least one points outside
 the current repository, 'git diff' will compare the two files /
 directories. This behavior can be forced by --no-index.
 
-'git diff' [--options] --cached [<commit>] [--] [<path>...]::
+'git diff' [options] --cached [<commit>] [--] [<path>...]::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
@@ -43,7 +43,7 @@ directories. This behavior can be forced by --no-index.
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
 
-'git diff' [--options] <commit> [--] [<path>...]::
+'git diff' [options] <commit> [--] [<path>...]::
 
 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
@@ -56,18 +56,18 @@ directories. This behavior can be forced by --no-index.
 	This form is to view the differences between the raw
 	contents of two blob objects.
 
-'git diff' [--options] <commit> <commit> [--] [<path>...]::
+'git diff' [options] <commit> <commit> [--] [<path>...]::
 
 	This is to view the changes between two arbitrary
 	<commit>.
 
-'git diff' [--options] <commit>..<commit> [--] [<path>...]::
+'git diff' [options] <commit>..<commit> [--] [<path>...]::
 
 	This is synonymous to the previous form.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
 
-'git diff' [--options] <commit>\...<commit> [--] [<path>...]::
+'git diff' [options] <commit>\...<commit> [--] [<path>...]::
 
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
-- 
1.8.2.1.502.g2d60b5c
