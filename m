Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E14DC636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 22:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBQWDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQWC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 17:02:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A1528D28
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 14:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.it; s=s31663417;
        t=1676671374; i=lore.pini@gmx.it;
        bh=noDOq20khZ5dP/JtbzfU4W+l+QtTFL7M0hHF74GpU+M=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=M4ZsYskxGvm88p6OZWHWAZ8fWXZGLlcfCmVWtDoSG2Lu9mRDsLmACbTjsr7tUk2gi
         dYxpYQOssJq1/StiQ2c52fyG+DOiBBpgLPYNO12gFJvTls3L73rAb6E5KXP8028TZg
         wi6HDc0PFnw80iQE8LeQTD790JZIVoXGaE9Ku4DSmh6IEX3pyR9ULfQVTeYLPRm/AT
         57g9YYjyoB/jEpmQrS/13vC9vr+ljmopPRyOIYFTCAcwsmTsXxGSO30rNVIOSig66F
         yRzfOQVhqozItFYNrnh9H7mJuAhue9AjIPMGxL0A+Tbtc4q96qBr+z1sEntSfkVSPo
         Hj0702/EBB6rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from DESKTOPBP3H8QE ([2.39.143.28]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXGrE-1p3AeW27xe-00YjAH for
 <git@vger.kernel.org>; Fri, 17 Feb 2023 23:02:54 +0100
From:   <lore.pini@gmx.it>
Sender: <lore.pini@gmx.com>
To:     <git@vger.kernel.org>
Subject: [PATCH] git-gui: Fix typo in Italian translation
Date:   Fri, 17 Feb 2023 23:02:55 +0100
Message-ID: <00aa01d9431b$96efb490$c4cf1db0$@gmx.it>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdlDG1kb359TL/vrTEuNY8K1vOCujw==
Content-Language: it
X-Provags-ID: V03:K1:p7+6QQwH9gJuQtTnsf+SOpi9FTpmY4g4l1+1G5QNWpHv5ASiahq
 hoOWIxHi/BJX5imRoCAPjqBeNI+B2DQ7aewEBOdYBOnQvBHS9DwNL8rgCG3z+VYIWCngWcr
 D6QIIxVp3hn3PcPdrTl2lZTxNJapSL+0E6cZbKNRuue0JdqkZsLn2uvvYxoull3NijOke+x
 iOLf2VC1Se6Q+ArOUSqhw==
UI-OutboundReport: notjunk:1;M01:P0:J3gnLumUsdU=;va3YiESyaq9qrTrjyOUmM9WkAJq
 qARbOsW7KTs5X/9x3mHRC/GK1ijr7cZeeg32jnHSncA5FIRdrCaelLPh6HvTvkwpwUSXNLJQ1
 14RQi86aul7/PqXGFw37MvlwylN4Kh2oN9UKWtN1ANgPbQjy+eI/QKvrSzB4RCNyWdrsXZouS
 EyScN4rRUBHIWNTWE0BJslp77G0bLw1v+QYaZ4m9yzWpZEa/giBFqnWE3GfYS9f3U3tnPxTke
 9riLcKsV3AKa8jKA+uBqzTTLAFkTnMxLXNNwshP2EdzDklj+CDBdW5DyzDatTFMgaj6CtYezy
 6QCFMKG9WYpewE1LEkRn/ep+ohVL++uDmSWO5bNTCAKGyKOLLZuOVzkx85/qrXpY3rQNxHJkE
 Nfbbc1yvfm5YjdqxgkD4UELdKcjxWrS/3Wvd/FDP+DZrM86Un3htIZ09KUjF6yovZpMTIB0/e
 ZUJIdIGAzthdMnpCWE24wkDBdbjdaI7rJhUaOeMcYIb57gT/CzZygqJI4kcmpaXPDZtWt2fA7
 bKcjeuQPNqLBFw9g9whVKTnQkIqHpzJkxAOK9Ohj5ARO7+EBUGZVoj7RMwxziRfb6BrS5dOmH
 mZUdrT/LXauZqj2aVtJE6gTFxOcfEoiVK4fTZvfRI4Qo25VTh2iq9qQtRBkF9ceF0JJPPbOZC
 A4Tde3rWI0yVsD41iOygAU66urvwibI8a8iFZQZVvCCjbQ+rMecSHX7GmAujU1R9Fn68Ree6+
 C1rgEYUkKE75Pm0b/QehY2hQmEzayA0HsrOqVrRyXyTsf+E86taxuEV7f8aCNMa3pgCaFbhph
 uCleuW/x6T2kULzokfka6/Y1jVQVJrErJZ18DJnlftVoTJzjuhcT1aLvz+0knu9UBo+x9TLjE
 UfgFd0n6Stctos65JJkXg+UEYpMd4LQ7xfdI6A55735v8ixg+z2OjGwF3DdqYk8SI3FEqd9f1
 GPxoYxv1iA/UCw2QGOdmc62aHZE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Lorenzo Pini <lore.pini@gmx.it>
=2D--
 po/it.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/it.po b/po/it.po
index 1bd8b8e..7963aed 100644
=2D-- a/po/it.po
+++ b/po/it.po
@@ -385,7 +385,7 @@ msgstr "Documentazione sul web"

 #: git-gui.sh:2786 lib/choose_repository.tcl:47
lib/choose_repository.tcl:56
 msgid "Show SSH Key"
-msgstr "Mostra chave SSH"
+msgstr "Mostra chiave SSH"

 #: git-gui.sh:2893
 #, tcl-format
=2D-
2.38.1.windows.1


