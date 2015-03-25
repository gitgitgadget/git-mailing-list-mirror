From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: fix messages with abbreviated hashs
Date: Wed, 25 Mar 2015 17:42:34 +0100
Message-ID: <1427301754-29919-1-git-send-email-ralf.thielow@gmail.com>
References: <1427222527-4086-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, gitster@pobox.com,
	phillip.szelat@gmail.com, tr@thomasrast.ch, jk@jk.gs,
	stimming@tuhh.de, matthias.ruester@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 17:42:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaoOC-0000Cs-2a
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 17:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbbCYQmk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2015 12:42:40 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34241 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387AbbCYQmi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 12:42:38 -0400
Received: by wgs2 with SMTP id 2so34520108wgs.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jBzMAsmU5lc1Pvk6BsMexkhwgGABtKAwbfA9Pu6MfHc=;
        b=QwpFMGrTgou2r/dmMZpwQV3v2saLdc99CCYyO6e/zzRFuKoAFXiJEz7YbiOqCMlEe+
         I36w9RzG72kYVHwM1/i+cbDbmGZjpXtmcFwP93akUQC4vYBWFRvYtxce+vbYR/1BZtWf
         a5YCvU+cLTVQ9QRtH+sWF8HqgYbW4pyQjgt+OO0hUFQkaiOAHKMLcOoraQZiYTxrOBB/
         9oWVp4swY0I3S5YFcd37rfOaWQWXHYF9WLZ7QFvWpV8Vu9yNSqUwvkFFLs21tLl0EA0W
         v3iHQr14tXNzmpGiRnMrtxwA/eXhQidhDcVeyX0cT2T+exWztFgnxIDQSpvLxRfmFI/1
         wgEg==
X-Received: by 10.194.95.4 with SMTP id dg4mr19133017wjb.81.1427301757348;
        Wed, 25 Mar 2015 09:42:37 -0700 (PDT)
Received: from localhost (dslb-178-000-084-015.178.000.pools.vodafone-ip.de. [178.0.84.15])
        by mx.google.com with ESMTPSA id vq9sm4474978wjc.6.2015.03.25.09.42.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Mar 2015 09:42:36 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.526.g7d26d9e
In-Reply-To: <1427222527-4086-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266284>

The three dots in messages where the hash is abbreviated
were misinterpreted and are fixed with this commit.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
In v2 there's a space added between dots and brackets.

 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 7b30f62..a9b9124 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1271,12 +1271,12 @@ msgstr "Kann keine Commit-Beschreibung f=C3=BCr=
 %s bekommen"
 #: sequencer.c:611
 #, c-format
 msgid "could not revert %s... %s"
-msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren... %s"
+msgstr "Konnte \"revert\" nicht auf %s... (%s) ausf=C3=BChren"
=20
 #: sequencer.c:612
 #, c-format
 msgid "could not apply %s... %s"
-msgstr "Konnte %s nicht anwenden... %s"
+msgstr "Konnte %s... (%s) nicht anwenden"
=20
 #: sequencer.c:648
 msgid "empty commit set passed"
--=20
2.3.4.526.g7d26d9e
