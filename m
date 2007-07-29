From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/9] white space fixes in setup.c
Date: Mon, 30 Jul 2007 00:24:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707300024310.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Mon Jul 30 01:24:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFI8A-0002LW-73
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935109AbXG2XYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935043AbXG2XYz
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:24:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:35458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934906AbXG2XYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:24:55 -0400
Received: (qmail invoked by alias); 29 Jul 2007 23:24:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 30 Jul 2007 01:24:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qZf81KLRqwQERn7/vW9OObKa2jWrwekHoJDQejT
	HoaOK5LyIHT9vO
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707300016470.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54152>


Some lines were not indented by tabs but by spaces.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Just to make the next patch look nicer.

 setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 7b07144..b54d65f 100644
--- a/setup.c
+++ b/setup.c
@@ -382,11 +382,11 @@ int git_config_perm(const char *var, const char *value)
 
 int check_repository_format_version(const char *var, const char *value)
 {
-       if (strcmp(var, "core.repositoryformatversion") == 0)
-               repository_format_version = git_config_int(var, value);
+	if (strcmp(var, "core.repositoryformatversion") == 0)
+		repository_format_version = git_config_int(var, value);
 	else if (strcmp(var, "core.sharedrepository") == 0)
 		shared_repository = git_config_perm(var, value);
-       return 0;
+	return 0;
 }
 
 int check_repository_format(void)
-- 
1.5.3.rc3.28.g1406
