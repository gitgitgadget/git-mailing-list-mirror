From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=201/3=5D=20git-gui=3A=20de=2Epo=3A=20consistently=20add=20untranslated=20hook=20names=20within=20braces?=
Date: Tue, 19 Jun 2012 20:25:39 +0200
Message-ID: <1340130341-5224-2-git-send-email-ralf.thielow@googlemail.com>
References: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: patthoyts@users.sourceforge.net, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue Jun 19 20:26:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh37n-00062a-E5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 20:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab2FSSZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 14:25:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50853 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab2FSSZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 14:25:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so5415542bkc.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s+Y26L+fuHUqTl3zKuTdb/p9trLtcOSSffzw2SZHj0Q=;
        b=BNYaclX4wVDnafLFIdO+fDh0rLv3oM08nPbsCEBNaSTZG0fkYDJmrcMdGnDrsVDOtu
         dQVXmZqMqwE75eiRV/xxzJYGzqLXYH20TF5GfK2baMhi6XFlG+fYXOmx5iCwo9kHT2Yu
         rg0LXSrI/Xf5styOW/le/NK7BC7EcxMq3EqA4kj7b6knyR2UA5PE032GjmAkkI/jG2jC
         Xsf+304m8PK4yl0ePB7E6Wal9V2GgGDwamMnA0tO+5V36E63NX6DN5HwKFb338vZkX05
         FBHDC1ZnxAL/jBXTpA9M6ysYDL6x3jagZes1TfLiYAhixGm2wzrb7B2yQCTIx7tO2ghJ
         vrfQ==
Received: by 10.204.143.140 with SMTP id v12mr8236724bku.98.1340130354034;
        Tue, 19 Jun 2012 11:25:54 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id e20sm24459087bkw.3.2012.06.19.11.25.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 11:25:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200221>

The user might not really know what hook is
actually meant if it's translated. To avoid such
a confusion we should consistently write it untranslated
within braces after.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po | 6 +++---
 1 Datei ge=C3=A4ndert, 3 Zeilen hinzugef=C3=BCgt(+), 3 Zeilen entfernt=
(-)

diff --git a/po/de.po b/po/de.po
index d9a9ebd..91221ef 100644
--- a/po/de.po
+++ b/po/de.po
@@ -88,7 +88,7 @@ msgstr "Nach ge=C3=A4nderten Dateien suchen..."
=20
 #: git-gui.sh:1454
 msgid "Calling prepare-commit-msg hook..."
-msgstr "Aufrufen der Eintragen-Vorbereiten-Kontrolle..."
+msgstr "Aufrufen der Eintragen-Vorbereiten-Kontrolle (=C2=BBprepare-co=
mmit hook=C2=AB)..."
=20
 #: git-gui.sh:1471
 msgid "Commit declined by prepare-commit-msg hook."
@@ -1446,7 +1446,7 @@ msgstr ""
=20
 #: lib/commit.tcl:234
 msgid "Calling pre-commit hook..."
-msgstr "Aufrufen der Vor-Eintragen-Kontrolle..."
+msgstr "Aufrufen der Vor-Eintragen-Kontrolle (=C2=BBpre-commit hook=C2=
=AB)..."
=20
 #: lib/commit.tcl:249
 msgid "Commit declined by pre-commit hook."
@@ -1454,7 +1454,7 @@ msgstr "Eintragen abgelehnt durch Vor-Eintragen-K=
ontrolle (=C2=BBpre-commit hook=C2=AB).
=20
 #: lib/commit.tcl:272
 msgid "Calling commit-msg hook..."
-msgstr "Aufrufen der Versionsbeschreibungs-Kontrolle..."
+msgstr "Aufrufen der Versionsbeschreibungs-Kontrolle (=C2=BBcommit-mes=
sage hook=C2=AB)..."
=20
 #: lib/commit.tcl:287
 msgid "Commit declined by commit-msg hook."
--=20
1.7.11
