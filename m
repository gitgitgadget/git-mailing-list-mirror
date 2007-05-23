From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: [PATCH] Documentation: fix git-config.xml generation
Date: Wed, 23 May 2007 18:16:12 -0400
Message-ID: <3f80363f0705231516x7c6fa2daua33a708deaa7a10c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:16:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqz8F-0001zr-3m
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264AbXEWWQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756873AbXEWWQO
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:16:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:59853 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbXEWWQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:16:13 -0400
Received: by wa-out-1112.google.com with SMTP id n7so101852wag
        for <git@vger.kernel.org>; Wed, 23 May 2007 15:16:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=dSmUqsRD7ptST4I0Z92KcvfhCM5+mMMSmEAteBnc3Q7r+e90/9Z7+wcRUMJmVlq2SFj1k2Fqpl1c7aiVjHjjIYHhueyFglZgvrYI2Cm4nd8p/traqtQJFNEzQff5Ku7dJCJ7JkHb+jhuGXzLoNt8/WuuOF9Q7xivRNpdrNMykU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=SptDFLgs/jtJqjroh9YzaemcYV+g2qZcWBB8LHljAq5OCCkhC8oMjef91HyHhKEqgRGsOXjXo0RCPujiH/fgAC255vNyb6toatdFvF5AiIkkuUzW+nG4wMS0nAc/4KOc6AxpM/eSct3Wi7CWCKzLxKg0DZfTFYg1gXhRrZMGNKc=
Received: by 10.114.77.1 with SMTP id z1mr536380waa.1179958572215;
        Wed, 23 May 2007 15:16:12 -0700 (PDT)
Received: by 10.114.194.4 with HTTP; Wed, 23 May 2007 15:16:12 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 6835928105789798
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48185>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

With asciidoc 8.1.0 and xmlto 0.0.18, git-config.xml failed to
validate. This patch just makes the asciidoc formatting for
branch.autosetupmerge the same as the other config options.

 Documentation/config.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index eb2e79a..14aa3bd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -281,11 +281,11 @@ apply.whitespace::
 	as the '--whitespace' option. See gitlink:git-apply[1].

 branch.autosetupmerge::
-	Tells `git-branch' and `git-checkout' to setup new branches
+	Tells `git-branch` and `git-checkout` to setup new branches
 	so that gitlink:git-pull[1] will appropriately merge from that
 	remote branch.  Note that even if this option is not set,
-	this behavior can be chosen per-branch using the `--track`
-	and `--no-track` options.  This option defaults to false.
+	this behavior can be chosen per-branch using the '--track'
+	and '--no-track' options.  This option defaults to false.

 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
-- 
1.5.2.762.gd8c6
