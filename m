From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/3] l10: de.po: translation fix for fall-back to 3way merge
Date: Tue, 19 May 2015 10:51:34 +0200
Message-ID: <d7f87b49a0d229a62f2f6c51a327c9fb98690b49.1432025365.git.git@drmicha.warpmail.net>
References: <cover.1432025365.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 10:52:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YudG7-0007eU-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 10:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbbESIvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2015 04:51:48 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35310 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754198AbbESIvk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2015 04:51:40 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 708DE209BF
	for <git@vger.kernel.org>; Tue, 19 May 2015 04:51:40 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 19 May 2015 04:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=rYcvAkRCAQ1L4OlQBWMt0o46XgU=; b=AJc78p
	awzLKFjAB++g/K7yYtL71JuPi6KuP+wX4X/84c6TFl5jH71/PvT0sRaEbux7RSX3
	orWgFWDonn0QHsa4R65RX1ZIkVOr5be0IMBJBvRjETeToUnawV+7ewNV+ODnoLAj
	t7ZQiOve4r/g0sbdt1Mn82TpW8M6lMhuRUlqg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=rYcvAkRCAQ1L4Ol
	QBWMt0o46XgU=; b=W/QvPZcO6WcI/giPhqYgXhTGTfJn2y7xWhDWiDssBvNNQIB
	2HUYdL8qYf91E/GYEDFq/E03gdLoglWIwFgDrqEZgzNTlbzneA36TgrRaJxlbkGH
	67tTqWu/cgOeh6J/wbhoBxh7gxZh0Qlhi/uvdZ/DPopnvtn9C9DSZVRE2aWM=
X-Sasl-enc: X5KKmOkkfDdBnNdyPzLPrwBH668peA1hD/ONWt2G3CEn 1432025500
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0AEE0C00015;
	Tue, 19 May 2015 04:51:39 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc3.332.g886447c
In-Reply-To: <cover.1432025365.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269348>

The English version is correct, but misleading: It is not the 3way merg=
e
that is being patched also, but that is being fallen back to also.

The German version translates the former meaning. Make it translate the
latter.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    Really, it would be clearer to say "mittels 3-Wege-Merge", and
    also "using 3way merge" in the original (rather than "and").
    But I tried to stay as close as possible to both the English versio=
n
    and the existing translation.

 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 6405f3e..b9eaa82 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10491,7 +10491,7 @@ msgstr ""
=20
 #: git-am.sh:166
 msgid "Falling back to patching base and 3-way merge..."
-msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merges =
=2E.."
+msgstr "Falle zur=C3=BCck zum Patchen der Basis und zum 3-Wege-Merge .=
=2E."
=20
 #: git-am.sh:182
 msgid "Failed to merge in the changes."
--=20
2.4.0.rc3.332.g886447c
