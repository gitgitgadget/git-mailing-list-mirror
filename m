From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 2/2] l10n: de.po: fix messages with abbreviated hashs
Date: Tue, 24 Mar 2015 19:42:07 +0100
Message-ID: <1427222527-4086-2-git-send-email-ralf.thielow@gmail.com>
References: <CAN0XMOKVAebs6xNuLLNvzi8gkARsmSgNC1k+TuS23BxqCffOig@mail.gmail.com>
 <1427222527-4086-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, phillip.szelat@gmail.com,
	tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 19:42:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaTmP-0003f8-T1
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 19:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbbCXSmQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 14:42:16 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34136 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbbCXSmO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 14:42:14 -0400
Received: by wgs2 with SMTP id 2so1393481wgs.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IWe3uTTG0epzOTizZXyamAIKofwyLq7689OCzDAfxNw=;
        b=HVzxD3G6dfg3zlxYFk7PTsZg3oa2J8AB3vUs6TEyrlN4XTUBTkB5c7jzS7s77UD/b1
         KMGh5ZCTSmtsF42lmGejCjT/33oCf5dQHAo+GWUrSHgSVhw9I+j4p3gXhcpGt0oAyXgI
         +vJKqCpngRzzmDvIOmuLzSjn73V5C+Dp2ciJkq+e+RzacIMw//uVICsW3YBfkG89ru9Z
         X5ptVD2nFv+KPrgsSJrRBLlAyYW8I/61HXw15i0Bujhq90pmq/+bAX4PmH03DjmWYiF5
         2VnyLfJ/xqKeQT4T+evvYwL3TQskm8SSDkYwlwOVld+xGYaLRnc5h7hy1HYTCk1CDDQh
         3Y7g==
X-Received: by 10.180.189.37 with SMTP id gf5mr31241756wic.86.1427222532243;
        Tue, 24 Mar 2015 11:42:12 -0700 (PDT)
Received: from localhost (dslb-178-000-084-015.178.000.pools.vodafone-ip.de. [178.0.84.15])
        by mx.google.com with ESMTPSA id ew5sm17067291wic.14.2015.03.24.11.42.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Mar 2015 11:42:11 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.434.g642b19b
In-Reply-To: <1427222527-4086-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266221>

The three dots in messages where the hash is abbreviated
were misinterpreted and are fixed with this commit.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 7b30f62..f818350 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1271,12 +1271,12 @@ msgstr "Kann keine Commit-Beschreibung f=C3=BCr=
 %s bekommen"
 #: sequencer.c:611
 #, c-format
 msgid "could not revert %s... %s"
-msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren... %s"
+msgstr "Konnte \"revert\" nicht auf %s...(%s) ausf=C3=BChren"
=20
 #: sequencer.c:612
 #, c-format
 msgid "could not apply %s... %s"
-msgstr "Konnte %s nicht anwenden... %s"
+msgstr "Konnte %s...(%s) nicht anwenden"
=20
 #: sequencer.c:648
 msgid "empty commit set passed"
--=20
2.3.3.434.g642b19b
