From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=2009/10=5D=20l10n=3A=20de=2Epo=3A=20unify=20translation=20of=20=22ahead=22=20and=20=22behind=22?=
Date: Tue,  8 May 2012 19:33:44 +0200
Message-ID: <1336498425-17890-10-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:35:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJT-0002G2-Dw
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab2EHRel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:41 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37448 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285Ab2EHRej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:39 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn19so437604wib.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uMJUzqdPUjOfROkEfkJ/yMwuJ87MezCCKWNzLYkY5Mk=;
        b=imRYnJwohSd4QOY/Sjusrpim1QZsiuere0sl8+yNFvmAWUTANsZQyXGpyREPLXQNko
         XSiPux4KldMzlsD9Te5OpgLxSIGUKvkDWZAnyeQk82EUzIJc3cgfjXkKT6JkI0wzHFCB
         tnrLEat8uUI6yDP4iCNZ78fmxuoZbuXtiq4L4WfJsjcTZAmyX4FPG32Eji05oA9UnCuH
         oPuhBN3qtmO0aHtvfZ62kAt7ctZWteyQe5dwhCxXQzvPapVNVxJ3+MjF/0Bd5+daAWzW
         tZNGjQ6ARAklq1wQk7dOdoPtwbfwLVDztMJp94TTkyihAp8WEnlRFWXx+d3lhle8H6oA
         Uz9Q==
Received: by 10.180.105.194 with SMTP id go2mr46679356wib.22.1336498478566;
        Tue, 08 May 2012 10:34:38 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197409>

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |   17 +++++++++--------
 1 Datei ge=C3=A4ndert, 9 Zeilen hinzugef=C3=BCgt(+), 8 Zeilen entfernt=
(-)

diff --git a/po/de.po b/po/de.po
index 961e88a..9f12843 100644
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
1.7.10.129.g1ec31a3
