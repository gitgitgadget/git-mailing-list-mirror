From: Phillip Sz <phillip.szelat@gmail.com>
Subject: [PATCH] l10n: de.po: change error message from "sagen" to "Meinten Sie"
Date: Sat,  9 May 2015 13:28:55 +0200
Message-ID: <1431170935-6027-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	ralf.thielow@gmail.com, Phillip Sz <phillip.szelat@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 13:29:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yr2wh-00008f-0F
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 13:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbbEIL3D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 May 2015 07:29:03 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34484 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbbEIL3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 07:29:01 -0400
Received: by wicmx19 with SMTP id mx19so53028218wic.1
        for <git@vger.kernel.org>; Sat, 09 May 2015 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=yvyw3QIV41dxbu4nT4C5cUNiWtmdvAI8JfOnB0mKvl8=;
        b=H3SEVj1fzTbjPvBXsarf4Q8D2MR+F4fzU/4Qm5qW6SWTSRnEWtVzuyjQXnXzuqFGfs
         DPVr9YOH1Y4qxpX19zdAcgKgzEc78vSJxFbWQsqjRukifDKcmRfs2inDNYkjh+fpCW4i
         NPPo+e7Z9BiW7LhBCXFdHG9WqrFszaamoyKvQInw6gkeuBAKaJyEPGWStFKO6sMLpxjg
         fu53qDzYPNQdqntVIn87XnrvJZR5rBNiMXF8O+EAjgINY3LI00Gc3YvVNJmcmYZtAmku
         OkXMhVfroaH2Q9VPcNchFESQilFf9Dk+sfB+BlBacHTl7V8YrQo6KqZpE/qKOrpaZevC
         EdaQ==
X-Received: by 10.194.77.180 with SMTP id t20mr4459143wjw.115.1431170939874;
        Sat, 09 May 2015 04:28:59 -0700 (PDT)
Received: from phillip.fritz.box (i577AA345.versanet.de. [87.122.163.69])
        by mx.google.com with ESMTPSA id i13sm3382880wic.13.2015.05.09.04.28.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 May 2015 04:28:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268700>

Hi,

I think we should not use "sagen" if someone has written something wron=
g.
Although it's "say" in English I think we should not use it in German a=
nd instead use our normal error message.

Phillip

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 2feaec1..a435da0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2183,7 +2183,7 @@ msgstr "Nichts spezifiziert, nichts hinzugef=C3=BC=
gt.\n"
 #: builtin/add.c:358
 #, c-format
 msgid "Maybe you wanted to say 'git add .'?\n"
-msgstr "Wollten Sie vielleicht 'git add .' sagen?\n"
+msgstr "Meinten Sie vielleicht 'git add .'?\n"
=20
 #: builtin/add.c:363 builtin/check-ignore.c:172 builtin/clean.c:920
 #: builtin/commit.c:335 builtin/mv.c:130 builtin/reset.c:235 builtin/r=
m.c:299
--=20
2.4.0
