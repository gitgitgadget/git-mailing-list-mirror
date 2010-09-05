From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v3 0/3]  Add support for SMTP server options
Date: Sun,  5 Sep 2010 19:48:57 +0200
Message-ID: <1283708940-2172-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 19:48:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJKd-0005FF-Hr
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab0IERsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 13:48:38 -0400
Received: from smtp19.orange.fr ([80.12.242.19]:28088 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211Ab0IERsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 13:48:37 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id BB86F20001F7;
	Sun,  5 Sep 2010 19:48:35 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id AE384200020F;
	Sun,  5 Sep 2010 19:48:35 +0200 (CEST)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id 4107820001F7;
	Sun,  5 Sep 2010 19:48:35 +0200 (CEST)
X-ME-UUID: 20100905174835266.4107820001F7@mwinf1928.orange.fr
X-Mailer: git-send-email 1.7.2.3.316.ga4c47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155467>

I'm not familiar at all with Perl so comments on style or usage most
welcomed. This patch is to introduce a way to pass specific options to the
SMTP server used by git-send-email.

I need that to be able to use different SMTP account (wanadoo, gmail...) on
some Git repositories to send over proper identity.

This is v3 of the patch thanks to Junio and AEvar for the review and help.

The two first patches are really code clean-up found while working on this
new feature. The last patch is the actual implementation of this new
feature.

Pascal Obry (3):
  Minor indentation fix.
  Remove @smtp_host_parts variable as not used.
  New send-email option smtpserveroption.

 Documentation/git-send-email.txt |    8 ++++++++
 git-send-email.perl              |   12 +++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.7.2.2.277.gb49c4
