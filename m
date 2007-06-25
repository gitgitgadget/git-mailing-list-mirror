From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 1/3] config: Complete documentation of --get-regexp
Date: Mon, 25 Jun 2007 16:03:53 +0200
Message-ID: <11827802353409-git-send-email-frank@lichtenheld.de>
References: <200706220156.01175.jnareb@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 16:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2pAm-0002Mo-Jz
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 16:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbXFYOEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 10:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754829AbXFYOEH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 10:04:07 -0400
Received: from v32413.1blu.de ([88.84.155.73]:55698 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640AbXFYOEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 10:04:06 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1I2pAh-00044D-4B; Mon, 25 Jun 2007 16:04:03 +0200
Received: from p54b0ff8c.dip.t-dialin.net ([84.176.255.140] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1I2pAg-0000dS-5v; Mon, 25 Jun 2007 16:04:02 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1I2pAa-0004kV-RA; Mon, 25 Jun 2007 16:03:56 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <200706220156.01175.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50896>

The asciidoc documentation of the --get-regexp option was
incomplete. Add some missing pieces:
 - List the option in SYNOPSIS
 - Mention that key names are printed

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-config.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index f2c6717..bb6dbb0 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git-config' [--system | --global] --replace-all name [value [value_regex]]
 'git-config' [--system | --global] [type] --get name [value_regex]
 'git-config' [--system | --global] [type] --get-all name [value_regex]
+'git-config' [--system | --global] [type] --get-regexp name_regex [value_regex]
 'git-config' [--system | --global] --unset name [value_regex]
 'git-config' [--system | --global] --unset-all name [value_regex]
 'git-config' [--system | --global] --rename-section old_name new_name
@@ -73,6 +74,7 @@ OPTIONS
 
 --get-regexp::
 	Like --get-all, but interprets the name as a regular expression.
+	Also outputs the key names.
 
 --global::
 	For writing options: write to global ~/.gitconfig file rather than
-- 
1.5.2.1
