Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4420C038
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840845; cv=none; b=G1AVmuqiX0yL4C4YoZBvA/CKZOi3liT7iSZFKYQPpHEv/+svE/5CHslob0zCot9sR30QeIvvBvMEm1+wHgjdAojGu7zvrXspL2rOwIsdR4flXoRukEL26RTdGe+8KUpvPp+rZPARc0/Hi/HSPzam/M4Tik2meHUoh2QsLOVN6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840845; c=relaxed/simple;
	bh=GMe7hCEFM9SnKVQEJpylYgYJ0tsWDk0tFKmrwphXJYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ql+RknMfljNyIXwhVwvEz0b4s84odEd4USoywF4WvaisUuwYMurU1lxL6XWNXtAIqsHls9IVb8SiZ9AiCOVF7TNlKBXxhJOhEBWcd4eqWUu0vaFvgzRGfmCxvokfDsMMdDREY4znRfqZFhAjtXntK9nWSoWX7A1q7jEgyqBh1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gauss.fritz.box (unknown [IPv6:2001:a62:46f:3001:d27:e1b:1196:fd7a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zzam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 914D5340D30;
	Tue, 02 Sep 2025 19:20:42 +0000 (UTC)
From: Matthias Schwarzott <zzam@gentoo.org>
To: git@vger.kernel.org
Cc: Matthias Schwarzott <zzam@gentoo.org>
Subject: [PATCH] l10n: de.po: Fix spelling of color-moved-ws mode allow-indentation-change
Date: Tue,  2 Sep 2025 21:20:32 +0200
Message-ID: <20250902192033.5366-1-zzam@gentoo.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
2.49.1

