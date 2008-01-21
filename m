From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] submodule: Document the details of the command line syntax
Date: Mon, 21 Jan 2008 07:41:27 +0100
Message-ID: <12008976873999-git-send-email-prohaska@zib.de>
References: <209F2074-DD8D-429A-95AA-6FB484852E4E@zib.de>
Cc: imyousuf@gmail.com, jnareb@gmail.com, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 07:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGqM4-0004qA-GS
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 07:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372AbYAUGlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 01:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756361AbYAUGlb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 01:41:31 -0500
Received: from mailer.zib.de ([130.73.108.11]:60271 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724AbYAUGlb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 01:41:31 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0L6fRI1026596;
	Mon, 21 Jan 2008 07:41:27 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0L6fRWH021394;
	Mon, 21 Jan 2008 07:41:27 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <209F2074-DD8D-429A-95AA-6FB484852E4E@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71230>

Only "status" accepts "--cached" and the preferred way of
passing sub-command specific options is after the sub-command.

The documentation is adapted to reflect this.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-submodule.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cffc6d4..e818e6e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,8 +9,9 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git-submodule' [--quiet] [-b branch] add <repository> [<path>]
-'git-submodule' [--quiet] [--cached] [status|init|update] [--] [<path>...]
+'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
+'git-submodule' [--quiet] status [--cached] [--] [<path>...]
+'git-submodule' [--quiet] [init|update] [--] [<path>...]
 
 
 COMMANDS
-- 
1.5.4.rc4.3.g7c32b
