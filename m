From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] api-run-command.txt: typofix
Date: Fri, 18 Jul 2008 01:53:55 +0200
Message-ID: <1216338835-10627-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
To: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 01:55:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJdJU-0008VQ-T1
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 01:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760826AbYGQXyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 19:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760825AbYGQXyD
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 19:54:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:52393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760766AbYGQXyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 19:54:01 -0400
Received: (qmail invoked by alias); 17 Jul 2008 23:53:58 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp021) with SMTP; 18 Jul 2008 01:53:58 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/qRs117ZDqBiHbw5PfnUKEFwMZZp8pLMYVUhk2o5
	X6ZGqPrDHXpy4U
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJdIJ-0002ln-9L; Fri, 18 Jul 2008 01:53:55 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88938>

Replace "run_command_v_opt_dir" by "run_command_v_opt_cd".

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Documentation/technical/api-run-command.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index 3e1342a..75aa5d4 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -30,7 +30,7 @@ Functions
 	start_command() followed by finish_command(). Takes a pointer
 	to a `struct child_process` that specifies the details.
 
-`run_command_v_opt`, `run_command_v_opt_dir`, `run_command_v_opt_cd_env`::
+`run_command_v_opt`, `run_command_v_opt_cd`, `run_command_v_opt_cd_env`::
 
 	Convenience functions that encapsulate a sequence of
 	start_command() followed by finish_command(). The argument argv
-- 
1.5.6.3.390.g7b30
