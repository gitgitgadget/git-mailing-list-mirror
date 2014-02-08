From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: correct message when hiding commits by craft
Date: Sat,  8 Feb 2014 22:29:37 +0100
Message-ID: <1391894977-6203-1-git-send-email-ralf.thielow@gmail.com>
References: <CAN0XMOLmcj0pqtbfGL7u+FOAg5_dv3+5Twb=SFju7BW=vkq1YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.c, git@vger.kernel.org, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: dak@gnu.org
X-From: git-owner@vger.kernel.org Sat Feb 08 22:29:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCFT8-0002gX-Sn
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 22:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbaBHV3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 16:29:42 -0500
Received: from mail-ea0-f171.google.com ([209.85.215.171]:50946 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbaBHV3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 16:29:41 -0500
Received: by mail-ea0-f171.google.com with SMTP id f15so2216887eak.2
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 13:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4yc+xzgFi193hwjuXtJE+ziWmCvoLuU9DCOdr7Y1xmE=;
        b=B7+61/1ZH71Bfsk4phwHyhpawIQJCvPQUQsfvM2AMpsu2g53GyoKTAmWnZnaTlP260
         DbmtBQ4lz06KKR4mmB+9lkthUNHzQ34heB4KMjuP9v3DxvHWLOgc7RUfuNJ3utahrSCP
         uXw1TZ20/DLHvGq3pyUc6gN6ifNRgsBBRTdAlI9uS/n9Ygd0enHqaOPs7rq4SxmO3B+Z
         rGIbsy4hz+bqNkVTKHYv2islzCGaVdnPhq2LIn8CEdVTXPzzQ4vYPj4cJ29zvAwIytpx
         PlTsxRXuQ0kLr8kRGDAAVaihzPaqa7fVmLAhMSEgsaopKJ+3COEnSZV72d2oLe7umQaA
         j/Tw==
X-Received: by 10.14.88.131 with SMTP id a3mr236468eef.64.1391894980308;
        Sat, 08 Feb 2014 13:29:40 -0800 (PST)
Received: from localhost (dslb-178-008-120-172.pools.arcor-ip.net. [178.8.120.172])
        by mx.google.com with ESMTPSA id x6sm33595124eew.20.2014.02.08.13.29.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 13:29:39 -0800 (PST)
X-Mailer: git-send-email 1.9.rc2.233.ged4ee9f
In-Reply-To: <CAN0XMOLmcj0pqtbfGL7u+FOAg5_dv3+5Twb=SFju7BW=vkq1YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241862>

The recent translation was giving the idea that all commits
based on a graft were meant to be hidden. Make it clear that
it is the graft commit itself.

Reported-by: David Kastrup <dak@gnu.org>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 205ff88..b777ef4 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7878,7 +7878,7 @@ msgstr "Komprimierungsgrad f=C3=BCr Paketierung"
=20
 #: builtin/pack-objects.c:2506
 msgid "do not hide commits by grafts"
-msgstr "verbirgt keine Commits mit k=C3=BCnstlichen Vorg=C3=A4ngern (\=
"grafts\")"
+msgstr "verbirgt keine k=C3=BCnstlichen Vorg=C3=A4nger-Commits (\"graf=
ts\")"
=20
 #: builtin/pack-refs.c:6
 msgid "git pack-refs [options]"
--=20
1.9.rc2.233.ged4ee9f
