From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=203/3=5D=20git-gui=3A=20de=2Epo=3A=20translate=20=22remote=22=20as=20=22extern=22?=
Date: Tue, 19 Jun 2012 20:25:41 +0200
Message-ID: <1340130341-5224-4-git-send-email-ralf.thielow@googlemail.com>
References: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: patthoyts@users.sourceforge.net, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue Jun 19 20:26:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh37w-0006NB-TD
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 20:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab2FSS0C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 14:26:02 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50853 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab2FSSZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 14:25:56 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so5415542bkc.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mz4XSd7X7V8CCSYVfW/g6G3Df5K3LfJvDorb+on+a3c=;
        b=yknQBIC0ZpfxWDvLjZS9BtRpiGUSIsKexrZLamMXJbLCiqIUKGVEr92Kz0sjaja8eU
         f8hpgnuq9ASGHn7FcmLfNuIQkV5icUv/Q9kOT7YIUrsPh1RHAd5kBXct6Lhvl/aysfYv
         bQGDLcFFvI++NrTUUeNNMduWcGaWepmvAOSetK5N+6K8+t13j1y4L7ebBk3LPOhe/OOC
         9QGmXrbVV8KZeOIJatRi3c/h+xW5jTkcsQQaGXlzbXWCkzz6e0peBeOKmFHZOtjfO4rW
         Cmq0U4qPLfpLLNaKY4WkcW6rHw9HlIbrCbP0NgVlv0J+apP8CKhRSyQDoR2z9cc10Kgb
         BRZA==
Received: by 10.204.129.87 with SMTP id n23mr8591731bks.19.1340130355789;
        Tue, 19 Jun 2012 11:25:55 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id e20sm24459087bkw.3.2012.06.19.11.25.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 11:25:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200222>

According to the translation in git-core, we
translate "remote" as "extern".

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po | 28 ++++++++++++++--------------
 1 Datei ge=C3=A4ndert, 14 Zeilen hinzugef=C3=BCgt(+), 14 Zeilen entfer=
nt(-)

diff --git a/po/de.po b/po/de.po
index 55fde80..baebff2 100644
--- a/po/de.po
+++ b/po/de.po
@@ -188,7 +188,7 @@ msgstr "Zusammenf=C3=BChren"
=20
 #: git-gui.sh:2465 lib/choose_rev.tcl:557
 msgid "Remote"
-msgstr "Andere Archive"
+msgstr "Externe Archive"
=20
 #: git-gui.sh:2468
 msgid "Tools"
@@ -478,7 +478,7 @@ msgstr "Zusammenf=C3=BChrungswerkzeug"
=20
 #: git-gui.sh:3328
 msgid "Use Remote Version"
-msgstr "Entfernte Version benutzen"
+msgstr "Externe Version benutzen"
=20
 #: git-gui.sh:3332
 msgid "Use Local Version"
@@ -771,7 +771,7 @@ msgstr "Bitte w=C3=A4hlen Sie einen =C3=9Cbernahmez=
weig."
 #: lib/branch_create.tcl:140
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "=C3=9Cbernahmezweig =C2=BB%s=C2=AB ist kein Zweig im anderen P=
rojektarchiv."
+msgstr "=C3=9Cbernahmezweig =C2=BB%s=C2=AB ist kein Zweig im externen =
Projektarchiv."
=20
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
@@ -2134,11 +2134,11 @@ msgstr "Optionen konnten nicht gespeichert werd=
en:"
=20
 #: lib/remote_add.tcl:19
 msgid "Add Remote"
-msgstr "Anderes Archiv hinzuf=C3=BCgen"
+msgstr "Externes Archiv hinzuf=C3=BCgen"
=20
 #: lib/remote_add.tcl:24
 msgid "Add New Remote"
-msgstr "Neues anderes Archiv hinzuf=C3=BCgen"
+msgstr "Neues externes Archiv hinzuf=C3=BCgen"
=20
 #: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
 msgid "Add"
@@ -2146,7 +2146,7 @@ msgstr "Hinzuf=C3=BCgen"
=20
 #: lib/remote_add.tcl:37
 msgid "Remote Details"
-msgstr "Einzelheiten des anderen Archivs"
+msgstr "Einzelheiten des externen Archivs"
=20
 #: lib/remote_add.tcl:50
 msgid "Location:"
@@ -2162,7 +2162,7 @@ msgstr "Gleich anfordern"
=20
 #: lib/remote_add.tcl:71
 msgid "Initialize Remote Repository and Push"
-msgstr "Anderes Archiv initialisieren und dahin versenden"
+msgstr "Externes Archiv initialisieren und dahin versenden"
=20
 #: lib/remote_add.tcl:77
 msgid "Do Nothing Else Now"
@@ -2170,17 +2170,17 @@ msgstr "Nichts tun"
=20
 #: lib/remote_add.tcl:101
 msgid "Please supply a remote name."
-msgstr "Bitte geben Sie einen Namen des anderen Archivs an."
+msgstr "Bitte geben Sie einen Namen des externen Archivs an."
=20
 #: lib/remote_add.tcl:114
 #, tcl-format
 msgid "'%s' is not an acceptable remote name."
-msgstr "=C2=BB%s=C2=AB ist kein zul=C3=A4ssiger Name eines anderen Arc=
hivs."
+msgstr "=C2=BB%s=C2=AB ist kein zul=C3=A4ssiger Name eines externen Ar=
chivs."
=20
 #: lib/remote_add.tcl:125
 #, tcl-format
 msgid "Failed to add remote '%s' of location '%s'."
-msgstr "Fehler beim Hinzuf=C3=BCgen des anderen Archivs =C2=BB%s=C2=AB=
 aus Herkunftsort =C2=BB%s=C2=AB."
+msgstr "Fehler beim Hinzuf=C3=BCgen des externen Archivs =C2=BB%s=C2=AB=
 aus Herkunftsort =C2=BB%s=C2=AB."
=20
 #: lib/remote_add.tcl:133 lib/transport.tcl:6
 #, tcl-format
@@ -2195,7 +2195,7 @@ msgstr "=C2=BB%s=C2=AB anfordern"
 #: lib/remote_add.tcl:157
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
-msgstr "Initialisieren eines anderen Archivs an Adresse =C2=BB%s=C2=AB=
 ist nicht m=C3=B6glich."
+msgstr "Initialisieren eines externen Archivs an Adresse =C2=BB%s=C2=AB=
 ist nicht m=C3=B6glich."
=20
 #: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
 #: lib/transport.tcl:81
@@ -2210,7 +2210,7 @@ msgstr "Einrichten von =C2=BB%s=C2=AB an =C2=BB%s=
=C2=AB"
=20
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
-msgstr "Zweig in anderem Archiv l=C3=B6schen"
+msgstr "Zweig in externem Archiv l=C3=B6schen"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -2218,7 +2218,7 @@ msgstr "In Projektarchiv"
=20
 #: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
 msgid "Remote:"
-msgstr "Anderes Archiv:"
+msgstr "Externes Archiv:"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
 msgid "Arbitrary Location:"
@@ -2281,7 +2281,7 @@ msgstr "=C2=BB%s=C2=AB laden..."
=20
 #: lib/remote.tcl:163
 msgid "Remove Remote"
-msgstr "Anderes Archiv entfernen"
+msgstr "Externes Archiv entfernen"
=20
 #: lib/remote.tcl:168
 msgid "Prune from"
--=20
1.7.11
