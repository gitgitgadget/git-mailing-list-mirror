From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] Document long options '--message=<msg>' and '--no-commit'
Date: Fri, 13 Jul 2007 01:54:07 +0200
Message-ID: <11842844531700-git-send-email-jnareb@gmail.com>
References: <11842844481113-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 01:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I98UQ-0006r5-KQ
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 01:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757965AbXGLXyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 19:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757467AbXGLXyR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 19:54:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:59833 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbXGLXyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 19:54:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so457427ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 16:54:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cLOmPHGNi3s8l0hmluWlLmfJUjqXZWagJuQjzH48FrjJDsU/tAb9JA4Y/CqDbA0vjSEAgRCLYTqi5dEs0UvdD4+XNlBUCiK9H1UC/5iJ6hkTr9Mvis4McDkSRNqm7F9UcSvGFOwCuGWpaXpTFKy0YUj3ceydruipLVf49IzcO4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uuyZOxAmn+QH+m3PDOiarGWMKbL1WkBfWYLQ29M7t9i3iTlfFodIWdYkqzWANqF3CCCmb9sIQOvwHhDcCgtyVbJb0k8PoAna1j/FPeKXiSdxtY9xQSqdK/6xcWCThQ4sRbOW2kAcDXuCNK9g/2tWKEyKNtUhD1L7awk3hmFvJHs=
Received: by 10.67.28.2 with SMTP id f2mr1574415ugj.1184284454578;
        Thu, 12 Jul 2007 16:54:14 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTP id c25sm35471393ika.2007.07.12.16.54.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 16:54:12 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6CNsERq002395;
	Fri, 13 Jul 2007 01:54:14 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6CNsDCr002392;
	Fri, 13 Jul 2007 01:54:13 +0200
X-Mailer: git-send-email 1.5.2.2
In-Reply-To: <11842844481113-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52343>

Document that '--message=<msg>' is long version of '-m <msg>' in
git-commit, and that '--no-checkout' is long version of '-n' in
git-clone.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was silently skipped in the 11 patches long series
of documenting undocumented long options
  "[PATCH 00/11] Document missing options"
(or rather two patches which are concatenated into this one).

 Documentation/git-clone.txt  |    1 +
 Documentation/git-commit.txt |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2f39864..a0a10e3 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -64,6 +64,7 @@ OPTIONS
 	Operate quietly.  This flag is passed to "rsync" and
 	"git-fetch-pack" commands when given.
 
+--no-checkout::
 -n::
 	No checkout of HEAD is performed after the clone is complete.
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 53a7bb0..352a494 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -71,7 +71,7 @@ OPTIONS
 	Override the author name used in the commit.  Use
 	`A U Thor <author@example.com>` format.
 
--m <msg>::
+-m <msg>|--message=<msg>::
 	Use the given <msg> as the commit message.
 
 -s|--signoff::
-- 
1.5.2.2
