Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4531E1C11
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771150933; cv=none; b=mVABl9qE2rBR0IrKhFK/ersatt3TpDxl1yyWG2JPBB7aOVMJ3w97u8eGmhHFY/SU6Rh7I4R8aoJVikwf7daJT/SV0+BWlOQk+OwU/I84KhZH3Bv2fzhlDKRZidfQTKCGZitWNgerJepXLPiGJ9HetNxRdpulBMGwvh1uAHgLSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771150933; c=relaxed/simple;
	bh=jr9N4NUju5hiaLdIh1s7RXEQLnaU8tlRoTOGyMtTtOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RMgpWN8b2fygHzMMgiVxhXoRVdlwuXz/Bgu4ugKE3Ho3/tsL7viTth8M16n+1eLNCvY2EBp2j4BCfpT6WLD6S8rQa8bZjeoHsEsic6zF5LnNw6SSLJHznT6zFYyl5OOUEnb4DV8Z+zdxZHbSL2tHKaMfIuF3K4qFs8gGuOaMZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gauss.fritz.box (unknown [IPv6:2001:a62:4f9:3601:ec47:70f:d4c0:5b33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zzam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3DA483427B9;
	Sun, 15 Feb 2026 10:22:10 +0000 (UTC)
From: Matthias Schwarzott <zzam@gentoo.org>
To: git@vger.kernel.org
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Matthias Schwarzott <zzam@gentoo.org>
Subject: [PATCH resent] l10n: de.po: Fix spelling of suggested color-moved-ws mode allow-indentation-change
Date: Sun, 15 Feb 2026 11:21:54 +0100
Message-ID: <20260215102154.21582-1-zzam@gentoo.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Copy and paste of the suggested mode makes git fail again and display the same
suggestion again:

Fehler: Unbekannter color-moved-ws Modus 'allow-identation-change', mögliche Werte sind 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-identation-change'
Fehler: ungültiger Modus 'allow-identation-change' in --color-moved-ws

Signed-off-by: Matthias Schwarzott <zzam@gentoo.org>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 6b65bb618076..16871c9a839f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -16564,7 +16564,7 @@ msgid ""
 "'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"
 msgstr ""
 "Unbekannter color-moved-ws Modus '%s', mögliche Werte sind 'ignore-space-"
-"change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-identation-change'"
+"change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"
 
 msgid ""
 "color-moved-ws: allow-indentation-change cannot be combined with other "
-- 
2.52.0

