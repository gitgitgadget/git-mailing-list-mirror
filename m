Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412A155321
	for <git@vger.kernel.org>; Fri,  3 May 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767327; cv=none; b=Wra/xBjfkRjUonfrfoXIO3qY5MhhL/Pu2DsDOB4kLpeVP90zW2aQjr8MhlvE8ocAlpBW44EkPHDavgdujEebKu5Mw1l7u66YBbTQUMPLA5aZPFh0CJAz9WzQZeILPKuTNSMMR4kipg7lwYquzcxM/SqYm6Uc+6yLLeZELuvSxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767327; c=relaxed/simple;
	bh=zxEdrbaOfRcwcklLgAzYodI+OmSyXkz7Jr+GO3gerws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2YKdBZ8O3MDfocsvW3kQy34liSoSfjV4bY18d+zK5/rlD///VnpRT475Vwc+2Dmji9X29Xcx1e7vlgucf8KDJ98RxDZ6vVsrHsMiSEVHe/6wv8Alr81sdyaFNynFHhV1SKgKVm0XGtRU395I4oUzJd2C0uy+o86fCbzUeSd5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=I8VF6nId; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="I8VF6nId"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 11C2F5B2EA;
	Fri,  3 May 2024 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1714767324;
	bh=zxEdrbaOfRcwcklLgAzYodI+OmSyXkz7Jr+GO3gerws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=I8VF6nIdsgREcpXknjIKCyAGcVAL4RH4QAU+d5Qt7ubU9LLrcEWOpCrlrPT6jJPnL
	 czdf6Eu7yBJRP+v1LKN4yW3+0EGbLu0B5Lc4jwLcxIvyJ64H0CEaCQmVUvHPngVJU4
	 ihmYyuKsrDR3b5L5d2bfGS1etTu6JE1sXPApGSmfJgItMyQCaFp4GYX4TfIYDp97dp
	 odoMl5a58UQWkYTpUlDuQJBIRaX3H8HuR+ivSOLyQzWOEJx1CuN5svuXpFKR4Dq7gh
	 K8+7CoWln5jGgkszZvRxiZltonXVCF0WuoIdpzJePWBtqQGT/4xfZlKnUDtnEhCpJD
	 rqgmjdN0rKKcHEDJS8ZB/1SUsKWYPcmtvKpVREsnLT49EXNR9KLqE4lDrAsYGXqI16
	 FxOmHC5dLktrc1xM4cpa7qpcyAo9aOoe+urQ92zpwss9Qu7CndrOcanYfepZQNNWKI
	 TiswLwSySWdJstAKdKDZo/sziCOXaBu1c58+qS4zdhW/M9M2Zex
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?L=C3=A9onard=20Michelet?= <leonard@lebasic.com>
Subject: [PATCH] =?UTF-8?q?po:=20fix=20typo=20in=20French=20"aper=C3=A7u"?=
Date: Fri,  3 May 2024 20:14:52 +0000
Message-ID: <20240503201452.3355520-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <ZjVDhAvfrR8d_Hok@tapette.crustytoothpaste.net>
References: <ZjVDhAvfrR8d_Hok@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The French word "aperçu", meaning "view" or "preview", contains only a
single letter "p".  Remove the extra letter, which is an obvious typo.

Reported-by: Léonard Michelet <leonard@lebasic.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 po/fr.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/fr.po b/po/fr.po
index 0aff186..878df65 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -1646,7 +1646,7 @@ msgstr "Dépôt Git (sous projet)"
 
 #: lib/diff.tcl:222
 msgid "* Binary file (not showing content)."
-msgstr "* Fichier binaire (pas d'apperçu du contenu)."
+msgstr "* Fichier binaire (pas d'aperçu du contenu)."
 
 #: lib/diff.tcl:227
 #, tcl-format
