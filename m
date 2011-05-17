From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20gitk=3A=20spelling=20fix=20in=20German=20translation?=
Date: Tue, 17 May 2011 22:18:29 +0200
Message-ID: <1305663509-5057-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 22:18:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMQj7-0008Fc-De
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 22:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245Ab1EQUSk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 16:18:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41597 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab1EQUSk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 16:18:40 -0400
Received: by fxm17 with SMTP id 17so723138fxm.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=mxg7GsijuGWlANs53QJ6doJKM6sbpyUHoKMaRgPppwM=;
        b=JfRqEUAT/+iNtxgBUDUSCX8OaxvbFGj8Sh6cfwmfpCQMdjsV4RfKooBmxuMht933+p
         eW+zf4Rqpn0Lpk6Z1sNv9xO3Xle4U0k4dQAKc0UvZFaKVy/g2TMQhSN/4ApZEhbeDn+f
         mIvwzXB+KYn55R12A5A7E7BBkJK2uK2/ZKTT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=c8jmpyutwyEnuldOL80F2qeA4dkZZ9n/CwPlbEm+ryOktG3gLYSeRIKBkmWT9hWIYT
         qS77GaAF3PeuceM3RfM8ZKrFpSKUUTXYJywSA6rPUnfz3LH+OEgRchDyOu83mcRp1MSm
         to30yPm8eD/z3cCJqDpBE9c+NeOyeNA/8lPdw=
Received: by 10.223.87.69 with SMTP id v5mr1381282fal.57.1305663519078;
        Tue, 17 May 2011 13:18:39 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-152-123.pools.arcor-ip.net [94.222.152.123])
        by mx.google.com with ESMTPS id b17sm350462fab.23.2011.05.17.13.18.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 May 2011 13:18:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173823>

=46ixed a spelling mistake in German translation. "positive integer" is
not correctly translated to "ganzzahliger Wert" because "ganzzahliger W=
ert"
also includes negative values.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 gitk-git/po/de.po |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/po/de.po b/gitk-git/po/de.po
index bd194a3..55e8467 100644
--- a/gitk-git/po/de.po
+++ b/gitk-git/po/de.po
@@ -652,7 +652,7 @@ msgstr "Bis:"
=20
 #: gitk:3835
 msgid "Limit and/or skip a number of revisions (positive integer):"
-msgstr "Versionsanzahl begrenzen oder einige =C3=BCberspringen (ganzza=
hliger Wert):"
+msgstr "Versionsanzahl begrenzen oder einige =C3=BCberspringen (positi=
ver ganzzahliger Wert):"
=20
 #: gitk:3836
 msgid "Number to show:"
--=20
1.7.5.1
