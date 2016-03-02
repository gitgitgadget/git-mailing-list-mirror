From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix interactive rebase message
Date: Wed,  2 Mar 2016 18:36:23 +0100
Message-ID: <1456940183-6712-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 18:36:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abAhN-0003Id-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 18:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbcCBRg3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 12:36:29 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36155 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbcCBRg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 12:36:28 -0500
Received: by mail-wm0-f41.google.com with SMTP id n186so97039684wmn.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 09:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GiGpDh8HKKKyaYQeDgdtRl9eQ7h88Yse5GZ3uE2wCfM=;
        b=Sx7i9Xsc/kVGtcGkhbtlKqYL5sPfYP1qtjVjNzmRa5jslGxD+SnIA17pqsuFO00wyB
         1I0r9zjtQVvHqVaMymsJLBkGRXM4LcIi/zJTLCcOokGgbTfEWPrAsMxkvqSACsK3mBxp
         S1KmBJ606u75ROl8nr0cwGP+IMmrr0ph/f/m7Qb7wXGFlXRbhr3FZC/6OWOpqLtjajq4
         VHFLHDcAfc1HgzCDrj2g1UfrX6P35vcItyXW0PUUUNniHuvk314I/GRWxAGo7SePmGFf
         zUW118boxBgRwVs5xocy88E6AlIRQ4qtf4s08idn88PYyTj5ll1nzaMJniu7I5yf/rUT
         Oe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GiGpDh8HKKKyaYQeDgdtRl9eQ7h88Yse5GZ3uE2wCfM=;
        b=mxmpgTg1wTg4tfcR4NORxsBIOmEh7l2dRgvZuwOYi4Od8CQSnv1Ln8qrrvIkvPKHJr
         wNep3xpiKqkXwd1JHMfxpDBg0HG77SArUx2ZceSCGdUpa13CgMCG6k4iT/xbasUGb/EM
         o2lYlNnmlFhHp/V20m0EXGctcv0igrpAI0iUjxYh7xDTmUZh/6uIzPL63JbkEl+bSPxi
         Ehtyo7YSEDslvptLRw3Anmw/5xjP/INxFarRLGOYtxeVLSCnRPzG/ihNQmIGz+UxUz10
         hiWr6KT9fN7C+HBxF1oA11HXFZ6oRrIn3XkJfC6ik6cxBLVa5rogwFxt8Ilk38lCbc6x
         obEA==
X-Gm-Message-State: AD7BkJLgFOK38Mx7Y90DzhuafIBsb1ddHBPBEhUbG3RidyGrcMIUrXRnxEbYShisfJfx7w==
X-Received: by 10.28.50.133 with SMTP id y127mr1152995wmy.4.1456940187626;
        Wed, 02 Mar 2016 09:36:27 -0800 (PST)
Received: from localhost (cable-94-139-5-136.cust.telecolumbus.net. [94.139.5.136])
        by smtp.gmail.com with ESMTPSA id v68sm5148703wmv.10.2016.03.02.09.36.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 09:36:26 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.140.gf92f5fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288136>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 8c5f05d..07b4456 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1950,8 +1950,8 @@ msgstr "Keine Kommandos ausgef=C3=BChrt."
 #, c-format
 msgid "Last command done (%d command done):"
 msgid_plural "Last commands done (%d commands done):"
-msgstr[0] "Letztes Kommando ausgef=C3=BChrt (%d Kommando ausgef=C3=BCh=
rt):"
-msgstr[1] "Letzte Kommandos ausgef=C3=BChrt (%d Kommandos ausgef=C3=BC=
hrt):"
+msgstr[0] "Zuletzt ausgef=C3=BChrtes Kommando (%d Kommando ausgef=C3=BC=
hrt):"
+msgstr[1] "Zuletzt ausgef=C3=BChrte Kommandos (%d Kommandos ausgef=C3=BC=
hrt):"
=20
 #: wt-status.c:1119
 #, c-format
--=20
2.8.0.rc0.140.gf92f5fe
