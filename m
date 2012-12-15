From: Thomas Ackermann <th.acker@arcor.de>
Subject: [Patch] Renumber list in api-command.txt
Date: Sat, 15 Dec 2012 09:29:07 +0100 (CET)
Message-ID: <683281078.296628.1355560147606.JavaMail.ngmail@webmail08.arcor-online.net>
References: <1479174763.154268.1350408444997.JavaMail.ngmail@webmail15.arcor-online.net> <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 09:29:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjn7h-00024n-3e
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 09:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab2LOI3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 03:29:10 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:53768 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751618Ab2LOI3J (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Dec 2012 03:29:09 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id A640015605A
	for <git@vger.kernel.org>; Sat, 15 Dec 2012 09:29:07 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id A121E7FEEBC
	for <git@vger.kernel.org>; Sat, 15 Dec 2012 09:29:07 +0100 (CET)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 9D7F1ED891
	for <git@vger.kernel.org>; Sat, 15 Dec 2012 09:29:07 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 9D7F1ED891
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1355560147; bh=08q/7YJkYADpnN2YZYaGv6TWpqqaQOMLdAKgRIWw91w=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=drDOO8wFYykkhKumOPhYZPmMYXI65CrgvfgVOSen8gtCTr4QjAlx/x3MGTeKieVjk
	 CWnr8eATeQNtcx5Gm1SC8Xc8agkeRRC7jCsdQXkTD7LHXFYen5rZuPhsIKyM3Lqt2f
	 0UsgtI0J/cI5dhj66/HsD4aiKyjk/9bHArArbXrI=
Received: from [94.217.29.98] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 15 Dec 2012 09:29:07 +0100 (CET)
In-Reply-To: <1479174763.154268.1350408444997.JavaMail.ngmail@webmail15.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.29.98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211523>


- Start list with 1 instead of 0 because ASCIIDOC will renumber it anyway

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/api-command.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-command.txt b/Documentation/technical/api-command.txt
index ea9b2ed..d3b9781 100644
--- a/Documentation/technical/api-command.txt
+++ b/Documentation/technical/api-command.txt
@@ -71,28 +71,28 @@ Integrating a command
 Here are the things you need to do when you want to merge a new
 subcommand into the git tree.
 
-0. Don't forget to sign off your patch!
+1. Don't forget to sign off your patch!
 
-1. Append your command name to one of the variables BUILTIN_OBJS,
+2. Append your command name to one of the variables BUILTIN_OBJS,
 EXTRA_PROGRAMS, SCRIPT_SH, SCRIPT_PERL or SCRIPT_PYTHON.
 
-2. Drop its test in the t directory.
+3. Drop its test in the t directory.
 
-3. If your command is implemented in an interpreted language with a
+4. If your command is implemented in an interpreted language with a
 p-code intermediate form, make sure .gitignore in the main directory
 includes a pattern entry that ignores such files.  Python .pyc and
 .pyo files will already be covered.
 
-4. If your command has any dependency on a particular version of
+5. If your command has any dependency on a particular version of
 your language, document it in the INSTALL file.
 
-5. There is a file command-list.txt in the distribution main directory
+6. There is a file command-list.txt in the distribution main directory
 that categorizes commands by type, so they can be listed in appropriate
 subsections in the documentation's summary command list.  Add an entry
 for yours.  To understand the categories, look at git-cmmands.txt
 in the main directory.
 
-6. Give the maintainer one paragraph to include in the RelNotes file
+7. Give the maintainer one paragraph to include in the RelNotes file
 to describe the new feature; a good place to do so is in the cover
 letter [PATCH 0/n].
 
-- 
1.8.0.msysgit.0


---
Thomas
