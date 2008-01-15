From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: Improve German translation.
Date: Tue, 15 Jan 2008 20:44:05 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801152044.05359.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F0QjHVIdcLRP4gH"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:47:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JErkj-00016m-IR
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 20:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYAOTqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 14:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbYAOTqt
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 14:46:49 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:55344 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbYAOTqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 14:46:48 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m0FJkfU4022744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 15 Jan 2008 20:46:41 +0100
Received: from [192.168.2.102] (p549006AB.dip0.t-ipconnect.de [84.144.6.171])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m0FJkdp5012277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 20:46:40 +0100
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70544>

--Boundary-00=_F0QjHVIdcLRP4gH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Change translation of "clone" back to "klonen" because "kopieren" is a
much broader term than this particular git action.
=2D--
This patch is against git-gui.git with my previous de.po patch=20
of 2008-01-07 already applied. Patch also attached=20
in case whitespace was messed up.

 po/de.po          |   14 +++++++-------
 po/glossary/de.po |    4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/po/de.po b/po/de.po
index 251bbba..2dfe07e 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2007-11-24 10:36+0100\n"
=2D"PO-Revision-Date: 2008-01-07 21:52+0100\n"
+"PO-Revision-Date: 2008-01-15 20:33+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -914,11 +914,11 @@ msgstr "Neu..."
=20
 #: lib/choose_repository.tcl:93 lib/choose_repository.tcl:468
 msgid "Clone Existing Repository"
=2Dmsgstr "Projektarchiv kopieren"
+msgstr "Projektarchiv klonen"
=20
 #: lib/choose_repository.tcl:99
 msgid "Clone..."
=2Dmsgstr "Kopieren..."
+msgstr "Klonen..."
=20
 #: lib/choose_repository.tcl:106 lib/choose_repository.tcl:978
 msgid "Open Existing Repository"
@@ -968,7 +968,7 @@ msgstr "Datei =BB%s=AB existiert bereits."
=20
 #: lib/choose_repository.tcl:463
 msgid "Clone"
=2Dmsgstr "Kopieren"
+msgstr "Klonen"
=20
 #: lib/choose_repository.tcl:476
 msgid "URL:"
@@ -976,7 +976,7 @@ msgstr "URL:"
=20
 #: lib/choose_repository.tcl:496
 msgid "Clone Type:"
=2Dmsgstr "Art der Kopie:"
+msgstr "Art des Klonens:"
=20
 #: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
@@ -1025,7 +1025,7 @@ msgstr "Kopien von Objekten/Info/Alternates konnten n=
icht erstellt werden: %s"
 #: lib/choose_repository.tcl:690
 #, tcl-format
 msgid "Nothing to clone from %s."
=2Dmsgstr "Von =BB%s=AB konnte nichts kopiert werden."
+msgstr "Von =BB%s=AB konnte nichts geklont werden."
=20
 #: lib/choose_repository.tcl:692 lib/choose_repository.tcl:906
 #: lib/choose_repository.tcl:918
@@ -1086,7 +1086,7 @@ msgstr "Verzeichnis =BB%s=AB kann nicht aufger=E4umt =
werden."
=20
 #: lib/choose_repository.tcl:897
 msgid "Clone failed."
=2Dmsgstr "Kopieren fehlgeschlagen."
+msgstr "Klonen fehlgeschlagen."
=20
 #: lib/choose_repository.tcl:904
 msgid "No default branch obtained."
diff --git a/po/glossary/de.po b/po/glossary/de.po
index 0e4ef86..0b33c57 100644
=2D-- a/po/glossary/de.po
+++ b/po/glossary/de.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui glossary\n"
 "POT-Creation-Date: 2008-01-07 21:20+0100\n"
=2D"PO-Revision-Date: 2008-01-07 21:27+0100\n"
+"PO-Revision-Date: 2008-01-15 20:32+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German \n"
 "MIME-Version: 1.0\n"
@@ -62,7 +62,7 @@ msgstr ""
=20
 #. ""
 msgid "clone [verb]"
=2Dmsgstr "kopieren"
+msgstr "klonen"
=20
 #. "A single point in the git history."
 msgid "commit [noun]"
=2D-=20
1.5.3.4.206.g58ba4


