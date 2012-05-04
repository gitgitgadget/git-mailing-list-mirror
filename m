From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=205/5=5D=20l10n=3A=20de=2Epo=3A=20unify=20translation=20of=20=22ahead=22=20and=20=22behind=22?=
Date: Fri,  4 May 2012 21:48:26 +0200
Message-ID: <1336160906-20708-6-git-send-email-ralf.thielow@googlemail.com>
References: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Fri May 04 21:49:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOUz-0007I9-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759563Ab2EDTsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 15:48:55 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:39488 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759557Ab2EDTsx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:48:53 -0400
Received: by werb10 with SMTP id b10so138121wer.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ISADfizCQSKkWIb+wXNwmSSDCSCba8rB3o4VpsGvBjY=;
        b=Mril95JRcGMzOdWuBR/oj4Lb2V33mzLlGQET6ICSaiAxOgzjgy/z2V/e7wmu/ULPAp
         4zBTAtQjIKL5E2WmHhyV3u90tqrkHNa12Iub6uud6ZyQxo3lhHVugkydZsL9uThMh7Bz
         /TPVWBaKes8gZ5KgZyTAdoqJYOCUSviL7CsL5sKxGE4WtyYJzLZdMmCJKUmt3n2NfzWh
         mUjkaUQDK97OChPSnCHF/GsPSoRXeuQqohkplyosIdx1eSnlvzHKVeUdZBgKqO3J4mFB
         8pk4Jqzu7PIM5S9q9BdSTHePvcVM6GtrOMBOLTr5Nh2psDNy7jmsboJwFcuA7S+u7y1h
         zVWA==
Received: by 10.216.200.90 with SMTP id y68mr4602500wen.49.1336160932593;
        Fri, 04 May 2012 12:48:52 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id 6sm3408902wiz.1.2012.05.04.12.48.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 12:48:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.72.g0dc6d
In-Reply-To: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197065>

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |   17 +++++++++--------
 1 Datei ge=C3=A4ndert, 9 Zeilen hinzugef=C3=BCgt(+), 8 Zeilen entfernt=
(-)

diff --git a/po/de.po b/po/de.po
index ade6d25..20ad8b2 100644
--- a/po/de.po
+++ b/po/de.po
@@ -169,9 +169,10 @@ msgid "Your branch is behind '%s' by %d commit, an=
d can be fast-forwarded.\n"
 msgid_plural ""
 "Your branch is behind '%s' by %d commits, and can be fast-forwarded.\=
n"
 msgstr[0] ""
-"Dein Zweig ist hinter '%s' um %d Version, und kann vorgespult werden.=
\n"
+"Dein Zweig ist zu '%s' um %d Version hinterher, und kann vorgespult w=
erden.\n"
 msgstr[1] ""
-"Dein Zweig ist hinter '%s' um %d Versionen, und kann vorgespult werde=
n.\n"
+"Dein Zweig ist zu '%s' um %d Versionen hinterher, und kann vorgespult=
 "
+"werden.\n"
=20
 #: remote.c:1621
 #, c-format
@@ -650,15 +651,15 @@ msgstr "Initiale Version auf "
=20
 #: wt-status.c:905
 msgid "behind "
-msgstr "hinter "
+msgstr "hinterher "
=20
 #: wt-status.c:908 wt-status.c:911
 msgid "ahead "
-msgstr "weiter: "
+msgstr "voraus "
=20
 #: wt-status.c:913
 msgid ", behind "
-msgstr ", zur=C3=BCckgefallen "
+msgstr ", hinterher "
=20
 #: builtin/add.c:62
 #, c-format
@@ -891,7 +892,7 @@ msgstr "%d voraus] "
 #: builtin/branch.c:398
 #, c-format
 msgid "ahead %d, behind %d] "
-msgstr "vor %d, hinter %d] "
+msgstr "%d voraus, %d hinterher] "
=20
 #: builtin/branch.c:501
 msgid "(no branch)"
@@ -1078,12 +1079,12 @@ msgid_plural ""
 "\n"
 "%s\n"
 msgstr[0] ""
-"Warnung: Du verl=C3=A4sst %d Version zur=C3=BCckliegend, nicht verbun=
den zu\n"
+"Warnung: Du bist um %d Version hinterher, nicht verbunden zu\n"
 "einem deiner Zweige:\n"
 "\n"
 "%s\n"
 msgstr[1] ""
-"Warnung: Du verl=C3=A4sst %d Versionen zur=C3=BCckliegend, nicht verb=
unden zu\n"
+"Warnung: Du bist um %d Versionen hinterher, nicht verbunden zu\n"
 "einem deiner Zweige:\n"
 "\n"
 "%s\n"
--=20
1.7.10.72.g0dc6d
