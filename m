From: Mikael Magnusson <mikachu@gmail.com>
Subject: [PATCH] Typo "bogos" in format-patch error message.
Date: Fri, 19 Sep 2008 15:42:30 +0200 (CEST)
Message-ID: <alpine.LNX.1.00.0809191540250.18318@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 15:45:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KggHc-0002XQ-7F
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 15:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbYISNme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 09:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYISNme
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 09:42:34 -0400
Received: from mail.bredband2.net ([82.209.166.4]:17690 "EHLO
	smtp.bredband2.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751235AbYISNme (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 09:42:34 -0400
Received: (qmail 20784 invoked from network); 19 Sep 2008 13:43:21 -0000
Received: from lkf-194-200-233-83.3.cust.bredband2.com (HELO mika.l3ib.org) ([83.233.200.194])
          (envelope-sender <mikachu@gmail.com>)
          by smtp.bredband2.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 19 Sep 2008 13:43:21 -0000
User-Agent: Alpine 1.00 (LNX )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96286>

---
  builtin-log.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index f4975cf..69cf564 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -835,7 +835,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
  			committer = git_committer_info(IDENT_ERROR_ON_NO_NAME);
  			endpos = strchr(committer, '>');
  			if (!endpos)
-				die("bogos committer info %s\n", committer);
+				die("bogus committer info %s\n", committer);
  			add_signoff = xmemdupz(committer, endpos - committer + 1);
  		}
  		else if (!strcmp(argv[i], "--attach")) {



--
Mikael Magnusson
