From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20de=2Epo=3A=20unify=20translations=20of=20=22ahead=22=20and=20=22behind=22?=
Date: Wed,  2 May 2012 23:29:51 +0200
Message-ID: <1335994191-5927-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 23:30:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPh7m-0000Dl-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 23:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab2EBVaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 17:30:07 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61879 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab2EBVaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 17:30:06 -0400
Received: by were53 with SMTP id e53so712924wer.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=WyU8Z7YY8KvdmvopDdEwAWNoXeX6KtYqGysYfJYlNW4=;
        b=i+7s1oeMUD0O8ucDl8gbHd1RgTdU1bdhS5cHmBkC5eksB9bBZ/nrVm79xlkYzzd5d9
         L2jEDgwXta+xowf9L50VA4hi/GPPgkbaLZ3b9w3tknaOc7adCeW6xud42H3SMYajD4Zq
         aaq0dRArsnE/9sJba2ytSL1VLC/2MdC9AaGj3pbZDS+I36pVlZVsZXw8FIorK7BVkW0/
         NCpS+DiDqooG873dAbjuhtrsXlRrc2lDaRwUSqes9atRZJI4zQwllIlvCOleYtK9FN3e
         es2+WzFPHbdc825EmnyNDJIbAFfUwws6TIraF6un4vxCjShdPqmqSL39hZ6MPSnzT8i/
         Kobw==
Received: by 10.216.133.139 with SMTP id q11mr7862163wei.44.1335994204690;
        Wed, 02 May 2012 14:30:04 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id gg2sm10726267wib.7.2012.05.02.14.30.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 14:30:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.67.g0b77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196863>

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |   17 +++++++++--------
 1 Datei ge=C3=A4ndert, 9 Zeilen hinzugef=C3=BCgt(+), 8 Zeilen entfernt=
(-)

diff --git a/po/de.po b/po/de.po
index abb719b..a43d289 100644
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
+msgstr "hinterher: "
=20
 #: wt-status.c:908 wt-status.c:911
 msgid "ahead "
-msgstr "weiter: "
+msgstr "voraus: "
=20
 #: wt-status.c:913
 msgid ", behind "
-msgstr ", zur=C3=BCckgefallen "
+msgstr ", hinterher: "
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
1.7.10.67.g0b77
