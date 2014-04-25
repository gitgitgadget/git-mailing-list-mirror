From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: improve hint for autocorrected command execution
Date: Fri, 25 Apr 2014 22:30:22 +0200
Message-ID: <1398457822-12477-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 22:30:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdmlX-0004bz-CN
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 22:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbaDYUa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2014 16:30:29 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:35884 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbaDYUa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 16:30:27 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so3067564eek.18
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=91Cd2WwP7E3Scwf/3Ybk76t5DsXD8qZhWH3hRQ9Envk=;
        b=xCeo6croGjfXVEudF6o9xvNWuUGqPd9YqY/FVNDH6wepMTGijHdSWbW0slEwDRZAoH
         ctqZtQKGxEKYXon34F0bguvepvfrhSDe+FpFjwtYvulAtNO86yfnqasK8msNwxUq01aw
         zRq9otrLU1psxq5QYrjX6TfnhIjFF2jHLo+aZEFKPgbcsvbk+AknRx4eb7WvWAjqKIxG
         B4Wwc4EOsr7hwHAhQ2kT/woxYtIG/XJTK9ZK7iWwh2WyqtoxuiWsEiZOtAmdYEoafXaw
         EHzys7Qo5ISFl9RQK4rzRazaJGUhzqc+1IuyenvrghskS5sFVbfdIh6zUdw5Hsob/LCq
         JUgw==
X-Received: by 10.15.61.133 with SMTP id i5mr4354718eex.80.1398457825763;
        Fri, 25 Apr 2014 13:30:25 -0700 (PDT)
Received: from localhost (dslb-188-103-228-182.pools.arcor-ip.net. [188.103.228.182])
        by mx.google.com with ESMTPSA id 44sm27533808eek.30.2014.04.25.13.30.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 13:30:25 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.325.ge848631
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247112>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
I'll queue this as part of the German l10n changes for
the next release.

 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index b777ef4..d143572 100644
--- a/po/de.po
+++ b/po/de.po
@@ -555,12 +555,12 @@ msgid ""
 "Continuing under the assumption that you meant '%s'"
 msgstr ""
 "Warnung: Sie haben das nicht existierende Git-Kommando '%s' ausgef=C3=
=BChrt.\n"
-"Setze fort unter der Annahme, dass Sie '%s' gemeint haben"
+"Setze fort unter der Annahme, dass Sie '%s' gemeint haben."
=20
 #: help.c:374
 #, c-format
 msgid "in %0.1f seconds automatically..."
-msgstr "automatisch in %0.1f Sekunden..."
+msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden..."
=20
 #: help.c:381
 #, c-format
--=20
2.0.0.rc0.325.ge848631
