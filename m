From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 06/11] Document git rev-list --timestamp
Date: Sat, 16 Jun 2007 21:03:42 +0200
Message-ID: <1182020634624-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU4-0007JN-2M
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbXFPS6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXFPS6Y
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:24 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:13011 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbXFPS6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:14 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1608069mue
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r7kvxjlwGTXvXNODv4rCImFbBYrAxvTp7IgaqPe71+Au0Y919MIi/38TpRako3OjCjsLRMkjrVay0BX6bQJKHjIoxjKMKxn9Zn77KC414asMNUYc19EeRoMorUI5b86Hi9NuTIjoyqvU+t11D4tGa1G6GvJq3bN+YDkkU8MUCkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=az5cds6RazJmz2pWz3oo+ekMnFFsD8xFd7crhVP/D43+KzIBf0XUTGdweHDPqMBfwWHVC0MU1mxY2vKrHUzxcW+FBDQjdLdhLFW+8gdWJ4XM8RO4jr3ryqr5lPpnvP9pvpfxkp3Yt1fmJLqsOgIPc1yBlKHwc+aBqheAHMRaVZ0=
Received: by 10.82.183.19 with SMTP id g19mr8150996buf.1182020293237;
        Sat, 16 Jun 2007 11:58:13 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id f6sm10785355nfh.2007.06.16.11.58.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:12 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3s6j004246;
	Sat, 16 Jun 2007 21:03:54 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3sq0004245;
	Sat, 16 Jun 2007 21:03:54 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50304>

Note that git log does not understand this option yet:

  $ git log --timestamp
  fatal: unrecognized argument: --timestamp

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-rev-list.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 0dba73f..f5e5786 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -21,6 +21,7 @@ SYNOPSIS
 	     [ \--stdin ]
 	     [ \--topo-order ]
 	     [ \--parents ]
+	     [ \--timestamp ]
 	     [ \--left-right ]
 	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
@@ -116,6 +117,9 @@ e.g. "2 hours ago".
 
 	Print the parents of the commit.
 
+--timestamp::
+	Print the raw commit timestamp.
+
 --left-right::
 
 	Mark which side of a symmetric diff a commit is reachable from.
-- 
1.5.2
