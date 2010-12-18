From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 5/8] grep docs: grep accepts a <tree-ish>, not a <tree>
Date: Sat, 18 Dec 2010 00:38:42 -0500
Message-ID: <1292650725-21149-6-git-send-email-lodatom@gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 06:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTpVx-0006oi-2n
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 06:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab0LRFjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 00:39:12 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab0LRFjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 00:39:05 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so1366776qwa.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 21:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tixv7XAU3Ul7AGE9HyWerrDmkrvHzNdJXVJb6mj+FYg=;
        b=N7aOCr1lcWc4r1paSijmt0Tpb5QilnpzXkK4bwBVEDGLPk7A7T8vsOCG4RO8q0c/vs
         O7J9+euEqjZsJS2WuWi/waINyk7F2kx61PJ78bTIuSqEkRAfOUQzQuEk54fBP4ABhLeO
         GPh3kLMCykpZNdqy84EgJp8O8Uf0RXcc+eCLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bG80Jb2luqHO3uC2TgnS1AV8z4Qv6d7RjMNnJbg+aBi1+CwNSWdq4jZJbtuk9LvQiI
         rvsWYjCsAC/+52hk85B43TwOJhMS0ftSKJFMHFN0hkL2yV41AJ6NbRe71kLfHG1jvdfL
         OmdpZWUdqkr8kNtSxIl7sLUNSn+ldXum3Vcs4=
Received: by 10.229.227.8 with SMTP id iy8mr1553452qcb.182.1292650744899;
        Fri, 17 Dec 2010 21:39:04 -0800 (PST)
Received: from localhost.localdomain (c-68-49-150-7.hsd1.dc.comcast.net [68.49.150.7])
        by mx.google.com with ESMTPS id n7sm683569qcu.28.2010.12.17.21.39.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 21:39:04 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163903>

Also document that -p accepts a <commit> in the usage message.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-grep.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index dab0a78..54ea24a 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -22,7 +22,7 @@ SYNOPSIS
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [--cached | --no-index | <tree>...]
+	   [--cached | --no-index | <tree-ish>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -176,7 +176,7 @@ OPTIONS
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
-<tree>...::
+<tree-ish>...::
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.
 
-- 
1.7.3.2
