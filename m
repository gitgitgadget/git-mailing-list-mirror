From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] .mailmap: combine more (email, name) to individual persons
Date: Wed, 24 Jul 2013 19:55:18 +0200
Message-ID: <1374688518-13563-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 24 19:55:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V23Hl-0001Vp-CZ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 19:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab3GXRzZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 13:55:25 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:38768 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab3GXRzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 13:55:21 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so3650512wes.17
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=w/eIIWGeE+ufTD80g9NkNzttXt8OLg9rGuX33lj38Mc=;
        b=lN+THYe90NzSnWAwzWmnmBWMQguXmyg1ydzE+Byjwg3OEPCpFqD0rLHtuDh6ZkHo0p
         Q954MJbmn/nOw312JzVUm4tVwGAEkGmgNtxbDPlXAsFSLwgBfUqLg6Hb7kAwWVKhz4M/
         z0Ip58SEDxVOD8qFr4RYWkwqzXvBU0tVDYOnka79hk9gG9x+hshzW1990IAEvyVn3RdA
         EY98KsxHzPY+ABtS64eeKxzj22ehNpRwi0R/DyKzDikOKPfyXpis48GB95xzkdOxontg
         r1tmGsTOCUWdOPKhd6YQrDeiUHHQTS0wPofgD8snZo/hvkJ7xIaFqBKlV2iAx9uq3GDd
         CfYg==
X-Received: by 10.194.234.100 with SMTP id ud4mr27765713wjc.44.1374688520365;
        Wed, 24 Jul 2013 10:55:20 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id li9sm6998470wic.2.2013.07.24.10.55.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jul 2013 10:55:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1135.ge2c9e63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231108>

I got more responses from people regarding the .mailmap file.
All added persons gave permission to add them to the .mailmap file.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 57070b5..57551b0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -26,6 +26,8 @@ Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com=
>
 Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
 Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
+Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
+Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
@@ -74,6 +76,7 @@ Johannes Schindelin <Johannes.Schindelin@gmx.de> <joh=
annes.schindelin@gmx.de>
 Johannes Sixt <j6t@kdbg.org> <J.Sixt@eudaptics.com>
 Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
 Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
+John 'Warthog9' Hawley <warthog9@kernel.org> <warthog9@eaglescrag.net>
 Jon Loeliger <jdl@jdl.com> <jdl@freescale.com>
 Jon Loeliger <jdl@jdl.com> <jdl@freescale.org>
 Jon Seymour <jon.seymour@gmail.com> <jon@blackcubes.dyndns.org>
@@ -181,6 +184,7 @@ Simon Hausmann <hausmann@kde.org> <shausman@trollte=
ch.com>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@atlas-elektronik.c=
om>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@googlemail.com>
 Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
+=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> <stepan.nemec@gma=
il.com>
 Stephen Boyd <bebarino@gmail.com> <sboyd@codeaurora.org>
 Steven Drake <sdrake@xnet.co.nz> <sdrake@ihug.co.nz>
 Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
--=20
1.8.3.3.1135.ge2c9e63