--Boundary-00=_F0QjHVIdcLRP4gH
Content-Type: application/x-gzip;
  name="0004-git-gui-Improve-German-translation.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0004-git-gui-Improve-German-translation.patch.gz"

H4sICH8MjUcAAzAwMDQtZ2l0LWd1aS1JbXByb3ZlLUdlcm1hbi10cmFuc2xhdGlvbi5wYXRjaAC1
VlFv2zYQftevOHgo0MKhQsmyZAvD0Cxr1qxNU6ReX7JioKSTzEWmDJHKmmE/Z2/7CXvr/tiOkq0q
ThqnDzMSyyKPvO/uvuPHk7paAUc+zVOeTlPkk0ma+1nqcfRnIvDn83TmI8+TJJ9zOKsUvMM1eBFw
Hrd/4HPuOSe0TQzHy1pqIwUZGblaSVXAt3rz67lplks3w++cH4TBGBYNHoA3hZ/ImraY0VccePFk
DmPuce68a5LfMDUxXL49Why//ACFNKxoZAynq3VdXSP8iPWKFptaKF0KIyvlOs7xUqgCh4NQ5TBK
y0rhCBKRXoGpYHRl3xUNYCoajTRQrSXWdkhqEM6qSZeQ1JXIsAZDjsAsra8lza5FbWTalKK2mECk
nWvGmAPr6jBDd11B//mT/r0Axt2HdZ/WsCgrrUV9s1lhDcEa2mkfclmihrQNJzuAOUilsbau9NPx
MzuQYYndO3vmOJnMc2CsRXTYw0j6n45UGX4Ef+olSSJc189y5BEC5ToMAot+sM4hqMO1z58Dmx1E
MLZf9LLShTY1jEYOjN7WlS0UO83Ye6w1AYq3tfpFWYMLXFe1YWe6kBn7vik0W1QxdHNvzxfsuMa2
UKwjBpEhYp7H/ICwxZOwpYO1ZmTNLvBa6lvGM8Y9xiPwvXjq98bjB4yJdUS2yaQ3htFroQ1bbEhT
1Y+k8natKhpRIFugoCboaNlNnZ2evficFc9tvdlkzr3gwPNgvHkOUvoGG9d1abED38RQyuQwXVaV
xl9rSqOWBO7GNWkZzycPTAbhzLE7ygxGx5bq8OKjDYeiuOgtKaNbp20Nr4yo06W8hr4XnPEXDLru
2Y9xfhtFG1jv9NXGTTvae3rV7v2oFHg8fMh59DkH52tU96egLUbYcrt7DEphWSPh0z9P9Ke/AdvV
1IF0ZtQojX4EwCCc3E7APdHfCf0R20Zhv+3PF6/jTRRR2EbRPgZRdBZ795yHO4xZ3KwxHgA+otDt
adgCjwewuwkNHXz9CGdT7vfO3hmhMlFn8PSEevCA5GUlqXGzhkYVvb+kuVKqK/2sC9Pj/tTGuXkO
Am2BKbimI/88sWxFdXiq8urwqKQTXFExNVFbKRoHJdOlAWpMg2Vp4HesM6QOfaJHe6CHc04WB0C/
WV5Rp5s+kjcVyQPRi/SllRvIrbY+0UPOvydwG0J1UDoketNzWyTDhvjikgJtHw6W7Et7OPcf6hce
7mtnb7YpwSzsSjDb4RoddX8goVMkk1vMQm3TLZq8wPrfv5rVV4CezaMdYuaCpDG77ySBHJdlgTpd
lnQeq7vHyl2DvUcYDwYFJp7noiHCJCQVdEOoEiOkasHs6u+Ouid3xzaKzDHAfBa6Lk/o7jWN7ijy
zqpemnfGbWUiW5aor4kFPXIeq9aw3fAhaR6orc+/Qpr96Guk2f8/pRn2aHPo2yy237evOkQVd5tQ
m9quyy+vsU4+DNh4j3wOBZO2OAJNWEukW6CkBpb2YontZZLuly31Bk4qCszApaoaZb0wcDx36k7c
wPV56BbTWSICx/kPZVUWk8gLAAA=

--Boundary-00=_F0QjHVIdcLRP4gH--
