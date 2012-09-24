From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BRFC/PATCH=5D=20l10n=3A=20de=2Epo=3A=20correct=20translation=20of=20a=20=27rebase=27=20message?=
Date: Mon, 24 Sep 2012 19:39:49 +0200
Message-ID: <1348508389-2883-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sascha-ml@babbelbox.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Mon Sep 24 19:40:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGCeM-0004KS-DM
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 19:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327Ab2IXRkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2012 13:40:45 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34381 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab2IXRko (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 13:40:44 -0400
Received: by wgbdr13 with SMTP id dr13so3915703wgb.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=1Ajy0aJNCAcHD/3dmFn49zQU6ilrSDOve1aEXLsgafM=;
        b=P2LSq3DxlBAHedqNziLcNOs/GLFDUmEDbywOXWffe5zNac8LOGspCtOF2g8ElRzuTK
         F3d37ll2F3E9RFrZ7BhCJCXqtgW+YK5IhY6Le5l8QoPkGtQQtC7sP5+Bafuidb0Glok7
         8R/jst+4p3tuooDWpEvVswp6b96+dhy9Ky0Cw6REOt2KjB0HIfaPsJC6MUkMmhE6Bhqv
         ETwvaDkjVtHdlgG8oeRSui1qoTzm+rD9Qc4mVLoJ3xcJ3Gky6DwVBheBFGP2JGDWIygS
         icp7T8nAKxcczDegiyYtg0DfYzVSAcaeGeQ4VLAJ6YkCwEc8lSN76glQwU0UNaAVwRi0
         wXGg==
Received: by 10.216.194.222 with SMTP id m72mr8337082wen.34.1348508442868;
        Mon, 24 Sep 2012 10:40:42 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id h9sm15704255wiz.1.2012.09.24.10.40.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Sep 2012 10:40:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.396.g7954078
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206299>

Noticed-by: Sascha Cunz <sascha-ml@babbelbox.org>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

It turns out that one of the 'rebase' messages
has a wrong translation. Please review this fix.

Thanks

The English original is:

"It seems that there is already a $state_dir_base directory, and\n"
"I wonder if you are in the middle of another rebase.  If that is the\n=
"
"case, please try\n"
"\t$cmd_live_rebase\n"
"If that is not the case, please\n"
"\t$cmd_clear_stale_rebase\n"
"and run me again.  I am stopping in case you still have something\n"
"valuable there."


 po/de.po | 10 +++++-----
 1 Datei ge=C3=A4ndert, 5 Zeilen hinzugef=C3=BCgt(+), 5 Zeilen entfernt=
(-)

diff --git a/po/de.po b/po/de.po
index 2739bc0..9e721c0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5750,14 +5750,14 @@ msgid ""
 "and run me again.  I am stopping in case you still have something\n"
 "valuable there."
 msgstr ""
-"Es scheint so, als g=C3=A4be es das Verzeichnis $state_dir_base berei=
ts, und\n"
-"es w=C3=A4re verwunderlich, wenn ein Neuaufbau bereits im Gange ist. =
Wenn das\n"
-"der Fall ist, probiere bitte\n"
+"Es sieht so aus, als gibt es das Verzeichnis $state_dir_base bereits\=
n"
+"und es k=C3=B6nnte ein anderer Neuaufbau im Gange sein. Wenn das der =
=46all ist,\n"
+"probiere bitte\n"
 "\t$cmd_live_rebase\n"
 "Wenn das nicht der Fall ist, probiere bitte\n"
 "\t$cmd_clear_stale_rebase\n"
-"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, falls=
 bereits\n"
-"etwas N=C3=BCtzliches vorhanden ist."
+"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, falls=
 noch\n"
+"etwas Sch=C3=BCtzenswertes vorhanden ist."
=20
 #: git-rebase.sh:395
 #, sh-format
--=20
1.7.12.396.g7954078
