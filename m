From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 3/5] glossary: man page
Date: Mon,  8 Dec 2014 16:38:57 +0100
Message-ID: <f09df5406eb25f53da5c1ef2d58fb500f5c91c57.1418052470.git.git@drmicha.warpmail.net>
References: <cover.1418052470.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 16:39:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0PF-0000ST-5P
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 16:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbaLHPjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 10:39:12 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41114 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755435AbaLHPjF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 10:39:05 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 0F5AD205EF
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 10:39:05 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 08 Dec 2014 10:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=a1hRrW/VgpqLeu
	cRuPjveSKm8wQ=; b=BghNWcubjzkdFEtmwIqS4POEWoYyzsFupIQiSJIgGcTBg/
	B4MiwIXwoUYh/T/bPR0Xv44EwKe0qIJ4jTLEQN/OI28e+o69Ynn5UEFYY1KhClDI
	r3DAle1G6Z2M9GUxiV5SnjrlXyEvsJ3Xr60dQd4+1gh8z2Cph6q07nyQTY+Yw=
X-Sasl-enc: oBdm1w9FBPaMcVkBOjqE9FN78MQsx2HSQRpjHAYW9T49 1418053144
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A9B13680190;
	Mon,  8 Dec 2014 10:39:04 -0500 (EST)
X-Mailer: git-send-email 2.2.0.345.g7041aac
In-Reply-To: <cover.1418052470.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261047>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This also means you have to use "git help gitglossary" if you want to have
the glossary only. But it's included in "git help glossary" for convenience.

 Documentation/git-glossary.txt | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/git-glossary.txt

diff --git a/Documentation/git-glossary.txt b/Documentation/git-glossary.txt
new file mode 100644
index 0000000..f2605c5
--- /dev/null
+++ b/Documentation/git-glossary.txt
@@ -0,0 +1,48 @@
+git-glossary(1)
+===============
+
+NAME
+----
+git-glossary - List and translate terms from the glossary
+
+SYNOPSIS
+--------
+[verse]
+'git glossary' [-a | --all] <term>...
+
+DESCRIPTION
+-----------
+Look up each term in the glossary and display it along with its
+translation. This works with localised (translated) versions
+of git only. 
+
+OPTIONS
+-------
+<term>...::
+	Term(s) to look up.
++
+If no term is specified, list all terms from the glossary along with its translation.
+
+-a::
+	Look up terms in the message catalogue of all git commands, instead of the glossary.
+	This matches with complete english messages only.
+
+
+DISCUSSION
+----------
+Unless `-a' is used, partial matches in both english and the translated
+entry are shown.
+
+The list of terms is taken from the linkgit:gitglossary[7].
+Currently they are:
+
+include::glossary-content.txt[]
+
+
+SEE ALSO
+--------
+linkgit:gitglossary[7]
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.2.0.345.g7041aac
