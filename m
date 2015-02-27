From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] l10n: de.po: fix negation for commit -a with paths
Date: Fri, 27 Feb 2015 17:30:19 +0100
Message-ID: <85fb5a9d3cf3bc911faa0d3ad193f5697837ff93.1425054567.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 17:30:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRNo4-0000XH-8Y
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 17:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbbB0QaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2015 11:30:23 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55062 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752158AbbB0QaV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2015 11:30:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5484C20D8C
	for <git@vger.kernel.org>; Fri, 27 Feb 2015 11:30:20 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 27 Feb 2015 11:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:mime-version:content-type:content-transfer-encoding;
	 s=smtpout; bh=IWvscw+JFFMh4W7ckka5B89GAEM=; b=BSdMs2UAAb06rorvH
	1GLZn9Tsd1SZVZwMPp06/pV3lSfDDPxrBcp6uoQenIBpVy7+FQMwfl+gxj2Q8Fvc
	CBzH4cYCtFqSpc7vdWOCJZ6RDmFovtE+LCu8hM3pQ35I1YX5V4XGx/pVDOsD16dQ
	blop6Z4JLaNPp2xP9RvZ4yID0k=
X-Sasl-enc: MIC0xsQLBd8tpyhzi9SNtoWLsGRWAamwQ35X7Dic+cvU 1425054620
Received: from localhost (unknown [88.71.97.79])
	by mail.messagingengine.com (Postfix) with ESMTPA id B08F6680120;
	Fri, 27 Feb 2015 11:30:20 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264501>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 11fbd0f..aff3109 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4613,7 +4613,7 @@ msgstr "Ung=C3=BCltiger \"cleanup\" Modus %s"
=20
 #: builtin/commit.c:1218
 msgid "Paths with -a does not make sense."
-msgstr "Die Option -a kann nur mit der Angabe von Pfaden verwendet wer=
den."
+msgstr "Die Option -a kann nicht mit der Angabe von Pfaden verwendet w=
erden."
=20
 #: builtin/commit.c:1328 builtin/commit.c:1608
 msgid "show status concisely"
--=20
2.3.1.303.g5174db1
