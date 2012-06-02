From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20l10n=3A=20de=2Epo=3A=20add=20additional=20newline?=
Date: Sat,  2 Jun 2012 20:31:12 +0200
Message-ID: <1338661872-13913-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Sat Jun 02 20:31:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sat6x-0004jQ-II
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 20:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846Ab2FBSbc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 14:31:32 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:41143 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964796Ab2FBSbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 14:31:18 -0400
Received: by weyu7 with SMTP id u7so2035648wey.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=rmJlDM3Wiynsf/7bo/I/ZMClNjNAJqBmFZRNJdTR/gU=;
        b=hwEbl+YmvRVvEPp1WwB/XrxkRjLPFaSMzoaQI7SjrboKC+6IECXzNoi6qZ0hUhT8ju
         LHn76cktDAlGDO6LdirI5XnzVhS55/RXuYjwruz349jA+lPFy+tUbkaC+7/k4ehRtpqC
         Nxk8IlIRQWKrmFZi+Wic5lXThpjR+T60FIa/pCYMJYBdVpn0qFo3E2m9ks3A1POl4bW+
         Ls9YoyuGRV3teCzRwS1kb3YSM3JV84AZmnhCDEw79XuNsz657tIejJ66RUUNIGWv7Upz
         07GdLy/9qaqsxEQsOT2fJeS2hmqy4YEUXbmR+1d+vxjO7vHw2d6cochtTb7Ozw7XWnew
         WSjA==
Received: by 10.216.26.201 with SMTP id c51mr4834714wea.108.1338661877033;
        Sat, 02 Jun 2012 11:31:17 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id gb9sm6601302wib.8.2012.06.02.11.31.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Jun 2012 11:31:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc0.105.g16abda8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199054>

The translation of "builtin/gc.c:224" was missing of
a newline which made the second part of the message
quite long. We simply add a newline.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po | 4 ++--
 1 Datei ge=C3=A4ndert, 2 Zeilen hinzugef=C3=BCgt(+), 2 Zeilen entfernt=
(-)

diff --git a/po/de.po b/po/de.po
index a7774e0..23829ef 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2812,8 +2812,8 @@ msgid ""
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
 "Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Performa=
nce\n"
-"komprimiert. Du kannst auch \"git gc\" manuell ausf=C3=BChren. Siehe =
\"git help gc"
-"\" f=C3=BCr weitere Informationen.\n"
+"komprimiert. Du kannst auch \"git gc\" manuell ausf=C3=BChren.\n"
+"Siehe \"git help gc\" f=C3=BCr weitere Informationen.\n"
=20
 #: builtin/gc.c:251
 msgid ""
--=20
1.7.11.rc0.105.g16abda8
