From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Minor grammar fix in the 'Not a git repository' message
Date: Mon, 16 Feb 2009 23:58:10 +0100 (CET)
Message-ID: <8787c5894e7831bbd1ace3b2fd6649f1362d4b78.1234825069u.git.johannes.schindelin@gmx.de>
References: <cover.1234825069u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 16 23:59:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZCQU-0000BB-LU
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 23:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbZBPW5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 17:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZBPW5P
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 17:57:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:59166 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753078AbZBPW5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 17:57:14 -0500
Received: (qmail invoked by alias); 16 Feb 2009 22:57:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 16 Feb 2009 23:57:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7AjZyxzW7krwkBICzH9ucC4+lJhuK8cXCPzr/Gx
	o5w4WH5Y4n7id0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1234825069u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110259>

It might cause less head-scratching to say 'nor any of the parent
directories' than 'or ...' after saying that this is not a git
repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 6c2deda..05bd462 100644
--- a/setup.c
+++ b/setup.c
@@ -386,7 +386,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				*nongit_ok = 1;
 				return NULL;
 			}
-			die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
+			die("Not a git repository (nor any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
 		}
 		if (chdir(".."))
 			die("Cannot change to %s/..: %s", cwd, strerror(errno));
-- 
1.6.2.rc0.397.g19ae22
