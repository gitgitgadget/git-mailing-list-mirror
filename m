From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] git-config: Correct asciidoc documentation for --int/--bool
Date: Mon, 21 May 2007 00:12:58 +0200
Message-ID: <11796991782027-git-send-email-frank@lichtenheld.de>
References: <11796991783280-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 00:13:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpteI-0004oZ-3G
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbXETWNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756831AbXETWNE
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:13:04 -0400
Received: from mail.lenk.info ([217.160.134.107]:1463 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756725AbXETWNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:13:01 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hptcd-00025b-7K; Mon, 21 May 2007 00:11:27 +0200
Received: from p54b0cecc.dip.t-dialin.net ([84.176.206.204] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hpte6-0004c5-5l; Mon, 21 May 2007 00:12:58 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hpte6-0002Uj-Gt; Mon, 21 May 2007 00:12:58 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <11796991783280-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47935>

The asciidoc documentation seemed to indicate that type specifiers
are honoured on writing operations which they aren't. Make this
more clear.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-config.txt |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 280ef20..827a499 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,15 +9,15 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git-config' [--system | --global] [type] name [value [value_regex]]
-'git-config' [--system | --global] [type] --add name value
-'git-config' [--system | --global] [type] --replace-all name [value [value_regex]]
+'git-config' [--system | --global] name [value [value_regex]]
+'git-config' [--system | --global] --add name value
+'git-config' [--system | --global] --replace-all name [value [value_regex]]
 'git-config' [--system | --global] [type] --get name [value_regex]
 'git-config' [--system | --global] [type] --get-all name [value_regex]
-'git-config' [--system | --global] [type] --unset name [value_regex]
-'git-config' [--system | --global] [type] --unset-all name [value_regex]
-'git-config' [--system | --global] [type] --rename-section old_name new_name
-'git-config' [--system | --global] [type] --remove-section name
+'git-config' [--system | --global] --unset name [value_regex]
+'git-config' [--system | --global] --unset-all name [value_regex]
+'git-config' [--system | --global] --rename-section old_name new_name
+'git-config' [--system | --global] --remove-section name
 'git-config' [--system | --global] -l | --list
 
 DESCRIPTION
@@ -36,7 +36,8 @@ prepend a single exclamation mark in front (see EXAMPLES).
 The type specifier can be either '--int' or '--bool', which will make
 'git-config' ensure that the variable(s) are of the given type and
 convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool). If no type specifier is passed,
+a "true" or "false" string for bool).  Type specifiers currently only
+take effect for reading operations.  If no type specifier is passed,
 no checks or transformations are performed on the value.
 
 This command will fail if:
-- 
1.5.2-rc3.GIT
