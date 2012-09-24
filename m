From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv2=5D=20l10n=3A=20de=2Epo=3A=20correct=20translation=20of=20one=20=27rebase=27=20message?=
Date: Mon, 24 Sep 2012 22:44:59 +0200
Message-ID: <1348519499-5231-1-git-send-email-ralf.thielow@gmail.com>
References: <87k3vjtbf7.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, sascha-ml@babbelbox.org,
	git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Mon Sep 24 22:45:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGFWs-0002l6-V0
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 22:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245Ab2IXUpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2012 16:45:09 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53931 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230Ab2IXUpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 16:45:07 -0400
Received: by wibhr14 with SMTP id hr14so5410385wib.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ksci5dSA81b8WZL8ebj6ZzE1MOLFoztKYI22g8oTwmM=;
        b=pCDbHL2Jrdxb/7bdHko/fXiDuEPs2383ZooULVyo+6ci2QHRheR8guN2iGnEqJd6Kf
         SGPCvlhk70B2R7iX7YKlWMEuO1MU9TY5YEy73EpRHdB1tUCzk5avejXqD08easHsCz1l
         KM1fQt2PNlgWBGYW+xyr6ErMVK+CwgHQ0ZfNtbd7dI1VmQ1xdkfdLAeGL7RjmQ1h+Azr
         ze190qa/Kv04JGW8ro5NOoeB5lXqmShf6fjrWmFmrhRVKUvLvpmlTgO9ZcbN1ngo4/dI
         xLvj1ShC+zf6RYECpka67GSjXDNkRkn08920qQi1M3RpNdKLVEmHEeRNSwC2vTgvhYn+
         iqtw==
Received: by 10.180.86.106 with SMTP id o10mr16662513wiz.22.1348519505789;
        Mon, 24 Sep 2012 13:45:05 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id eu4sm16478006wib.2.2012.09.24.13.45.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Sep 2012 13:45:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.396.g7954078
In-Reply-To: <87k3vjtbf7.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206329>

Noticed-by: Sascha Cunz <sascha-ml@babbelbox.org>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

>Not very elegant yet, shouldn't it say something like
>
>  als ob es das Verzeichnis ... bereits {gibt,g=C3=A4be}
>
>?

Yes, thanks.

 po/de.po | 10 +++++-----
 1 Datei ge=C3=A4ndert, 5 Zeilen hinzugef=C3=BCgt(+), 5 Zeilen entfernt=
(-)

diff --git a/po/de.po b/po/de.po
index 2739bc0..a3cf695 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5750,14 +5750,14 @@ msgid ""
 "and run me again.  I am stopping in case you still have something\n"
 "valuable there."
 msgstr ""
-"Es scheint so, als g=C3=A4be es das Verzeichnis $state_dir_base berei=
ts, und\n"
-"es w=C3=A4re verwunderlich, wenn ein Neuaufbau bereits im Gange ist. =
Wenn das\n"
-"der Fall ist, probiere bitte\n"
+"Es sieht so aus, als ob es das Verzeichnis $state_dir_base bereits gi=
bt\n"
+"und es k=C3=B6nnte ein anderer Neuaufbau im Gange sein. Wenn das der =
=46all ist,\n"
+"probiere bitte\n"
 "\t$cmd_live_rebase\n"
 "Wenn das nicht der Fall ist, probiere bitte\n"
 "\t$cmd_clear_stale_rebase\n"
-"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, falls=
 bereits\n"
-"etwas N=C3=BCtzliches vorhanden ist."
+"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, falls=
 noch\n"
+"etwas Sch=C3=BCtzenswertes vorhanden ist."
=20
 #: git-rebase.sh:395
 #, sh-format
--=20
1.7.12.396.g7954078
