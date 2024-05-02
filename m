Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B235EE78
	for <git@vger.kernel.org>; Thu,  2 May 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647842; cv=none; b=d6LDBBa6OGlheJb45vUyAHbYqHQSn8IcU8Ne3eM+AtrORFlVHcSIGKclESkQmqUMWOzKRKjJKPxwR0gR2fUmec+uVCrp26nNuoogA2/rCf+weE1Nh+zd2IO38J4S9EKZfONLk872+oJAhUGZC6lQDbBrUYa8PP1NF9pcJD1zZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647842; c=relaxed/simple;
	bh=4nK/E7RABLdHXRTrdyxm0UlGWc5UrzrvngOw4ZvHUsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4rZlq6//wrWFrHQm2ttIdn8u14WmQ85Ti6A7dz0tuXRvHMAQrNF8VKOPLy0fk3B808bnokp0mpYtQhm35irXpONAUPTidLFCVx22GDNh3P1UEf6S733H1x5PTjSsGm/OJ+2l4J/o8UbFTUTNnM3D2RvZcZQk89Iy+QWLHDwrO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1s2UEA-0000000025X-1x9J
	for git@vger.kernel.org;
	Thu, 02 May 2024 13:03:51 +0200
Received: from [10.20.10.231] (port=15048 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1s2UE9-00EbDP-17;
	Thu, 02 May 2024 13:03:49 +0200
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 07E031801C7;
	Thu,  2 May 2024 13:03:48 +0200 (CEST)
Received: by minibeat.bolli (sSMTP sendmail emulation); Thu, 02 May 2024 13:03:47 +0200
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 1/3] t/t4026-color: remove an extra double quote character
Date: Thu,  2 May 2024 13:03:29 +0200
Message-ID: <20240502110331.6347-2-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502110331.6347-1-dev+git@drbeat.li>
References: <20240502110331.6347-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

This is most probably just an editing left-over from cb357221a4 (t4026:
test "normal" color, 2014-11-20) which added this test.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t4026-color.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index cc3f60d468f4..37622451fc23 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -112,7 +112,7 @@ test_expect_success '"default" can be combined with attributes' '
 	color "default default no-reverse bold" "[1;27;39;49m"
 '
 
-test_expect_success '"normal" yields no color at all"' '
+test_expect_success '"normal" yields no color at all' '
 	color "normal black" "[40m"
 '
 
-- 
2.44.0

