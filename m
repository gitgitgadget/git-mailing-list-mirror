From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] commit: quote the user name in the example
Date: Wed, 24 Feb 2010 06:18:25 -0800
Message-ID: <1267021105-25691-1-git-send-email-kraai@ftbfs.org>
References: <4B84DA03.1040809@viscovery.net>
Cc: Matt Kraai <kraai@ftbfs.org>
To: gitster@pobox.com, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 15:20:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkI6g-0000Ja-Ba
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 15:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446Ab0BXOUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 09:20:48 -0500
Received: from zoom.lafn.ORG ([206.117.18.8]:49035 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752981Ab0BXOUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 09:20:46 -0500
Received: from macbookpro (pool-71-254-176-161.lsanca.fios.verizon.net [71.254.176.161])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id o1OEIWPa059975
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Feb 2010 06:18:33 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by macbookpro with local (Exim 4.71)
	(envelope-from <kraai@ftbfs.org>)
	id 1NkI4J-0006gu-I8; Wed, 24 Feb 2010 06:18:27 -0800
X-Mailer: git-send-email 1.7.0
In-Reply-To: <4B84DA03.1040809@viscovery.net>
X-Virus-Scanned: clamav-milter 0.95.3 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140943>

If the user runs

 git config --global user.name Your Name

as suggested, user.name will be set to "Your".  With this patch, the
suggested command will be

 git config --global user.name "Your Name"

which will set user.name to "Your Name" and hopefully help users avoid
the former mistake.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 55676fd..46513bf 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -41,7 +41,7 @@ static const char implicit_ident_advice[] =
 "on your username and hostname. Please check that they are accurate.\n"
 "You can suppress this message by setting them explicitly:\n"
 "\n"
-"    git config --global user.name Your Name\n"
+"    git config --global user.name \"Your Name\"\n"
 "    git config --global user.email you@example.com\n"
 "\n"
 "If the identity used for this commit is wrong, you can fix it with:\n"
-- 
1.7.0
