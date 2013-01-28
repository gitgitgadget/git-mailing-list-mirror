From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate "revision" consistently as "Version"
Date: Mon, 28 Jan 2013 19:33:33 +0100
Message-ID: <1359398014-3325-2-git-send-email-ralf.thielow@gmail.com>
References: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com>
 <1359398014-3325-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jojo@schmitz-digital.de
X-From: git-owner@vger.kernel.org Mon Jan 28 19:34:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TztX0-0004Ej-7E
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab3A1Sdt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 13:33:49 -0500
Received: from mail-bk0-f42.google.com ([209.85.214.42]:44860 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab3A1Sds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:33:48 -0500
Received: by mail-bk0-f42.google.com with SMTP id jk7so771254bkc.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=nytXWThzgYxPabuAbZqpVj/HnapSmKydarm/Gp6xMT0=;
        b=pibV8rjAKX7b8hqE5dbiqmsRAAZyCcWeDbGazp9WDfdFoqnQnykQKkMFcgq3FmSiU1
         wt0/Ex7APFVTdmZQ2b9L80qJ078X6lanQnzb6RyukJXcZaqIcpTJGhsgruxfJBidmL60
         Y3HmHXfPxbKidTUSEWcdbCU6i+TQnfDQU0GbFmI9QHX7gve1DSAgzJQ5LIa9WKhcOJ+T
         ei0tKgqIrbOAJvBV1glJBTq4a7V2QLgZ0Xh89a7Qh+Rgc38AbMxDyqjY8B8TU+s4WxP2
         YDl4wATR7gAfrPv6BIl/Xk3krNxUFO37tWy0gCCj/zBmD0jVhRHGrYxo7ukDTXejEgUg
         vMdA==
X-Received: by 10.204.4.81 with SMTP id 17mr4321632bkq.137.1359398026825;
        Mon, 28 Jan 2013 10:33:46 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id n1sm7137805bkv.14.2013.01.28.10.33.45
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 10:33:46 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.439.g50a6b54
In-Reply-To: <1359398014-3325-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214852>

In the German translation, we have translated "revision"
as both "Revision" and "Version". In the context of version
control, revision has the same meaning as commit, so we don't
need to use both terms. "revision" is now consistently translated
as "Version".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/po/de.po b/po/de.po
index ed8330a..6c7384b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -156,7 +156,7 @@ msgstr "Dem Projektarchiv fehlen folgende vorausges=
etzte Versionen:"
 #: builtin/log.c:751 builtin/log.c:1358 builtin/log.c:1574 builtin/mer=
ge.c:347
 #: builtin/shortlog.c:157
 msgid "revision walk setup failed"
-msgstr "Einrichtung des Revisionsgangs fehlgeschlagen"
+msgstr "Einrichtung des Versionsgangs fehlgeschlagen"
=20
 #: bundle.c:186
 #, c-format
@@ -2201,7 +2201,7 @@ msgstr "arbeite l=C3=A4nger, um bessere =C3=9Cber=
einstimmungen zu finden"
=20
 #: builtin/blame.c:2380
 msgid "Use revisions from <file> instead of calling git-rev-list"
-msgstr "Benutzt Revisionen von <Datei> anstatt \"git-rev-list\" aufzur=
ufen"
+msgstr "Benutzt Versionen von <Datei> anstatt \"git-rev-list\" aufzuru=
fen"
=20
 #: builtin/blame.c:2381
 msgid "Use <file>'s contents as the final image"
@@ -2832,7 +2832,7 @@ msgstr ""
=20
 #: builtin/checkout.c:730
 msgid "internal error in revision walk"
-msgstr "interner Fehler im Revisionsgang"
+msgstr "interner Fehler im Versionsgang"
=20
 #: builtin/checkout.c:734
 msgid "Previous HEAD position was"
@@ -6193,7 +6193,7 @@ msgstr "findet Vorfahren f=C3=BCr eine einzelne n=
-Wege-Zusammenf=C3=BChrung"
=20
 #: builtin/merge-base.c:100
 msgid "list revs not reachable from others"
-msgstr "listet Revisionen auf, die nicht durch Andere erreichbar sind"
+msgstr "listet Versionen auf, die nicht durch Andere erreichbar sind"
=20
 #: builtin/merge-base.c:102
 msgid "is the first one ancestor of the other?"
@@ -6831,7 +6831,7 @@ msgstr "erzeugt keine leeren Pakete"
=20
 #: builtin/pack-objects.c:2481
 msgid "read revision arguments from standard input"
-msgstr "liest Argumente bez=C3=BCglich Revisionen von der Standard-Ein=
gabe"
+msgstr "liest Argumente bez=C3=BCglich Versionen von der Standard-Eing=
abe"
=20
 #: builtin/pack-objects.c:2483
 msgid "limit the objects to those that are not yet packed"
@@ -7917,7 +7917,7 @@ msgstr "setzt Zweigspitze (HEAD) zur=C3=BCck, beh=
=C3=A4lt aber lokale =C3=84nderungen"
 #: builtin/reset.c:275
 #, c-format
 msgid "Failed to resolve '%s' as a valid revision."
-msgstr "Konnte '%s' nicht als g=C3=BCltige Revision aufl=C3=B6sen."
+msgstr "Konnte '%s' nicht als g=C3=BCltige Version aufl=C3=B6sen."
=20
 #: builtin/reset.c:278 builtin/reset.c:286
 #, c-format
@@ -8193,7 +8193,7 @@ msgstr ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
 "current] [--color[=3D<Wann>] | --no-color] [--sparse] [--more=3D<n> |=
 --list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] "
-"[(<Revision> | <glob>)...]"
+"[(<Version> | <glob>)...]"
=20
 #: builtin/show-branch.c:10
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
@@ -9440,7 +9440,7 @@ msgstr "Kein \"stash\" gefunden."
 #: git-stash.sh:359
 #, sh-format
 msgid "Too many revisions specified: $REV"
-msgstr "Zu viele Revisionen angegeben: $REV"
+msgstr "Zu viele Versionen angegeben: $REV"
=20
 #: git-stash.sh:365
 #, sh-format
--=20
1.8.1.1.439.g50a6b54
