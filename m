From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v5 0/3]  Add support for SMTP server options
Date: Mon,  6 Sep 2010 20:12:08 +0200
Message-ID: <1283796731-4540-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 20:12:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsgBR-0005of-Ot
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 20:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab0IFSM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 14:12:26 -0400
Received: from smtp19.orange.fr ([80.12.242.18]:27154 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409Ab0IFSMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 14:12:21 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1921.orange.fr (SMTP Server) with ESMTP id 56BDE2000613;
	Mon,  6 Sep 2010 20:12:16 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1921.orange.fr (SMTP Server) with ESMTP id 43C17200079E;
	Mon,  6 Sep 2010 20:12:16 +0200 (CEST)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
	by mwinf1921.orange.fr (SMTP Server) with ESMTP id 10FF42000613;
	Mon,  6 Sep 2010 20:12:16 +0200 (CEST)
X-ME-UUID: 20100906181216697.10FF42000613@mwinf1921.orange.fr
X-Mailer: git-send-email 1.7.3.rc0.3.g0de60
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155594>

This is v5 of the patch thanks to Junio and AEvar for the review and help.

context:
--------

I'm not familiar at all with Perl so comments on style or usage most
welcomed. This patch is to introduce a way to pass specific options to the
SMTP server used by git-send-email.

I need that to be able to use different SMTP account (wanadoo, gmail...) on
some Git repositories to send over proper identity.

change since v4:
----------------

Add the missing signed-off-by.

change since v3:
----------------

I have moved smtp server option description after smtp server port. Seems
more natural to me.

I have added note about the fact that multiple lines are needed for each
option in configuration files.

patches:
--------

The two first patches are really code clean-up found while working on this
new feature. The last patch is the actual implementation of this new
feature.

Pascal Obry (3):
  Minor indentation fix.
  Remove @smtp_host_parts variable as not used.
  New send-email option smtpserveroption.

 Documentation/config.txt         |    1 +
 Documentation/git-send-email.txt |    9 +++++++++
 git-send-email.perl              |   12 +++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
1.7.2.2.277.gb49c4
