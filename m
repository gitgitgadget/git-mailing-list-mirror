Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D38612E
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409559; cv=none; b=ddJYn4QkYCPTMJNebf8Ou5cV2c8wLT0uaaPUb7JaDTVSB8WF/sYuSjGiJKYYuGLS16GLuzyn3G4/Wt/SlIP+ApTm0Z72hkz5dHlvZ5AHLZEi3rH2NXzjO516zftOM39PoU425J094UHMdDPeBqfyMO+W0mqrr8RSMg+Dt2QD8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409559; c=relaxed/simple;
	bh=4nK/E7RABLdHXRTrdyxm0UlGWc5UrzrvngOw4ZvHUsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5hyfCxDy11sCgrHHVb/yPt/NZpmw2Yygcdkw0xqkKWFt7QFFbQ4BmNM5/C6qc2X6rRRVBIhnS3kuSUliDXL2Q80ludv/WDJWQFXfs/RQ+4X8JFImVtV5j6iIXzdzUdFqAAX6XPF/99rrJrS+nAEvGRHkkIGJ9WsDMMMhRxr+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1s1UEu-000000007tb-0wFT
	for git@vger.kernel.org;
	Mon, 29 Apr 2024 18:52:28 +0200
Received: from [10.20.10.233] (port=58698 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1s1UEt-0069XH-0M;
	Mon, 29 Apr 2024 18:52:27 +0200
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id D3C371801C4;
	Mon, 29 Apr 2024 18:52:25 +0200 (CEST)
Received: by minibeat.bolli (sSMTP sendmail emulation); Mon, 29 Apr 2024 18:52:25 +0200
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 1/3] t/t4026-color: remove an extra double quote character
Date: Mon, 29 Apr 2024 18:48:47 +0200
Message-ID: <20240429164849.78509-2-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429164849.78509-1-dev+git@drbeat.li>
References: <20240429164849.78509-1-dev+git@drbeat.li>
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

