Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C052F85DE
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473359; cv=none; b=RWQ26ZRDbRSMf17uMMouiv92s40mQ4uOF+Ftg+VPND+LxdXyi7J2WVpwzG7iOOXkTj05TFbmVWP0p0DlGeIaHeO87iuIRMeo8zKjjzFinEuEYpKSlAdpUvYQAeXAxA+GO1y1JCSiV4hWiUKAWo5OKKbRvgsDhfNJjfqd3rakLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473359; c=relaxed/simple;
	bh=+X3CDPv1awbnSMnwS4gVTTjnugPW1knNldb43DLo7TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGH5S2OrLGNpbCBAvFmUdH+Ll/xcUJRntRQaYkZi/YYPT7KP8I8osC7YWNBQFpoieS7y2K714QV5fkvuACImNisVCco2xtHwUy1H3w/nx5aCcGF8hYDKZfetuZFKY8nl+HUnxz+//hOdwQtqBrgWOHxPxnUFr6WaeyjRCH5hq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Received: from [2a0c:e303:0:7000:1adb:f2ff:fe4f:84eb] (port=56826 helo=karahi.gladserv.com)
	by bregans-1.gladserv.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(envelope-from <bacs@librecast.net>)
	id 1uX0DS-007VVg-3B;
	Wed, 02 Jul 2025 16:21:47 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: git@vger.kernel.org
Cc: Brett A C Sheffield <bacs@librecast.net>
Subject: [PATCH] gitremote-helpers.adoc: fix formatting
Date: Wed,  2 Jul 2025 18:19:52 +0200
Message-ID: <20250702161951.22908-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brett A C Sheffield (Librecast) <bacs@librecast.net>

Add missing colon to fix formatting.

Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
---
 Documentation/gitremote-helpers.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitremote-helpers.adoc b/Documentation/gitremote-helpers.adoc
index d0be008e5e..39cdece16e 100644
--- a/Documentation/gitremote-helpers.adoc
+++ b/Documentation/gitremote-helpers.adoc
@@ -498,7 +498,7 @@ set by Git if the remote helper has the 'option' capability.
 	ask for the tag specifically.  Some helpers may be able to
 	use this option to avoid a second network connection.
 
-'option dry-run' {'true'|'false'}:
+'option dry-run' {'true'|'false'}::
 	If true, pretend the operation completed successfully,
 	but don't actually change any repository data.  For most
 	helpers this only applies to the 'push', if supported.

base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
-- 
2.49.0

