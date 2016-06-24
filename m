Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A4AE2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 18:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbcFXSHI (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 14:07:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36090 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbcFXSHG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 14:07:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so7079383wme.3
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 11:07:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShVe6kHuExaqUpumqmNUDYdV1KWCrzdEgweOVv7j8lI=;
        b=qEoEXzT8NN1J1U2e44blXIxM384qqAiI8he4/5MfiosLIWwhAwWRwXz3dM//HS41BC
         0vg2GqLi2Rjr0OGTXY+dKcCmPF8s6P8VqhiRbLqFZA+RH7fKHVAS+1RRVxFkJZzOOR9d
         ANhGCZzIp0QZo1TMLmYz0bish0307sSXuR5EP1GH9r3wiwuN5J6ULcNJvBggWzbrCZ9s
         wzFDT3JoBMoTaU+EfGf8cOESiRQVwBWXQbmDhkCUlz4pX6jlifeV0G8DYxxII1QgASr8
         ITxzvRRniHb7BzLdnDfWhZzp3hb+ZZ0rFbMYKSyctTYOv3WlkmraMBZrq7W2wAKa3nKm
         SfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShVe6kHuExaqUpumqmNUDYdV1KWCrzdEgweOVv7j8lI=;
        b=TkkMN5iY6CIdAfLaZww9eeV5Mp60Bg7TUyCFETCQ6IHr2JHlYTjVcEQ6vwy6DsV8k6
         rFoy+dxQLemZIznjx8txwSnsjL/KapAeKvTtJPCcRJM3YhT0A1elY6cZaJviW2ffebCl
         sbjE09z9ihZwW4Ev/jQVCvfMIjp/3fy7EMcwxupuE+1DHgJ3qyfCy6oWme8UTmltz40n
         71D0dmwhVKaCNDQ+HV930v9GExSXRDlwx8oANov07mtQrWbqxHyIciKfDSBIyLFaa9NF
         NPu5lyRs65Xet+hGQCycj0gDs8i0Ei38a0pKfbkwZuW8itlIJPaTpMi4mbPzgZr2DpCI
         PsJQ==
X-Gm-Message-State: ALyK8tJBQFTBoGG5cdqUwt7yppoYq/jEdaqJOb76s2m6Y733vRuAm8JsDz1XDwvWCsbHwQ==
X-Received: by 10.28.73.86 with SMTP id w83mr19716603wma.83.1466791624569;
        Fri, 24 Jun 2016 11:07:04 -0700 (PDT)
Received: from localhost (cable-62-117-30-12.cust.telecolumbus.net. [62.117.30.12])
        by smtp.gmail.com with ESMTPSA id a198sm4210780wme.16.2016.06.24.11.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 11:07:03 -0700 (PDT)
From:	Ralf Thielow <ralf.thielow@gmail.com>
To:	git@vger.kernel.org
Cc:	tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix translation of autostash
Date:	Fri, 24 Jun 2016 20:07:00 +0200
Message-Id: <20160624180700.11685-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.0.129.g44ae68f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/po/de.po b/po/de.po
index d50cb1b..fdf4d92 100644
--- a/po/de.po
+++ b/po/de.po
@@ -12408,7 +12408,7 @@ msgstr ""
 
 #: git-rebase.sh:168
 msgid "Applied autostash."
-msgstr "\"autostash\" angewendet."
+msgstr "Automatischen Stash angewendet."
 
 #: git-rebase.sh:171
 #, sh-format
@@ -12421,7 +12421,7 @@ msgid ""
 "Your changes are safe in the stash.\n"
 "You can run \"git stash pop\" or \"git stash drop\" at any time.\n"
 msgstr ""
-"Anwendung von \"autostash\" resultierte in Konflikten.\n"
+"Anwendung des automatischen Stash resultierte in Konflikten.\n"
 "Ihre Änderungen sind im Stash sicher.\n"
 "Sie können jederzeit \"git stash pop\" oder \"git stash drop\" ausführen.\n"
 
@@ -12508,12 +12508,12 @@ msgstr "fatal: Branch $branch_name nicht gefunden"
 
 #: git-rebase.sh:558
 msgid "Cannot autostash"
-msgstr "Kann \"autostash\" nicht ausführen."
+msgstr "Kann automatischen Stash nicht anwenden."
 
 #: git-rebase.sh:563
 #, sh-format
 msgid "Created autostash: $stash_abbrev"
-msgstr "\"autostash\" erzeugt: $stash_abbrev"
+msgstr "Automatischen Stash erzeugt: $stash_abbrev"
 
 #: git-rebase.sh:567
 msgid "Please commit or stash them."
-- 
2.9.0.129.g44ae68f

