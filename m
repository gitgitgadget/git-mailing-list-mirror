From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] l10n: de.po: translate "leave behind" correctly
Date: Mon, 26 Jan 2015 16:34:31 +0100
Message-ID: <960f016f1252640ccc3b1071ad5c8d6d2b1fbd0e.1422286422.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 16:34:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFlgW-0000vr-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 16:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbbAZPeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jan 2015 10:34:36 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59278 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751771AbbAZPee (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2015 10:34:34 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 2859220755
	for <git@vger.kernel.org>; Mon, 26 Jan 2015 10:34:34 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 26 Jan 2015 10:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:mime-version:content-type:content-transfer-encoding;
	 s=smtpout; bh=Cizo+tHLjjN2/TM97xXmKO0/1P4=; b=Tyk5zxu79T+HGPYvN
	jlcA6cvKn8vcrSMvWZXUyjnBaiZdz/+yc1n+LDkvLW9npBC58plXCSdPr3k/YNm1
	bqzPjl82cjZOW3U2ed2Ibkmhh+Fd/hyLE6aU8k8snfMT7/8G/ijbfQjjSqTHtLHf
	seKrtQd4ganCj1YPdJSxhZJ5pA=
X-Sasl-enc: mGyW1C7z60uWXljAVFD+G2pI72buZTUUFdZrSA164xnG 1422286473
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AA066C0001A;
	Mon, 26 Jan 2015 10:34:33 -0500 (EST)
X-Mailer: git-send-email 2.3.0.rc1.222.gae238f2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263030>

This message is about leaving orphaned commits behind, not about
behing behind an upstream branch. Try to make this clear.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 5a93ea8..65a8ac0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3559,26 +3559,26 @@ msgid ""
 "Warning: you are leaving %d commit behind, not connected to\n"
 "any of your branches:\n"
 "\n"
 "%s\n"
 msgid_plural ""
 "Warning: you are leaving %d commits behind, not connected to\n"
 "any of your branches:\n"
 "\n"
 "%s\n"
 msgstr[0] ""
-"Warnung: Sie sind um %d Commit hinterher. Folgende Commits sind in\n"
+"Warnung: Sie lassen %d Commit zur=C3=BCck. Folgende Commits sind in\n=
"
 "keinem Ihrer Branches enthalten:\n"
 "\n"
 "%s\n"
 msgstr[1] ""
-"Warnung: Sie sind um %d Commits hinterher. Folgende Commits sind in\n=
"
+"Warnung: Sie lassen %d Commits zur=C3=BCck. Folgende Commits sind in\=
n"
 "keinem Ihrer Branches enthalten:\n"
 "\n"
 "%s\n"
=20
 #: builtin/checkout.c:729
 #, c-format
 msgid ""
 "If you want to keep them by creating a new branch, this may be a good=
 time\n"
 "to do so with:\n"
 "\n"
--=20
2.3.0.rc1.222.gae238f2
