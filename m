From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A v4 1/5] git config: codestyle cleanups
Date: Sat, 21 Feb 2009 02:48:53 +0200
Message-ID: <1235177337-2532-2-git-send-email-felipe.contreras@gmail.com>
References: <1235177337-2532-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:50:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lag4l-000784-Ke
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbZBUAtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbZBUAtF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:49:05 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:42984 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbZBUAtE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:49:04 -0500
Received: by bwz5 with SMTP id 5so3160824bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xdDTY8tKE0QJDNph4dyi2d7ltuWN/pRriOlL8lTt2+Q=;
        b=X5cr6q0VinHoPRH3mj75vLpeCTkUXXynOgTe6m/aMemydhGGKXNCC6s4RAzVlzcRZm
         VALKqdOUXs+6yX/nMuvlK3JoRWphdlTZLIfeQ0jiC4Tpzt3fp6pXScaEVfsFUyx/pnKJ
         PvliNBy8Y4Mss3AI8tVklghbQ5mTOBqciyyLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UsfV4HmQ14Np4q04CTsPFWHy2/Qn7qSPnRzMgaRIK2Dv6xhK4feDf8ri/D8OAcxrGP
         CUo+2plJG0Cy1t5hsKtVjFY84lgmPpUsv0WS95qS6CFXp7TCddNGvew/LUUAWuwGbVJc
         BwB/FtqBAlPy7GtomaeXBtl9WTITQZ1sB8OP8=
Received: by 10.181.134.12 with SMTP id l12mr482316bkn.26.1235177342583;
        Fri, 20 Feb 2009 16:49:02 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id h2sm5720665fkh.29.2009.02.20.16.49.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:02 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235177337-2532-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110911>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 6937eaf..afc4393 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -27,7 +27,7 @@ static int show_all_config(const char *key_, const char *value_, void *cb)
 	return 0;
 }
 
-static int show_config(const char* key_, const char* value_, void *cb)
+static int show_config(const char *key_, const char *value_, void *cb)
 {
 	char value[256];
 	const char *vptr = value;
@@ -74,7 +74,7 @@ static int show_config(const char* key_, const char* value_, void *cb)
 	return 0;
 }
 
-static int get_value(const char* key_, const char* regex_)
+static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
 	char *tl;
@@ -284,7 +284,7 @@ static int get_colorbool(int argc, const char **argv)
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
-	char* value;
+	char *value;
 	const char *file = setup_git_directory_gently(&nongit);
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
-- 
1.6.1.3
