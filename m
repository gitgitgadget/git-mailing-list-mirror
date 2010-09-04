From: Pascal Obry <pascal@obry.net>
Subject: [PATCH 0/2] Add support for SMTP server options
Date: Sat,  4 Sep 2010 18:06:10 +0200
Message-ID: <1283616372-3340-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 18:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrvG5-0003Fx-G3
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 18:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab0IDQGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 12:06:20 -0400
Received: from smtp20.orange.fr ([80.12.242.26]:60724 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab0IDQGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 12:06:19 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2003.orange.fr (SMTP Server) with ESMTP id C3C302000273;
	Sat,  4 Sep 2010 18:06:06 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2003.orange.fr (SMTP Server) with ESMTP id B69B820002F6;
	Sat,  4 Sep 2010 18:06:06 +0200 (CEST)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
	by mwinf2003.orange.fr (SMTP Server) with ESMTP id 85B242000273;
	Sat,  4 Sep 2010 18:06:06 +0200 (CEST)
X-ME-UUID: 20100904160606547.85B242000273@mwinf2003.orange.fr
X-Mailer: git-send-email 1.7.2.2.277.gb49c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155334>

I'm not familiar at all with Perl so comments on style or usage most
welcomed. This patch is to introduce a way to pass specific options to the
SMTP server used by git-send-email.

I need that to be able to use different SMTP account (wanadoo, gmail...) on
some Git repositories to send over proper identity.

Pascal Obry (2):
  Minor indentation fix.
  New send-email option smtpserveroptions.

 Documentation/git-send-email.txt |    5 +++++
 git-send-email.perl              |   11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.7.2.2.277.gb49c4
